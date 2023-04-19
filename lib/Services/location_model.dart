import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
// Future<bool> _handleLocationPermission() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();
//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
//   Future<void> _getAddressFromLatLng(Position position) async {
//   await placemarkFromCoordinates(
//           _currentPosition!.latitude, _currentPosition!.longitude)
//       .then((List<Placemark> placemarks) {
//     Placemark place = placemarks[0];
//     setState(() {
//       _currentAddress =
//          '${place.street}, ${place.subLocality},
//           ${place.subAdministrativeArea}, ${place.postalCode}';
//     });
//   }).catchError((e) {
//     debugPrint(e);
//   });
//  }
// }
class LocationModel {
  final double latitude;
  final double longitude;
  LocationModel(this.latitude, this.longitude);
}
// class UserLocation {
//   final double latitude;
//   final double longitude;

//   UserLocation({this.latitude, this.longitude});
// }
