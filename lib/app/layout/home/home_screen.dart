import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:once/once.dart';
import 'package:sitech_books/app/app.dart';
import 'package:sitech_books/app/layout/home/providers/cubit.dart';
import 'package:sitech_books/app/shared/widgets/book_widget.dart';
import 'package:sitech_books/app/shared/widgets/bookmark_dialog.dart';
import 'package:sitech_books/app/shared/widgets/disclaimer_dialog.dart';
import 'package:sitech_books/app/shared/widgets/material3_dialog.dart';
import 'package:sitech_books/app/utils/local_cache.dart';
import 'package:sitech_books/app/utils/repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(Repository.instance),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SiTech Books'),
          actions: [
            if (Platform.isAndroid)
              Switch(
                value: context.watch<ThemeCubit>().state,
                onChanged: context.read<ThemeCubit>().toggleTheme,
              ),
            IconButton(
              icon: const Icon(Icons.book_outlined),
              onPressed: () => Navigator.of(context).pushNamed('/bookmark'),
            )
          ],
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) async {
            if (state is HomeFirstLoad) {
              await showDialog(
                context: context,
                builder: (context) => const DisclaimerDialog(),
              );
              if (Platform.isAndroid) {
                await showDialog(
                  context: context,
                  builder: (context) => const MaterialYouDialog(),
                );
              }
            }

            if (state is HomeBookmarkAdded) {
              LocalCache.instance.save('hint-ack', true);
              Once.runOnce('Surprise-dialog',
                  callback: () => showGeneralDialog(
                        context: context,
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (_, __, ___) => const BookmarkDialog(),
                        transitionBuilder: (_, a1, __, child) {
                          var curve = Curves.easeInOut.transform(a1.value);
                          return Transform.scale(scale: curve, child: child);
                        },
                      ),
                  fallback: () {
                    Future.delayed(const Duration(milliseconds: 1000),
                        () => Navigator.pop(context));
                    showGeneralDialog(
                      context: context,
                      transitionDuration: const Duration(milliseconds: 300),
                      pageBuilder: (_, __, ___) =>
                          Lottie.asset('assets/surprise.json'),
                      transitionBuilder: (_, a1, __, child) {
                        var curve = Curves.easeInOut.transform(a1.value);
                        return Transform.scale(scale: curve, child: child);
                      },
                      barrierColor: Colors.transparent,
                      barrierDismissible: false,
                    );
                  });
            }
          },
          builder: (context, state) {
            final cubit = context.watch<HomeCubit>();

            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (cubit.visibleBooks.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Lottie.asset('assets/no-books.json'),
                    Text(
                      'Uh oh!\nLooks like there are no books here!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
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
              controller: cubit.scrollController,
              itemCount: cubit.visibleBooks.length,
              itemBuilder: (context, index) {
                final book = cubit.visibleBooks[index];
                return BookWidget(
                  book: book,
                  onLongPress: () =>
                      context.read<HomeCubit>().addToBookmark(book),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
