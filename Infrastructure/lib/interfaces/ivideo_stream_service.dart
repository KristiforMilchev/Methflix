import 'package:domain/models/categorie.dart';
import 'package:domain/models/movie.dart';
import 'package:domain/models/tv_show_season.dart';

abstract class IVideoStreamService {
  Future<List<Category>> getAllCategories();
  Future<Movie?> getMovie(int id);
  Future<TvShowSeason?> getSeasonData(int seasonId);
}
