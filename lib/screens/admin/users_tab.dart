import 'package:flutter/material.dart';
import 'package:fotogo/widgets/section.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({Key? key}) : super(key: key);

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
        title: "Users",
        body: Column(
          children: [
            statisticItem(context, "user 1", 1),
            statisticItem(context, "user 2", 2),
            statisticItem(context, "user 3", 3),
          ],
        ));
  }
}
