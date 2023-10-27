import 'dart:convert';

import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:infrastructure/interfaces/ivideo_stream_service.dart';
import 'package:domain/models/video_stream_request.dart';
import 'package:domain/models/http_request.dart';

class VideoStreamService implements IVideoStreamService {
  IHttpProviderService _providerService;
  String apiEndpoint;

  VideoStreamService(this._providerService, this.apiEndpoint);

  @override
  Future getMovieChunks(int id, int from, int to, int lastSegment) async {
    var apiUrl = '${apiEndpoint}/v1/video/stream/segmented/your-request';

    // Create a VideoStreamRequest object with the required parameters.
    VideoStreamRequest request = VideoStreamRequest(
      segmentFrom: from, // Set the appropriate values
      segmentTo: to, // Set the appropriate values
      movieId: id, // Set the movie ID
      lastSegment: lastSegment, // Set the appropriate value
    );

    try {
      // Convert the request object to JSON.
      String requestBody = jsonEncode(request);

      var result = await _providerService.postRequest(HttpRequest(apiUrl, {
        'Content-Type': 'application/json',
      }, {}));
      return Future(() => null);
    } catch (e) {
      print('Error while fetching the next video segment: $e');
      return Future(() => null);
    }
  }
}
