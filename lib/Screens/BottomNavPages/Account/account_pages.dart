import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


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
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network('https://assets2.lottiefiles.com/packages/lf20_vmlm0zew.json',
                  width: 300,
                  height: 400,
                  fit: BoxFit.fill,),
            const SizedBox(height: 25),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                icon: Icon(Icons.arrow_back,size: 32,),
                label:Text("Sign Out"),
                onPressed:()=>FirebaseAuth.instance.signOut(),
            ),
          ]),
        ),
    ),
    );
  }
}
