import 'package:geolocator/geolocator.dart';

class Location{
  double? latitude;
  double? longitude;
  bool permissionDenied = false;

  Future<void> getCurrentLocation() async{
    try{
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        permissionDenied = true;
      }
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    }catch(err){
      'Something goes wrong: $err';
    }
  }

}