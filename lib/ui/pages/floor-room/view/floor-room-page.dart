import 'package:flutter/material.dart';

import '../model/floor-model.dart';
import 'export.dart';

class FloorRoomPage extends StatelessWidget {
  const FloorRoomPage({super.key, required this.floorRouteMotel});
  final FloorRouteMotel floorRouteMotel;

  @override
  Widget build(BuildContext context) {
    return FloorRoomVew(
      floorRouteMotel: floorRouteMotel,
    );
  }
}
