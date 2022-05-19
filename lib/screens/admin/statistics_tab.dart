import 'package:flutter/material.dart';
import 'package:fotogo/widgets/section.dart';

class StatisticsTab extends StatelessWidget {
  const StatisticsTab({Key? key}) : super(key: key);

  Widget statisticItem(BuildContext context, String title, final value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.normal)),
          const Spacer(),
          Text(value.toString(), style: Theme.of(context).textTheme.headline6),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FotogoSection(
        title: "General statistics",
        body: Column(
          children: [
            statisticItem(context, "Total users", 4),
            statisticItem(context, "Total albums", 10),
            statisticItem(context, "Total images", 24),
          ],
        ));
  }
}
