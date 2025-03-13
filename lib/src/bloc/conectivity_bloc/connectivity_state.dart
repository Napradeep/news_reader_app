import 'package:equatable/equatable.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object?> get props => [];
}

// Initial state
class ConnectivityInitial extends ConnectivityState {}

// Online state
class ConnectivityOnline extends ConnectivityState {}

// Offline state
class ConnectivityOffline extends ConnectivityState {}
