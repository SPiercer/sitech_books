part of 'cubit.dart';

abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {}

class BookmarkError extends BookmarkState {
  final String message;
  BookmarkError(this.message);
}

/// Path: lib\app\layout\bookmark\providers\cubit.dart
