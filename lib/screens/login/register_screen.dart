
import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:TourGuideApp/resources/auth_methods.dart';
import 'package:TourGuideApp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static String id = 'register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? emailAddress;
  String? password;
  String? passwordValue;
  String? userName;
  bool isLoading = false;
  GlobalKey<FormState> registerFormKey = GlobalKey();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  Uint8List? _image;
   late ByteData imageData;
  Future<Uint8List> convert() async {
    final ByteData bytes = await rootBundle.load('assets/images/user.png');
    final Uint8List list = bytes.buffer.asUint8List();
    return list;
  }
  Future<Uint8List?>  defaultImage() async{
      Uint8List defaultImage = await convert();
      return defaultImage;
    }
  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/images/user.png')
        .then((data) => setState(() => this.imageData = data));
  }
  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color(0xff272938),
            ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Form(
            key: registerFormKey,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    //-----------------Image--------------------------
                    Stack(
                      children: [
                        _image != null ?
                         CircleAvatar(
                          backgroundColor: Colors.white10,
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),

                         )
                        :
                        CircleAvatar(
                          backgroundColor: Colors.white10,
                          radius: 60,
                          backgroundImage:
                          NetworkImage('https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg',),
                        ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // ---------------------UserName-----------------------------
                    kSizedBox,
                    CustomTextField(
                      controller: _userNameController,
                      labelText: 'UserName',
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[a-zA-Z\d_-].{3,30}$').hasMatch(value)) {
                          return 'Enter correct Username';
                        }
                        userName = value;
                        return null;
                      },
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      textInputType: TextInputType.text,
                    ),
                    kSizedBox,
                    // ---------------------Email-----------------------------
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
                        emailAddress = value;
                        return null;
                      },
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                      ),
                      textInputType: TextInputType.text,
                    ),
                    kSizedBox,
                    // --------------------Password-----------------------------
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^.{8,}$')
                                .hasMatch(value)) {
                          return 'Password must be at least 8 characters ';
                        }
                        passwordValue = value;
                        return null;

                      },
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                      ),
                      textInputType: TextInputType.visiblePassword,
                    ),
                    kSizedBox,
                    // ----------------ConfirmPassword-----------------------------
                    CustomTextField(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty || value != passwordValue) {
                          return 'password not matched';
                        }
                        password = value;
                        return null;
                      },
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                      ),
                      textInputType: TextInputType.visiblePassword,
                    ),
                    kSizedBox,
                    GestureDetector(
                      onTap: () async {
                        if (registerFormKey.currentState!.validate()) {
                          isLoading = true;
                          if(_image == null){
                            setState(() {
                              _image =  imageData.buffer.asUint8List();
                            });
                          }
                          setState(() {});
                          await AuthMethods().signUpUser(
                            context: context,
                            file: _image! ,
                            email: _emailController.text,
                            password: _passwordController.text,
                            userName: _userNameController.text,
                          );
                        }
                        isLoading = false;
                        setState(() {});
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
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    kSizedBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already Have Account ? ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
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

  void selectImage() async{
   Uint8List im =  await pickImage(ImageSource.gallery);
   setState(() {
     _image = im;
   });
  }
}
