import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fotogo/providers/google_sign_in.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:sizer/sizer.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final User? user = FirebaseAuth.instance.currentUser;

  Widget _signedInPage(BuildContext context) {
    return Column(
      children: [
        Text(
          'Login or sign up',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 50),
        // google button
        SizedBox(
          width: 60.w,
          height: 45,
          child: OutlinedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/logos/Google__G__Logo.svg',
                  height: 20,
                ),
                // Image.network(
                //     'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png',
                //   width: 20,
                // ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Sign in with Google'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        // ElevatedButton(onPressed: () {}, child: const Text('Continue')),
      ],
    );
  }

  Widget _signInPage(BuildContext context) {
    return Column(
      children: [
        Text(
          'Login or sign up',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 50),
        // google button
        SizedBox(
          width: 60.w,
          height: 45,
          child: OutlinedButton(
            onPressed: () {
              final a = GoogleSignInProvider()..googleLogin();
              print(a.user);
              print('DONE');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/logos/Google__G__Logo.svg',
                  height: 20,
                ),
                // Image.network(
                //     'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png',
                //   width: 20,
                // ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Sign in with Google'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        // ElevatedButton(onPressed: () {}, child: const Text('Continue')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppWidgets.circularLoadingAnimation();
          } else if (snapshot.hasData) {
            return _signedInPage(context);
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong.'));
          } else {
            return _signInPage(context);
          }
        });
  }
}
