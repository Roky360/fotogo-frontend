import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fotogo/config/themes/light_theme.dart';
import 'package:fotogo/launcher.dart';
import 'package:fotogo/pages/app_navigator/app_navigator.dart';
import 'package:fotogo/pages/auth_checker.dart';
import 'package:fotogo/pages/on_boarding_setup/on_boarding_page.dart';
import 'package:fotogo/providers/google_sign_in.dart';
import 'package:fotogo/services/albums_service.dart';
import 'package:fotogo/widgets/photo_view.dart';
import 'package:sizer/sizer.dart';

import 'fotogo_protocol/networking_protocol.dart';
import 'models/album/album_bloc.dart';
import 'models/server_networking/server_bloc.dart';
import 'models/user_bloc/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const FotogoApp());
}

class FotogoApp extends StatelessWidget {
  const FotogoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<UserBloc>(
              create: (context) => UserBloc(GoogleSignInProvider()),
            ),
            BlocProvider<AlbumBloc>(
              create: (context) => AlbumBloc(AlbumService(context)),
            ),
            BlocProvider<ServerBloc>(
              create: (context) => ServerBloc(Client()),
            ),

          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "fotogo",
            theme: lightTheme,
            initialRoute: '/launcher',
            routes: {
              '/launcher': (context) => FotogoLauncher(),
              '/app_navigator': (context) => const AppNavigator(),
              '/setup': (context) => const OnBoardingPage(),
              '/auth_checker': (context) => const AuthChecker(),
            },
          ),
        );
      },
    );
  }
}
