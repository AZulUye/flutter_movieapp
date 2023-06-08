import 'package:flutter/material.dart';
import 'package:movieapp_propnextest_mzulkifly/presentation/styles.dart';
import 'package:provider/provider.dart';
import 'package:movieapp_propnextest_mzulkifly/data/injection.dart';

import 'package:movieapp_propnextest_mzulkifly/provider/movie_now_playing.dart';
import 'package:movieapp_propnextest_mzulkifly/provider/movie_search.dart';
import 'package:movieapp_propnextest_mzulkifly/provider/movie_popular.dart';
import 'package:movieapp_propnextest_mzulkifly/presentation/ui/movie_home_page.dart';

void main() {
  serviceLocatorSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => serviceLocator<MovieNowPlayingProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => serviceLocator<MoviePopularProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => serviceLocator<MovieSearchProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie App',
        home: const MovieHomePage(),
        theme: ThemeData(scaffoldBackgroundColor: primaryColor),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
