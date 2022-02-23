part of '../create_album_page.dart';

class CreateAlbumInitial extends StatefulWidget {
  const CreateAlbumInitial({Key? key}) : super(key: key);

  @override
  _CreateAlbumInitialState createState() => _CreateAlbumInitialState();
}

class _CreateAlbumInitialState extends State<CreateAlbumInitial> {
  final TextEditingController titleController = TextEditingController();
  DateTimeRange dateTimeRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  AlbumScheduleData newAlbumSchedule = AlbumScheduleData(
    title: '',
    dates: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
    sharedPeople: [],
  );

  void pickDates() async {
    final DateTimeRange? datePicked =
        await AppWidgets.fotogoDateRangePicker(context);

    if (datePicked != null) {
      setState(() {
        dateTimeRange = datePicked;
      });
    }
  }

  void onSubmit() {
    // title not provided
    if (titleController.text == '') {
      // TODO: add empty error message
    }

    newAlbumSchedule = AlbumScheduleData(
      title: titleController.text,
      dates: dateTimeRange,
      sharedPeople: [],
    );

    context
        .read<AlbumScheduleBloc>()
        .add(CreateAlbumSchedule(newAlbumSchedule));
  }

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
                controller: titleController,
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
          FotogoSection(
              title: 'Dates',
              body: Row(
                children: [
                  TextButton(
                      onPressed: pickDates,
                      child: Text(formatDateRangeToString(dateTimeRange)),
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
          FotogoSection(
            title: 'People',
            body: TextButton(
                onPressed: () {},
                child: const Text('Add people to your album'),
                style: Theme.of(context).textButtonTheme.style),
          ),
          SizedBox(
            height: 25.h,
          ),
          // Submit button
          ElevatedButton(
            onPressed: onSubmit,
            child: const Text('Create album schedule'),
            style: Theme.of(context).elevatedButtonTheme.style,
          ),
        ],
      ),
    );
  }
}
