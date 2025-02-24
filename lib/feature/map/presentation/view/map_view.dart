import 'package:evently/core/provider/event_list_provider.dart';
import 'package:evently/core/provider/location_provider.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/feature/add_event/data/model/event_model.dart';
import 'package:evently/feature/map/presentation/widget/map_event_item.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapView extends StatefulWidget {
  const MapView({super.key, this.eventModel});

  final EventModel? eventModel;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? mapController;
  centerMap(LatLng newLatLang) {
    mapController?.animateCamera(
      CameraUpdate.newLatLng(newLatLang),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var locationProvider = Provider.of<LocationProvider>(context);
    return eventListProvider.eventList.isEmpty
        ? SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.no_event_found,
                    style: AppStyle.bold20Primary,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Expanded(
                    child: Image.asset(
                      AppAssets.selectedHomeIcon,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) {
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  zoom: 15,
                  target: locationProvider.userLocation ??
                      LatLng(31.0872111, 29.9140115),
                ),
                circles: {},
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
              ),
              Positioned(
                top: 35,
                right: 16,
                child: InkWell(
                  onTap: () {
                    centerMap(locationProvider.userLocation!);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primaryLight,
                    ),
                    child: Image.asset(
                      AppAssets.iconLocation,
                    ),
                  ),
                ),
              ),
               Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SizedBox(
                  height: height * .23,
                  width: width * .83,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const PageScrollPhysics(),
                      itemCount: eventListProvider.eventList.length,
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.01,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell( onTap: (){},
                          child: MapEventItem(
                            eventModel: eventListProvider.eventList[index],
                          ),);
                      }),
                ),
              ), 
            ],
          );
  }
}
