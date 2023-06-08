import 'package:flutter/material.dart';
import 'package:movieapp_propnextest_mzulkifly/data/models/movie.dart';
import 'package:movieapp_propnextest_mzulkifly/presentation/styles.dart';

import 'package:movieapp_propnextest_mzulkifly/provider/movie_now_playing.dart';
import 'package:movieapp_propnextest_mzulkifly/provider/movie_popular.dart';
import 'package:movieapp_propnextest_mzulkifly/presentation/ui/movie_detail_page.dart';
import 'package:movieapp_propnextest_mzulkifly/presentation/widget/movie_background_image.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

enum TypeMovie { popular, nowPlaying }

class MoviePaginationPage extends StatefulWidget {
  const MoviePaginationPage({super.key, required this.type});

  final TypeMovie type;

  @override
  State<MoviePaginationPage> createState() => _MoviePaginationPageState();
}

class _MoviePaginationPageState extends State<MoviePaginationPage> {
  final PagingController<int, MovieModel> _pagingController = PagingController(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      switch (widget.type) {
        case TypeMovie.popular:
          context.read<MoviePopularProvider>().getPopularWithPaging(
                context,
                pagingController: _pagingController,
                page: pageKey,
              );
          break;

        case TypeMovie.nowPlaying:
          context.read<MovieNowPlayingProvider>().getNowPlayingWithPaging(
                context,
                pagingController: _pagingController,
                page: pageKey,
              );
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (_) {
          switch (widget.type) {
            case TypeMovie.nowPlaying:
              return const Text('Now Playing Movies');
            case TypeMovie.popular:
              return const Text('Popular Movies');
          }
        }),
        backgroundColor: appbarColor,
        foregroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: PagedListView.separated(
        padding: const EdgeInsets.all(16.0),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MovieModel>(
          itemBuilder: (context, item, index) => ItemMovieWidget(
            movie: item,
            imageHeight: 200,
            imageWidth: double.infinity,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) {
                  return MovieDetailPage(id: item.id);
                },
              ));
            },
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
