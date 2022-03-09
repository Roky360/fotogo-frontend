import 'package:flutter/material.dart';
import 'package:fotogo/pages/auth_checker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'sign_in.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

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
        image: Container(
          color: Colors.grey[200],
        ),
        decoration: pageDecoration,
        titleWidget: Text(
          'Welcome',
          style: Theme.of(context).textTheme.headline5,
        ),
        bodyWidget: Text(
          'blah blah\n\n\n\n\n\n\\n\n\n\n\ns\\d\\n\n\n\n\\n\n\n\ndsgds',
          style: Theme.of(context).textTheme.headline5,
        ),
        useRowInLandscape: true
      ),
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
    return IntroductionScreen(
      pages: _getPages(context),
      showBackButton: true,
      // isProgress: false,
      // freeze: true,
      curve: Curves.easeInOutCirc,
      // animationDuration: 500,
      next: const Icon(Icons.arrow_forward),
      back: const Icon(Icons.arrow_back),
      done: Text('Continue', style: Theme.of(context).textTheme.subtitle1,),
      onDone: () => Navigator.pushReplacementNamed(context, '/auth_checker'),
    );
  }
}
