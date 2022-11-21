import 'package:flutter/material.dart';
import 'package:qr_app/models/models.dart';
import 'package:qr_app/providers/db_provider.dart';

class ScanProvider extends ChangeNotifier{

  List<ScanModel>  scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {

    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    nuevoScan.id = id; //Asigna  el id de la BBDD al scan
    
    if(tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  cargarScans() async {
    final scans = await DBProvider.db.getScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScanPorTipo( String tipo) async {
    final scans = await DBProvider.db.getScansByTipo(tipo);
    this.scans = [...scans];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteScans();
    scans = [];
    notifyListeners();
  }

  borrarPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    // this.scans.where((element) => element.id == id);
    cargarScanPorTipo(tipoSeleccionado);
  }

}