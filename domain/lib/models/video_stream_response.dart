import 'dart:convert';
import 'dart:typed_data';

class VideoStreamResponse {
  Uint8List chunkData;
  int nextChunk;
  String extensionType;

  VideoStreamResponse({
    required this.chunkData,
    required this.nextChunk,
    required this.extensionType,
  });

  factory VideoStreamResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    print(json['chunkData']);
    var data = base64.decode(json['chunkData']);
    var test = "";
    return VideoStreamResponse(
      chunkData: Uint8List.fromList(data),
      nextChunk: json['nextChunk'],
      extensionType: json['extension'],
    );
  }
}
