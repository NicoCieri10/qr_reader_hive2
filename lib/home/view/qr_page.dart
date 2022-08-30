import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qr_reader_hive2/home/scans_cubit/scans_cubit.dart';
import 'package:qr_reader_hive2/map/map.dart';

class QRPage extends StatelessWidget {
  const QRPage({
    super.key,
    this.scansType = ScanModelType.geo,
    required this.scans,
  });

  factory QRPage.maps(List<ScanModel>? scans) => QRPage(
        scans: scans,
      );

  factory QRPage.directions(List<ScanModel>? scans) => QRPage(
        scans: scans,
        scansType: ScanModelType.http,
      );

  final List<ScanModel>? scans;
  final ScanModelType? scansType;

  @override
  Widget build(BuildContext context) {
    final _scans = scans;

    if (_scans == null || _scans.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              scansType == ScanModelType.geo
                  ? Icons.map
                  : Icons.compass_calibration,
              size: 75,
            ),
            Text(
              scansType == ScanModelType.geo
                  ? 'No hay geoposiciones'
                  : 'No hay direcciones',
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _scans.length,
      itemBuilder: (_, index) {
        final scan = _scans[index];

        final actionList = ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => context.read<ScansCubit>().deleteScan(scan),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Borrar',
            ),
          ],
        );

        return Slidable(
          endActionPane: actionList,
          startActionPane: actionList,
          child: ListTile(
            leading: Icon(Icons.map, color: Theme.of(context).primaryColor),
            title: Text(scan.value),
            subtitle: Text('ID: ${scan.id}'),
            onTap: () {
              if (scansType == ScanModelType.geo) {
                Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (_) => PageMap(scan),
                  ),
                );
              } else {}
            },
          ),
        );
      },
    );
  }
}
