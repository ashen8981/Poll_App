import 'package:flutter/material.dart';
import 'package:poll_2022/Screens/Authentication/auth_page.dart';
import '../../../Providers/authentication_provider.dart';
import '../../../Styles/Colors.dart';
import '../../../Utils/message.dart';
import '../../../Utils/router.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:GestureDetector(
        onTap: () {
      AuthProvider().logOut().then((value) {
        // if (value== false) {
        //   error(context, message: "Please try again");
        // } else {
        // nextPageOnly(context, const AuthPage());
        // }
      });
    },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          child: const Text("Logout"),
        ),),
    ),);
  }
}
