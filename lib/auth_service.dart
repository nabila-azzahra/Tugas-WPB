import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Variabel untuk menyimpan pesan error
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Stream untuk memantau status login
  User? get currentUser => _auth.currentUser;
  bool get isLoggedIn => _auth.currentUser != null;

  // Fungsi Login
  Future<void> login(String email, String password) async {
    try {
      _errorMessage = null; // Reset pesan error
      await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Menangkap pesan error dari Firebase (contoh: user-not-found, wrong-password, too-many-requests)
      _errorMessage = e.message;
      notifyListeners();
      // Melempar error kembali agar bisa ditangkap oleh UI (SnackBar)
      rethrow;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Fungsi Logout
  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }

  // Fungsi untuk membersihkan pesan error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}