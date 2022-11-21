import 'package:flutter/material.dart';
import 'package:qr_app/providers/scan_provider.dart';
import 'package:qr_app/providers/ui_provider.dart';
import 'package:qr_app/screens/screens.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // final scanProvider = Provider.of<ScanProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
            onPressed: (){
              final scanProvider = Provider.of<ScanProvider>(context, listen: false);
              scanProvider.borrarTodos();
            }, 
            icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: const CustomNavbar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
   
  }
}

class _HomeScreenBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    //cambiar para cambiar de screen 
    final currentIndex = uiProvider.selectedMenuOpt;


    //TODO:  temporal leer dbfinal 
  //  final tempScan = ScanModel(valor: 'http://google.com');
  //  final intTemp = DBProvider.db.nuevoScan(tempScan);
    // final res = DBProvider.db.getScans().then(print);
    final scanProvider = Provider.of<ScanProvider>(context, listen: false);

    switch(currentIndex) {
      case 0:
        scanProvider.cargarScanPorTipo('geo');
        return const MapasScreen();

      case 1:
        scanProvider.cargarScanPorTipo('http');
        return const DirectionsScreen();

      default:
        return const MapasScreen();
    }
  }
}