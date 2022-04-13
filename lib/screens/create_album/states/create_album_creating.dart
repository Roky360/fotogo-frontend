part of '../create_album_page.dart';

class CreateAlbumCreating extends StatelessWidget {
  final AlbumCreationData data;

  const CreateAlbumCreating({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: null,
          icon: const Icon(Icons.close),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Panel title
            Text(
              'Create single_album',
              style: Theme.of(context).textTheme.headline6,
            ),
            const Spacer(flex: 1),
            // Title text field
            SizedBox(
                width: 100.w - pageMargin * 2,
                child: TextFormField(
                  controller: TextEditingController()..text = data.title,
                  enabled: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(3, 20, 0, 0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  style: Theme.of(context).textTheme.headline5,
                  textCapitalization: TextCapitalization.sentences,
                )),
            // const SizedBox(height: 35),
            const Spacer(flex: 1),
            // People
            FotogoSection(
              title: 'People',
              body: TextButton(
                  onPressed: null,
                  child: const Text('Add people to your single_album'),
                  style: Theme.of(context).textButtonTheme.style),
            ),
            const Spacer(flex: 1),
            FotogoSection(
              title: 'Photos',
              action: const TextButton(
                  onPressed: null, child: Text('Add more photos')),
              body: SizedBox(
                height: 30.h,
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  children: List.generate(
                      data.imagesFiles.length,
                      (index) => Image(
                            image: FileImage(data.imagesFiles[index]),
                            fit: BoxFit.cover,
                          )),
                ),
              ),
            ),
            // SizedBox(height: 25.h),
            const Spacer(flex: 3),
            // Submit button
            ElevatedButton(
              onPressed: null,
              // onPressed: onSubmit,
              child: AppWidgets.fotogoCircularLoadingAnimation(),
              style: Theme.of(context).elevatedButtonTheme.style,
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}
