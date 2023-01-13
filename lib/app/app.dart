import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sitech_books/app/layout/bookmark/bookmark_screen.dart';
import 'package:sitech_books/app/layout/home/home_screen.dart';
import 'package:sitech_books/app/shared/constants.dart' as theme;

/// using bool as state for simplicity
/// false indicates that the app is using the device's Material You theme (android 12+)
/// true indicates that the app is using the app's predefined theme
class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);

  void toggleTheme(bool? val) => emit(val!);
}

class SitechBooks extends StatelessWidget {
  const SitechBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, useAppTheme) {
          return MaterialApp(
              title: 'Sitech Books',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: !useAppTheme ? theme.lightColorScheme : null,
                scaffoldBackgroundColor:
                    !useAppTheme ? theme.lightColorScheme.background : null,
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: !useAppTheme ? theme.darkColorScheme : null,
                scaffoldBackgroundColor:
                    !useAppTheme ? theme.darkColorScheme.background : null,
              ),
              initialRoute: '/',
              routes: {
                '/': (context) => const HomeScreen(),
                '/bookmark': (context) => const BookmarkScreen(),
              });
        },
      ),
    );
  }
}
