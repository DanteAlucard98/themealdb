import 'package:flutter/material.dart';
import 'package:recetas_adpp_2025/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:recetas_adpp_2025/services/connectivity_service.dart';
import 'dart:async';

class NetworkImageWithFallback extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const NetworkImageWithFallback({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<NetworkImageWithFallback> createState() => _NetworkImageWithFallbackState();
}

class _NetworkImageWithFallbackState extends State<NetworkImageWithFallback> {
  final ConnectivityService _connectivityService = ConnectivityService();
  Timer? _connectivityTimer;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    
    // Verificar la conectividad cada 5 segundos
    _connectivityTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _checkConnectivity();
    });

    // Escuchar cambios de conectividad
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((_) {
      _checkConnectivity();
    });
  }

  @override
  void dispose() {
    _connectivityTimer?.cancel();
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    if (mounted) {
      await _connectivityService.checkConnectivity(context);
      setState(() {});
    }
  }

  Widget _buildFallbackWidget() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: widget.width != null ? widget.width! * 0.5 : 100,
            height: widget.height != null ? widget.height! * 0.5 : 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/no-image-icon-23494.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          if (widget.height == null || widget.height! > 100) ...[
            const SizedBox(height: 8),
            Text(
              _connectivityService.hasInternet ? 'Error al cargar la imagen' : 'Sin conexión a Internet',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_connectivityService.hasInternet) {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: _buildFallbackWidget(),
      );
    }

    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: Image.network(
        widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackWidget();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: widget.borderRadius ?? BorderRadius.zero,
            ),
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          );
        },
      ),
    );
  }
} 