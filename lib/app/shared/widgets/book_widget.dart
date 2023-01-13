import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sitech_books/app/shared/models/book.dart';
import 'package:sitech_books/app/shared/widgets/book_dialog.dart';

class BookWidget extends StatelessWidget {
  final Book book;
  final void Function() onLongPress;
  const BookWidget({
    super.key,
    required this.book,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          showDialog(
              context: context, builder: (context) => BookDialog(book: book));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: CachedNetworkImage(imageUrl: book.coverImg),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.name,
                    style:
                        const TextStyle(fontWeight: FontWeight.bold, height: 1),
                  ),
                  Text(
                    book.author,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
