import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class HardwareService {
  Future<Position?> obtenerUbicacion() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    // Aquí obtienes la ubicación
    return await Geolocator.getCurrentPosition();
  }

  Future<XFile?> tomarFoto() async {
    final ImagePicker picker = ImagePicker();
    
    // Aquí obtienes la cámara
    return await picker.pickImage(source: ImageSource.camera);
  }
}