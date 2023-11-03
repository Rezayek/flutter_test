import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/services/location_service/managers/location_sms_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'app_router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  listenToNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouter _router;
  @override
  void initState() {
    super.initState();
    _router = AppRouter();
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder: (context, orientation, screenType) => MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              onGenerateRoute: _router.onGenerateRoute,
            ));
  }
}

listenToNotification() => LocationSMSManager()
    .onNotifcationClick
    .stream
    .listen(onNotificationListenr);

onNotificationListenr(String? payload) {
  if (payload == null && payload!.isEmpty) {
    return;
  }
  openMap(payload);
}
//28328869
openMap(String? location) async {
  runApp(const MyApp());
  String url = 'https://www.google.com/maps/search/?api=1&query=$location';
  try {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {}
}








// import 'dart:async';

// onBackgroundMessage(SmsMessage message) {
  
//   LocationSMSManager().showNotification(
//       title: "Location of ${message.address}", body: message.body);
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String _message = "";
//   final telephony = Telephony.instance;

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   onMessage(SmsMessage message) async {
//     setState(() {
//       _message = message.body ?? "Error reading message body.";
//     });
//   }

//   onSendStatus(SendStatus status) {
//     setState(() {
//       _message = status == SendStatus.SENT ? "sent" : "delivered";
//     });
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.

//     final bool? result = await telephony.requestPhoneAndSmsPermissions;

//     if (result != null && result) {
//       telephony.listenIncomingSms(
//           onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
//     }
//     LocationSMSManager().initNotification();
//     if (!mounted) return;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         title: const Text('Plugin example app'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(child: Text("Latest received SMS: $_message")),
//           TextButton(
//               onPressed: () async {
//                 await telephony.sendSms(to: '23083511', message: "location");
//               },
//               child: Text('Open Dialer'))
//         ],
//       ),
//     ));
//   }
// }
