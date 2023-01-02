import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:poll_2022/Screens/Authentication/auth_page.dart';

import 'main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) =>
      isLogin
          ? AuthPage(onClickedSignUp: toggle)
          :SignUpWidget(onClickedSignIn: toggle);

  void toggle() => setState(()=>isLogin = !isLogin);
}

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Hey There",
                      style: TextStyle(fontSize: 32,fontWeight:FontWeight.bold),),
                    const Text("Welcome Back",
                      style: TextStyle(fontSize: 32,fontWeight:FontWeight.bold),),
                    Lottie.network('https://assets9.lottiefiles.com/packages/lf20_Cf4bEaWlAO.json',
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: emailController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: 'Email'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email)=>
                          email != null && !EmailValidator.validate(email)
                              ?'Enter a valid email'
                              :null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: passwordController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: 'password'),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value)=>
                      value != null && value.length < 6
                          ?'Enter minimum 6 characters'
                          :null,
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                        ),
                        icon: Icon(Icons.lock,size: 32,),
                        label:Text("Sign Up"),
                        onPressed: signUp),
                    const SizedBox(height: 25),
                    RichText(text: TextSpan(
                        style: TextStyle(
                            color: Colors.black,fontSize: 20),
                        text:  "Already have an account ?",
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignIn,
                            text: "Sign In",
                            style: TextStyle(
                                decoration:TextDecoration.underline ,
                                color: Colors.red,fontSize: 20),
                          )
                        ]
                    )),
                    const SizedBox(height: 25),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=>Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }on FirebaseAuthException catch(e){
      print(e);
    }
    navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }
}

