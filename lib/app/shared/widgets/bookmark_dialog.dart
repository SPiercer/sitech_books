import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BookmarkDialog extends AlertDialog {
  const BookmarkDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Surprise!'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/surprise.json'),
          const Text(
            'You have added a new bookmark!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
              'Now you know how to add it.\nJust tap and hold any book to send it to the list!\nGo ahead and check it out in the bookmarks tab in the top corner.',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
              textAlign: TextAlign.center),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Amazing!'),
        ),
      ],
    );
  }
}
