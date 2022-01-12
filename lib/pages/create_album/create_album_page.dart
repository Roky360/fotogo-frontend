import 'package:flutter/material.dart';
import 'package:fotogo/widgets/sliding_up_panel.dart';
import 'package:fotogo/theme/style.dart';
import 'package:sizer/sizer.dart';

class CreateAlbumPage extends StatelessWidget {
  const CreateAlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Schedule an album',
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
            width: 80.w,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Title',
                contentPadding: const EdgeInsets.fromLTRB(3, 20, 0, 0),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              style: Theme.of(context).textTheme.caption,
              textInputAction: TextInputAction.next,
            )),
      ],
    );
  }
}
