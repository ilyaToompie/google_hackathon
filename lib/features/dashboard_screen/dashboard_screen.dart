import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hackathon_google/core/extensions/theme_extension.dart';
import 'package:hackathon_google/shared/themed_background/themed_background.dart';
import 'package:latlong2/latlong.dart';
import 'package:easy_localization/easy_localization.dart';

class DashboardScreen extends StatelessWidget {
  final List<KpiData> kpiData = [
    KpiData(labelKey: 'dashboard.kpi.objects', value: '47'),
    KpiData(labelKey: 'dashboard.kpi.new_anomalies', value: '3'),
    KpiData(labelKey: 'dashboard.kpi.risk_regions', value: '5'),
  ];

  final List<HotspotData> hotspots = [
    HotspotData(
      nameKey: 'regions.almaty',
      position: LatLng(43.238949, 76.889709),
      summaryKey: 'dashboard.hotspot.drought_high',
    ),
    HotspotData(
      nameKey: 'regions.astana',
      position: LatLng(51.169392, 71.449074),
      summaryKey: 'dashboard.hotspot.emissions_medium',
    ),
    HotspotData(
      nameKey: 'regions.kostanay',
      position: LatLng(53.214, 63.6246),
      summaryKey: 'dashboard.hotspot.ndvi_drop',
    ),
  ];

  final List<NotificationData> notifications = [
    NotificationData(
      typeKey: 'dashboard.notification.warning',
      messageKey: 'dashboard.notification.ndvi_drop_kostanay',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    NotificationData(
      typeKey: 'dashboard.notification.info',
      messageKey: 'dashboard.notification.soil_moisture_normal',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(style: textTheme.headlineMedium, 'dashboard.title'.tr()),
      ),
      body: ThemedBackground(
        blur: 2,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                KpiRowWidget(kpis: kpiData),
                const SizedBox(height: 12),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: colors.surface,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: colors.onSurface.withAlpha(255),
                          blurRadius: 16,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: HotspotMapWidget(hotspots: hotspots),
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'dashboard.last_notifications'.tr(),
                    style: textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 8),
                NotificationFeedWidget(notifications: notifications),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KpiData {
  final String labelKey;
  final String value;
  KpiData({required this.labelKey, required this.value});
}

class KpiRowWidget extends StatelessWidget {
  final List<KpiData> kpis;
  const KpiRowWidget({super.key, required this.kpis});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: kpis
            .map(
              (kpi) => Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      kpi.value,
                      style: textTheme.headlineMedium?.copyWith(
                        color: colors.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      kpi.labelKey.tr(),
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.onPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class HotspotData {
  final String nameKey;
  final LatLng position;
  final String summaryKey;
  HotspotData({
    required this.nameKey,
    required this.position,
    required this.summaryKey,
  });
}

class HotspotMapWidget extends StatelessWidget {
  final List<HotspotData> hotspots;
  const HotspotMapWidget({super.key, required this.hotspots});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(initialCenter: LatLng(48.0, 67.0), initialZoom: 4.0),
      children: [
        TileLayer(
          tileProvider: NetworkTileProvider(),
          userAgentPackageName: 'com.example.app',
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MarkerLayer(
          markers: hotspots
              .map(
                (h) => Marker(
                  point: h.position,
                  width: 40,
                  height: 40,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          backgroundColor: context.colors.onSurface,
                          title: Text(h.nameKey.tr()),
                          content: Text(h.summaryKey.tr()),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.location_on,
                      size: 36,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class NotificationData {
  final String typeKey;
  final String messageKey;
  final DateTime timestamp;
  NotificationData({
    required this.typeKey,
    required this.messageKey,
    required this.timestamp,
  });
}

class NotificationFeedWidget extends StatelessWidget {
  final List<NotificationData> notifications;
  const NotificationFeedWidget({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notif = notifications[index];
        return Card(
          color: colors.secondary,
          child: ListTile(
            title: Text(
              notif.typeKey.tr(),
              style: textTheme.titleMedium?.copyWith(
                color: notif.typeKey == 'dashboard.notification.warning'
                    ? Colors.red
                    : colors.onSecondary,
              ),
            ),
            subtitle: Text(
              notif.messageKey.tr(),
              style: textTheme.bodySmall?.copyWith(color: colors.onSecondary),
            ),
            trailing: Text(
              '${notif.timestamp.hour}:${notif.timestamp.minute.toString().padLeft(2, '0')}',
              style: textTheme.bodySmall?.copyWith(color: colors.onSecondary),
            ),
          ),
        );
      },
    );
  }
}
