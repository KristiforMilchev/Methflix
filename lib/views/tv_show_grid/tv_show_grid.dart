import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
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
          child: RawKeyboardListener(
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
                        const SizedBox(height: 16),
                        Text(
                          "Season ${e.season} ${viewModel.columnIndex} ${viewModel.rowIndex}",
                          style: ThemeStyles.regularParagraphOv(
                            size: 18,
                          ),
                          textAlign: TextAlign.start,
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
