import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_reader_hive2/home/scans_cubit/scans_cubit.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scans =
        (context.read<ScansCubit>().state as ScansSuccessful).geoScans;

    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, index) => ListTile(
        leading: Icon(Icons.map, color: Theme.of(context).primaryColor),
        title: const Text('http//'),
        subtitle: const Text('ID: 1'),
        trailing: const Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey,
        ),
        onTap: () => print('abir algo...'),
      ),
    );
  }
}
