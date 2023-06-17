import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login.dart';
import 'firebase/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _paswordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Register Here",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
                ),
                Image.asset(
                  "assets/traidatdep.jpg",
                  height: 250.h,
                  width: double.infinity,
                ),
                Text(
                  "Get Registered From Here",
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
                        hintText: 'Enter Password',
                        contentPadding: EdgeInsets.all(10)),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 12.sp),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Colors.black12,
                //       ),
                //       color: Colors.grey[100],
                //       borderRadius:
                //           const BorderRadius.all(Radius.circular(10))),
                //   child: const TextField(
                //     obscureText: true,
                //     decoration: InputDecoration(
                //         border: InputBorder.none,
                //         hintText: 'Enter Confirm Password',
                //         contentPadding: EdgeInsets.all(10)),
                //   ),
                // ),
                SizedBox(
                  height: 20.h,
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
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  ),
                  onPressed: () async {
                    User? user = await FireAuth.registerUsingEmailPassword(
                        email: _emailController.text.replaceAll(' ', ''),
                        password: _paswordController.text,);
                    print(user);
                    if (user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()));
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
                      "already have an account ? ",
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
                                builder: (_) => const LoginScreen()));
                      },
                      child: Text(
                        "Sign In ",
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
