import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:ejrili_yammi/Login/LoginPage.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:ejrili_yammi/emergency/Maps.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';

class RasaChatPage extends StatefulWidget {
    final Map<String, dynamic> data;

  const RasaChatPage({Key? key, required this.data}) : super(key: key);






  @override
  _RasaChatPageState createState() => _RasaChatPageState();
}



class _RasaChatPageState extends State<RasaChatPage>
    with AutomaticKeepAliveClientMixin<RasaChatPage> {
  TextEditingController _messageController = TextEditingController();
  List<ChatBubble> chatBubbles = [];

  // void sendMessage(String message) async {
  //   chatBubbles.add(ChatBubble(
  //     message: message,
  //     isSentByUser: true,
  //   ));
  //   setState(() {});
  //   try {
  //     var response = await http.post(
  //       Uri.parse('http://10.0.2.2:5005/webhooks/rest/webhook'),
  //       body: '{"sender": "user", "message": "$message"}',
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     if (response.statusCode == 200) {
  //       var jsonResponse = jsonDecode(response.body);
  //       for (var item in jsonResponse) {
  //         if (item['text'] != null) {
  //           // Check if the current item has a 'text' key
  //           var botMessage = item['text'];
  //           print(botMessage);
  //           chatBubbles.add(ChatBubble(
  //             message: botMessage,
  //             isSentByUser: false,
  //           ));
  //         } else if (item['image'] != null) {
  //           // Check if the current item has an 'image' key
  //           var imageUrl = item['image'];
  //           print(imageUrl);
  //           chatBubbles.add(ChatBubble(
  //             message: imageUrl,
  //             isSentByUser: false,
  //           ));
  //         }
  //       }
  //       setState(() {});
  //     } else {
  //       //  throw Exception('Failed code to connect to Rasa server');
  //       setState(() {
  //         final errorMessage = response.statusCode != 200
  //             ? 'Failed code to connect to Rasa server'
  //             : response.reasonPhrase;
  //         setState(() {
  //           print(errorMessage);
  //         });
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  final ScrollController _scrollController = ScrollController();
  void sendMessage(String message) async {
    chatBubbles.add(
      ChatBubble(
        message: message,
        isSentByUser: true,
      ),
    );
    setState(() {});
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:5005/webhooks/rest/webhook'),
        body: '{"sender": "user", "message": "$message"}',
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        for (var item in jsonResponse) {
          if (item['text'] != null) {
            var botMessage = item['text'];
            print('Yammi: $botMessage');
            chatBubbles.add(
              ChatBubble(
                message: botMessage,
                isSentByUser: false,
              ),
            );

            if (item.containsKey('buttons')) {
              var buttons = item['buttons'];
              var buttonTitles = <String>[];
              var buttonPayloads = <String>[];

              for (var button in buttons) {
                buttonTitles.add(button['title']);
                // buttonPayloads.add(button['payload']);
              }

              print('Buttons: $buttonTitles');
              // print('Button Payloads: $buttonPayloads');

              // Create a list of ElevatedButton widgets
              List<String> buttonList =
                  buttonTitles.map((title) => '* ${title}').toList();

              // Add the button list to chatBubbles
              chatBubbles.addAll(
                buttonList.map(
                  (button) => ChatBubble(
                    message: button,
                    isSentByUser: false,
                  ),
                ),
              );
            }
          } else if (item['image'] != null) {
            var imageUrl = item['image'];
            print('Image; $imageUrl');
            chatBubbles.add(
              ChatBubble(
                message: imageUrl,
                isSentByUser: false,
              ),
            );
          }
        }
        setState(() {
          // Scroll to the bottom of the ListView whenever there's a new message from the bot.
        });
      } else {
        // throw Exception('Failed code to connect to Rasa server');
        setState(() {
          final errorMessage = response.statusCode != 200
              ? 'Failed code to connect to Rasa server'
              : response.reasonPhrase;
          setState(() {
            print('Error: $errorMessage');
          });
        });
      }
    } catch (e) {
      print('catch: $e');
    }
  }

  void _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // final currentLocation = await location.getLocation();
      final latitude = position.latitude;
      final longitude = position.longitude;
      final GPS_location = '$latitude,$longitude';
      setState(() {
        print('GPS: $GPS_location');
        sendMessage(GPS_location);
        // chatBubbles.add(ChatBubble(
        //   message: GPS_location,
        //   isSentByUser: true,
        // ));
      });
    } catch (e) {
            print('catchGPS: $e');

    }
  }
