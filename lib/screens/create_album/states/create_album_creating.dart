part of '../create_album_page.dart';

class CreateAlbumCreating extends StatelessWidget {
  final AlbumCreationData data;

  const CreateAlbumCreating({Key? key, required this.data}) : super(key: key);

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
                  enabled: false,
                  controller: TextEditingController()..text = data.title,
                  decoration: InputDecoration(
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
                )),
            // const SizedBox(height: 35),
            const Spacer(flex: 1),
            // People
            FotogoSection(
              title: 'People',
              body: TextButton(
                  onPressed: null,
                  style: Theme.of(context).textButtonTheme.style,
                  child: const Text('Add people (COMING SOON)')),
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
                            image:
                                FileImage(data.imagesFiles[index], scale: .1),
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
      // Submit button
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: fPageMargin * 3, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: null,
              child: AppWidgets.fotogoCircularLoadingAnimation(),
            ),
          ],
        ),
      ),
    );
  }
}
