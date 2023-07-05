import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:TourGuideApp/resources/auth_methods.dart';
import 'package:TourGuideApp/screens/login/forget_password.dart';
import 'package:TourGuideApp/screens/login/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);
  static String id = 'loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool isPassObscure = true;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
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
                      child: Text(
                        'Welcome'.toUpperCase(),
                        style: const TextStyle(
                          letterSpacing: 2,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
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
                            'Login now to Discover Egypt !',
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
                    //Password
                    CustomTextField(
                      controller: _passController,
                      labelText: 'Password',
                      obscureText: isPassObscure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          //||
                          //                             !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d).{8,}$')
                          //                                 .hasMatch(value))
                          return 'Enter correct password';
                        }
                        return null;
                      },
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPassObscure = !isPassObscure;
                          });
                        },
                        icon: isPassObscure
                            ? const Icon(
                                Icons.visibility_rounded,
                                color: Colors.grey,
                              )
                            : const Icon(Icons.visibility_off),
                        color: Colors.grey,
                      ),
                      textInputType: TextInputType.visiblePassword,
                    ),
                    kSizedBox,
                    GestureDetector(
                      onTap: ()  async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {

                          });
                           await AuthMethods().loginUser(
                              context: context,
                              email: _emailController.text,
                              password: _passController.text,
                          );
                        }
                        isLoading = false;
                        setState(() {

                        });
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
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    kSizedBox,
                    //-------------------------------------------------------------------
                    //Forget Password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return ForgetPasswordScreen();
                              }));
                            },
                            child: const Text(
                              'Forget password ?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterPage.id);
                            },
                            child: Text(
                              'Sign up '.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
