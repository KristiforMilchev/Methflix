import 'dart:async';
import 'dart:convert';

import 'package:domain/models/categorie.dart';
import 'package:domain/models/movie.dart';
import 'package:domain/models/http_request.dart';
import 'package:domain/models/tv_show_season.dart';
import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:infrastructure/interfaces/ivideo_stream_service.dart';

class VideoStreamService implements IVideoStreamService {
  IHttpProviderService _providerService;
  String apiEndpoint;

  VideoStreamService(this._providerService, this.apiEndpoint);

  @override
  Future<List<Category>> getAllCategories() async {
    var apiUrl = '$apiEndpoint/API/V1/Movies/Categories';

    // Convert the request object to JSON.

    var result = await _providerService.getRequest(
      HttpRequest(apiUrl, {
        'Content-Type': 'application/json',
      }, {}),
    );

    if (result == null || result.statusCode != 200)
      throw Exception("Can't get API data");

    List<Category> categories = [];
    var data = jsonDecode(result.body);
    for (var categoryMap in data) {
      var current = Category.fromJson(categoryMap);
      categories.add(current);
    }

    return categories;
  }

  @override
  Future<Movie?> getMovie(int id) async {
    var apiUrl = '$apiEndpoint/API/V1/Movies/$id';

    try {
      // Convert the request object to JSON.

      var result = await _providerService.getRequest(
        HttpRequest(apiUrl, {
          'Content-Type': 'application/json',
        }, {}),
      );

      if (result == null || result.statusCode != 200) return null;

      var data = jsonDecode(result.body);

      var current = Movie.fromJson(data);

      return current;
    } catch (e) {
      print('Error while fetching the categories: $e');
      return null;
    }
  }

  @override
  Future<TvShowSeason?> getSeasonData(int seasonId) async {
    var apiUrl = '$apiEndpoint/API/V1/Movies/Tv-Show-Episodes/$seasonId';

    try {
      // Convert the request object to JSON.

      var result = await _providerService.getRequest(
        HttpRequest(apiUrl, {
          'Content-Type': 'application/json',
        }, {}),
      );

      if (result == null || result.statusCode != 200) return null;

      var data = jsonDecode(result.body);

      var current = TvShowSeason.fromJson(data);

      return current;
    } catch (e) {
      print('Error while fetching the categories: $e');
      return null;
    }
  }
}
