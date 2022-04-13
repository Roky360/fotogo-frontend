import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eget purus gravida, lacinia nunc quis, commodo dolor. Quisque vitae luctus nibh. Nam bibendum orci euismod tempus lacinia. Quisque a feugiat ligula, ut interdum enim. Nulla eu nibh massa. Sed vitae tempus lectus, in faucibus massa. Donec in ante a dolor fringilla lacinia. Vestibulum at mattis arcu. Ut pellentesque diam id laoreet lacinia. Phasellus ut aliquet erat. Mauris viverra, ligula at iaculis posuere, orci enim bibendum orci, et commodo justo velit vitae nisl. Mauris bibendum suscipit est. Nam velit ante, ornare sit amet gravida sed, luctus ultricies turpis.',
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
        // change 'first_launch' to false, to never show the OnBoardingPage again.
        (await SharedPreferences.getInstance()).setBool('first_launch', false);
        Navigator.pushReplacementNamed(context, '/auth_checker');
      },
    );
  }
}
