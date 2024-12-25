import '../../../utils/widgets.dart';

class HomeMap extends StatelessWidget {
  const HomeMap({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ControllerLocator.homeController;
    return Obx(() => Container(
          height: 150,
          child: GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.hybrid,
            initialCameraPosition: controller.cameraPosition.value,
            onMapCreated: (mapController) {
              controller.googleMapController.value = mapController;
            },
            markers: controller.markers,
          ),
        ));
  }
}
