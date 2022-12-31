import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../Providers/authentication_provider.dart';
import '../../Styles/Colors.dart';
import '../../Utils/message.dart';
import '../../Utils/router.dart';
import '../../main.dart';
import '../main_activity_page.dart';


class AuthPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const AuthPage({
    Key? key,
    required this.onClickedSignUp,
  }):super(key: key);


  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
         // alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to",
              style: TextStyle(fontSize: 32,fontWeight:FontWeight.bold),),
            const Text("Poll App",
              style: TextStyle(fontSize: 32,fontWeight:FontWeight.bold),),
            Lottie.network('https://assets3.lottiefiles.com/packages/lf20_EyJRUV.json',
              width: 280,
              height: 200,
              fit: BoxFit.fill,),
            const SizedBox(height: 15),
            TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'password'),
              obscureText: true,
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                icon: Icon(Icons.lock,size: 32,),
                label:Text("Sign In"),
                onPressed: signIn),
            const SizedBox(height: 25),
            RichText(text: TextSpan(
              style: TextStyle(
                color: Colors.black,fontSize: 20),
              text:  "No account ?",
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                  text: "Sign UP",
                  style: TextStyle(
                    decoration:TextDecoration.underline ,
                      color: Colors.red,fontSize: 20),
                )
              ]
            )),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                AuthProvider().signInWithGoogle().then((value) {
                  if (value.user == null) {
                    error(context, message: "Please try again");
                  } else {
                    nextPageOnly(context, const MainActivityPage());
                  }
                });
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: const Text("Login"),
              ),
            ),


          ]),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) =>  MainActivityPage()),);
      //   },
      //   backgroundColor: Colors.green,
      //   child: const Icon(Icons.navigation),
      // ),
    );
  }
  //sign in method
  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=>Center(child: CircularProgressIndicator()));
    try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }on FirebaseAuthException catch(e){
      print(e);
    }
    navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }
}