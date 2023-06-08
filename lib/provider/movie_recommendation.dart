import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movieapp_propnextest_mzulkifly/data/models/movie.dart';
import 'package:movieapp_propnextest_mzulkifly/data/repositories/movie_repository.dart';

class MovieRecommendationProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieRecommendationProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void getRecommendation(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepository.getRecommendations(id: 1);

    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _isLoading = false;
        notifyListeners();
        return;
      },
      (response) {
        _movies.clear();
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return;
      },
    );
  }

  void getRecommendationWithPaging(
    BuildContext context, {
    required PagingController pagingController,
    required int page,
  }) async {
    final result = await _movieRepository.getRecommendations(id: 1);

    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        pagingController.error = messageError;
        return;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          pagingController.appendPage(response.results, id(1) + 1);
        }
        return;
      },
    );
  }
}
