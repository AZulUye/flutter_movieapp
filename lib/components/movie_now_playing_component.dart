import 'package:flutter/material.dart';
import 'package:movieapp_propnextest_mzulkifly/provider/movie_now_playing.dart';
import 'package:movieapp_propnextest_mzulkifly/presentation/ui/movie_detail_page.dart';
import 'package:movieapp_propnextest_mzulkifly/presentation/widget/image_widget.dart';
import 'package:provider/provider.dart';

class MovieNowPlayingComponent extends StatefulWidget {
  const MovieNowPlayingComponent({super.key});

  @override
  State<MovieNowPlayingComponent> createState() =>
      MovieNowPlayingComponentState();
}

class MovieNowPlayingComponentState extends State<MovieNowPlayingComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieNowPlayingProvider>().getNowPlaying(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: SizedBox(
          height: 200,
          child: Consumer<MovieNowPlayingProvider>(
            builder: (_, provider, __) {
              if (provider.isLoading) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12.0)),
                );
              }

              if (provider.movies.isNotEmpty) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return ImageNetworkWidget(
                      imageSrc: provider.movies[index].posterPath,
                      height: 220,
                      width: 140,
                      radius: 12.0,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) {
                            return MovieDetailPage(
                                id: provider.movies[index].id);
                          },
                        ));
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(
                    width: 8.0,
                  ),
                  itemCount: provider.movies.length,
                );
              }

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                  child: Text('Not found now playing movies'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
