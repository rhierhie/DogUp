import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';


class MyMapPage extends StatefulWidget {

  MyMapPage({this.address});
  final String address;
  @override
  State<MyMapPage> createState() => MyMapPageState(address: address);
}

class MyMapPageState extends State<MyMapPage> {
  MyMapPageState({this.address,});
  final String address;
// CURRENT LOCATION OF THE USER
  LocationData _currentLocation;
  StreamSubscription<LocationData> _locationSubscription;

  var _locationService = new Location();
  String error;
  
//END CURREND LOCATION OF THE USER

String userslocation =  "Grand Caprice";

  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];
  

final CameraPosition _kGooglePlex = new CameraPosition(
    target: LatLng(8.483469, 124.653721),
    bearing: 150.8334901395799,
    zoom: 15.151926040649414,
    tilt: 30.440717697143555, 
  );

 @override
  void initState() { 
    super.initState();
      allMarkers.add(Marker(
      markerId: MarkerId('MYMARKERS'),
      draggable: false,
      position: LatLng(0.0, 0.0),
    )
    );  
   
  }
//function to get current location
//function to get current location
//function to get current location
//function to get current location
  Future <void> initPlatformState() async {
    try {
      _currentLocation = await _locationService.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      }else if(e.code == "PERMISSION_DENIED_NEVER_ASK"){
        error = 'Permission denied';
      }
    }
    _locationSubscription = _locationService
        .onLocationChanged()
        .listen((LocationData currentLocation) async {
          print(_currentLocation.latitude.toDouble());
          print(_currentLocation.longitude.toDouble());
          print(_locationSubscription.cancel());
      setState(() {
        _currentLocation = currentLocation; 
      });
    });

    
     CameraPosition userplace = new CameraPosition(
  target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
  bearing: 150.8334901395799,
zoom: 17.151926040649414,
  tilt: 30.440717697143555, 
 );

 
 final GoogleMapController controller = await _controller.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(userplace));

  setState(() {
       GoogleMap(                                        
      initialCameraPosition: userplace,
  markers: Set.from(allMarkers),
  onMapCreated: (GoogleMapController controller) {
_controller.complete(controller);
          },
        );
        allMarkers.add(Marker(
      markerId: MarkerId('MYMARKERS'),
      draggable: false,
      position: LatLng(_currentLocation.latitude, _currentLocation.longitude),
      ));
      });
   }
   //end function to get current location
  //end function to get current location
  //end function to get current location
  //end function to get current location
  //end function to get current location

//this is the function to navigate to other location
//this is the function to navigate to other location
//this is the function to navigate to other location
//this is the function to navigate to other location
                                    Future<void> _goToTheusersLocation() async {   
                                          final query = address;
                                        var addresses = await Geocoder.local.findAddressesFromQuery(query);
                                        var first = addresses.first;
                                        print("${first.featureName} : ${first.coordinates}");

                                    CameraPosition newplace = new CameraPosition(
                                        target: LatLng(first.coordinates.latitude, first.coordinates.longitude),
                                        bearing: 150.8334901395799,
                                        zoom: 17.151926040649414,
                                        tilt: 30.440717697143555, 
                                      );
                                        final GoogleMapController controller = await _controller.future;
                                        controller.animateCamera(CameraUpdate.newCameraPosition(newplace));
                                    setState(() {

                                      GoogleMap(
                                          
                                            initialCameraPosition: newplace,
                                            markers: Set.from(allMarkers),
                                            onMapCreated: (GoogleMapController controller) {
                                              _controller.complete(controller);
                                            },
                                          );

                                        allMarkers.add(Marker(
                                          markerId: MarkerId('MYMARKERS'),
                                          draggable: false,
                                          position: LatLng(first.coordinates.latitude, first.coordinates.longitude),
                                          )); 
                                        });
                                      }
//end of function
//end of function
//end of function
//end of function
//end of function
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center( 
          
          child:Container( 
            padding: EdgeInsets.only(right: 50),
            child: Text("show map",
        style: TextStyle(
          fontFamily: "tangerine",
          color: Colors.grey[300],
          fontSize: 50,

        )
        ),
        ),
      ),
      ),
      body: Column(
                    children: <Widget>[
                    new Container(
                      height: 550,
                      width: 450,
                      child:   GoogleMap(
                    initialCameraPosition: _kGooglePlex,
                    markers: Set.from(allMarkers),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                        },
                      ),
                    ),
                    new RaisedButton(
                      child: Text("view your current location"),
                      onPressed: initPlatformState,
                      ),
                    new FloatingActionButton.extended(
                    onPressed: _goToTheusersLocation,
                    label: Text('GO ! To the users address!'),
                    icon: Icon(Icons.directions_walk)
                    ),
                  ],
                ),
    );
  }
} 

