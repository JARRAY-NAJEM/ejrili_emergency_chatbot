import 'dart:convert';
import 'package:ejrili_yammi/emergency/ProfilePage.dart';
import 'package:ejrili_yammi/emergency/RasaChatPage.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ejrili_yammi/Login/SignPage.dart';
import 'package:ejrili_yammi/Widget/bezierContainer.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    _printLoginPage();
  }

  void _printLoginPage() {
    print('LoginPage');
  }

//   Future<Map<String, dynamic>> fetchData() async {
//     final email = _emailController.text;
//     final password = _passwordController.text;
//  final loginUrl = 'http://10.0.2.2:5000/api/login';
//   final getDataUrl = 'http://10.0.2.2:5000/api/get/$email/$password';

//     try {
//       final response = await http
//           .get(Uri.parse(getDataUrl));

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

  // void loginAuth() async {
  //   final email = _emailController.text;
  //   final password = _passwordController.text;
  //    final loginUrl = 'http://10.0.2.2:5000/api/login';

  //   try {
  //     final response = await http.post(
  //       Uri.parse(loginUrl),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'email': email, 'password': password}),
  //     );

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         // _errorMessage = 'done.';
  //         showSpinner = false;
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => NavBar()));
  //       });
  //     } else {
  //       setState(() {
  //         showSpinner = false;
  //         final errorMessage = response.statusCode == 401
  //             ? 'Invalid email or password.'
  //             : response.reasonPhrase;
  //         _errorMessage = 'Error: $errorMessage';
  //       });
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  final _emailController = TextEditingController(text: 'najmejarray@gmail.com');
  final _passwordController = TextEditingController(text: 'najmeJARRAY');
  String _errorMessage = '';
  final apiUrl = 'https://ejrili-yammi.onrender.com/api/';

  Future<void> loginAndFetchData() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final getDataUrl = '${apiUrl}get/$email/$password';
    final loginUrl = '${apiUrl}login';

    try {
      final responseGet = await http.get(Uri.parse(getDataUrl));
      final responsePost = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (responseGet.statusCode == 200 && responsePost.statusCode == 200) {
        final responseData = jsonDecode(responseGet.body);
        setState(() {
          showSpinner = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfilePage(data: responseData),
            ),
          );

          // _errorMessage = 'done.';
        });
      } else {
        setState(() {
          showSpinner = false;
          final errorMessage = responsePost.statusCode != 200
              ? 'Invalid email or password.'
              : responsePost.reasonPhrase;
          setState(() {
            _errorMessage = ' $errorMessage';
          });
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _errorMessage = ' $e';
      });
    }
    //   _emailController.dispose();
    // _passwordController.dispose();
  }

  bool _passwordObscureText = true;
  String? adjective;
  String? noun;
  bool? agreedToTerms = false;
  String _email = '';
  String _password = '';

  Widget page() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  Lottie.asset('animations/login.json', height: 350),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Transform.scale(
                    scale: 1,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/loginxx.png',
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Login',
                    style: GoogleFonts.rancho(
                      fontSize: 50,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFe00505),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                //----------------------
                Form(
                  key: _formKey,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          // A text field that validates that the text is an adjective.
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,

                            //   autofocus: true,
                            // textInputAction: TextInputAction.next,
                            controller: _emailController,

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              } else if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                              ValidationBuilder().email().required().build();
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.mail,
                                color: Color(0xFFe00505),
                              ),
                              //  filled: true,
                              labelText: 'Email',
                              hintText: 'Enter your Email',
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xFFe00505),
                                  width: 2,
                                ),
                              ),

                              floatingLabelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              hoverColor: Color(0xFFe00505),
                              prefixIconColor: Color(0xFF448AFF),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Color(0xFFe00505),
                                  width: 2,
                                ),
                              ),
                            ),
                            // onChanged: (value) {
                            //   print(value);
                            // },

                            onSaved: (value) {
                              _email = value!;
                            },
                          ),
