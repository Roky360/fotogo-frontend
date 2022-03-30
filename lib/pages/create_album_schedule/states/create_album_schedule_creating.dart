part of '../create_album_schedule_page.dart';

class CreateAlbumScheduleCreating extends StatelessWidget {
  final AlbumScheduleData data;
  final TextEditingController _controller = TextEditingController();

  CreateAlbumScheduleCreating({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.text = data.title;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 90.h),
      child: Column(
        children: [
          // Panel title
          Text(
            'Schedule an album',
            style: Theme.of(context).textTheme.headline6,
          ),
          const Spacer(flex: 1),
          SizedBox(
              width: 100.w - pageMargin * 2,
              child: TextField(
                enabled: false,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Title',
                  contentPadding: const EdgeInsets.fromLTRB(3, 20, 0, 0),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                style: Theme.of(context).textTheme.headline5,
              )),
          const Spacer(flex: 1),
          FotogoSection(
              title: 'Dates',
              body: Row(
                children: [
                  TextButton(
                      onPressed: null,
                      child: Text(formatDateRangeToString(data.dates)),
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
          const Spacer(flex: 1),
          FotogoSection(
            title: 'People',
            body: TextButton(
                onPressed: null,
                child: const Text('Add people to your album'),
                style: Theme.of(context).textButtonTheme.style),
          ),
          // SizedBox(height: 25.h),
          const Spacer(flex: 5),
          // Submit button
          ElevatedButton(
            onPressed: null,
            child: AppWidgets.fotogoCircularLoadingAnimation(),
          ),
          const Spacer(flex: 4),
        ],
      ),
    );
  }
}
