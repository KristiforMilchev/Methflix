import 'package:flutter/material.dart';
import 'package:presentation/views/dashboard/dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DashboardViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => SingleChildScrollView(
        controller: viewModel.scrollController,
        child: Column(
          children: viewModel.movieLists
              .map(
                (e) => Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: viewModel.rowIndex == viewModel.movieLists.indexOf(e)
                      ? Container(
                          color: Colors.blue,
                          child: RawKeyboardListener(
                            focusNode: viewModel.focusNode,
                            onKey: (value) => viewModel.onRowChanged(e, value),
                            child: ListView.builder(
                              itemCount: e.movies.length,
                              scrollDirection: Axis.horizontal,
                              controller: viewModel.horizontalController,
                              itemBuilder: (context, index) => e.movies[index]
                                  ? Placeholder()
                                  : Container(
                                      color: Colors.red,
                                      child: Placeholder(),
                                    ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: e.movies.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Placeholder()),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
