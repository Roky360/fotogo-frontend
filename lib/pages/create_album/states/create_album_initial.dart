part of '../create_album_page.dart';

class CreateAlbumInitial extends StatefulWidget {
  late final List<File> images;

  CreateAlbumInitial({Key? key, images}) : super(key: key) {
    this.images = images ?? [];
  }

  @override
  _CreateAlbumInitialState createState() => _CreateAlbumInitialState();
}

class _CreateAlbumInitialState extends State<CreateAlbumInitial> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController titleController;

  late List<File> _images;

  List<File> get images => _images;

  set images(List<File> newImages) {
    setState(() {
      _images = newImages;
    });
  }

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
    titleController = TextEditingController();

    _images = widget.images;
  }

  DateTimeRange calculateDateRange() {
    return DateTimeRange(start: DateTime.now(), end: DateTime.now());
  }

  void openGalleryPicker() async {
    final res = await Navigator.push(
        context, sharedAxisRoute(widget: const FotogoImagePicker()));
    print(res);
    setState(() {
      images = res;
    });
  }

  void onSubmit() {
    // if (_formKey.currentState!.validate()) {
    //   context.read<AlbumBloc>().add(CreateAlbumEvent(albumCreationData: data));
    // } else {
    //   AppWidgets.fotogoSnackBar(context, "Please provide a title.");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Panel title
              Text(
                'Create album',
                style: Theme.of(context).textTheme.headline6,
              ),
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
              // People
              FotogoSection(
                title: 'People',
                body: TextButton(
                    onPressed: () {},
                    child: const Text('Add people to your album'),
                    style: Theme.of(context).textButtonTheme.style),
              ),
              const Spacer(flex: 1),
              FotogoSection(
                title: 'Photos',
                body: images.isEmpty
                    ? TextButton(
                        onPressed: openGalleryPicker,
                        child: const Text('Add photos'))
                    : SizedBox(
                        height: 30.h,
                        child: GridView.count(
                          crossAxisCount: 4,
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 1.0,
                          children: List.generate(
                              images.length,
                              (index) => Image(
                                    image: FileImage(images[index]),
                                    fit: BoxFit.cover,
                                  )),
                        ),
                      ),
              ),
              // SizedBox(height: 25.h),
              const Spacer(flex: 3),
              // Submit button
              ElevatedButton(
                onPressed: onSubmit,
                child: const Text('Create album'),
                style: Theme.of(context).elevatedButtonTheme.style,
              ),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
