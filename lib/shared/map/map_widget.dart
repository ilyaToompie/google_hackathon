import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final LatLng center;
  final double zoom;
  final List<Marker> markers;
  final List<Widget> overlays;

  const MapWidget({
    super.key,
    this.center = const LatLng(48.0196, 66.9237),
    this.zoom = 4.0,
    this.markers = const [],
    this.overlays = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: FlutterMap(
            options: MapOptions(initialCenter: center, initialZoom: zoom),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: markers),
            ],
          ),
        ),
        ...overlays,
      ],
    );
  }
}
