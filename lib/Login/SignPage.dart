import 'package:ejrili_yammi/Login/LoginPage.dart';
import 'package:ejrili_yammi/Widget/bezierContainer.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
      firstname: json['firstname'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      gradient: json['gradient'],
      relationship: json['relationship'],
      contact1: json['contact1'],
      contact2: json['contact2'],
      information: json['information'],
      medications: json['medications'],
      allergies: json['allergies'],
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  final apiUrl = 'https://ejrili-yammi.onrender.com/api/';

  Future<Patient> createAccount(
    String firstname,
    String name,
    String username,
    String email,
    String phone,
    String password,
    String gradient,
    String relationship,
    String contact1,
    String contact2,
    String information,
    String medications,
    String allergies,
  ) async {
    final signUrl = '${apiUrl}postAccount';

    try {
      final response = await http.post(
        Uri.parse(signUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstname': firstname,
          'name': name,
          'username': username,
          'email': email,
          'phone': phone,
          'password': password,
          'gradient': gradient,
          'relationship': relationship,
          'contact1': contact1,
          'contact2': contact2,
          'information': information,
          'medications': medications,
          'allergies': allergies,
        }),
      );

  ;

      if (response.statusCode == 200) {
        setState(() {
          showSpinner = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );

          // _errorMessage = 'done.';
        });

        print('add succes');
        return Patient.fromJson(jsonDecode(response.body));
      } else {
        setState(() {
          showSpinner = false;
          final errorMessage = response.statusCode != 200
              ? 'feild request.'
              : response.reasonPhrase;
          setState(() {
            _errorMessage = ' $errorMessage';
          });
        });
        throw Exception('Failed to update Account...');
      }
    } catch (e) {
      setState(() {
        _errorMessage = ' $e';
      });
      throw Exception('Failed to update Account.');
    }
  }

  bool _passwordObscureText = true;

  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    _printLoginPage();
  }

  void _printLoginPage() {
    print('Signup Page');
  }

  //------------

  final TextEditingController firstname = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirm = TextEditingController();
  final TextEditingController gradient = TextEditingController();
  final TextEditingController relationship = TextEditingController();
  final TextEditingController contact1 = TextEditingController();
  final TextEditingController contact2 = TextEditingController();
  final TextEditingController information = TextEditingController();
  final TextEditingController medications = TextEditingController();
  final TextEditingController allergies = TextEditingController();
  Future<Patient>? _futurePatient;

  //---------------
  String? adjective;
  String? noun;
  bool? agreedToTerms = false;
  String _username = '';
  String _firstname = '';
  String _name = '';
  String _email = '';
  String _phone = '';
  String _password = '';
  String _confirm = '';
  //--------------------
  String _gradient = '';
  String _relationship = '';
  String _contact1 = '';
  String _contact2 = '';
  String _information = '';
  String _medications = '';
  String _allergies = '';
  Widget page() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Transform.scale(
                    scale:1,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/signUp.png',
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ),
                ),                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Sign Up',
                      style: GoogleFonts.rancho(
                          fontSize: 50,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFdd0130)),
                    ),
                  ),

                  //----------------------
                  Form(
                    key: _formKey,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SizedBox(height: 8.0),
                              TextFormField(
                                controller: firstname,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  // suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,
                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),

                                  //  filled: true,
                                  labelText: 'Firstname',
                                  hintText: 'Enter your Firstname',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: ValidationBuilder()
                                    .minLength(3)
                                    .maxLength(50)
                                    .build(),
                                onSaved: (value) {
                                  _firstname = value!;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: name,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  // suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),

                                  //  filled: true,
                                  labelText: 'lastname',
                                  hintText: 'Enter your lastname',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: ValidationBuilder()
                                    .minLength(3)
                                    .maxLength(50)
                                    .build(),
                                onSaved: (value) {
                                  _name = value!;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: username,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  // suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,

                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),

                                  //  filled: true,
                                  labelText: 'Username',
                                  hintText: 'Enter your username',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: ValidationBuilder()
                                    .minLength(3)
                                    .maxLength(50)
                                    .build(),
                                onSaved: (value) {
                                  _username = value!;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.mail),
                                  // suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,

                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),

                                  //  filled: true,
                                  labelText: 'Email',
                                  hintText: 'Enter your Email',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: ValidationBuilder()
                                    .email()
                                    .maxLength(50)
                                    .build(),
                                onSaved: (value) {
                                  _email = value!;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: phone,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.phone),
                                  // suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),

                                  //  filled: true,
                                  labelText: 'Phone',
                                  hintText: 'Enter a phone number',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: ValidationBuilder().phone().maxLength(8).build(),
                                onSaved: (value) {
                                  _phone = value!;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: password,
                                obscureText: _passwordObscureText,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  //                        suffixIcon: Icon(Icons.remove_red_eye_outlined),
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
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),
                                  suffixIconColor: Colors.black,

                                  //  filled: true,
                                  labelText: 'Password',
                                  hintText: 'Enter your password',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: ValidationBuilder()
                                    .minLength(8)
                                    .maxLength(50)
                                    .regExp(
                                      RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$',
                                      ),
                                      'Password must contain at least 8 characters, including uppercase and lowercase ',
                                    )
                                    .build(),
                                onSaved: (value) {
                                  _password = value!;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                          
                                obscureText: _passwordObscureText,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  // suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),
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
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  //  filled: true,
                                  labelText: 'Confirm Password',
                                  hintText: 'Confirm Password',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please confirm your password';
                                  }  else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _confirm = value!;
                                },
                                // onChanged: (value) {
                                //   print(value);
                                // },
                              ),
                              SizedBox(height: 25.0),
                              Divider(
                                thickness: 2,
                                color: Colors.grey,
                              ),
                              Text("Emergency Contact Information:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0)),
                              Divider(
                                thickness: 2,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: gradient,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  // suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,

                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),
                                  //  filled: true,
                                  labelText: 'Name',
                                  hintText: 'Enter your guardians name',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: ValidationBuilder()
                                    .minLength(3)
                                    .maxLength(50)
                                    .build(),
                                onSaved: (value) {
                                  _gradient = value!;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: relationship,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.group),
                                  // suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,

                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),
                                  //  filled: true,
                                  labelText: 'RelationShip',
                                  hintText: 'Enter your guardian name',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: ValidationBuilder()
                                    .minLength(3)
                                    .maxLength(50)
                                    .build(),
                                onSaved: (value) {
                                  _relationship = value!;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: contact1,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.mail),
                                  // suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,

                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),

                                  //  filled: true,
                                  labelText: 'Email',
                                  hintText: 'Enter your Email',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: ValidationBuilder()
                                    .email()
                                    .maxLength(50)
                                    .build(),
                                onSaved: (value) {
                                  _contact1 = value!;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: contact2,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.phone),
                                  // suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),

                                  //  filled: true,
                                  labelText: 'Phone',
                                  hintText: 'Enter a phone number',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: ValidationBuilder().phone().maxLength(8).build(),
                                onSaved: (value) {
                                  _contact2 = value!;
                                },
                              ),
                              SizedBox(height: 16.0),
                              Divider(
                                thickness: 2,
                                color: Colors.grey,
                              ),
                              Text(
                                "Medical Information",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0),
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16.0),
                              Center(
                                child: Text(
                                    'Do you have any medical conditions? '),
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: information,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.medical_services),
                                  // suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,

                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),
                                  //  filled: true,
                                  labelText: 'medical conditions',
                                  hintText: 'Enter your medical conditions',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: ValidationBuilder()
                                    .maxLength(10240)
                                    .build(),
                                onSaved: (value) {
                                  _information = value!;
                                },
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                  'Do you take any medications on a regular basis? '),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: medications,
                                // keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.medication),
                                  // suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,

                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),

                                  //  filled: true,
                                  labelText: 'medications',
                                  hintText: 'Enter your medications',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: ValidationBuilder()
                                    .maxLength(10240)
                                    .build(),
                                onSaved: (value) {
                                  _medications = value!;
                                },
                              ),
                              SizedBox(height: 16.0),
                              Text('Do you have any allergies ? '),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: allergies,
                                //   keyboardType: TextInputType.aller,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.medication),
                                  // suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.amber,
                                  focusColor: Colors.grey,
                                  iconColor: Colors.lightGreen,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFdd0130),
                                      width: 2,
                                    ),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  hoverColor: Colors.green,
                                  prefixIconColor: Color(0xFFdd0130),

                                  //  filled: true,
                                  labelText: 'allergies',
                                  hintText: 'Enter a phone allergies',
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: ValidationBuilder()
                                    .maxLength(10240)
                                    .build(),
                                onSaved: (value) {
                                  _allergies = value!;
                                },
                              ),
                              Column(
                                children: [
                                  Text(
                                    _errorMessage,
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                              
                                
                                
                                
                                
                                
                                
                                    InkWell(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()
                                      //  &&
                                      //    _confirm  ==_password
                                          ) {
                                        _formKey.currentState!.save();
                                        setState(() {
                                          showSpinner = true;
                                        });
                                        final _futurePatient =
                                            await createAccount(
                                                firstname.text,
                                                name.text,
                                                username.text,
                                                email.text,
                                                phone.text,
                                                password.text,
                                                gradient.text,
                                                relationship.text,
                                                contact1.text,
                                                contact2.text,
                                                information.text,
                                                medications.text,
                                                allergies.text);
                                        setState(() {
                                          showSpinner = false;
                                        });
                                      } else {
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(
                                        //   SnackBar(
                                        //     content:
                                        //         Text('Passwords do not match'),
                                        //     backgroundColor: Colors.red,
                                        //   ),
                                        // );
                                        print("");
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
                                              'SIGN UP',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Icon(
                                                Icons.how_to_reg,
                                                color: Colors.white,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //------------------------
                ]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFeff2f9),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Stack(
          children: [
            Positioned(
              top: -height * .20,
              right: -MediaQuery.of(context).size.width * .45,
              child: BezierContainer(),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    page(),
                    SizedBox(height: 20),
                  ],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
