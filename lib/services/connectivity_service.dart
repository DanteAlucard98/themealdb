import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  
  factory ConnectivityService() => _instance;
  
  ConnectivityService._internal() {
    _initializeConnectivity();
    // Inicializar el listener de conectividad
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  bool _hasInternet = true;
  bool _previousState = true;

  bool get hasInternet => _hasInternet;

  Future<void> _initializeConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    _hasInternet = result != ConnectivityResult.none;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _hasInternet = result != ConnectivityResult.none;
  }

  Future<void> checkConnectivity(BuildContext context) async {
    final result = await Connectivity().checkConnectivity();
    _hasInternet = result != ConnectivityResult.none;

    // Solo mostrar mensaje si el estado cambió
    if (_previousState != _hasInternet && context.mounted) {
      _previousState = _hasInternet;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _hasInternet ? 'Conexión a Internet disponible' : 'Sin conexión a Internet',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: _hasInternet ? Colors.green : Colors.red,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
} 