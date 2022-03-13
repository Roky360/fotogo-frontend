import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/models/album/album_bloc.dart';
import 'package:fotogo/models/user_bloc/user_bloc.dart';
import 'package:fotogo/pages/albums/album_content_page.dart';
import 'package:fotogo/pages/albums/widgets/album_cover.dart';
import 'package:fotogo/services/albums_service.dart';
import 'package:fotogo/widgets/app_widgets.dart';

import '../../widgets/section.dart';
import 'album_data.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  List<AlbumData> get _albumsData =>
      context.read<UserBloc>().userData.albumsData;

  @override
  void initState() {
    super.initState();

    context.read<AlbumBloc>().add(const FetchAlbumsDetailsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(pageMargin),
          child: Row(
            children: [
              Text(
                'Albums',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const Spacer(),
              IconButton(
                onPressed: () => context
                    .read<AlbumBloc>()
                    .add(const FetchAlbumsDetailsEvent()),
                icon: const Icon(Icons.sort),
              )
            ],
          ),
        ),
        FotogoSection(
          title: 'Scheduled',
          body: Column(
            children: [
              BlocConsumer<AlbumBloc, AlbumState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is AlbumCoverFetched) {
                    context.read<UserBloc>().userData.albumsData =
                        state.albumData;

                    return Column(
                      children: List.generate(
                          state.albumData.length,
                          (index) => Column(
                                children: [
                                  OpenContainer(
                                    transitionType:
                                        ContainerTransitionType.fade,
                                    transitionDuration:
                                        const Duration(milliseconds: 400),
                                    closedBuilder: (context, action) {
                                      return GestureDetector(
                                        onTap: action,
                                        child: AlbumCover(
                                          data: _albumsData[index],
                                        ),
                                      );
                                    },
                                    openBuilder: (context, action) {
                                      return AlbumContentPage(
                                          data: _albumsData[index]);
                                    },
                                    closedShape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              )),
                    );
                  } else if (state is AlbumCoverError) {
                    return Text(
                      state.message,
                      style: Theme.of(context).textTheme.headline6,
                    );
                  } else {
                    // loading
                    return Center(
                      child: AppWidgets.fotogoCircularLoadingAnimation(),
                    );
                  }
                },
              ),
              // space from the BNB
              const SizedBox(
                height: 120,
              )
            ],
          ),
        ),
      ],
    );
  }
}
