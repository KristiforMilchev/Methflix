abstract class IVideoStreamService {
  Future getMovieChunks(int id, int from, int to, int lastSegment);
}
