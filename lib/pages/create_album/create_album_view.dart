import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fotogo/widgets/section.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CreateAlbumPage extends StatelessWidget {
  CreateAlbumPage({Key? key}) : super(key: key);
  final FocusNode titleNode = FocusNode(debugLabel: "FUCK");
  final DateRangePickerController controller = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          // Panel title
          Text(
            'Schedule an album',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 12,
          ),
          // Title text field
          SizedBox(
              width: 90.w,
              child: TextField(
                focusNode: titleNode,
                decoration: InputDecoration(
                  hintText: 'Title',
                  contentPadding: const EdgeInsets.fromLTRB(3, 20, 0, 0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                style: Theme.of(context).textTheme.headline5,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
              )),
          const SizedBox(
            height: 35,
          ),
          // Dates
          section(context,
              title: 'Dates',
              body: Row(
                children: [
                  TextButton(
                      onPressed: () async {
                        showDialog<Widget>(
                            context: context,
                            builder: (BuildContext context) {
                              return SfDateRangePicker(
                                showActionButtons: true,
                                onSubmit: (Object? value) {
                                  Navigator.pop(context);
                                },
                                onCancel: () {
                                  Navigator.pop(context);
                                },
                              );
                            });

                        // final datePicked = await
                        // showDatePicker(
                        //   context: context,
                        //   initialDate: DateTime.now(),
                        //   firstDate: DateTime.now(),
                        //   lastDate: DateTime(DateTime.now().year + 5),
                        //   helpText: "SELECT RANGE DATES",
                        // );
                      },
                      child: const Text('Choose dates'),
                      style: Theme.of(context).textButtonTheme.style),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.event),
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 50,
          ),
          // People
          section(
            context,
            title: 'People',
            body: TextButton(
                onPressed: () {},
                child: const Text('Add people to your album'),
                style: Theme.of(context).textButtonTheme.style),
          ),
          SizedBox(
            height: 25.h,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Create album schedule'),
            style: Theme.of(context).elevatedButtonTheme.style,
          ),
        ],
      ),
    );
  }
}
