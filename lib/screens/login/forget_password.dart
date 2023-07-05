import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({
    Key? key,
  }) : super(key: key);
  static String id = 'ForgetPasswordScreen';

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  bool isPassObscure = true;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/wallpaper.jpg'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(-0.5),
          child: AppBar(
            leading: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.2,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color(0xff272938),
            ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    const Image(
                      image: AssetImage('assets/images/applogo.png'),
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Enter your email to reset password',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    kSizedBox,
                    //-------------------------------------------------------------------
                    //Email
                    CustomTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^([a-z\d_.-]+)@([\da-z.-]+)\.([a-z.]{2,63})$')
                                .hasMatch(value)) {
                          return 'Enter correct Email';
                        }
                        return null;
                      },
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                      ),
                      textInputType: TextInputType.emailAddress,
                    ),
                    kSizedBox,
                    //-------------------------------------------------------------------
                    kSizedBox,
                    GestureDetector(
                      onTap: () {
                        resetPassword();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          width: double.infinity,
                          height: 50,
                          child: const Center(
                            child: Text(
                              'Reset Password',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    kSizedBox,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showSnackBar(context, 'Password reset was sent');
    } on FirebaseAuthException catch (e) {
      print(e);
      showSnackBar(context, 'Error');
    }
  }
}
