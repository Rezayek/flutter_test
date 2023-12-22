import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/services/data/position_data.dart';
import 'package:flutter_application_1/services/services/best_location_services/position_services.dart';

import '../../services/location_service/managers/location_manager.dart';
import 'friend_event.dart';
import 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  FriendBloc( PositionService positionService)
      : super(const FriendStateInit(isLoading: false)) {
    on<FriendEventInit>(
      (event, emit) async{
        emit(const FriendStateInit(isLoading: true));
        await LocationManager().requestLocationPermission();
        var location = await LocationManager().locationFunc();
        emit(FriendStateInit(isLoading: false, location:location));
      },
    );

    on<FriendEventGetLocation>(
      (event, emit) async {
        emit(const FriendStateInit(isLoading: true));
        var location = await LocationManager().locationFunc();
        if(location != null){
          emit(FriendStateInit(isLoading: false, location: location));
        }
        emit(const FriendStateInit(isLoading: false));
        
      },
    );

    on<FriendEventUploadLocation>((event, emit)async {
      emit(const FriendStateInit(isLoading: true));
      await positionService.addPosition(event.positionData);
      emit(const FriendStateInit(isLoading: false));
    },);


    on<FriendEventGetBestLocations>((event, emit) async{
      emit(const FriendStateInit(isLoading: true));
      List<PositionData> bestLocations = await positionService.fetchPositions();
      emit(const FriendStateInit(isLoading: false));
      emit(FriendStateLocations(bestLocations: bestLocations, isLoading: false));
    },);

    

    on<FriendEventAddFriendInit>(
      (event, emit) {
        //emit(const FriendStateAdd (position: ));
      },
    );

    on<FriendEventAddFriend>(
      (event, emit) {
        emit(const FriendStateInit(isLoading: false));
      },
    );
  }
}
