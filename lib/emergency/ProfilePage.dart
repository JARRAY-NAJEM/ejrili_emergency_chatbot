import 'package:ejrili_yammi/Login/LoginPage.dart';
import 'package:ejrili_yammi/emergency/RasaChatPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> data;
  const ProfilePage({Key? key, required this.data}) : super(key: key);
  
  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  bool _passwordObscureText = true;

  final TextEditingController firstname = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirnpassword = TextEditingController();
  final TextEditingController gradient = TextEditingController();
  final TextEditingController relationship = TextEditingController();
  final TextEditingController contact1 = TextEditingController();
  final TextEditingController contact2 = TextEditingController();
  final TextEditingController information = TextEditingController();
  final TextEditingController medications = TextEditingController();
  final TextEditingController allergies = TextEditingController();

  String? adjective;
  String? noun;
  bool? agreedToTerms = false;

  // String _lastname = '';
  String _username = '';
  String _name = '';
  String _firstname = '';
  String _email = '';
  String _emailParam = '';
  String _phoneParam = '';
  String _phone = '';
  String _password = '';
  String _confirmPassword = '';
  //--------------------
  String _gradient = '';
  String _relationship = '';
  String _contact1 = '';
  String _contact2 = '';
  String _information = '';
  String _medications = '';
  String _allergies = '';
  bool dismissible = true;

  List<bool> _isExpandedList = [false, false, false];

  final apiUrl = 'https://ejrili-yammi.onrender.com/api/';

  Future<void> updateUser(
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
    final updateUrl = '${apiUrl}put/${_emailParam}';
    try {
      final response = await http.put(
        Uri.parse(updateUrl),
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

      // Check the response status code
      if (response.statusCode == 200) {
        // If the request was successful, display a success message and update the data
        final data = json.decode(response.body);
        print(data);
        setState(() {
          showSpinner = false;
          //  widget.data = data;
          // Update the TextEditingControllers
          // firstname.text = data['firstname'];
          // name.text = data['name'];
          // username.text = data['username'];
          // email.text = data['email'];
          // phone.text = data['phone'];
          // password.text = data['password'];
          // gradient.text = data['gradient'];
          // relationship.text = data['relationship'];
          // contact1.text = data['contact1'];
          // contact2.text = data['contact2'];
          // information.text = data['information'];
          // medications.text = data['medications'];
          // allergies.text = data['allergies'];
        });
        // Display success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User data updated successfully')),
        );
      } else {
        setState(() {
          showSpinner = false;
        });
        // If the request was not successful, display an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating user data')),
        );
      }
    } catch (e) {
      print(e);
      // Catch any HTTP errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred during HTTP request')),
      );
    }
  }

  void getUserByEmail() async {
    final getUserByEmailUrl = '${apiUrl}getUser/${_emailParam}';

    final response = await http.get(Uri.parse(getUserByEmailUrl));

    if (response.statusCode == 200) {
      final dataByEmail = json.decode(response.body);

      // Update the TextEditingControllers with the fetched data
      firstname.text = dataByEmail['firstname'];
      name.text = dataByEmail['name'];
      username.text = dataByEmail['username'];

      email.text = dataByEmail['email'];
      phone.text = dataByEmail['phone'];
      password.text = dataByEmail['password'];
      gradient.text = dataByEmail['gradient'];
      relationship.text = dataByEmail['relationship'];
      contact1.text = dataByEmail['contact1'];
      contact2.text = dataByEmail['contact2'];
      information.text = dataByEmail['information'];
      medications.text = dataByEmail['medications'];
      allergies.text = dataByEmail['allergies'];
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _printLoginPage();
    //  create function get
    //   print(widget.data);
    _emailParam = widget.data['email'];
    _phoneParam = widget.data['contact2'];
    // print(_emailParam = widget.data['email']);
    // print(_phoneParam = widget.data['contact2']);
    getUserByEmail();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);
    // firstname.text = widget.data['firstname'];
    // name.text = widget.data['name'];
    // username.text = widget.data['username'];
    // // lastname.text = widget.data['username'];
    // phone.text = widget.data['phone'];
    // password.text = widget.data['password'];

    // gradient.text = widget.data['gradient'];
    // relationship.text = widget.data['relationship'];
    // contact1.text = widget.data['contact1'];
    // contact2.text = widget.data['contact2'];
    // information.text = widget.data['information'];
    // medications.text = widget.data['medications'];
    // allergies.text = widget.data['allergies'];
    //  Text('Email: ${userData['email']}'),
    //Text(
    // '${widget.data.firstname} ${widget.data.lastname}',
    // style: TextStyle(fontSize: 16),
//)
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _printLoginPage() {
    print('Profile Page');
  }

  bool _isEditable = false;
  bool _isEditMode = false;
  bool _isSaveEnabled = false;
  bool _isEditing = false; // état de l'édition
  final double _borderRadius = 10.0; // rayon de la bordure
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeff2f9),
    //  appBar: AppBar(backgroundColor: Colors.transparent,
    //     // leading: IconButton(
    //     //   icon: Icon(Icons.login),
    //     //   onPressed: () {
           
    //     //   },
    //     // ),
    //      actions: <Widget>[
    //       IconButton(
    //         icon: Icon(Icons.search),
    //         onPressed: () {
    //           // do something
    //         },
    //       ),
    //     ],
    //   ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Stack(
                children: <Widget>[
                  Column(
             
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),

                      //  Container(
                      //                                   child: SizedBox(
                      //                                     height:
                      //                                         MediaQuery.of(context).size.height *0.25,

                      //                                     child: PhysicalModel(
                      //                                       color: Colors.transparent,
                      //                                       elevation: 70,shadowColor: Color.fromRGBO(236, 194, 191, 1),
                      //                                       borderRadius:
                      //                                           BorderRadius.circular(50),
                      //                                       child: GestureDetector(
                      //                                         onTap: () async {
                      //                                           Navigator.push(
                      //                                               context,
                      //                                               MaterialPageRoute(
                      //                                                   builder: (context) =>
                      //                                                       RasaChatPage()));
                      //                                         },
                      //                                         child: SizedBox(height: MediaQuery.of(context).size.height * 0.15,
                      //                                           child: Transform.scale(
                      //                                             scale: 0.9,
                      //                                             alignment: Alignment.center,
                      //                                             child: ClipRRect(
                      //                                               borderRadius:
                      //                                                   BorderRadius.circular(50),
                      //                                               child: Image.asset(
                      //                                                 'images/profil.png',
                      //                                                 height:
                      //                                                     MediaQuery.of(context)
                      //                                                             .size
                      //                                                             .height *
                      //                                                         0.1,
                      //                                               ),
                      //                                             ),
                      //                                           ),
                      //                                         ),
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: AnimatedBuilder(
                          animation: animationController,
                          builder: (context, child) {
                            return Container(
                              decoration: ShapeDecoration(
                                color: Color.fromRGBO(236, 194, 191, 1)
                                    .withOpacity(.5),
                                shape: CircleBorder(),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  7.0 * animationController.value,
                                ),
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            decoration: ShapeDecoration(
                              color: Colors.black,
                              shape: CircleBorder(),
                            ),
                            child: PhysicalModel(
                              color: Colors.black,
                              elevation: 70,
                              shadowColor: Color.fromRGBO(236, 194, 191, 1),
                              borderRadius: BorderRadius.circular(50),
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>RasaChatPage(
                                                  data: {
                                                    'email': _emailParam,
                                                    'contact2': _phoneParam
                                                  })));
                                },
                                child: Transform.scale(
                                  scale: 1.5,
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      'images/profil.png',
                                      height: MediaQuery.of(context).size.height *
                                          0.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),

                      Container(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18,
                          child: Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                'EJRILI YAMMI',
                                style: GoogleFonts.audiowide(
                                  fontSize: 40,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFdd0130),
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                'اجريلي يـــــامي',
                                style: GoogleFonts.notoNastaliqUrdu(
                                  fontSize: 40,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFdd0130),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 25),
                      Material(
                        elevation: 0,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RasaChatPage(data: {
                                          'email': _emailParam,
                                          'contact2': _phoneParam
                                        })));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                border: Border.all(
                                    color: Colors.transparent, width: 2),
                                color: Color(0xFFdd0130)),
                            child: Text(
                              'Go To YAMMI',
                              style: GoogleFonts.audiowide(
                                  fontSize: 25,
                                  color: Color(0xFFeff2f9),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),

                      Container(
                        child: //----------------------
                            SizedBox(
                          child: Form(
                            key: _formKey,
                            child: Scrollbar(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    children: [
                                      //    SizedBox(height: 25.0),
                                      Container(
                                        child: ExpansionPanelList(
                                          dividerColor:
                                              Colors.transparent,
                                          elevation: 0,
                                          animationDuration: Duration(seconds: 2),
                                          expansionCallback:
                                              (int index, bool isExpanded) {
                                            setState(() {
                                              _isExpandedList[index] =
                                                  !isExpanded;
                                            });
                                          },
                                          children: [
                                            ExpansionPanel(canTapOnHeader:true,
                                              backgroundColor: Color(0xFFeff2f9),
                                              headerBuilder:
                                                  (BuildContext context,
                                                      bool isExpanded) {
                                                return ListTile(
                                                  leading: Icon(
                                                    Icons.person,
                                                    color: Color(0xFFdd0130),
                                                  ),
                                                  title: Text(
                                                    'User Informations',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 17),
                                                  ),
                                                );
                                              },
                                              body: Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextFormField(
                                                      controller: firstname,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons.person),
                                                        // suffixIcon: Icon(Icons.person),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,
                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),

                                                        //  filled: true,
                                                        labelText: 'Firstname',
                                                        hintText:
                                                            'Enter your Firstname',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),

                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFe00505),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator:
                                                          ValidationBuilder()
                                                              .minLength(3)
                                                              .maxLength(50)
                                                              .build(),
                                                      onSaved: (value) {
                                                        _firstname = value!;
                                                      },
                                                      //                                                        onChanged: (value) {
                                                      //   setState(() {
                                                      //     _firstname = value;
                                                      //   });
                                                      //   print('Input changed: $_firstname');
                                                      // },
                                                      enabled: _isEditable,
                                                    ),
                                                    SizedBox(height: 20.0),
                                                    TextFormField(
                                                      controller: name,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons.person),
                                                        // suffixIcon: Icon(Icons.person),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFe00505),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),

                                                        //  filled: true,
                                                        labelText: 'Lastname',
                                                        hintText:
                                                            'Enter your Lastname',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),

                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator:
                                                          ValidationBuilder()
                                                              .minLength(3)
                                                              .maxLength(50)
                                                              .build(),
                                                      onSaved: (value) {
                                                        _name = value!;
                                                      },
                                                      enabled: _isEditable,
                                                    ),
                                                    SizedBox(height: 20.0),
                                                    TextFormField(
                                                      controller: username,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons.person),
                                                        // suffixIcon: Icon(Icons.person),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,

                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),

                                                        //  filled: true,
                                                        labelText: 'Username',
                                                        hintText:
                                                            'Enter your username',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFe00505),
                                                            width: 2,
                                                          ),
                                                        ),

                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator:
                                                          ValidationBuilder()
                                                              .minLength(3)
                                                              .maxLength(50)
                                                              .build(),
                                                      onSaved: (value) {
                                                        _username = value!;
                                                      },
                                                      enabled: _isEditable,
                                                    ),
                                                    SizedBox(height: 20.0),
                                                    TextFormField(
                                                      controller: email,
                                                      keyboardType: TextInputType
                                                          .emailAddress,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons.mail),
                                                        // suffixIcon: Icon(Icons.person),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,

                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),

                                                        //  filled: true,
                                                        labelText: 'Email',
                                                        hintText:
                                                            'Enter your Email',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),

                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFe00505),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator:
                                                          ValidationBuilder()
                                                              .email()
                                                              .maxLength(50)
                                                              .build(),
                                                      onSaved: (value) {
                                                        _email = value!;
                                                      },
                                                      enabled: _isEditable,
                                                    ),
                                                    SizedBox(height: 20.0),
                                                    TextFormField(
                                                      controller: phone,
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons.phone),
                                                        // suffixIcon: Icon(Icons.person),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFe00505),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),

                                                        //  filled: true,
                                                        labelText: 'Phone',
                                                        hintText:
                                                            'Enter a phone number',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),

                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator:
                                                          ValidationBuilder()
                                                              .phone()
                                                              .build(),
                                                      onSaved: (value) {
                                                        _phone = value!;
                                                      },
                                                      enabled: _isEditable,
                                                    ),
                                                    SizedBox(height: 20.0),
                                                    TextFormField(
                                                      controller: password,
                                                      obscureText:
                                                          _passwordObscureText,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons.lock),
                                                        //                        suffixIcon: Icon(Icons.remove_red_eye_outlined),
                                                        suffixIcon:
                                                            GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              _passwordObscureText =
                                                                  !_passwordObscureText;
                                                            });
                                                          },
                                                          child: Icon(
                                                            color:
                                                                Color(0xFFe00505),
                                                            _passwordObscureText
                                                                ? Icons.visibility
                                                                : Icons
                                                                    .visibility_off,
                                                          ),
                                                        ),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFe00505),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),
                                                        suffixIconColor:
                                                            Colors.black,

                                                        //  filled: true,
                                                        labelText: 'Password',
                                                        hintText:
                                                            'Enter your password',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),

                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator: ValidationBuilder()
                                                          .minLength(8)
                                                          .maxLength(50)
                                                          // .regExp(
                                                          //   RegExp(
                                                          //     r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$',
                                                          //   ),
                                                          //   'Password must contain at least 8 characters, including uppercase and lowercase letters, numbers, and special characters',
                                                          // )
                                                          .build(),
                                                      onSaved: (value) {
                                                        _password = value!;
                                                      },
                                                      enabled: _isEditable,
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    TextFormField(
                                                      controller: confirnpassword,
                                                      obscureText:
                                                          _passwordObscureText,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons.lock),
                                                        // suffixIcon: Icon(Icons.person),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFdd0130),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),
                                                        suffixIcon:
                                                            GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              _passwordObscureText =
                                                                  !_passwordObscureText;
                                                            });
                                                          },
                                                          child: Icon(
                                                            color:
                                                                Color(0xFFe00505),
                                                            _passwordObscureText
                                                                ? Icons.visibility
                                                                : Icons
                                                                    .visibility_off,
                                                          ),
                                                        ),
                                                        //  filled: true,
                                                        labelText:
                                                            'Confirm Password',
                                                        hintText:
                                                            'Confirm Password',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),

                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Please confirm your password';
                                                        } else if (value !=
                                                            _password) {
                                                          return 'Passwords do not match';
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      onSaved: (value) {
                                                        _confirmPassword = value!;
                                                      },
                                                      // onChanged: (value) {
                                                      //   print(value);
                                                      // },
                                                    ),
                                                
                                                  ],
                                                ),
                                              ),
                                              isExpanded: _isExpandedList[0],
                                            ),
                                            ExpansionPanel(canTapOnHeader:true,
                                              backgroundColor: Color(0xFFeff2f9),
                                              headerBuilder:
                                                  (BuildContext context,
                                                      bool isExpanded) {
                                                return ListTile(
                                                  leading: Icon(
                                                    Icons.contact_phone,
                                                    color: Color(0xFFdd0130),
                                                  ),
                                                  title: Text(
                                                    'Contact Informations',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 17),
                                                  ),
                                                );
                                              },
                                              body: Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      controller: gradient,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons.person),
                                                        // suffixIcon: Icon(Icons.person),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,

                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),

                                                        //  filled: true,
                                                        labelText: 'Name',
                                                        hintText:
                                                            'Enter your guardians name',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFe00505),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator:
                                                          ValidationBuilder()
                                                              .minLength(3)
                                                              .maxLength(50)
                                                              .build(),
                                                      onSaved: (value) {
                                                        _gradient = value!;
                                                      },
                                                      enabled: _isEditable,
                                                    ),
                                                    SizedBox(height: 20.0),
                                                    TextFormField(
                                                      controller: relationship,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons.group),
                                                        // suffixIcon: Icon(Icons.person),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,

                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),

                                                        //  filled: true,
                                                        labelText: 'RelationShip',
                                                        hintText:
                                                            'Enter your guardian name',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFe00505),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator:
                                                          ValidationBuilder()
                                                              .minLength(3)
                                                              .maxLength(50)
                                                              .build(),
                                                      onSaved: (value) {
                                                        _relationship = value!;
                                                      },
                                                      enabled: _isEditable,
                                                    ),
                                                    SizedBox(height: 20.0),
                                                    TextFormField(
                                                      controller: contact1,
                                                      keyboardType: TextInputType
                                                          .emailAddress,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons.mail),
                                                        // suffixIcon: Icon(Icons.person),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,

                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),

                                                        //  filled: true,
                                                        labelText: 'Email',
                                                        hintText:
                                                            'Enter your Email',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),

                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFe00505),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator:
                                                          ValidationBuilder()
                                                              .email()
                                                              .maxLength(50)
                                                              .build(),
                                                      onSaved: (value) {
                                                        _contact1 = value!;
                                                      },
                                                      enabled: _isEditable,
                                                    ),
                                                    SizedBox(height: 20.0),
                                                    TextFormField(
                                                      controller: contact2,
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons.phone),
                                                        // suffixIcon: Icon(Icons.person),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFe00505),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),

                                                        //  filled: true,
                                                        labelText: 'Phone',
                                                        hintText:
                                                            'Enter a phone number',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),

                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator:
                                                          ValidationBuilder()
                                                              .phone()
                                                              .build(),
                                                      onSaved: (value) {
                                                        _contact2 = value!;
                                                      },
                                                      enabled: _isEditable,
                                                    ),
                                                  
                                                  ],
                                                ),
                                              ),
                                              isExpanded: _isExpandedList[1],
                                            ),
                                            ExpansionPanel(canTapOnHeader:true,
                                              backgroundColor: Color(0xFFeff2f9),
                                              headerBuilder:
                                                  (BuildContext context,
                                                      bool isExpanded) {
                                                return ListTile(
                                                  leading: Icon(
                                                    Icons.medical_services,
                                                    color: Color(0xFFdd0130),
                                                  ),
                                                  title: Text(
                                                    'Medical Informations',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 17),
                                                  ),
                                                );
                                              },
                                              body: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: Column(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          'Do you have any medical conditions? '),
                                                    ),
                                                    SizedBox(height: 20.0),
                                                    TextFormField(
                                                      controller: information,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons
                                                                .medical_services),
                                                        // suffixIcon: Icon(Icons.person),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,

                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),

                                                        //  filled: true,
                                                        labelText:
                                                            'medical conditions',
                                                        hintText:
                                                            'Enter your medical conditions',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFe00505),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator:
                                                          ValidationBuilder()
                                                              .maxLength(10240)
                                                              .build(),
                                                      onSaved: (value) {
                                                        _information = value!;
                                                      },
                                                      enabled: _isEditable,
                                                    ),
                                                    SizedBox(height: 16.0),
                                                    Center(
                                                      child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          'Do you take any medications on a regular basis? '),
                                                    ),
                                                    SizedBox(height: 20.0),
                                                    TextFormField(
                                                      controller: medications,
                                                      // keyboardType: TextInputType.emailAddress,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons.medication),
                                                        // suffixIcon: Icon(Icons.person),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,

                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),

                                                        //  filled: true,
                                                        labelText: 'medications',
                                                        hintText:
                                                            'Enter your medications',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),

                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFe00505),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator:
                                                          ValidationBuilder()
                                                              .maxLength(10240)
                                                              .build(),
                                                      onSaved: (value) {
                                                        _medications = value!;
                                                      },
                                                      enabled: _isEditable,
                                                    ),
                                                    SizedBox(height: 16.0),
                                                    Center(
                                                      child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          'Do you have any allergies ? '),
                                                    ),
                                                    SizedBox(height: 16.0),
                                                    TextFormField(
                                                      controller: allergies,
                                                      //   keyboardType: TextInputType.aller,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                            Icons.medication),
                                                        // suffixIcon: Icon(Icons.person),
                                                        fillColor: Colors.amber,
                                                        focusColor: Colors.grey,
                                                        iconColor:
                                                            Colors.lightGreen,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xFFe00505),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                color: Color
                                                                    .fromARGB(255,
                                                                        0, 0, 0)),
                                                        hoverColor: Colors.green,
                                                        prefixIconColor:
                                                            Color(0xFFdd0130),

                                                        //  filled: true,
                                                        labelText: 'allergies',
                                                        hintText:
                                                            'Enter a phone allergies',
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),

                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      validator:
                                                          ValidationBuilder()
                                                              .maxLength(10240)
                                                              .build(),
                                                      onSaved: (value) {
                                                        _allergies = value!;
                                                      },
                                                      enabled: _isEditable,
                                                    ),
                                                    SizedBox(height: 16.0),
                                                  ],
                                                ),
                                              ),
                                              isExpanded: _isExpandedList[2],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 25.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            child: ElevatedButton.icon(
                                              onPressed: _isEditable
                                                  ? null
                                                  : () {
                                                      setState(() {
                                                        _isEditable =
                                                            !_isEditable;
                                                      });
                                                    },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                              label: const Text(
                                                'EDIT',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 1.5,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: _isEditing
                                                    ? Colors.grey
                                                    : Color(0xFFdd0130),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            child: ElevatedButton.icon(
                                              onPressed: !_isEditable
                                                  ? null
                                                  : () async {
                                                      if (_formKey.currentState!
                                                              .validate() ||
                                                          _password ==
                                                              _confirmPassword) {
                                                        _formKey.currentState!
                                                            .save();
                                                        setState(() {
                                                          showSpinner = true;
                                                        });
                                                        await updateUser(
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
                                                        getUserByEmail();
                                                        setState(() {
                                                          showSpinner = false;
                                                          _isEditable =
                                                              !_isEditable;
                                                        });
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                'Passwords do not match'),
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                        );
                                                      }
                                                    },
                                              icon: const Icon(
                                                Icons.save,
                                                color: Colors.white,
                                              ),
                                              label: const Text(
                                                'SAVE',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 1.5,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: _isEditing
                                                    ? Colors.grey
                                                    : Color(0xFFdd0130),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //------------------------,
                      ),
                    ],
                  ),

                    Positioned(
            top: 0,
            right: 0,
            child:  IconButton(
            icon: Icon(Icons.power_settings_new, color: Color(0xFFdd0130)),
            onPressed: () {
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
          ), 
          ),
                ],
              ),
            ),
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
