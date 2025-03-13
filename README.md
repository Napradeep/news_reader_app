# Flutter News Reader App

A modern Flutter application that fetches and displays news articles from an API. It supports offline caching, state management, and a sleek UI with shimmer effects.

## Features

Fetches the latest news from an API (e.g., NewsAPI)  
Displays articles with images, titles, descriptions, and published dates  
Supports offline caching using Hive  
Implements BLoC for state management 
Shimmer effect for better UX while loading  
Error handling with a FAB button when API fails  

## Clone the Repository  

git clone https://github.com/YOUR_GITHUB_USERNAME/flutter_news_reader.git
cd flutter_news_reader

##  Dependency used

Flutter_bloc - state management
dio - api call
hive - local storage
hive_flutter - flutter biniding for hive
path_provider - get a dircetories from the storing files
shimmer - loading effect
equatable - simplifies state comparision


## To install all Dependency:

flutter pub get


## App Structure 
lib/
│── main.dart            
│── src/
│   ├── bloc/                 # BLoC state management
│   │   ├── news_bloc/
│   │   │   ├── news_bloc.dart
│   │   │   ├── news_event.dart
│   │   │   ├── news_state.dart
│   │   ├── connectivity_bloc/
│   │   │   ├── connectivity_bloc.dart
│   │   │   ├── connectivity_event.dart
│   │   │   ├── connectivity_state.dart
│   ├── model/                # Data models
│   │   ├── new_model.dart
│   │   ├── new_model.g.dart  # Generated Hive adapter
│   ├── utils/                # Utility functions
│   │   ├── constants.dart
│   │   ├── dio.dart
│   │   ├── router.dart
│   │   ├── snackbar.dart
│   │   ├── spacer.dart
│   ├── view/                 # Screens / Views
│   │   ├── home_screen.dart
│   │   ├── detail_screen.dart
│   ├── widgets/              # Reusable UI components
│   │   ├── news_card.dart
│   │   ├── shimmer_news_card.dart

## Api Key 
   Store in Environment Variables this Recommended but i am storing in constants.dart

## APK LINK
https://we.tl/t-2GJaoHZEhj




