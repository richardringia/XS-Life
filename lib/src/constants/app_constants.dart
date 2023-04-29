import 'package:global_configuration/global_configuration.dart';
import 'package:latlong2/latlong.dart';

class AppConstants {
  static final kmuttLocation = LatLng(
      GlobalConfiguration().get("lat"), GlobalConfiguration().get("long"));
}
