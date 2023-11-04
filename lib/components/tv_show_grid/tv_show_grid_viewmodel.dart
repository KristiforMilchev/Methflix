import 'package:domain/models/season_data.dart';
import 'package:domain/models/tv_show.dart';
import 'package:infrastructure/interfaces/ivideo_stream_service.dart';
import 'package:presentation/page_view_model.dart';

class TvShowGridViewModel extends PageViewModel {
  TvShow tvShow;
  late IVideoStreamService _streamService;
  List<SeasonData> _seasonData = [];
  List<SeasonData> get seasonsData => _seasonData;
  TvShowGridViewModel(super.context, this.tvShow);

  int movieRow = 1;

  ready() async {
    _streamService = getIt.get<IVideoStreamService>();

    var tvSeason = await _streamService.getSeasonData(tvShow.id);
    if (tvSeason == null) return;

    _seasonData = tvSeason.seasons;
    notifyListeners();
  }
}
