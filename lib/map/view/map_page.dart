import 'dart:async';

import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader_hive2/map/cubit/map_cubit.dart';

class PageMap extends StatelessWidget {
  const PageMap(
    this.scan, {
    super.key,
  });

  final ScanModel scan;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapCubit(),
      child: ViewMap(scan),
    );
  }
}

class ViewMap extends StatefulWidget {
  const ViewMap(
    this.scan, {
    super.key,
  });

  final ScanModel scan;

  @override
  State<ViewMap> createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    context.read<MapCubit>().init(widget.scan);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text('Mapa'),
          //   actions: [
          //     IconButton(
          //       icon: Icon(Icons.location_disabled),
          //       onPressed: () async {
          //    final GoogleMapController controller = await _controller.future;
          //         controller.animateCamera(
          //           CameraUpdate.newCameraPosition(
          //             CameraPosition(
          //               target: scan.getLatLng(),
          //               zoom: 17.5,
          //               tilt: 50,
          //             ),
          //           ),
          //         );
          //       },
          //     )
          //   ],
          // ),
          body: Builder(
            builder: (context) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isFailure) {
                return const Center(
                  child: Text('GIL!!!, Error al cargar el mapa'),
                );
              } else if (state is MapSuccess) {
                return GoogleMap(
                  myLocationButtonEnabled: false,
                  mapType: state.mapType,
                  markers: state.markers,
                  initialCameraPosition: state.cameraPosition,
                  onMapCreated: _controller.complete,
                );
              }
              return const SizedBox();
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: context.read<MapCubit>().changeMapType,
            child: const Icon(Icons.layers),
          ),
        );
      },
    );
  }
}
