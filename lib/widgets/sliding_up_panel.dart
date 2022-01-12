import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sizer/sizer.dart';

Widget getFotogoSlidingUpPanel(
  BuildContext context, {
  required Widget panelWidget,
  required Widget bodyWidget,
  required PanelController panelController,
}) {
  return SlidingUpPanel(
    panelBuilder: (scrollController) => buildSlidingPanel(
      panelWidget: panelWidget,
      scrollController: scrollController,
    ),
    body: bodyWidget,
    controller: panelController,
    maxHeight: 90.h,
    color: Theme.of(context).colorScheme.background,
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
    // parallaxEnabled: true,
    minHeight: 150,
  );
}

Widget buildSlidingPanel({
  required Widget panelWidget,
  required ScrollController scrollController,
}) {
  return Material(
    color: Colors.transparent,
    child: Column(
      children: [
        buildHandle(),
        const SizedBox(
          height: 10,
        ),
        panelWidget,
      ],
    ),
  );
}

Widget buildHandle() {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      width: 60,
      height: 8,
      decoration: BoxDecoration(
        // color: Colors.purpleAccent,
        color: Color.fromARGB(255, 210, 210, 210),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
