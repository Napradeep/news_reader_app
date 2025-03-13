import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:newapp/src/bloc/new_bloc/news_event.dart';
import 'package:newapp/src/bloc/new_bloc/news_state.dart';
import 'package:newapp/src/model/new_model.dart';
import 'package:newapp/src/utils/const/const.dart';
import 'package:newapp/src/utils/dio/dio.dart';

class NewsBloc extends Bloc<FetchnewsEvent, NewsState> {
  final _apiClient = NetworkUtils();
  final Box<Newmodel> _newsBox = Hive.box<Newmodel>('newsBox');

  NewsBloc() : super(NewsInitialState()) {
    on<FetchnewsEvent>(_fetchnewsEvent);
  }

  Future<void> _fetchnewsEvent(
    FetchnewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoadingState());
    //  Checkin.. Internet Connection
    bool isOnline = await _apiClient.isNetworkAvailable();

    if (!isOnline && _newsBox.isNotEmpty) {
      log("No internet. Loading cached news...");
      _loadCachedNews(emit);
      return;
    }

    if (_newsBox.isNotEmpty) {
      log("Using cached news instead of hitting API");
      emit(NewsLoadedState(_newsBox.values.toList()));
      return;
    }

    emit(NewsLoadingState());

    try {
      final apiUrl = 'apiKey=$apiKey';
      final response = await _apiClient.request(
        endpoint: apiUrl,
        method: HttpMethod.get,
      );

      if (response?.statusCode == 200) {
        final articles =
            (response?.data['articles'] as List)
                .map((articleJson) => Newmodel.fromJson(articleJson))
                .toList();

        if (articles.isNotEmpty) {
          await _newsBox.clear();
          await _newsBox.addAll(articles);
        }

        emit(NewsLoadedState(articles));
      } else {
        log("API call failed. Loading cached news...");
        _loadCachedNews(emit);
      }
    } catch (e) {
      log("Network error: $e. Loading cached news...");
      _loadCachedNews(emit);
    }
  }

  //cache data
  void _loadCachedNews(Emitter<NewsState> emit) {
    if (_newsBox.isNotEmpty) {
      final cachedNews = _newsBox.values.toList();
      log('Loading cached news from Hive............');
      emit(NewsLoadedState(cachedNews));
    } else {
      emit(NewsErrorState("No news available."));
      log('No cached news found.');
    }
  }
}
