import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tridhee_application_1/services/geolocator_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeoLocatorService();

  Position currentLocation;

  ApplicationBloc() {
    setCurrentLOcation();
  }

  setCurrentLOcation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }
}
