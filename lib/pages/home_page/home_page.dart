import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../models/user_bloc/user_bloc.dart';
import '../../widgets/photo_view.dart';

part 'views/gallery_view.dart';

part 'views/album_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget getTopBar() {
    return Padding(
      padding: const EdgeInsets.all(pageMargin),
      child: Row(
        children: [
          Text(
            'Welcome back, ${context.read<UserBloc>().userName}',
            style: Theme.of(context).textTheme.headline6,
          ),
          const Spacer(),
          CircleAvatar(
            radius: 18,
            backgroundImage:
                NetworkImage(context.read<UserBloc>().user!.photoUrl ?? ''),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          getTopBar(),
          const Expanded(child: GalleryView()),
          const SizedBox(height: 90),

          // TextButton(
          //   onPressed: () async {
          //     final Uint8List imgBytes =
          //         await readAssetBytes('assets/test_images/amsterdam.jpg');
          //
          //     context.read<ServerBloc>().client.createConnection(
          //           Request(
          //             requestType: RequestType.deleteUserData,
          //             idToken:
          //                 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImIwNmExMTkxNThlOGIyODIxNzE0MThhNjdkZWE4Mzc0MGI1ZWU3N2UiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoi16LXk9efINep16fXkyIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQVRYQUp3SGdYQzZwYXVLX1RZV2ZwNXJzR2FfWExOSFk2NGlKZlREUFJaaz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9mb3RvZ28tNWU5OWYiLCJhdWQiOiJmb3RvZ28tNWU5OWYiLCJhdXRoX3RpbWUiOjE2NDgyMDYyODMsInVzZXJfaWQiOiJoSDBVNEZNWGVtaHdpRXFjUElHVHJONnN4NzMyIiwic3ViIjoiaEgwVTRGTVhlbWh3aUVxY1BJR1RyTjZzeDczMiIsImlhdCI6MTY0ODIwNjI4MywiZXhwIjoxNjQ4MjA5ODgzLCJlbWFpbCI6InN0MzgyNzg3M0Brc2hhcGlyYS5vcnQub3JnLmlsIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZ29vZ2xlLmNvbSI6WyIxMDY3NTc3NjcxNDAzMjIwMjgwODAiXSwiZW1haWwiOlsic3QzODI3ODczQGtzaGFwaXJhLm9ydC5vcmcuaWwiXX0sInNpZ25faW5fcHJvdmlkZXIiOiJnb29nbGUuY29tIn19.I24Atf2Ut77kshQlkT7gNGFPSpDnilU61N8ZXjAGCorlE1nA9uCkaBY3nFSF69DpojZ7qw5y0miH2ZOxzbCKkDtm-EUehEpdC6M2IduobXFdgHoQ-j4BK_JahUJg8JdzfrDHkPFYsBij9__rlVduUvPhgLOB5w_um25gR-64CyXrWpORPMV2Jpdc-R2sATbRGVCua6hYOMMWAG8yXGlelz469_nwOCmgh1ojCbpBCfmfePYTxHsFa5-i70K46-a_5JrrwI0_y_HbLUbqTBOXORIPdep5ko8FmyOnwXxQ9E65YWXcnGIa_KRV4n93CvrHhjtC_25G4JI2vSMU_4mfkA',
          //             // idToken: await context.read<UserBloc>().idToken,
          //             args: {'arg1': 0, 'arg2': '000101000'},
          //             payload: [base64Encode(imgBytes)],
          //           ),
          //         );
          //   },
          //   child: const Text('send request'),
          // ),
          // BlocConsumer(
          //   bloc: context.read<ServerBloc>(),
          //   listener: (context, state) {},
          //   builder: (context, state) {
          //     if (state is ServerWaiting) {
          //       return AppWidgets.fotogoCircularLoadingAnimation();
          //     } else if (state is ServerGotData) {
          //       return Text(
          //         state.data.toString(),
          //         style: Theme.of(context).textTheme.subtitle1,
          //       );
          //     } else if (state is ServerError) {
          //       return Text(
          //         state.message.toString(),
          //         style: Theme.of(context).textTheme.subtitle1,
          //       );
          //     } else {
          //       return Text(
          //         'initial',
          //         style: Theme.of(context).textTheme.subtitle1,
          //       );
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
