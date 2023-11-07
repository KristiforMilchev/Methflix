import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/views/tv_show_grid/tv_show_grid_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TvShowGrid extends StatelessWidget {
  const TvShowGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TvShowGridViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.background100,
        child: SingleChildScrollView(
          controller: viewModel.scrollController,
          child: RawKeyboardListener(
            autofocus: true,
            focusNode: viewModel.focusNode,
            onKey: (value) => viewModel.onRowChanged(value),
            child: Column(
              children: viewModel.seasonsData.map(
                (e) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: viewModel.missingImage,
                          child: Container(
                            child: Image.memory(
                              viewModel.thumbnail,
                              fit: BoxFit.fill,
                              width: ThemeStyles.width!,
                              height: ThemeStyles.height! / 2,
                            ),
                          ),
                          replacement: Container(
                            width: ThemeStyles.width!,
                            height: ThemeStyles.height! / 2,
                            decoration: BoxDecoration(
                              color: ThemeStyles.background300,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(60),
                            child: Center(
                              child: SvgPicture.asset(
                                "packages/domain/assets/images/season.svg",
                                fit: BoxFit.fill,
                                alignment: Alignment.center,
                                width: ThemeStyles.width! / 6,
                                height: ThemeStyles.width! / 9,
                                colorFilter: ColorFilter.mode(
                                    ThemeStyles.accent200, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.tvShow.name,
                              style: ThemeStyles.regularParagraphOv(
                                size: 30,
                                color: ThemeStyles.accent100,
                              ),
                            ),
                            Expanded(child: Container()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Genre: Sci-fy",
                                  style: ThemeStyles.regularParagraphOv(
                                    size: 12,
                                    color: ThemeStyles.accent200,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "Year: 2005-2007",
                                  style: ThemeStyles.regularParagraphOv(
                                    size: 12,
                                    color: ThemeStyles.accent200,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "Total seasons: ${viewModel.tvShow.seasons}",
                                  style: ThemeStyles.regularParagraphOv(
                                    size: 12,
                                    color: ThemeStyles.accent200,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (viewModel.tvShow.description != null)
                          Text(
                            viewModel.tvShow.description!,
                            style: ThemeStyles.regularParagraph,
                          ),
                        if (viewModel.tvShow.description == null)
                          Container(
                            height: ThemeStyles.height! / 3,
                            width: ThemeStyles.width,
                            decoration: BoxDecoration(
                              color: ThemeStyles.background200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Missing description",
                                  style: ThemeStyles.regularParagraphOv(
                                      color: ThemeStyles.accent200),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Season ${e.season}",
                              style: ThemeStyles.regularParagraphOv(
                                  size: 18, color: ThemeStyles.accent100),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "Episodes ${e.movies.length}",
                              style: ThemeStyles.regularParagraphOv(
                                  size: 18, color: ThemeStyles.accent100),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ...viewModel.getMovie(e)
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
