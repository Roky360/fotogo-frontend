import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_details/album_data.dart';
import 'package:fotogo/album_details/album_details_service.dart';
import 'package:fotogo/album_details/bloc/album_details_bloc.dart';
import 'package:fotogo/screens/albums/album_content_page.dart';
import 'package:fotogo/screens/albums/widgets/album_cover.dart';
import 'package:fotogo/single_album/single_album_data.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:fotogo/widgets/app_widgets.dart';

import '../../album_creation/bloc/album_creation_bloc.dart';
import '../../single_album/bloc/single_album_bloc.dart';
import '../../widgets/section.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  final SingleAlbumService _singleAlbumService = SingleAlbumService();

  List<SingleAlbumData> get _albumsData => _singleAlbumService.albumsData;

  @override
  void initState() {
    super.initState();

    context.read<AlbumDetailsBloc>().add(const GetAlbumsDetailsEvent());
  }

  Widget _getAlbumCovers() {
    print(_albumsData);

    Future.delayed(Duration(milliseconds: 1000), () => print(_albumsData));

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
                          data: _albumsData[index].data,
                        ),
                      );
                    },
                    openBuilder: (context, action) {
                      return AlbumContentPage(
                          singleAlbumData: _albumsData[index]);
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
    return RefreshIndicator(
      onRefresh: () async {
        context.read<AlbumDetailsBloc>().add(const GetAlbumsDetailsEvent());
        await Future.delayed(const Duration(milliseconds: 1000));
      },
      child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
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
                MultiBlocListener(
                  listeners: [
                    BlocListener<AlbumCreationBloc, AlbumCreationState>(
                        listener: (context, state) {
                      if (state is AlbumCreated) {
                        print('setting state AlbumCreated');
                        setState(() {});
                      }
                    }),
                    BlocListener<SingleAlbumBloc, SingleAlbumState>(
                        listener: (context, state) {
                      if (state is SingleAlbumDeleted) {
                        print('setting state SingleAlbumDeleted');
                        setState(() {});
                      }
                    }),
                  ],
                  child: BlocConsumer<AlbumDetailsBloc, AlbumDetailsState>(
                    listener: (context, state) {
                      if (state is AlbumDetailsFetched) {
                        print('setting state AlbumDetailsFetched');
                        setState(() {});
                      }
                    },
                    builder: (context, state) {
                      print(state);
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
                ),
                // space from the BNB
                const SizedBox(height: 120)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
