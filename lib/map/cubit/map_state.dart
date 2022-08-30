part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();

  bool get isInitial => this is MapInitial;
  bool get isLoading => this is MapLoading;
  bool get isSuccessful => this is MapSuccess;
  bool get isFailure => this is MapFailure;

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {
  const MapInitial();
}

class MapLoading extends MapState {
  const MapLoading();
}

class MapSuccess extends MapState {
  const MapSuccess({
    this.mapType = MapType.normal,
    required this.markers,
    required this.cameraPosition,
  });

  final Set<Marker> markers;
  final CameraPosition cameraPosition;
  final MapType mapType;

  MapSuccess copyWith({
    MapType? mapType,
    Set<Marker>? markers,
    CameraPosition? cameraPosition,
  }) {
    return MapSuccess(
      mapType: mapType ?? this.mapType,
      markers: markers ?? this.markers,
      cameraPosition: cameraPosition ?? this.cameraPosition,
    );
  }

  @override
  List<Object> get props => [markers, cameraPosition, mapType];
}

class MapFailure extends MapState {
  const MapFailure();
}
