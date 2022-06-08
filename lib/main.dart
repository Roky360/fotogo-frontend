import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/auth/bloc/auth_bloc.dart';

import 'package:fotogo/config/themes/light_theme.dart';
import 'package:fotogo/launcher.dart';
import 'package:fotogo/screens/app_navigator/app_navigator.dart';
import 'package:fotogo/screens/auth_checker.dart';
import 'package:fotogo/screens/on_boarding_setup/welcome_page.dart';
import 'package:fotogo/single_album/external_bloc/ext_single_album_bloc.dart';
import 'package:sizer/sizer.dart';

import 'album_creation/bloc/album_creation_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const FotogoApp());
}

/// The root application of fotogo.
///
/// This widget contains the [MaterialApp], which is the base widget of the
/// application. It initializes what is needed for the app.
class FotogoApp extends StatelessWidget {
  const FotogoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(),
            ),
            BlocProvider<AlbumCreationBloc>(
              create: (context) => AlbumCreationBloc(),
            ),
            BlocProvider<ExtSingleAlbumBloc>(
              create: (context) => ExtSingleAlbumBloc(),
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
              '/setup': (context) => WelcomePage(),
              '/auth_checker': (context) => const AuthChecker(),
            },
          ),
        );
      },
    );
  }
}
