import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_controllers/chat_controller.dart';
import 'package:flutter_application_1/app_controllers/friend_controller.dart';
import 'package:flutter_application_1/app_interface/views/location_display_view.dart';
import 'package:flutter_application_1/app_interface/views/main_view.dart';
import 'package:flutter_application_1/services/blocs/chat_bloc/chat_bloc.dart';
import 'package:flutter_application_1/services/blocs/location_bloc/location_bloc.dart';
import 'package:flutter_application_1/services/services/best_location_services/position_services.dart';
import 'package:flutter_application_1/services/services/chat_services/chat_manager.dart';
import 'package:flutter_application_1/services/services/location_service/location_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_controllers/location_controller.dart';
import '../services/blocs/friend_bloc/friend_bloc.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) =>  const MainView());
      case "/find_me":
        return MaterialPageRoute(builder: (_) => BlocProvider(create: (context) => LocationBloc(LocationService()),child: const LocationController(),));
      case "/map":
        return MaterialPageRoute(settings: routeSettings,builder: (_) =>  const LocationDisplayView());
      case "/best_location":
        return MaterialPageRoute(builder: (_) =>  BlocProvider(create: (context) => FriendBloc(PositionService()),child: const FriendController(),));
      case "/chat":
        return MaterialPageRoute(builder: (_) =>  BlocProvider(create: (context) => ChatBloc(ChatManager()),child: const ChatController(),));
    }

    return null;
  }

  void dispose() {}
}
