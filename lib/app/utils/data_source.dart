import 'package:dio/dio.dart';
import 'package:sitech_books/app/shared/models/book.dart';
import 'package:sitech_books/app/utils/local_cache.dart';

abstract class _DataSource {
  final Dio _dio;

  _DataSource(this._dio);

  Future<List<Book>> fetchBooks();

  Future<Book> fetchBook(int id);

  Future<void> deleteBook(Book book);
}

class RemoteSource extends _DataSource {
  RemoteSource(super.dio);

  /// Fetches all [Book]s.
  @override
  Future<List<Book>> fetchBooks() async {
    final response = await _dio.get('/books');
    final books = (response.data as List).map((e) => Book.fromJson(e)).toList();
    LocalCache.instance.save('books', books);
    return books;
  }

  /// Fetches a [Book] by its id.
  ///! wont be used as there's no extra info to be fetched.
  @override
  Future<Book> fetchBook(int id) async {
    final response = await _dio.get('/books/$id');
    return Book.fromJson(response.data);
  }

  /// Deletes a [Book] by its id.
  /// ! wont be used as i don't quite understand the purpose of it.
  @override
  Future<void> deleteBook(Book book) {
    throw UnimplementedError();
  }
}

class LocalSource extends _DataSource {
  LocalSource(super.dio);
  final _localCache = LocalCache.instance;

  /// Fetches a [Book] by its id.
  ///! wont be used as there's no extra info to be fetched.
  @override
  Future<Book> fetchBook(int id) async {
    final bookList = _localCache.get('books') as List<Book>;
    return bookList.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<Book>> fetchBooks() async {
    final books = _localCache.get('books') as List?;
    if (books == null) {
      return [];
    }
    return books.map((e) => Book.fromJson(e)).toList();
  }

  /// Deletes a [Book] by its id.
  /// ! wont be used as i don't quite understand the purpose of it.
  @override
  Future<void> deleteBook(Book book) {
    throw UnimplementedError();
  }
}
