import 'package:flutter/material.dart';

Widget section(
  context, {
  required String title,
  required Widget body,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, top: 35,),
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
