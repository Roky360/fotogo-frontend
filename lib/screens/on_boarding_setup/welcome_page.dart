import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);

  final ConfettiController _confettiController = ConfettiController();

  List<PageViewModel> _getPages(BuildContext context) {
    PageDecoration pageDecoration = const PageDecoration(
      imageAlignment: Alignment.center,
      // fullScreen: true,
      imageFlex: 2,
      bodyFlex: 4,
    );

    return [
      // welcome
      PageViewModel(
          image: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: 1.5 * pi,
            blastDirectionality: BlastDirectionality.explosive,
            gravity: .05,
            numberOfParticles: 8,
            shouldLoop: true,
            child: Container(
              // color: Colors.grey[200],
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  AppWidgets.fotogoLogoFull(height: 50),
                ],
              ),
            ),
          ),
          decoration: pageDecoration,
          titleWidget: Column(
            children: [
              SizedBox(height: 10.h),
              Text(
                'Welcome to fotogo!',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontSize: 24),
              ),
            ],
          ),
          bodyWidget: Text(
            "",
            // "Welcome to fotogo!\n"
            // "This is a gallery app. You can create your own albums from your "
            // "gallery, they will be saved in the cloud, and you will be able to "
            // "access them from any device.\n"
            // "For your convenience, the account system is made with Google "
            // "accounts, so you don't have to remember another password.\n"
            // "\n"
            // "That's it, hope you will enjoy my app!\n\n"
            // "* This project was made as a 12th grade final project ",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.normal),
          ),
          useRowInLandscape: true),
      // preferences
      // PageViewModel(
      //   titleWidget: Text(
      //     'Initial Preferences',
      //     style: Theme.of(context).textTheme.headline5,
      //   ),
      //   bodyWidget: Text(
      //     'body',
      //     style: Theme.of(context).textTheme.headline6,
      //   ),
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _confettiController.play();

    return IntroductionScreen(
      pages: _getPages(context),
      showBackButton: true,
      // isProgress: false,
      // freeze: true,
      curve: Curves.easeInOutCirc,
      // animationDuration: 500,
      next: const Icon(Icons.arrow_forward),
      back: const Icon(Icons.arrow_back),
      done: Text(
        'Continue',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      onDone: () async {
        // change 'first_launch' to false, to never show the WelcomePage again.
        (await SharedPreferences.getInstance()).setBool('first_launch', false);

        Navigator.pushReplacementNamed(context, '/auth_checker');
      },
    );
  }
}
