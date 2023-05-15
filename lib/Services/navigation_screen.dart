import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:pathstrides_mobile/Screens/task_desc.dart';
import 'package:pathstrides_mobile/Services/main_test.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' show cos, sqrt, asin;

import '../Screens/task_report.dart';
import '../Screens/task_screen.dart';

class NavigationScreen extends StatefulWidget {
  final double lat;
  final double lng;
  final TaskData taskview;
  const NavigationScreen(this.lat, this.lng,
      {super.key, required this.taskview});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final Completer<GoogleMapController?> _controller = Completer();

  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  late TaskData taskview;
  Marker? sourcePosition, destinationPosition;
  loc.LocationData? _currentPosition;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  LatLng curLocation = LatLng(10.2, 31);
  StreamSubscription<loc.LocationData>? locationSubscription;
  // final GeofencingManager geofencingManager = GeofencingManager();
  Set<Circle> _circles = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavigation();
    addMarker();
  }

  Future<void> updateCoordinates(double latitude, double longitude) async {
    final response = await http.post(
      Uri.parse('https://your-laravel-api.com/api/update-coordinates'),
      body: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      },
    );
    if (response.statusCode == 200) {
      // Coordinates updated successfully
    } else {
      // Error occurred
    }
  }

  void _addCircle(LatLng latlng) {
    setState(() {
      _circles.add(
        Circle(
          circleId: CircleId('destination'),
          center: LatLng(widget.lat, widget.lng),
          radius: 100.0, // in meters
          fillColor: const Color.fromARGB(255, 255, 126, 45).withOpacity(0.5),
          strokeWidth: 2,
        ),
      );
    });
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double distance2 = double.parse(
        (getDistance(LatLng(widget.lat, widget.lng)).toStringAsFixed(2)));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color.fromARGB(255, 255, 126, 45),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const TaskScreen()));
          },
        ),
        title: new Text(
          widget.taskview.address,
          style: TextStyle(
            fontFamily: 'Inter-bold',
            color: Colors.black,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        elevation: 10,
      ),
      body: sourcePosition == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  circles: _circles,
                  onCameraMove: (CameraPosition position) {},
                  polylines: Set<Polyline>.of(polylines.values),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.lat, widget.lng),
                    zoom: 2,
                  ),
                  markers: {sourcePosition!, destinationPosition!},
                  onTap: (latLng) {
                    print(latLng);
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    onMapCreated:
                    (GoogleMapController controller) {
                      _controller.complete(controller);
                    };
                  },
                ),

                // Positioned(
                //   top: 30,
                //   left: 15,
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.of(context).pushAndRemoveUntil(
                //           MaterialPageRoute(builder: (context) => MyApp()),
                //           (route) => false);
                //     },
                //     child: Icon(Icons.arrow_back),
                //   ),
                // ),
                Positioned(
                    bottom: 100,
                    right: 6,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 255, 126, 45)),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.navigation_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            await launchUrl(Uri.parse(
                                'google.navigation:q=${widget.lat}, ${widget.lng}&key=AIzaSyA6CHGuhMeOn6rl1cz4A2EMtXV8OPYVWa0'));
                          },
                        ),
                      ),
                    )),
                distance2 <= 0.3
                    ? Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 530.0, left: 100.0, bottom: 0.0, right: 0.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => TaskReport(
                                            taskview: widget.taskview,
                                          )));
                            },

                            // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.only(
                                    top: 0.0,
                                    left: 0.0,
                                    bottom: 0.0,
                                    right: 0.0),
                                minimumSize: const Size(200, 40),
                                backgroundColor:
                                    Color.fromARGB(255, 255, 126, 45),
                                elevation: 12.0,
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter-Bold',
                                    fontSize: 14)),
                            child: const Text('Create Task Report'),
                          ),
                        ),
                      )
                    : Container(),
                //'${double.parse((getDistance(LatLng(widget.lat, widget.lng)).toStringAsFixed(2)))} km'

                // if('${double.parse((getDistance(LatLng(widget.lat, widget.lng)).toStringAsFixed(2)))} km'=='2'){}
                // if(double.parse(getDistance(LatLng(widget.lat.toDouble(), widget.lng.toDouble())).toStringAsFixed(2)) == 1.0) {}
              ],
            ),
    );
  }

  getNavigation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    final GoogleMapController? controller = await _controller.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (permissionGranted == loc.PermissionStatus.granted) {
      _currentPosition = await location.getLocation();

      curLocation =
          LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
      locationSubscription =
          location.onLocationChanged.listen((LocationData currentLocation) {
        //updateCoordinates(currentLocation.latitude, _currentPosition.longitude);
        target:
        LatLng(currentLocation.latitude!, currentLocation.longitude!);
        zoom:
        100.0;
        // controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        //   target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        //   zoom: 12.0,
        // )));
        if (mounted) {
          controller
              ?.showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));
          setState(() {
            curLocation =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
            sourcePosition = Marker(
              markerId: MarkerId(currentLocation.toString()),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              position:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
              infoWindow: InfoWindow(
                  title:
                      '${double.parse((getDistance(LatLng(widget.lat, widget.lng)).toStringAsFixed(2)))} km'),
              onTap: () {
                print('market tapped');
              },
            );
          });
          getDirections(LatLng(widget.lat, widget.lng));
        }
      });
    }
  }

  getDirections(LatLng dst) async {
    List<LatLng> polylineCoordinates = [];
    List<dynamic> points = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyA6CHGuhMeOn6rl1cz4A2EMtXV8OPYVWa0',
        PointLatLng(curLocation.latitude, curLocation.longitude),
        PointLatLng(dst.latitude, dst.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        points.add({'lat': point.latitude, 'lng': point.longitude});
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: const Color.fromARGB(255, 255, 126, 45),
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double getDistance(LatLng destposition) {
    return calculateDistance(curLocation.latitude, curLocation.longitude,
        destposition.latitude, destposition.longitude);
  }

  addMarker() {
    setState(() {
      sourcePosition = Marker(
        markerId: MarkerId('source'),
        position: curLocation,
        icon: markerIcon,
      );
      destinationPosition = Marker(
        markerId: MarkerId('destination'),
        position: LatLng(widget.lat, widget.lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      );
    });
  }
}
