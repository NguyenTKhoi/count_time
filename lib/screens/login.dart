import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Home.dart';
import 'forgot_password.dart';
import 'register.dart';
import 'firebase/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  // static Future<User?> loginUsingEmailPassword(
  //     {required String email,
  //     required String password,
  //     required BuildContext context}) async {
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   User? user;
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     user = userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == "user-not-found") {
  //       print("No User found for that email");
  //     }
  //   }
  //   return user;
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _paswordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightGreenAccent,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Login Here",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
                ),
                Image.asset(
                  "assets/traidatdep.jpg",
                  height: 250.h,
                  width: double.infinity,
                ),
                Text(
                  "Get Logged In From Here",
                  style: TextStyle(fontSize: 12.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Email",
                  style: TextStyle(fontSize: 12.sp),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      color: Colors.grey[100],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Email',
                        contentPadding: EdgeInsets.all(10)),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 12.sp),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      color: Colors.grey[100],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    controller: _paswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Passwor',
                        contentPadding: EdgeInsets.all(10)),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ForgotPassword()));
                    },
                    child: Text(
                      "Forgot Password ? ",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    )),
                SizedBox(
                  height: 10.h,
                ),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  height: 20.h,
                  minWidth: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  ),
                  onPressed: () async {
                    User? user = await FireAuth.signInUsingEmailPassword(
                        email: _emailController.text.replaceAll(' ', ''),
                        password: _paswordController.text,
                        context: context);
                    print(user?.email);
                    if (user != null) {
                      Navigator.of(context)
                          .pushReplacement(
                        MaterialPageRoute(builder: (context) => MyStatefulWidget(user: user)),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "don't have an account ?? ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.sp,
                          color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const RegisterScreen()));
                      },
                      child: Text(
                        "Sign Up ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
