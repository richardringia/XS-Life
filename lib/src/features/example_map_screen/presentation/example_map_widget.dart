import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:xs_life/src/constants/app_constants.dart';
import 'package:xs_life/src/features/app/presentation/fab_navigation_widget.dart';

class ExampleMapWidget extends StatelessWidget {
  const ExampleMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter MapBox'),
      ),
      body: Column(
        children: [
          Flexible(
            child: FlutterMap(
              options: MapOptions(
                center: AppConstants.kmuttLocation,
                zoom: 5,
                interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: const FabNavigationWidget(),
    );
  }
}
