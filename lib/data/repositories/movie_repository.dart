import 'package:dartz/dartz.dart';
import 'package:movieapp_propnextest_mzulkifly/data/models/movie.dart';
import 'package:movieapp_propnextest_mzulkifly/data/models/movie_detail.dart';

abstract class MovieRepository {
  Future<Either<String, MovieResponseModel>> getPopular({int page = 1});
  Future<Either<String, MovieResponseModel>> getNowPlaying({int page = 1});
  Future<Either<String, MovieResponseModel>> search({required String query});
  Future<Either<String, MovieDetailModel>> getDetail({required int id});
}
