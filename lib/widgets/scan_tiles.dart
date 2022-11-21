import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/utils/utils.dart';
import '../providers/scan_provider.dart';

class ScanTiles extends StatelessWidget {

  final String tipo;
  const ScanTiles({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanProvider>(context);
    final scans = scanProvider.scans;
    // Future<dynamic> future = scanProvider.cargarScans();// cargarScanPorTipo('http');
          // List<ScanModel> scans = snapshot.data!;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          child: const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Icon(Icons.delete, color: Colors.white,),
          ),
        ),

        onDismissed: (DismissDirection dir) {
          Provider.of<ScanProvider>(context, listen: false).borrarPorId(scans[i].id!);
        },
        
        child: ListTile(
          leading: Icon(tipo == 'http' ? Icons.wifi : Icons.map, color: Theme.of(context).primaryColor),
          title: Text(scans[i].valor),
          subtitle: Text('ID: ${scans[i].id.toString()}'),
          trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () {
            launch(context, scans[i]);
          },
        ),
      ),
    );
      
  }
}