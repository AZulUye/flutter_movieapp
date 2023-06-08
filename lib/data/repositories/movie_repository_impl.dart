import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movieapp_propnextest_mzulkifly/data/models/movie.dart';
import 'package:movieapp_propnextest_mzulkifly/data/models/movie_detail.dart';
import 'package:movieapp_propnextest_mzulkifly/data/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio _dio;

  MovieRepositoryImpl(this._dio);

  @override
  Future<Either<String, MovieResponseModel>> getPopular({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get top rated movies');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Failed to load top rated movies');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getNowPlaying(
      {int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get now playing movies');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Failed to load now playing movies');
    }
  }

  @override
  Future<Either<String, MovieDetailModel>> getDetail({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieDetailModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get movie detail');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Failed to load movie detail');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> search({
    required String query,
  }) async {
    try {
      final result = await _dio.get(
        '/search/movie',
        queryParameters: {"query": query},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error search movie');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Failed to load search movie');
    }
  }
}