String removeTrailingSpaces(String str) {
  RegExp regex = RegExp(r'\s*$');
  return str.replaceAll(regex, '');
}
  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void dispose() {
    _messageController.dispose();

    super.dispose();
  }

  bool _showTextField = false;

  void _callEmergencyServices() {
    final phoneNumber = '+216$_phoneParam';
    launch('tel:$phoneNumber');
  }

  void _callEmergencyServicesAmbulance() {
    final phoneNumber = '190';
    launch('tel:$phoneNumber');
  }

  void _callEmergencyServicesFire() {
    final phoneNumber = '198';
    launch('tel:$phoneNumber');
  }

  void _callEmergencyServicesPolice() {
    final phoneNumber = '197';
    launch('tel:$phoneNumber');
  }
  String _emailParam = '';
  String _phoneParam = '';

    @override
  void initState() {
    super.initState();

    //  create function get
    //   print(widget.data);
    _phoneParam = widget.data['contact2'];
    _emailParam = widget.data['email'];


  }
  

  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      backgroundColor: Color(0xFFeff2f9),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 238, 239, 241),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.power_settings_new,
            color: Color(0xFFdd0130),
          ),
          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));

          },
        ),
        title: Text(
          'YAMMI',
          style: GoogleFonts.audiowide(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFFdd0130),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: Color(0xFFdd0130)),
            onPressed: () {
              _callEmergencyServices();
            },
          ),
          IconButton(
            icon: Icon(Icons.place, color: Color(0xFFdd0130)),
            onPressed: () {
              _getCurrentLocation();
            },
          ),   
          //  IconButton(
          //   icon: Icon(Icons.power_settings_new, color: Color(0xFFdd0130)),
          //   onPressed: () {
          //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
          //   },
          // ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(

decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/profil.png'),
              fit: BoxFit.fitHeight,opacity: 0.08,
   
            ),
          ),


              child: ListView.builder(
                addAutomaticKeepAlives: true,
                controller: _scrollController,
                reverse: false,
                scrollDirection: Axis.vertical,
                itemCount: chatBubbles.length,
                itemBuilder: (context, index) {
                  var chatBubble = chatBubbles[index];
            
                  if (chatBubble.message.toLowerCase().endsWith('.png') ||
                      chatBubble.message.toLowerCase().endsWith('.jpg') ||
                      chatBubble.message.toLowerCase().endsWith('.jpeg')) {
                    return Container(color: Colors.transparent,
                      padding:
                          const EdgeInsets.only(left: 50.0, bottom: 0, top: 0),
                      child: BubbleNormalImage(bubbleRadius:5 ,
                          onTap: () {
                            try {
                              print('image opened');
                            } catch (e) {
                                    print('catchImg: $e');
            
                            }
                          },
                          id: 'id002',
                          color: Colors.transparent,
                          image: Container(color: Colors.red,
                            child: CachedNetworkImage(
                              imageUrl: chatBubble.message,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              httpHeaders: {
                                'Cache-Control': 'max-age=604800'
                              }, // cache for a week
                              fadeInDuration: Duration(milliseconds: 200),
                              fadeOutDuration: Duration(milliseconds: 200),
                              fit: BoxFit.contain,
                            ),
                          ),
                          tail: false,
                          delivered: false,
                          isSender: false),
                    );
                  } else if (chatBubble.message.toLowerCase().contains('*')) {
                    String newText =
                        chatBubble.message.replaceAll('*', '').trim();
            
                    if (newText.isNotEmpty) {
                      String titleBtn =
                          newText[0].toUpperCase() + newText.substring(1);
            
                      // If the message ends with a valid image extension, display the image
                      return Row(
                        children: [
                          Wrap(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  minWidth: 100,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 15),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print('User: $titleBtn');
                                      sendMessage(titleBtn);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10, backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      // Change background color here
                                      // Change text color here
                                      // You can also define other properties like textstyle, padding, shape, elevation etc. as per your requirement.
                                    ),
                                    child: Text(
                                      titleBtn,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 17),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            // Set your desired maximum width here
                          ),
                        ],
                      );
                    }
                  } else {
                    return chatBubble.isSentByUser
                        ? BubbleSpecial(
                            message: chatBubble.message,
                            isSentByUser: true,
                          )
                        : BubbleSymmetric(
                            message: chatBubble.message,
                          );
                  }
                },
              ),
            ),
          ),
          
             if (_showTextField)
              Center(
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: 100,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  margin: EdgeInsets.symmetric(
                      vertical: 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 5,),
                    child: ElevatedButton(
                     onPressed: () {
                      
                           
                          // _textController.clear();
                     setState(() {
                        _showTextField = !_showTextField;
                          });
                          },
                      style: ElevatedButton.styleFrom(
                        elevation: 10, backgroundColor: Color(0xFFdd0130),
                        foregroundColor: Colors.white,
                        // Change background color here
                        // Change text color here
                        // You can also define other properties like textstyle, padding, shape, elevation etc. as per your requirement.
                      ),
                      child: Text(
                        'Other',
                     
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 17,letterSpacing:2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),





              if (!_showTextField)
          Column(
            children: [
              //       Divider(
              //   height: 5,
              //   color: Color(0xFFdd0130),
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _callEmergencyServicesAmbulance();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                            0xFFeff2f9) //,e Set button background to transparent
                        ,
                        elevation: 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.medical_services,
                          color: Color(0xFFdd0130),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          "Ambulance",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _callEmergencyServicesPolice();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                            0xFFeff2f9) //,e Set button background to transparent
                        ,
                        elevation: 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.local_police,
                          color: Color(0xFFdd0130),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          "Police",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _callEmergencyServicesPolice();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                            0xFFeff2f9) //,e Set button background to transparent
                        ,
                        elevation: 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Color(0xFFdd0130),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          "Fire Fighters",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
// ElevatedButton(
//   onPressed: () {
//     // Handle button press
//   },
//   style: ElevatedButton.styleFrom(
//     backgroundColor: Color(0xFFeff2f9)//,e Set button background to transparent
//   ,elevation: 0
//   ),
//   child: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Icon(Icons.search),
//       SizedBox(width: 8.0),
//       Text("Road police"),
//     ],
//   ),
// ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                            0xFFeff2f9) //,e Set button background to transparent
                        ,
                        elevation: 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.public,
                          color: Color(0xFFdd0130),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          "GPS ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Divider(
                height: 1,
                color: Color(0xFFdd0130),
              ),
              Container(
                color: Color(0xFFeff2f9),
                margin: EdgeInsets.all(0),
                child: Row(
                  children: [
   


                    Expanded(
                      
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Tell me ...',
                          prefixIcon: const Icon(Icons.emergency,
                              color: Color(0xFfdd0130)),
                          border: InputBorder.none,
                        ),
                        maxLines: 3,
                        minLines: 1,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),


                    IconButton(
                      color: Colors.brown,
                      onPressed: () {
                          var message = removeTrailingSpaces(_messageController.text);

                        if (message.trimRight().isNotEmpty) {
                          // check if message contains non-space characters
                          _messageController.clear();
                          sendMessage(message);
                          setState(() => _showTextField = !_showTextField);
                        } else {
                          print('Message contains only spaces!');
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        size: 30.0,
                        color: Color(0xFfdd0130),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatBubble {
  final String message;
  final bool isSentByUser;

  ChatBubble({required this.message, required this.isSentByUser});
}

class BubbleSpecial extends StatelessWidget {
  final String message;
  final bool isSentByUser;

  const BubbleSpecial({
    Key? key,
    required this.message,
    required this.isSentByUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSentByUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isSentByUser ? 'You' : 'Bot',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: isSentByUser ? Colors.transparent : Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft:
                    isSentByUser ? Radius.circular(20) : Radius.circular(0),
                bottomRight:
                    isSentByUser ? Radius.circular(0) : Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: BubbleSpecialThree(
              color: Color(0xFFdd0130),
              text: message,
              textStyle: TextStyle(
                  color: isSentByUser
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              isSender: true,
              tail: true,
              delivered: false,
              seen: true,
              sent: true,
            ),
          ),
        ],
      ),
    );
  }
}

// class BubbleSymmetric extends StatelessWidget {
//   final String message;

//   const BubbleSymmetric({Key? key, required this.message}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: 5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//           Column(
//   children:  [
//    const Text(
//       'Bot',
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//      Container(
//       decoration: BoxDecoration(
//         color: Colors.red,
//         borderRadius: BorderRadius.circular(50),
//       ),
//       padding: EdgeInsets.all(8),
//       child: Icon(Icons.smart_toy, color: Colors.white),
//     ),
//   ],
// ),

//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.85,
//                 child: BubbleSpecialThree(
//                   color: Color.fromRGBO(255, 255, 255, 1),
//                   text: message,
//                   textStyle: TextStyle(
//                       color: Color.fromARGB(255, 0, 0, 0),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 17),
//                   isSender: false,
//                   tail: true,
//                   delivered: false,
//                   seen: false,
//                   sent: false,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
class BubbleSymmetric extends StatefulWidget {
  final String message;

  const BubbleSymmetric({Key? key, required this.message}) : super(key: key);

  @override
  _BubbleSymmetricState createState() => _BubbleSymmetricState();
}

class _BubbleSymmetricState extends State<BubbleSymmetric> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
          Column(
  children:  [
   const Text(
      'Bot',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
     Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(8),
      child: Icon(Icons.smart_toy, color: Colors.white),
    ),
  ],
),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: BubbleSpecialThree(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  text: widget.message,
                  textStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                  isSender: false,
                  tail: true,
                  delivered: false,
                  seen: false,
                  sent: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
