import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/pages/app_navigator/app_navigator_data.dart';

import '../models/user_bloc/user_bloc.dart';

class HomePage extends StatefulWidget {
  final AppNavigatorData data;

  const HomePage(this.data, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
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
                  backgroundImage: NetworkImage(
                      context.read<UserBloc>().user!.photoUrl ?? ''),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
