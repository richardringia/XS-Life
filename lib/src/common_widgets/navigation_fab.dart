import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NavigationFab extends StatelessWidget {
  const NavigationFab({
    super.key,
    required this.location,
    required this.icon,
    this.onPressed,
  });

  final String location;
  final Icon icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !(ModalRoute.of(context)?.settings.name == location),
      child: Container(
        margin: const EdgeInsets.all(10),
        // icon
        child: FloatingActionButton(
          heroTag: location,
          onPressed: onPressed ??
              () {
                context.replace('/$location');
              },
          backgroundColor: Colors.orange,
          child: icon,
        ),
      ),
    );
  }
}
