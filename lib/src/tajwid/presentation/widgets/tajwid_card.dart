import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TajwidCard extends StatelessWidget {
  const TajwidCard({
    required this.tajwid,
    required this.onPressed,
    required this.isAdmin,
    this.editable = false,
    this.onLongPressed,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final Tajwid tajwid;
  final VoidCallback onPressed;
  final bool isAdmin;
  final bool editable;
  final VoidCallback? onLongPressed;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: isAdmin ? onLongPressed : null,
      onTap: editable == false ? onPressed : onLongPressed,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colours.grey50,
          boxShadow: [
            BoxShadow(
              color: Colours.grey700.withOpacity(0.45),
              blurRadius: 3,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CachedNetworkImage(
                  imageUrl: tajwid.imageUrl,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 128,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          tajwid.name,
                          // 'buadi iagd vi/gvdwa iaved iy',
                          style: Typographies.medium16,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (editable)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black.withOpacity(0.75),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: onEdit,
                        label: const Text('Edit'),
                        icon: const Icon(Icons.edit),
                        style: TextButton.styleFrom(
                          iconColor: context.colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      TextButton.icon(
                        onPressed: onDelete,
                        label: const Text('Hapus'),
                        icon: const Icon(Icons.delete),
                        style: TextButton.styleFrom(
                          iconColor: Colours.error200,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
