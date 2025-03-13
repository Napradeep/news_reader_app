import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<CheckConnectivity>(_onCheckConnectivity);
    on<ConnectivityChanged>(_onConnectivityChanged);

    _subscription = _connectivity.onConnectivityChanged.listen(_connectivityListener);
    _initialize();
  }

  // Manually check connectivity when the app starts
  Future<void> _initialize() async {
    var result = await _connectivity.checkConnectivity();
    _connectivityListener(result);
  }

  void _connectivityListener(List<ConnectivityResult> results) {
    bool isOnline = results.isNotEmpty && results.first != ConnectivityResult.none;
    add(ConnectivityChanged(isOnline));
  }

  void _onCheckConnectivity(CheckConnectivity event, Emitter<ConnectivityState> emit) async {
    var result = await _connectivity.checkConnectivity();
    bool isOnline = result.isNotEmpty && result.first != ConnectivityResult.none;
    emit(isOnline ? ConnectivityOnline() : ConnectivityOffline());
  }

  void _onConnectivityChanged(ConnectivityChanged event, Emitter<ConnectivityState> emit) {
    emit(event.isOnline ? ConnectivityOnline() : ConnectivityOffline());
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
