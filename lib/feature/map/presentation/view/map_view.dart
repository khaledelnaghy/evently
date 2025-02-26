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
  Set<Circle> cirecleList = {};
  centerMap(LatLng newLatLang) {
    mapController?.animateCamera(
      CameraUpdate.newLatLng(newLatLang),
    );
  }

  @override
  void initState() {
    super.initState();
    initCircles();
  }

  void initCircles() {
    var eventListProvider =
        Provider.of<EventListProvider>(context, listen: false);
    for (var event in eventListProvider.eventList) {
      setState(() {
        cirecleList.add(
          Circle(
            circleId: CircleId(event.id),
            center: LatLng(event.lat!, event.lang!),
            radius: 5,
            fillColor: AppColors.blackColor,
            strokeWidth: 10,
            strokeColor: AppColors.blackColor.withValues(alpha: .5),
          ),
        );
      });
    }
  }

  Set<Circle> updateCircleByColor(EventModel eventModel) {
    return cirecleList.map((circle) {
      if (circle.circleId.value == eventModel.id) {
        return Circle(
          circleId: circle.circleId,
          center: circle.center,
          radius: circle.radius,
          fillColor: AppColors.redColor,
          strokeWidth: circle.strokeWidth,
          strokeColor: AppColors.redColor.withValues(alpha: .5),
        );
      } else {
        return Circle(
          circleId: circle.circleId,
          center: circle.center,
          radius: circle.radius,
          fillColor: AppColors.blackColor,
          strokeWidth: circle.strokeWidth,
          strokeColor: AppColors.blackColor.withValues(alpha: .5),
        );
      }
    }).toSet();
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
                circles: cirecleList,
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
                        return InkWell(
                          onTap: () {
                            // لما ادوس علي الايفنت ينفذ حاجة معينة
                            var selectEvent =
                                eventListProvider.eventList[index];
                            centerMap(
                              LatLng(selectEvent.lat!, selectEvent.lang!),
                            );

                            setState(() {
                              cirecleList = updateCircleByColor(selectEvent);
                            });
                          },
                          child: MapEventItem(
                            eventModel: eventListProvider.eventList[index],
                          ),
                        );
                      }),
                ),
              ),
            ],
          );
  }
}
