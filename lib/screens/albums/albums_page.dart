import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_details/album_details_data.dart';
import 'package:fotogo/album_details/album_details_service.dart';
import 'package:fotogo/album_details/bloc/album_details_bloc.dart';
import 'package:fotogo/screens/albums/album_content_page.dart';
import 'package:fotogo/screens/albums/widgets/album_cover.dart';
import 'package:fotogo/widgets/app_widgets.dart';

import '../../widgets/section.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  final AlbumDetailsService _albumDetailsService = AlbumDetailsService();

  List<AlbumDetailsData> get _albumsData =>
      _albumDetailsService.albumsDetailsData;

  @override
  void initState() {
    super.initState();

    context.read<AlbumDetailsBloc>().add(const GetAlbumsDetailsEvent());
  }

  Widget _getAlbumCovers() {
    return Column(
      children: List.generate(
          _albumsData.length,
          (index) => Column(
                children: [
                  OpenContainer(
                    transitionType: ContainerTransitionType.fade,
                    transitionDuration: const Duration(milliseconds: 400),
                    closedElevation: 3,
                    closedBuilder: (context, action) {
                      return GestureDetector(
                        onTap: action,
                        child: AlbumCover(
                          data: _albumsData[index],
                        ),
                      );
                    },
                    openBuilder: (context, action) {
                      return AlbumContentPage(data: _albumsData[index]);
                    },
                    closedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  const SizedBox(height: 20),
                ],
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        // body (list of single_album covers)
        FotogoSection(
          title: 'Albums',
          // sort button
          action: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort),
          ),
          body: Column(
            children: [
              BlocConsumer<AlbumDetailsBloc, AlbumDetailsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is AlbumDetailsFetched) {
                    return _getAlbumCovers();
                  } else if (state is AlbumDetailsError) {
                    return Text(
                      state.message,
                      style: Theme.of(context).textTheme.headline6,
                    );
                  } else {
                    // initial state - loading
                    return Center(
                        child: AppWidgets.fotogoCircularLoadingAnimation());
                  }
                },
              ),
              // space from the BNB
              const SizedBox(height: 120)
            ],
          ),
        ),
      ],
    );
  }
}
