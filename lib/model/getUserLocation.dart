import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';


Future<Address> getUserLocation() async{

  LocationData locationData;
  String errorMsg;
  Location location = Location();


  try{
    locationData = await location.getLocation();
  } on PlatformException catch(e){
    if(e.code == 'PERMISSION_DANIED'){
      errorMsg = "Error: Please Grant Permission";
      print(errorMsg);
    }
    if(e.code == 'PERMISSION_DANIED_NEVER_ASK'){
      errorMsg = "permission denied- please enable it from app settings";
      print(errorMsg);
    }
    print(e.message);
    locationData = null;
  }
  final coordinates = new Coordinates(locationData.latitude, locationData.longitude);
  var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var result = address.first;
  print('${result.locality}, ${result.adminArea},${result.subLocality}, ${result.subAdminArea},${result.addressLine}, ${result.featureName},${result.thoroughfare}, ${result.subThoroughfare}');
  return result;
}