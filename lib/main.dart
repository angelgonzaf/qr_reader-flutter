import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/providers/scan_provider.dart';
import 'package:qr_app/providers/ui_provider.dart';
import 'package:qr_app/screens/home_screen.dart';
import 'package:qr_app/screens/mapa_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var primary = Colors.teal;
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': ( _ ) => HomeScreen(),
          'mapa': ( _ ) => MapaScreen()
        },
        theme: ThemeData(
          primaryColor: primary,
          appBarTheme: AppBarTheme(color: primary),
          floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: primary,),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(unselectedItemColor: Colors.grey.shade600, selectedItemColor: primary)
        )
      ),
    );
  }
} 