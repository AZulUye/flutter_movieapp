import 'package:flutter/material.dart';
import 'package:movieapp_propnextest_mzulkifly/data/models/movie.dart';
import 'package:movieapp_propnextest_mzulkifly/data/models/movie_detail.dart';

import 'image_widget.dart';

class ItemMovieWidget extends Container {
  final MovieModel? movie;
  final MovieDetailModel? movieDetail;
  final double imageHeight;
  final double imageWidth;
  final double radius;
  final void Function()? onTap;

  ItemMovieWidget({
    required this.imageHeight,
    required this.imageWidth,
    this.radius = 12,
    this.movie,
    this.movieDetail,
    this.onTap,
    super.key,
  });

  @override
  Clip get clipBehavior => Clip.hardEdge;

  @override
  Decoration? get decoration => BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      );

  @override
  Widget? get child => Stack(
        children: [
          ImageNetworkWidget(
            imageSrc:
                '${movieDetail != null ? movieDetail!.backdropPath : movie!.backdropPath}',
            height: imageHeight,
            width: imageWidth,
          ),
          Container(
            height: imageHeight,
            width: imageWidth,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ),
        ],
      );
}
