import 'package:flutter/material.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/widgets/section.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: fPageMargin, vertical: fPageMargin * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "People",
            style: Theme.of(context).textTheme.headline4,
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sharing and collaborating are",
                      style: Theme.of(context).textTheme.bodyText1),
                  Text("Coming soon!",
                      style: Theme.of(context).textTheme.headline5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
