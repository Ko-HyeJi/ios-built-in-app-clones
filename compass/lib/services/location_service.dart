import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:compass/models/geo_data_model.dart';

class LocationService {
  Future<GeoData> getGeoData() async {
    Position position = await _determinePosition();

    List<String> placemarks =
        await _getPlacemarks(position.latitude, position.longitude);

    return GeoData(
      latitude: position.latitude,
      longitude: position.longitude,
      altitude: position.altitude,
      administrativeArea: placemarks[0],
      locality: placemarks[1],
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<String>> _getPlacemarks(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    final administrativeArea = placemarks.reversed.last.administrativeArea ?? '';
    final locality = placemarks.reversed.last.locality ?? '';

    return [administrativeArea, locality];
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

  String getDirection(double angle) {
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
