import 'package:flutter/material.dart';
import 'package:fotogo/widgets/app_widgets.dart';

class FotogoSplashScreen extends StatelessWidget {
  final String message;
  final bool showLoadingAnimation;

  const FotogoSplashScreen(
      {Key? key, required this.message, this.showLoadingAnimation = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          heightFactor: .95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppWidgets.fotogoLogoFull(height: 50),
              const SizedBox(height: 40),
              showLoadingAnimation
                  ? AppWidgets.fotogoCircularLoadingAnimation()
                  : const SizedBox(),
              const SizedBox(height: 40),
              Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
      ),
    );
  }
}
