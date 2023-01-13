import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sitech_books/app/shared/models/book.dart';
import 'package:sitech_books/app/utils/local_cache.dart';

class BookDialog extends StatelessWidget {
  final Book book;
  const BookDialog({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    void showHint() {
      if (LocalCache.instance.has('hint-ack')) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: const Text(
            'Try to long press on a book...',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
            textColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        showHint();
        return true;
      },
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(8),
        title: Text(book.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImage(imageUrl: book.coverImg),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('By: ${book.author}',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          )),
                      Flexible(child: Text(book.description)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              showHint();
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
