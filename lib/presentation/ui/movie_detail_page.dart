import 'package:flutter/material.dart';
import 'package:movieapp_propnextest_mzulkifly/components/movie_now_playing_component.dart';
import 'package:movieapp_propnextest_mzulkifly/components/movie_popular_component.dart';
import 'package:movieapp_propnextest_mzulkifly/data/injection.dart';
import 'package:movieapp_propnextest_mzulkifly/presentation/styles.dart';
import 'package:movieapp_propnextest_mzulkifly/provider/movie_detail.dart';
import 'package:movieapp_propnextest_mzulkifly/presentation/widget/movie_background_image.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              serviceLocator<MovieDetailProvider>()..getDetail(context, id: id),
        ),
      ],
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomAppBar(context),
            const MovieSummary(),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends SliverAppBar {
  final BuildContext context;

  const CustomAppBar(this.context, {super.key});

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Color? get foregroundColor => primaryColor;

  @override
  Widget? get leading => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: primaryColor,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      );

  @override
  double? get expandedHeight => 250;

  @override
  Widget? get flexibleSpace => Consumer<MovieDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;

          if (movie != null) {
            return ItemMovieWidget(
              movieDetail: movie,
              imageHeight: double.infinity,
              imageWidth: double.infinity,
              radius: 0,
            );
          }

          return Container(
            color: primaryColor,
            height: double.infinity,
            width: double.infinity,
          );
        },
      );
}

class MovieContent extends StatelessWidget {
  final String title;
  final Widget body;
  final double padding;

  const MovieContent(
      {super.key,
      required this.title,
      required this.body,
      this.padding = 16.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 8.0,
          ),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: body,
        ),
      ],
    );
  }
}

class MovieSummary extends SliverToBoxAdapter {
  const MovieSummary({super.key});

  @override
  Widget? get child => Consumer<MovieDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;
          if (movie != null) {
            return SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieContent(
                      title: movie.title,
                      body: Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                          ),
                          Text(
                            '${movie.voteAverage}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            ' (${movie.voteCount})',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                  MovieContent(
                    title: 'Release Date',
                    body: Row(
                      children: [
                        const Icon(Icons.calendar_month_rounded,
                            size: 20.0, color: Colors.white),
                        const SizedBox(width: 6.0),
                        Text(
                          movie.releaseDate.toString().split(' ').first,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MovieContent(
                    title: 'Genres',
                    body: Wrap(
                      spacing: 6,
                      children: movie.genres
                          .map((genre) => Chip(label: Text(genre.name)))
                          .toList(),
                    ),
                  ),
                  MovieContent(
                    title: 'Overview',
                    body: Text(
                      movie.overview,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      );
}
