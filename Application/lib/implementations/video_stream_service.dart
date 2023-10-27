import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:infrastructure/interfaces/ivideo_stream_service.dart';
import 'package:domain/models/video_stream_request.dart';
import 'package:domain/models/http_request.dart';
import 'package:domain/models/video_stream_response.dart';
import 'package:path_provider/path_provider.dart';

class VideoStreamService implements IVideoStreamService {
  IHttpProviderService _providerService;
  String apiEndpoint;

  VideoStreamService(this._providerService, this.apiEndpoint);

  @override
  Future<VideoStreamResponse?> getMovieChunks(
      int id, int from, int to, int lastSegment) async {
    var apiUrl = '$apiEndpoint/v1/video/stream/segmented';

    // Create a VideoStreamRequest object with the required parameters.
    VideoStreamRequest request = VideoStreamRequest(
      segmentFrom: from, // Set the appropriate values
      segmentTo: to, // Set the appropriate values
      movieId: id, // Set the movie ID
      lastSegment: lastSegment, // Set the appropriate value
    );

    try {
      // Convert the request object to JSON.
      var requestBody = request.toJson();

      var result = await _providerService.postRequest(
        HttpRequest(
          apiUrl,
          {
            'Content-Type': 'application/json',
          },
          requestBody,
        ),
      );

      if (result == null) return null;
      var data = jsonDecode(result);

      var response = VideoStreamResponse.fromJson(data);
      await saveUint8ListToTempFile(response.chunkData, id.toString(),
          "chunk_${from}_$to${response.extensionType}");

      return response;
    } catch (e) {
      print('Error while fetching the next video segment: $e');
      return null;
    }
  }

  Future<void> saveUint8ListToTempFile(
      Uint8List data, String directory, String name) async {
    try {
      final Directory tempDir = await getTemporaryDirectory();

      if (!Directory("${tempDir.path}/$directory").existsSync()) {
        Directory("${tempDir.path}/$directory").createSync();
      }

      final String tempFilePath = '${tempDir.path}/$directory/$name';

      final File tempFile = File(tempFilePath);
      await tempFile.writeAsBytes(data, flush: true);
    } catch (ex) {
      print(ex);
    }
  }

  Future<File?> getFile(int from, int to, int id, String ext) async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final String tempFilePath = '${tempDir.path}/$id/chunk_${from}_$to${ext}';

      var file = File(tempFilePath);

      if (!file.existsSync()) return null;

      return file;
    } catch (ex) {
      return null;
    }
  }

  Future<bool> deleteCache() async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final String tempFilePath = '${tempDir.path}/3';
      Directory(tempFilePath).deleteSync(recursive: true);
      return true;
    } catch (ex) {
      return false;
    }
  }
}
