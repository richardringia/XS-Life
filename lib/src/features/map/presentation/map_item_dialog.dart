import 'package:flutter/material.dart';
import 'package:xs_life/src/features/map/application/maps_utils.dart';
import 'package:xs_life/src/features/map/domain/map_item.dart';

class MapItemDialog extends StatelessWidget {
  final MapItem mapItem;

  const MapItemDialog({super.key, required this.mapItem});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(mapItem.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Category: ${mapItem.category.title}"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            MapUtils.openMap(mapItem.lat, mapItem.long);
          },
          child: const Text('Navigate'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            },
          child: const Text('Dismiss'),
        ),
      ],
    );
  }
}
