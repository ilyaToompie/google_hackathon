import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileButton extends ConsumerWidget {
  final String? uid;
  final bool? isClickable;
  const ProfileButton({super.key, this.uid, this.isClickable});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox.shrink();
  }
}
