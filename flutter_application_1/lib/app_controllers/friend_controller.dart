import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_interface/views/sub_views/location_best.dart';
import 'package:flutter_application_1/app_interface/views/sub_views/locations_best.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/blocs/friend_bloc/friend_bloc.dart';
import '../services/blocs/friend_bloc/friend_event.dart';
import '../services/blocs/friend_bloc/friend_state.dart';

class FriendController extends StatefulWidget {
  const FriendController({super.key});

  @override
  State<FriendController> createState() => _LocationControllerState();
}

class _LocationControllerState extends State<FriendController> {
  @override
  Widget build(BuildContext context) {
    context.read<FriendBloc>().add(const FriendEventInit());
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<FriendBloc, FriendState>(
        builder: (context, state) {
          if (state is FriendStateInit) {
            return const LocationBest();
          } else if (state is FriendStateAdd) {
            return Container();
          } else if (state is FriendStateLocations) {
            return LocationsBest(locations: state.bestLocations);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
