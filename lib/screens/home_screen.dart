import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import '../services/hardware_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HardwareService _hardwareService = HardwareService();
  
  XFile? _foto;
  Position? _ubicacion;
  DateTime? _horaExacta;
  bool _procesando = false;

  Future<void> _iniciarRegistro() async {
    setState(() {
      _procesando = true;
    });

    Position? ubicacionObtenida = await _hardwareService.obtenerUbicacion();

    if (ubicacionObtenida != null) {
      XFile? fotoObtenida = await _hardwareService.tomarFoto();

      if (fotoObtenida != null) {
        setState(() {
          _ubicacion = ubicacionObtenida;
          _foto = fotoObtenida;
          _horaExacta = DateTime.now();
        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, enciende el GPS y otorga permisos.')),
        );
      }
    }

    setState(() {
      _procesando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evidencias de Campo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_foto != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.file(
                    File(_foto!.path),
                    height: 350,
                  ),
                ),
              if (_ubicacion != null && _horaExacta != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Latitud: ${_ubicacion!.latitude}\n'
                    'Longitud: ${_ubicacion!.longitude}\n'
                    'Hora exacta: ${_horaExacta.toString().split('.')[0]}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              const SizedBox(height: 30),
              _procesando
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _iniciarRegistro,
                      child: const Text('Registrar Evidencia'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}