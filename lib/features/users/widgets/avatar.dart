import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kill_tiktok/features/users/view_models/avatar_view_model.dart';

class Avatar extends ConsumerWidget {
  const Avatar(
      {super.key,
      required this.name,
      required this.hasAvatar,
      required this.uid});
  final String name;
  final bool hasAvatar;
  final String uid;

  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap: isLoading ? null : () => _onAvatarTap(ref),
      child: isLoading
          ? Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : CircleAvatar(
              radius: 40,
              foregroundColor: Colors.amber,
              foregroundImage: hasAvatar
                  ? NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/test-912ee.appspot.com/o/avatars%2F$uid?alt=media&token=1a81efd7-8834-44d8-b5ca-be6b8d03a60f',
                    )
                  : null,
              child: Text(name),
            ),
    );
  }
}
