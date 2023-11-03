import 'dart:async';

import 'package:flutter_application_1/services/services/location_service/managers/location_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telephony/telephony.dart';
import 'dart:developer' as debug;
import 'package:rxdart/rxdart.dart';

class LocationSMSManager {
  // Private constructor to prevent external instantiation
  LocationSMSManager._privateConstructor() {
    _initTelephony();
  }

  // Singleton instance variable
  static final LocationSMSManager _instance =
      LocationSMSManager._privateConstructor();

  // Factory constructor to return the singleton instance
  factory LocationSMSManager() {
    return _instance;
  }

  late final Telephony _smsManager;
  final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotifcationClick = BehaviorSubject();
  late String? payload;

  void _initTelephony() async {
    _smsManager = Telephony.instance;
    await _smsManager.requestPhoneAndSmsPermissions;
    _initNotification();
    _recieveLocationRequestListener();
  }

  Future sendLocationRquest(String phoneNumber) async {
    if (await _requestPrmission()) {
      debug.log("send loc");
      await _smsManager.sendSms(to: phoneNumber, message: "location");
      debug.log("send loc-------");
    }
  }

  void sendLocation(String phoneNumber, Position? location) async {
    debug.log("Call loc sender");
    if (await _requestPrmission()) {
      _smsManager.sendSms(
          to: phoneNumber,
          message: "${location!.latitude},${location.longitude}");
    }
  }

  Future<bool> _requestPrmission() async {
    return await _smsManager.requestPhoneAndSmsPermissions ?? false;
  }

  void _recieveLocationRequestListener() {
    _smsManager.listenIncomingSms(
      onNewMessage: _forgroundMessageHandlerLocationRquest,
      onBackgroundMessage: backgrounMessageHandlerLocationRequest,
    );
  }

  Future<void> _initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
  }

  Future showNotification(
      {int id = 0,
      String? title = "Notification",
      String? body = "none",
      String? payload}) async {
    return _notification.show(id, title, body, await _notificationDetails(),
        payload: payload);
  }

  _notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max));
  }

  _onSelectNotification(NotificationResponse details) async {
    if (details.payload == null && details.payload!.isEmpty) return;
    onNotifcationClick.add(details.payload);
  }

  _forgroundMessageHandlerLocationRquest(SmsMessage message) async {
    if (message.body == "location") {
      debug.log(message.address!);
      Position? location = await LocationManager().locationFunc();
      LocationSMSManager().sendLocation(message.address!, location!);
    } else {
      LocationSMSManager().showNotification(
          title: "Location of ${message.address}",
          body: message.body,
          payload: message.body);
    }
  }
}

void backgrounMessageHandlerLocationRequest(SmsMessage message) async {
  if (message.body == "location") {
    debug.log(message.address!);
    Position? location = await LocationManager().locationFunc();
    LocationSMSManager().sendLocation(message.address!, location!);
  } else {
    LocationSMSManager().showNotification(
        title: "Location of ${message.address}",
        body: message.body,
        payload: message.body);
  }
}
