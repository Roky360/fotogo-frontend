import 'package:flutter/material.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:sizer/sizer.dart';

class FotogoSection extends StatelessWidget {
  final String title;
  final Widget body;

  const FotogoSection({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: pageMargin,
        top: 35,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 20,
            ),
            body
          ],
        ),
      ),
    );
  }
}
