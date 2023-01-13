import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:once/once.dart';
import 'package:sitech_books/app/shared/models/book.dart';
import 'package:sitech_books/app/utils/local_cache.dart';
import 'package:sitech_books/app/utils/repository.dart';

part 'states.dart';

class HomeCubit extends Cubit<HomeState> {
  final Repository repository;
  HomeCubit(this.repository) : super(HomeInitial()) {
    showDisclaimer();
    fetchBooks();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreBooks();
      }
    });
  }

  final List<Book> books = [];
  final List<Book> visibleBooks = [];

  final scrollController = ScrollController();

  void showDisclaimer() {
    Once.runOnce(
      'disclaimer',
      debugCallback: kDebugMode,
      callback: () {
        emit(HomeFirstLoad());
      },
    );
  }

  void addToBookmark(Book book) {
    final bookmarks = LocalCache.instance.get('bookmarks') as List?;
    if (bookmarks != null) {
      final data = bookmarks.map((e) => Book.fromJson(e)).toList();
      if (data.any((element) => element.id == book.id)) return;
      data.add(book);
      LocalCache.instance.save('bookmarks', data);
    } else {
      LocalCache.instance.save('bookmarks', [book]);
    }
    emit(HomeBookmarkAdded());
  }

  Future<void> loadMoreBooks() async {
    final start = visibleBooks.length;
    final end = start + 10;
    visibleBooks.addAll(books.skip(start).take(end));
    emit(HomeLoaded());
  }

  Future<void> fetchBooks() async {
    emit(HomeLoading());
    try {
      final data = await repository.fetchBooks();
      books.addAll(data);
      visibleBooks.addAll(data.take(10));
      emit(HomeLoaded());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
