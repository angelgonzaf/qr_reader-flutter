import 'dart:async';
import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaScreen extends StatefulWidget {

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {

  
  
  @override
  Widget build(BuildContext context) {

    final  ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

    final Completer<GoogleMapController> _controller = Completer();
    MapType tipo = MapType.satellite;

    final CameraPosition initialPoint = CameraPosition(
      target: scan.getLatLong(),
      zoom: 18,
      tilt: 25
    );

    Set<Marker> markers = <Marker>{};
    markers.add(Marker(
      markerId: const MarkerId('geo-location'),
      position: scan.getLatLong()

      ));
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
            onPressed:() async {
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: scan.getLatLong(),
              zoom: 18,
              tilt: 25
              )));
            } , 
            icon: const Icon(Icons.location_on_outlined))
        ],
      ),
    
      body: GoogleMap(
        mapType: tipo,
        myLocationButtonEnabled: false,
        initialCameraPosition: initialPoint,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.layers),
        onPressed: () {
          print('changing');
          
            if(tipo == MapType.normal){
              tipo = MapType.hybrid;
            } else {
              tipo = MapType.normal;
            }
          setState(() {});
        },
      ),
   );
  }
}