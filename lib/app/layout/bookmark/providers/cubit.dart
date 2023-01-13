import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sitech_books/app/shared/models/book.dart';
import 'package:sitech_books/app/utils/local_cache.dart';

part 'states.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitial()) {
    loadBookmarks();
  }

  final List<Book> books = [];

  void loadBookmarks() {
    try {
      final data = LocalCache.instance.get('bookmarks') as List?;
      if (data != null) {
        books.addAll(data.map((e) => Book.fromJson(e)));
      }
      emit(BookmarkLoaded());
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }

  void removeFromBookmark(Book book) {
    books.remove(book);
    LocalCache.instance.save('bookmarks', books);
    emit(BookmarkLoaded());
  }
}
