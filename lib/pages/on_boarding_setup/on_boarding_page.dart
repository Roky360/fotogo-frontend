import 'package:flutter/material.dart';
import 'package:fotogo/pages/auth_checker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'sign_in.dart';

class LoginAndSetup extends StatelessWidget {
  const LoginAndSetup({Key? key}) : super(key: key);

  List<PageViewModel> getPages(BuildContext context) {
    return [
      PageViewModel(
        titleWidget: Text(
          'PAGE 1',
          style: Theme.of(context).textTheme.headline5,
        ),
        bodyWidget: const AuthChecker(),
      ),
      PageViewModel(
        titleWidget: Text(
          'PAGE 2',
          style: Theme.of(context).textTheme.headline5,
        ),
        bodyWidget: Text(
          'body',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      PageViewModel(
        titleWidget: Text(
          'PAGE 3',
          style: Theme.of(context).textTheme.headline5,
        ),
        bodyWidget: Text(
          'body',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: getPages(context),
      // rawPages: [],
      showNextButton: true,
      next: Text(
        'Next',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      done: Text(
        'Finish!',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      onDone: () {},
      curve: Curves.easeInOutCirc,
      // animationDuration: 500,
    );
  }
}
