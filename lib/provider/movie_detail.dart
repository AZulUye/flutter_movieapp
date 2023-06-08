import 'package:flutter/material.dart';
import 'package:movieapp_propnextest_mzulkifly/data/models/movie_detail.dart';
import 'package:movieapp_propnextest_mzulkifly/data/repositories/movie_repository.dart';

class MovieDetailProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieDetailProvider(this._movieRepository);

  MovieDetailModel? _movie;
  MovieDetailModel? get movie => _movie;

  void getDetail(BuildContext context, {required int id}) async {
    _movie = null;
    notifyListeners();
    final result = await _movieRepository.getDetail(id: id);
    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _movie = null;
        notifyListeners();
        return;
      },
      (response) {
        _movie = response;
        notifyListeners();
        return;
      },
    );
  }
}
