import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/authenticate/authenticate_viewmodel.dart';
import 'package:presentation/views/authenticate/panels/quick_connect_panel.dart';
import 'package:presentation/views/authenticate/panels/server_list_panel.dart';
import 'package:stacked/stacked.dart';

class AuthenticateView extends StatelessWidget {
  const AuthenticateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ThemeStyles.background100,
      child: ViewModelBuilder.reactive(
        viewModelBuilder: () => AuthenticateViewModel(context),
        onViewModelReady: (viewModel) => viewModel.ready(),
        builder: (context, viewModel, child) => RawKeyboardListener(
          focusNode: viewModel.node,
          onKey: viewModel.onKeyPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QuickConnectPanel(),
              ServerListPanel(
                servers: viewModel.servers,
                rowIndex: viewModel.row,
                controller: viewModel.controller,
              )
            ],
          ),
        ),
      ),
    );
  }
}
