import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_hive2/home/scans_cubit/scans_cubit.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
        // final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //   '#3D8BEF',
        //   'Cancelar',
        //   false,
        //   ScanMode.QR,
        // );
        const barcodeScanRes = 'https//www.google.com';

        await context.read<ScansCubit>().createScan(barcodeScanRes);
      },
    );
  }
}
