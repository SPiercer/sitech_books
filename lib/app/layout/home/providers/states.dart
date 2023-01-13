part of 'cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

class HomeFirstLoad extends HomeState {}

class HomeBookmarkAdded extends HomeState {}

/// Path: lib\app\layout\home\providers\cubit.dart
