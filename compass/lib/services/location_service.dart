import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/geo_data_model.dart';

class LocationService {
  Future<GeoData> getGeoData() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    String address =
        await _getPlacemarks(position.latitude, position.longitude);
    return GeoData(
      latitude: position.latitude,
      longitude: position.longitude,
      altitude: position.altitude,
      address: address,
    );
  }

  Future<String> _getPlacemarks(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    final address =
        '${placemarks.reversed.last.administrativeArea ?? ' - '}, ${placemarks.reversed.last.locality ?? ' - '}';
    return address;
  }

  String convertLatLng(double decimal, bool isLat) {
    String degree = "${decimal.toString().split(".")[0]}°";
    double minutesBeforeConversion =
        double.parse("0.${decimal.toString().split(".")[1]}");
    String minutes =
        "${(minutesBeforeConversion * 60).toString().split('.')[0]}'";
    double secondsBeforeConversion = double.parse(
        "0.${(minutesBeforeConversion * 60).toString().split('.')[1]}");
    String seconds =
        '${double.parse((secondsBeforeConversion * 60).toString()).toStringAsFixed(0)}"';
    String dmsOutput =
        '$degree$minutes$seconds ${isLat ? decimal > 0 ? '북' : '남' : decimal > 0 ? '동' : '서'}';
    return dmsOutput;
  }

  String getDirection(int angle) {
    if (angle >= 338 || angle < 23) {
      return '북';
    } else if (angle >= 23 && angle < 68) {
      return '북동';
    } else if (angle >= 68 && angle < 113) {
      return '동';
    } else if (angle >= 113 && angle < 158) {
      return '남동';
    } else if (angle >= 158 && angle < 203) {
      return '남';
    } else if (angle >= 203 && angle < 248) {
      return '남서';
    } else if (angle >= 248 && angle < 293) {
      return '서';
    } else {
      return '북서';
    }
  }
}
