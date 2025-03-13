import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/src/bloc/conectivity_bloc/connectivity_bloc.dart';
import 'package:newapp/src/bloc/conectivity_bloc/connectivity_event.dart';
import 'package:newapp/src/bloc/conectivity_bloc/connectivity_state.dart';
import 'package:newapp/src/bloc/new_bloc/news_bloc.dart';
import 'package:newapp/src/bloc/new_bloc/news_event.dart';
import 'package:newapp/src/bloc/new_bloc/news_state.dart';
import 'package:newapp/src/utils/snackbar/messager.dart';
import 'package:newapp/src/widget/container.dart';
import 'package:newapp/src/widget/shimmer_container.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  bool _wasOffline = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnectivityBloc()..add(CheckConnectivity()),
        ),
        BlocProvider(create: (context) => NewsBloc()..add(FetchnewsEvent())),
      ],
      child: BlocListener<ConnectivityBloc, ConnectivityState>(
        listener: (context, state) {
          if (state is ConnectivityOffline) {
            _wasOffline = true;
            Messenger.alertError("No Internet Connection!");
          } else if (state is ConnectivityOnline) {
            if (_wasOffline) {
              Messenger.alertSuccess("Back Online!");
            }
            _wasOffline = false;
            context.read<NewsBloc>().add(FetchnewsEvent());
          }
        },
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: false,
                title: const Text("News Reader App"),
              ),
              body: _buildBody(state),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.read<NewsBloc>().add(FetchnewsEvent());
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.refresh, color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(NewsState state) {
    if (state is NewsLoadingState) {
      return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return ShimmerNewsCard();
        },
      );

      // return const ShimmerNewsCard();
    } else if (state is NewsLoadedState) {
      log(state.articles.length.toString());
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: state.articles.length,
        itemBuilder: (context, index) {
          return NewsCard(article: state.articles[index]);
        },
      );
    } else if (state is NewsErrorState) {
      return Center(
        child: Text(
          state.message,
          style: const TextStyle(color: Colors.red, fontSize: 18),
        ),
      );
    }
    return InkWell(
      onTap: () {
        context.read<NewsBloc>().add(FetchnewsEvent());
      },
      child: const Center(child: Text("Press the button to load news")),
    );
  }
}