//----------------------------------------------------------------------------------------------------------------
                          const SizedBox(
                            height: 10,
                          ),
                          // A text field that validates that the text is a noun.
                          TextFormField(
                            obscureText: _passwordObscureText,
                            showCursor: false,
                            controller: _passwordController,
                            //  autofocus: true,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                              ValidationBuilder()
                                  .required()
                                  .regExp(
                                    RegExp(
                                      r'^(?=.*[a-z])(?=.*[A-Z])[\w\d]{8,}$',
                                    ),
                                    'Password must contain at  letters, numbers, and special characters',
                                  )
                                  .build();
                            },
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _passwordObscureText =
                                        !_passwordObscureText;
                                  });
                                },
                                child: Icon(
                                  color: Color(0xFFe00505),
                                  _passwordObscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Color(0xFFe00505),
                              ),
                              //  filled: true,
                              labelText: 'Password',
                              hintText: 'Enter your Password',
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Color(0xFFe00505),
                                  width: 2,
                                ),
                              ),
                              floatingLabelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              hoverColor: Color(0xFFe00505),
                              prefixIconColor: Color(0xFFe00505),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),

                            onSaved: (value) {
                              // print(value);
                              _password = value!;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          // FormField<bool>(
                          //   initialValue: false,
                          //   validator: (value) {
                          //     if (value == false) {
                          //       return 'please Remember your password';
                          //     }
                          //     return null;
                          //   },
                          //   builder: (formFieldState) {
                          //     return Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Row(
                          //           children: [
                          //             Checkbox(
                          //               value: agreedToTerms,
                          //               onChanged: (value) {
                          //                 formFieldState.didChange(value);
                          //                 setState(() {
                          //                   agreedToTerms = value;
                          //             _formKey.currentState!.save();

                          //                 });
                          //               },
                          //             ),
                          //             Text(
                          //               'Remember the password',
                          //               style: Theme.of(context)
                          //                   .textTheme
                          //                   .titleMedium,
                          //             ),
                          //           ],
                          //         ),
                          //         if (!formFieldState.isValid)
                          //           Text(
                          //             formFieldState.errorText ?? "",
                          //             style: Theme.of(context)
                          //                 .textTheme
                          //                 .bodySmall!
                          //                 .copyWith(
                          //                     color: Theme.of(context)
                          //                         .colorScheme
                          //                         .error),
                          //           ),
                          //       ],
                          //     );
                          //   },
                          // ),
 const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  _errorMessage,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      setState(() {
                                        showSpinner = true;
                                      });

                                      await loginAndFetchData();

                                      setState(() {
                                        showSpinner = false;
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 2),
                                          color: Color(0xFFdd0130)),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'LOGIN',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFFeff2f9),
                                                fontWeight: FontWeight.bold),
                                          ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Icon(
                                    Icons.login,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //------------------------
                          // Container(
                          //   child: InkWell(
                          //     onTap: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => RasaChatPage()));
                          //     },
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(top: 8.0),
                          //       child: Container(
                          //         width: MediaQuery.of(context).size.width,
                          //         padding: EdgeInsets.symmetric(vertical: 10),
                          //         alignment: Alignment.center,
                          //         decoration: BoxDecoration(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(10)),
                          //             border: Border.all(
                          //                 color: Colors.transparent, width: 2),
                          //             color: Colors.blueAccent),
                          //         child: Text(
                          //           'Go To Chat',
                          //           style: TextStyle(
                          //               fontSize: 20,
                          //               color:
                          //                    Color(0xFFeff2f9)),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          //--------------------

                          // Container(
                          //   child: InkWell(
                          //     onTap: () {
                          //       // Navigator.push(

                          //       //     context, MaterialPageRoute(builder: (context) => SignUpPage()));
                          //     },
                          //     child: Container(
                          //       width: MediaQuery.of(context).size.width,
                          //       padding: EdgeInsets.only(
                          //           left: 15, top: 15, bottom: 10, right: 10),

                          //       // alignment: Alignment.center,
                          //       decoration: BoxDecoration(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(5)),
                          //       ),
                          //       child: Text(
                          //         'Forget Password',
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 15,
                          //             color: Color.fromARGB(255, 48, 46, 46)),
                          //       ),
                          //     ),
                          //   ),
                          // ),
 const SizedBox(
                            height: 10,
                          ), const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(
                                          color: Colors.transparent, width: 2),
                                      color: Color(0xFFdd0130)),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFFeff2f9),
                                            fontWeight: FontWeight.bold),
                                      ),    Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Icon(
                                    Icons.how_to_reg,
                                    color: Colors.white,
                                  ),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //------------------------
              ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 245, 247),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .2,
                  right: -MediaQuery.of(context).size.width * .45,
                  child: const BezierContainer()),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[page()],
                  ),
                ),
              ),
              Positioned(
                  top: 50,
                  left: 15,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(
                                left: 0, top: 10, bottom: 10),
                            child: const Icon(Icons.keyboard_arrow_left,
                                color: Color(0xFFdd0130)),
                          ),
                          const Text('Back',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFdd0130)))
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class Patient {
  final int id;
  final String firstname;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String gradient;
  final String relationship;
  final String contact1;
  final String contact2;
  final String information;
  final String medications;
  final String allergies;

  const Patient({
    required this.id,
    required this.firstname,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.gradient,
    required this.relationship,
    required this.contact1,
    required this.contact2,
    required this.information,
    required this.medications,
    required this.allergies,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      firstname: json['firstname'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      gradient: json['gradient'] ?? '',
      relationship: json['relationship'] ?? '',
      contact1: json['contact1'] ?? '',
      contact2: json['contact2'] ?? '',
      information: json['information'] ?? '',
      medications: json['medications'] ?? '',
      allergies: json['allergies'] ?? '',
    );
  }
}
