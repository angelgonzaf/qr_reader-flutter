

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';



Future<void> launch(BuildContext context, ScanModel scan) async {

  final url = Uri.parse(scan.valor) ;
  if(scan.tipo == 'http'){
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else  {
      throw 'Could not launch $url';
    }
  } else{
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
  
}