import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Utils/router.dart';
import '../signUpPage.dart';
import 'Authentication/auth_page.dart';
import 'main_activity_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  // void navigate() {
  //   Future.delayed(const Duration(seconds: 1), () {
  //     if (user == null) {
  //       nextPageOnly(context, const AuthPage());
  //     } else {
  //       // DynamicLinkProvider().initDynamicLink().then((value) {
  //       //   if (value == "") {
  //           nextPageOnly(context, const MainActivityPage());
  //       //   } else {
  //       //     nextPage(context, IndividualPollsPage(id: value));
  //         }
  //       });
  //     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Text("something went wrong !"));
          }
          else if(snapshot.hasData){
            return const MainActivityPage();
          }else{
            return SignUpPage();
          }
      },
      ),
    );
  }
///google sign in
  // @override
  // void initState() {
  //   // TODO: implement build
  //   super.initState();
  //   navigate();
  // }
///google sign in

  // @override
  // Widget build(BuildContext context) {
  //   return const Scaffold(
  //     body: Center(
  //         child: FlutterLogo()),
  //   );
  // }
}
