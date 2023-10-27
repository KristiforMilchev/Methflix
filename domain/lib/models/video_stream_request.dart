class VideoStreamRequest {
  final int segmentFrom;
  final int segmentTo;
  final int movieId;
  final int lastSegment;

  VideoStreamRequest({
    required this.segmentFrom,
    required this.segmentTo,
    required this.movieId,
    required this.lastSegment,
  });

  factory VideoStreamRequest.fromJson(Map<String, dynamic> json) {
    return VideoStreamRequest(
      segmentFrom: json['segmentFrom'],
      segmentTo: json['segmentTo'],
      movieId: json['movieId'],
      lastSegment: json['lastSegment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SegmentFrom': segmentFrom,
      'SegmentTo': segmentTo,
      'MovieId': movieId,
      'LastSegment': lastSegment,
    };
  }
}
