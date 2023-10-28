import 'package:domain/models/categorie.dart';
import 'package:domain/models/movie.dart';

abstract class IVideoStreamService {
  Future<List<Category>> getAllCategories();
  Future<Movie?> getMovie(int id);
}
