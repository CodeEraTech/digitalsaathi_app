import 'dart:async';

import 'package:digitalsaathi/provider/complaint_provider.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';



class AddLocation extends StatefulWidget {
  static const DEFAULT_ZOOM = 14.4746;
  //static const KINSHASA_LOCATION = LatLng(-4.325, 15.322222);

  double initZoom;
  LatLng initCoordinates;

  bool onlyView;

  LatLng? value;
  AddLocation(
      {Key? key,
        this.initZoom = DEFAULT_ZOOM,
        required this.initCoordinates,required this.onlyView})
      : super(key: key);

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ComplaintProvider>(
        builder: (context,locationProvider,_) {
          return Center(
            child: SizedBox(
              // width: 400,
             // height: 300,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  var maxWidth = constraints.biggest.width;
                  var maxHeight = constraints.biggest.height;

                  return Stack(
                    children: <Widget>[
                      
                      SizedBox(
                        height: maxHeight,
                        width: maxWidth,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(locationProvider.currentPosittion!.latitude, locationProvider.currentPosittion!.longitude),
                            zoom: widget.initZoom,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          onCameraMove: (CameraPosition newPosition) {
                            // print(newPosition.target.toJson());
                            if(!widget.onlyView) {
                              widget.value = newPosition.target;

                              locationProvider.getAddressFromCoordinates(LatLng(
                                  newPosition.target.latitude,
                                  newPosition.target.longitude));
                            }
                          },
                          mapType: MapType.normal,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: false,
                          zoomGesturesEnabled: true,
                          padding: const EdgeInsets.all(0),
                          buildingsEnabled: true,
                          cameraTargetBounds: CameraTargetBounds.unbounded,
                          compassEnabled: true,
                          indoorViewEnabled: false,
                          mapToolbarEnabled: true,
                          minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                          rotateGesturesEnabled: true,
                          scrollGesturesEnabled: true,
                          tiltGesturesEnabled: true,
                          trafficEnabled: false,
                        ),
                      ),
                      Positioned(
                        bottom: maxHeight / 2,
                        right: (maxWidth - 30) / 2,
                        child: const Icon(
                          Icons.person_pin_circle,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      Visibility(
                        visible: !widget.onlyView,
                        child: Positioned(
                          bottom: 30,
                          left: 30,
                          child: Container(
                            color: Colors.white,
                            child: IconButton(
                              onPressed: () async {
                                var position = await locationProvider.determinePosition(context);
                                locationProvider.getAddressFromCoordinates(LatLng(position.latitude, position.longitude));
                                final GoogleMapController controller =
                                await _controller.future;
                                controller.animateCamera(
                                    CameraUpdate.newCameraPosition(CameraPosition(
                                        target: LatLng(
                                            position.latitude, position.longitude),
                                        zoom: widget.initZoom)));
                              },
                              icon: const Icon(Icons.my_location),
                            ),
                          ),
                        ),
                      ),

                      SafeArea(
                        child: Container(
                          width: screenWidth(context),
                          height: 50,
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(6),
                          padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                          decoration: BoxDecoration(
                            color: ColorUtils.colorWhite,
                              border: Border.all(color: ColorUtils.colorBlack),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text(
                              "${locationProvider.addressCtr.text.toString()}"
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }
      ),
    );
  }


}
