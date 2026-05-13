import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // Tambahan untuk Firebase
import 'firebase_options.dart'; // File hasil konfigurasi flutterfire
import 'temperature_provider.dart';
import 'auth_service.dart';
import 'login_page.dart';
import 'home_page.dart';

void main() async {
  // Wajib ditambahkan untuk inisialisasi async
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Firebase menggunakan file konfigurasi kamu
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TemperatureProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas WPB Nabila',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0088CC)),
        useMaterial3: true,
      ),
      home: Consumer<AuthService>(
        builder: (context, auth, child) {
          // Perbaikan: Menghapus keyword 'const' agar tidak error saat compile
          if (auth.isLoggedIn) {
            return HomePage(); 
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}