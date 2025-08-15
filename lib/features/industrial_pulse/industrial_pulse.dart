import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hackathon_google/core/extensions/theme_extension.dart';
import 'package:hackathon_google/features/industrial_pulse/data/factories.dart';
import 'package:hackathon_google/shared/map/map_widget.dart';
import 'package:hackathon_google/shared/themed_background/themed_background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:latlong2/latlong.dart';

class IndustrialPulse extends StatefulWidget {
  const IndustrialPulse({super.key});

  @override
  State<IndustrialPulse> createState() => _IndustrialPulseState();
}

class _IndustrialPulseState extends State<IndustrialPulse> {
  void _showFactoryDetails(FactoryModel site) {
    showModalBottomSheet(
      backgroundColor: context.colors.secondary,
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(tr(site.descriptionKey), style: context.text.headlineMedium),
              SizedBox(height: 8),
              Text('Industry: ${tr(site.industryTypeKey)}'),
              Text('Year built: ${site.yearBuilt}'),
              Text('Owner: ${site.owner}'),
              Text('Employees: ${site.employees}'),
              Text('Annual emissions: ${site.annualEmissions} tons'),
              Text('Pollution types: ${site.pollutionTypes.join(', ')}'),
              Text('Region: ${site.region}'),
              Text(
                'Location: Lat ${site.latLng.latitude}, Lng ${site.latLng.longitude}',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Risk index: ${site.riskIndex}',
                    style: context.text.bodyLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  buildRiskCircle(site.riskIndex.toDouble(), 100.0),
                ],
              ),
              SizedBox(height: 16),
              Text(site.descriptionKey.tr(), style: context.text.bodyMedium),
              SizedBox(height: 55),
            ],
          ),
        ),
      ),
    );
  }

  Color getRiskColor(double riskIndex, double maxRisk) {
    final ratio = (riskIndex / maxRisk).clamp(0.0, 1.0);
    return Color.lerp(Colors.green, Colors.red, ratio)!;
  }

  Widget buildRiskCircle(double riskIndex, double maxRisk) {
    final ratio = riskIndex / maxRisk;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            value: ratio,
            valueColor: AlwaysStoppedAnimation(
              getRiskColor(riskIndex, maxRisk),
            ),
            backgroundColor: Colors.grey.shade300,
          ),
        ),
        Text("${riskIndex.toInt()}"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Industrial Pulse')),
      body: ThemedBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'industrial-pulse.map-title'.tr(),
                      style: context.text.headlineSmall,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: MapWidget(
                    center: const LatLng(48.0196, 66.9237),
                    zoom: 5,
                    markers: factories.map((site) {
                      return Marker(
                        point: site.latLng,
                        width: 40,
                        height: 40,
                        child: GestureDetector(
                          onTap: () => _showFactoryDetails(site),
                          child: const Icon(
                            Icons.location_on,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
