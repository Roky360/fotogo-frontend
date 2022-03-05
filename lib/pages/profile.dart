import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/models/user_bloc/user_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
          onPressed: () {
            context.read<UserBloc>().signOut(context);
          },
          child: Row(
            children: const [
              Icon(Icons.switch_account),
              SizedBox(width: 10),
              Text('Switch account'),
            ],
          ),
        ),
      ),
    );
  }
}
