import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends ConsumerWidget {
  const Avatar(this.name, {super.key});
  final String name;

  Future<void> _onAvatarTap() async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xfile != null) {
      final file = File(xfile.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: _onAvatarTap,
      child: CircleAvatar(
        radius: 40,
        foregroundColor: Colors.amber,
        child: Text(name),
      ),
    );
  }
}
