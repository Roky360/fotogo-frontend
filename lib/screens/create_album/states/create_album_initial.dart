part of '../create_album_page.dart';

class CreateAlbumInitial extends StatefulWidget {
  late final List<File> images;

  CreateAlbumInitial({
    Key? key,
    images,
  }) : super(key: key) {
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

  void openGalleryPicker() async {
    // TODO: can add same image multiple times, fix this
    final res = await Navigator.push(
        context, sharedAxisRoute(widget: const FotogoImagePicker()));

    if (res != null) {
      setState(() {
        images += res;
      });
    }
  }

  void onSubmit() async {
    // Check if title is not empty
    if (!_formKey.currentState!.validate()) {
      AppWidgets.fotogoSnackBar(context,
          content: "Please provide a title",
          icon: FotogoSnackBarIcon.error,
          bottomPadding: 8);
      return;
    }
    // Check that album has at least one image
    if (images.isEmpty) {
      AppWidgets.fotogoSnackBar(context,
          content: "Please add at least one image",
          icon: FotogoSnackBarIcon.error,
          bottomPadding: 8);
      return;
    }

    context.read<AlbumCreationBloc>().add(CreateAlbumEvent(AlbumCreationData(
          title: titleController.text,
          dateRange: await calculateDateRangeFromImages(images),
          creationTime: DateTime.now(),
          imagesFiles: images,
          sharedPeople: [],
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CloseButton(color: Theme.of(context).colorScheme.primary),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Panel title
              Text(
                'Create album',
                style: Theme.of(context).textTheme.headline4,
              ),
              const Spacer(flex: 1),
              // Title text field
              SizedBox(
                  width: 100.w - fPageMargin * 2,
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
                    style: Theme.of(context).textButtonTheme.style,
                    child: const Text('Add people to your album')),
              ),
              const Spacer(flex: 1),
              FotogoSection(
                title: 'Photos',
                action: images.isNotEmpty
                    ? TextButton(
                        onPressed: openGalleryPicker,
                        child: const Text('Add more photos'))
                    : const SizedBox(),
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
                                    image: FileImage(images[index], scale: .1),
                                    fit: BoxFit.cover,
                                  )),
                        ),
                      ),
              ),
              // SizedBox(height: 25.h),
              const Spacer(flex: 10),
            ],
          ),
        ),
      ),
      // Submit button
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: fPageMargin * 3, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onSubmit,
              style: Theme.of(context).elevatedButtonTheme.style,
              // onPressed: onSubmit,
              child: const Text('Create album'),
            ),
          ],
        ),
      ),
    );
  }
}
