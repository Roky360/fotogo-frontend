import 'package:flutter/material.dart';
import 'package:fotogo/config/constants/theme_constants.dart';

class FotogoSection extends StatelessWidget {
  final String title;
  final Widget body;
  final EdgeInsets padding;
  final Widget action;

  const FotogoSection({
    Key? key,
    required this.title,
    required this.body,
    this.padding =
        const EdgeInsets.only(left: pageMargin, right: pageMargin, top: 35),
    this.action = const SizedBox(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: padding,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const Spacer(),
                  action
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              body
            ],
          ),
        ),
      ),
    );
  }
}
