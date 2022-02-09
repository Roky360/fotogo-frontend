import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Login or sign up',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          width: 60.w,
          height: 45,
          child: OutlinedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/logos/google-g-logo.svg', height: 20,),
                // Image.network(
                //     'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png',
                //   width: 20,
                // ),
                const SizedBox(width: 10,),
                const Text('Sign in with Google'),
              ],
            ),
          ),
        ),
        ElevatedButton(onPressed: () {}, child: const Text('Continue')),
      ],
    );
  }
}
