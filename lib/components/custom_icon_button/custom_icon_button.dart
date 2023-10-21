import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:presentation/components/custom_button/custom_button.dart';
import 'package:presentation/components/custom_icon_button/custom_icon_button_viewmodel.dart';
import 'package:stacked/stacked.dart';

//ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  final Widget? icon;
  final String label;
  final Function callback;
  late Color c1;
  late Color c2;
  late Color borderColor;
  late Color solidColor;
  late Color fontColor;
  bool disableGradient;
  List<double> stops;
  bool enabled;
  final bool playAnim;
  final BorderRadius? decorationRadius;
  final double? btnRadius;
  CustomIconButton({
    super.key,
    required this.label,
    this.icon,
    required this.callback,
    this.c1 = const Color.fromRGBO(0, 0, 0, 0.2),
    this.c2 = const Color.fromRGBO(0, 0, 0, 0),
    this.stops = const [0.2, 1.2],
    this.borderColor = Colors.white,
    this.solidColor = Colors.black45,
    this.disableGradient = false,
    this.fontColor = const Color.fromRGBO(255, 255, 255, 0.9),
    this.enabled = true,
    this.playAnim = false,
    this.btnRadius,
    this.decorationRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CustomIconButtonViewModel(),
      onViewModelReady: (viewModel) => viewModel.ready(playAnim),
      builder: (context, viewModel, child) => CustomButton(
        enabled: enabled,
        callback: () => enabled ? callback.call() : {},
        widget: Opacity(
          opacity: enabled ? 1 : 0.5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: decorationRadius ??
                  const BorderRadius.all(Radius.circular(28)),
              color: solidColor,
            ),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                border: GradientBoxBorder(
                  gradient: RadialGradient(
                    colors: [
                      borderColor,
                      const Color.fromRGBO(0, 0, 0, 0.2),
                    ],
                    radius: btnRadius ?? 10,
                    stops: const [0.001, 1],
                    focal: Alignment.topLeft,
                    focalRadius: 1,
                    transform: const GradientRotation(6.8),
                  ),
                  width: 1,
                ),
                gradient: disableGradient
                    ? null
                    : LinearGradient(
                        colors: [c1, c2],
                        stops: stops,
                        transform: const GradientRotation(143.26),
                      ),
                borderRadius: decorationRadius ??
                    const BorderRadius.all(Radius.circular(28)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                      visible: icon != null, child: icon ?? const Text("")),
                  if (icon != null)
                    const SizedBox(
                      width: 12,
                    ),
                  Text(
                    label,
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 18,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Loto",
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
