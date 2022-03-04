part of '../create_album_page.dart';

class CreateAlbumCreating extends StatefulWidget {
  final AlbumScheduleData data;

  const CreateAlbumCreating({Key? key, required this.data}) : super(key: key);

  @override
  _CreateAlbumCreatingState createState() => _CreateAlbumCreatingState();
}

class _CreateAlbumCreatingState extends State<CreateAlbumCreating> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller.text = widget.data.title;
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
                enabled: false,
                controller: controller,
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
                      onPressed: null,
                      child: Text(formatDateRangeToString(widget.data.dates)),
                      style: Theme.of(context).textButtonTheme.style),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.event),
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
                onPressed: null,
                child: const Text('Add people to your album'),
                style: Theme.of(context).textButtonTheme.style),
          ),
          SizedBox(
            height: 25.h,
          ),
          // Submit button
          ElevatedButton(
            onPressed: null,
            child: AppWidgets.fotogoCircularLoadingAnimation(),
          ),
        ],
      ),
    );
  }
}
