import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ejrili_yammi/Login/LoginPage.dart';
import 'package:ejrili_yammi/Login/SignPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final List<String> texts = [
    'Ejrili provides a quick and easy way to access emergency services in any situation.',
    'يوفر اجريلي طريقة سريعة وسهلة للوصول إلى خدمات الطوارئ في أي موقف',
    'With Ejrili, you can rest assured that help is always just a few taps away.',
    'مع اجريلي ، يمكنك أن تطمئن إلى أن المساعدة دائمًا ما تكون على بعد بضع نقرات.',
    'Stay safe and secure with Ejrili, the ultimate emergency app.',
    'حافظ على سلامتك وأمانك مع اجريلي  تطبيق الطوارئ النهائي',
    'Ejrili is the must-have app for anyone who wants peace of mind in any emergency situation.',
    'اجريلي هو التطبيق الضروري لمن يريد راحة البال في أي حالة طارئة',
    'Get instant access to emergency services and resources with Ejrili, your personal safety companion.',
    'احصل على وصول فوري إلى خدمات الطوارئ والموارد مع اجريلي ، رفيق سلامتك الشخصية',
    'Ejrili is the ultimate emergency app for travelers, adventurers, and anyone on the go.',
    'اجريلي هو تطبيق الطوارئ النهائي للمسافرين والمغامرين وأي شخص أثناء التنقل',
    'Be prepared for anything with Ejrili, the emergency app that\'s always there when you need it.',
    'استعد لأي شيء مع اجريلي ، تطبيق الطوارئ الموجود دائمًا عندما تحتاج إليه',
    'With Ejrili, you can feel confident knowing that you\'re ready for any emergency that comes your way.',
    'مع اجريلي ، يمكنك أن تشعر بالثقة بمعرفة أنك مستعد لأي طارئ يأتي في طريقك',
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color.fromARGB(255, 238, 238, 238),
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            stops: [
              0.1,
              0.12,
              0.23,
              0.34,
              0.40,
              0.95,
              0.965,
              0.975,
              0.985,
              0.99,
              1,
            ],
            colors: [
              // Color(0xFFf00100),
              Color(0xFFdd0130),
              Color(0xFFdd0130),

              Color(0xFFdd0130),
              Color(0xFFdd0130),
              Color(0xFFdd0130),
              Color(0xFF5C0719),
              Color(0xFF5C0719),
              Color(0xFF5C0719),
              Color(0xFF5C0719),
              Color(0xFF5C0719),
              //  Color(0xFF2A2A2B),
              //  Color(0xFFdd0130),

              Color(0xFF5C0719),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
    //             SizedBox(
    //               height: MediaQuery.of(context).size.height * 0.45,
    //               child: ListView(
    //   scrollDirection: Axis.horizontal,
    //   children: [
    //     Transform.scale(
    //                 scale: 1,
    //                 alignment: Alignment.center,
    //                 child: Image.asset(
    //                   'images/login.png',
                      
    //                   height: MediaQuery.of(context).size.height * 0.1,
    //                 ),
    //               ), Transform.scale(
    //                 scale: 1,
    //                 alignment: Alignment.center,
    //                 child: Image.asset(
    //                   'images/first.png',
                      
    //                   height: MediaQuery.of(context).size.height * 0.1,
    //                 ),
    //               ), Transform.scale(
    //                 scale: 1,
    //                 alignment: Alignment.center,
    //                 child: Image.asset(
    //                   'images/login.png',
                      
    //                   height: MediaQuery.of(context).size.height * 0.1,
    //                 ),
    //               ),
    //     // Add more images as needed
    //   ],
    // )
    //             ),
                SizedBox( height: MediaQuery.of(context).size.height * 0.45,
                  child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio:1.7,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            pauseAutoPlayOnTouch: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: [
                           Transform.scale(
                      scale: 1.5,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/login.png',
                        
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ), Transform.scale(
                      scale: 1.15,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/first.png',
                        
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ), Transform.scale(
                      scale: 1.5,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/login.png',
                        
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ),Transform.scale(
                      scale: 1.4,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/loginxx.png',
                        
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ),Transform.scale(
                      scale: 1.5,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/signUp.png',
                        
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ),Transform.scale(
                      scale: 1.7,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/more.png',
                        
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ),
                          ],
                        ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'EJRILI',
                        style: GoogleFonts.audiowide(
                          fontSize: 45,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: '    ',
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                          TextSpan(
                            text: 'إجريلي',
                            //amiriQuran//
                            style: GoogleFonts.notoNastaliqUrdu(
                              fontSize: 45,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                            //    color: Color(0xFFffdde1)
                            color: Color(0xFFdd0130),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'REGISTER NOW',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Icon(
                                    Icons.how_to_reg,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.transparent,
                                offset: Offset(0, 0),
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                            color: Color(0xFFdd0130),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFffffff),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Icon(
                                    Icons.login,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider(
                    items: texts.map((item) {
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              item,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  letterSpacing: 1,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      pauseAutoPlayOnTouch: true,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      scrollDirection: Axis.vertical,
                      reverse: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
