import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  final String uid;

  const ProfileScreen(this.uid, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(uid);
  }
}
