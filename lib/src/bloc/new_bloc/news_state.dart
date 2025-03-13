import 'package:equatable/equatable.dart';
import 'package:newapp/src/model/new_model.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<Newmodel> articles;

  NewsLoadedState(this.articles);

  @override
  List<Object?> get props => [articles];
}

class NewsErrorState extends NewsState {
  final String message;

  NewsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
