import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import '../providers/scan_provider.dart';
import 'package:qr_app/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {//https://pub.dev/packages/fast_qr_reader_view
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
        
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', true, ScanMode.QR);
        // final barcodeScanRes = await scanProvider.nuevoScan('geo:39.480488, -0.323798');
        if(barcodeScanRes  == '-1'){
          return;
        }

        final scanProvider = Provider.of<ScanProvider>(context, listen: false);
       
        final nuevoScan = await scanProvider.nuevoScan(barcodeScanRes);
       

        launch(context, nuevoScan);
  
      },
    );
  }
}