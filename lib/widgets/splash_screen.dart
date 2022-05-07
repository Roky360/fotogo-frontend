import 'package:flutter/material.dart';
import 'package:fotogo/widgets/app_widgets.dart';

class FotogoSplashScreen extends StatelessWidget {
  final String message;

  const FotogoSplashScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              AppWidgets.fotogoLogoFull(height: 50),
              const SizedBox(height: 30),
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
