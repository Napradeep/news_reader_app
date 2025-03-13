import 'package:equatable/equatable.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object?> get props => [];
}

// Event for checking connectivity
class CheckConnectivity extends ConnectivityEvent {}

// Event triggered when connectivity status changes
class ConnectivityChanged extends ConnectivityEvent {
  final bool isOnline;
  const ConnectivityChanged(this.isOnline);

  @override
  List<Object?> get props => [isOnline];
}
