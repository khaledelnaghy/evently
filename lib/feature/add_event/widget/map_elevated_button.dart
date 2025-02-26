import 'package:evently/core/services/location_services.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';
 import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapElevatedButton extends StatelessWidget {
  final Function(LatLng) onLocatedPicker;
final String text;
  const MapElevatedButton({super.key, required this.onLocatedPicker , required this.text});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    LatLng? locationLatLang;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color: AppColors.primaryLight,
        ),
      ),
      child: InkWell(
        onTap: () async {
          locationLatLang = await LocationServices.pickLocation(context);
          if (locationLatLang != null) {
            onLocatedPicker(locationLatLang!);
          }
        },
        child: Row(
          children: [
            Container(
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
            SizedBox(
              width: width * 0.02,
            ),
            Expanded(
              child: Text(
                text ,
                // AppLocalizations.of(context)!.choose_event_location,
                style: AppStyle.meduim16primary,
              ),
            ),
           
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppColors.primaryLight,
            ),
          ],
        ),
      ),
    );
  }
}
