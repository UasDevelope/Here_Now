import 'package:get/get.dart';
import 'package:here_now/app/utils/widgets.dart';

class EventsController extends GetxController {
  Rx<GoogleMapController?> googleMapController = Rx<GoogleMapController?>(null);
  // CameraPosition, with initial camera position
  Rx<CameraPosition> cameraPosition = CameraPosition(
    target: LatLng(51.5072, 0.1276), // Initial target LatLng
    zoom: 8.0, // You can set a default zoom value
  ).obs;
}
