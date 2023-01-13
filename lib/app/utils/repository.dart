import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sitech_books/app/shared/models/book.dart';
import 'package:sitech_books/app/utils/data_source.dart';
import 'package:sitech_books/app/utils/service_locator.dart';

enum _ConnectionStatus { online, offline }

class Repository {

  static Repository get instance => locator.get(); 

  late final _ConnectionStatus _currentConnectionStatus;

  Future<void> _checkConnectionStatus() async {
    final result = await Connectivity().checkConnectivity();
    log(result.name);
    if (result == ConnectivityResult.none) {
      _currentConnectionStatus = _ConnectionStatus.offline;
    } else {
      _currentConnectionStatus = _ConnectionStatus.online;
    }
  }

  final _remoteSource = locator<RemoteSource>();
  final _localSource = locator<LocalSource>();

  Future<Book> fetchBook(int id) async {
    await _checkConnectionStatus();
    if (_currentConnectionStatus == _ConnectionStatus.online) {
      return _remoteSource.fetchBook(id);
    }
    return _localSource.fetchBook(id);
  }

  Future<List<Book>> fetchBooks() async {
    await _checkConnectionStatus();
    if (_currentConnectionStatus == _ConnectionStatus.online) {
      return _remoteSource.fetchBooks();
    }
    return _localSource.fetchBooks();
  }

  /// ! wont be used as i don't quite understand the purpose of it.
  Future<void> deleteBook(Book book) {
    throw UnimplementedError();
  }
}
