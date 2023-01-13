import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sitech_books/app/layout/bookmark/providers/cubit.dart';
import 'package:sitech_books/app/shared/widgets/book_widget.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookmarkCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bookmarks'),
        ),
        body: BlocBuilder<BookmarkCubit, BookmarkState>(
          builder: (context, state) {
            final cubit = context.watch<BookmarkCubit>();
            if (cubit.books.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset('assets/bookmark.json'),
                    const Text(
                      'Looks like you have no bookmarks yet.\nGo ahead and bookmark some books!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                childAspectRatio: 1 / 1.2,
                mainAxisSpacing: 8,
              ),
              padding: const EdgeInsets.all(8),
              itemCount: cubit.books.length,
              itemBuilder: (context, index) {
                final book = cubit.books[index];
                return BookWidget(
                  book: book,
                  onLongPress: () =>
                      context.read<BookmarkCubit>().removeFromBookmark(book),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
