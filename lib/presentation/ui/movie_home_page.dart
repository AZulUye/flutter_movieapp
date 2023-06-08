import 'package:flutter/material.dart';

import 'package:movieapp_propnextest_mzulkifly/components/movie_now_playing_component.dart';
import 'package:movieapp_propnextest_mzulkifly/components/movie_popular_component.dart';
import 'package:movieapp_propnextest_mzulkifly/presentation/styles.dart';
import 'package:movieapp_propnextest_mzulkifly/presentation/ui/movie_pagination_page.dart';
import 'package:movieapp_propnextest_mzulkifly/presentation/ui/movie_search_page.dart';

class MovieHomePage extends StatelessWidget {
  const MovieHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Movie App'),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => showSearch(
                  context: context,
                  delegate: MovieSearchPage(),
                ),
                icon: const Icon(Icons.search),
              ),
            ],
            floating: true,
            snap: true,
            centerTitle: true,
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
          ),
          Title(
            title: 'Now Playing Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MoviePaginationPage(
                    type: TypeMovie.nowPlaying,
                  ),
                ),
              );
            },
          ),
          const MovieNowPlayingComponent(),
          Title(
            title: 'Popular Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MoviePaginationPage(
                    type: TypeMovie.popular,
                  ),
                ),
              );
            },
          ),
          const MoviePopularComponent(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
        ],
      ),
    );
  }
}

class Title extends SliverToBoxAdapter {
  final String title;
  final void Function() onPressed;

  const Title({super.key, required this.title, required this.onPressed});

  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: const StadiumBorder(),
              ),
              child: const Text('See All'),
            ),
          ],
        ),
      );
}
