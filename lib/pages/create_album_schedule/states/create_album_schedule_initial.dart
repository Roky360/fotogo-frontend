part of '../create_album_schedule_page.dart';

class CreateAlbumScheduleInitial extends StatefulWidget {
  const CreateAlbumScheduleInitial({Key? key}) : super(key: key);

  @override
  _CreateAlbumScheduleInitialState createState() =>
      _CreateAlbumScheduleInitialState();
}

class _CreateAlbumScheduleInitialState
    extends State<CreateAlbumScheduleInitial> {
  final _formKey = GlobalKey<FormState>();
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
    if (_formKey.currentState!.validate()) {
      context.read<AlbumBloc>().add(
            CreateAlbumScheduleEvent(
              AlbumScheduleData(
                title: titleController.text,
                dates: dateTimeRange,
                sharedPeople: [],
              ),
            ),
          );
    } else {
      AppWidgets.fotogoSnackBar(context, "Please provide a title.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 90.h),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Panel title
            Text(
              'Schedule an album',
              style: Theme.of(context).textTheme.headline6,
            ),
            // const SizedBox(height: 12),
            const Spacer(flex: 1),
            // Title text field
            SizedBox(
                width: 100.w - pageMargin * 2,
                child: TextFormField(
                  controller: titleController,
                  validator: (val) {
                    if (val == '') {
                      return "Title must not be empty";
                    }
                    return null;
                  },
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
            // const SizedBox(height: 35),
            const Spacer(flex: 1),
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
            // const SizedBox(height: 50),
            const Spacer(flex: 1),
            // People
            FotogoSection(
              title: 'People',
              body: TextButton(
                  onPressed: () {},
                  child: const Text('Add people to your album'),
                  style: Theme.of(context).textButtonTheme.style),
            ),
            // SizedBox(height: 25.h),
            const Spacer(flex: 5),
            // Submit button
            ElevatedButton(
              onPressed: onSubmit,
              child: const Text('Create album schedule'),
              style: Theme.of(context).elevatedButtonTheme.style,
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}

// old widget
/*    return Container(
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
    );*/
