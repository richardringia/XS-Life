import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:xs_life/src/common_widgets/loading_screen_widget.dart';
import 'package:xs_life/src/constants/app_constants.dart';
import 'package:xs_life/src/features/app/presentation/fab_navigation_widget.dart';
import 'package:xs_life/src/features/map/domain/map_category.dart';
import 'package:xs_life/src/features/map/domain/map_item.dart';

class MapScreenWidget extends StatefulWidget {
  const MapScreenWidget(
      {super.key,
      required this.mapItems,
      required this.mapCategories,
      required this.isLoading});

  @override
  State<StatefulWidget> createState() => MapScreenWidgetState();

  final List<MapItem> mapItems;
  final List<MapCategory> mapCategories;
  final bool isLoading;
}

class MapScreenWidgetState extends State<MapScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset(
            'assets/images/Artboard_11.png',
            height: 120,
            width: 120,
          ),
        ],
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 255, 110, 14),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 255, 110, 14),
                Color.fromARGB(255, 252, 213, 134)
              ])),
        ),
      ),
      body: widget.isLoading
          ? const LoadingScreenWidget()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 243, 243),
                  borderRadius: BorderRadius.circular(17),
                ),
                margin: const EdgeInsets.all(30),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: FlutterMap(
                          options: MapOptions(
                            center: AppConstants.kmuttLocation,
                            zoom: AppConstants.mapZoom,
                            interactiveFlags:
                                InteractiveFlag.all - InteractiveFlag.rotate,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName:
                                  'dev.fleaflet.flutter_map.example',
                            ),
                            CurrentLocationLayer(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  colors: [
                                    Color.fromARGB(255, 255, 110, 14),
                                    Color.fromARGB(255, 252, 213, 134)
                                  ])),
                          child: Center(
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Text(
                                  'KMUTT MAP',
                                  style: TextStyle(fontSize: 24.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: const FabNavigationWidget(),
    );
  }
}
