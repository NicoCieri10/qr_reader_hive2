import 'package:bloc/bloc.dart';
import 'package:data_persistence/data_persistence.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_state.dart';

abstract class MapCubitBase {
  /// This method is used to initialize all the stuff we need for the map.
  void init(ScanModel scan);

  /// This method is used to change the map type.
  void changeMapType();
}

class MapCubit extends Cubit<MapState> implements MapCubitBase {
  MapCubit() : super(const MapInitial());

  @override
  void init(ScanModel scan) {
    emit(const MapLoading());
    try {
      final markers = <Marker>{
        Marker(
          markerId: const MarkerId('geo-location'),
          position: scan.getLatLng(),
        )
      };
      final cameraPosition = CameraPosition(
        target: scan.getLatLng(),
        zoom: 15,
        tilt: 50,
      );
      emit(
        MapSuccess(
          markers: markers,
          cameraPosition: cameraPosition,
        ),
      );
    } catch (_) {
      emit(const MapFailure());
    }
  }

  @override
  void changeMapType() {
    final _state = state;
    if (_state is! MapSuccess) return;
    emit(
      _state.copyWith(
        mapType: _state.mapType == MapType.normal
            ? MapType.satellite
            : MapType.normal,
      ),
    );
  }
}
