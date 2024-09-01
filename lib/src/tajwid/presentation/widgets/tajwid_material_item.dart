import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_material.dart';
import 'package:flutter/material.dart';

class TajwidMaterialItem extends StatelessWidget {
  const TajwidMaterialItem({
    required this.index,
    required this.material,
    required this.isAdmin,
    required this.onEdit,
    required this.onDelete,
    required this.textWidth,
    super.key,
  });

  final int index;
  final TajwidMaterial material;
  final bool isAdmin;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final double textWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          width: textWidth,
          child: Center(
            child: Text(
              '${index + 1}',
              style: Typographies.medium16,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(4),
            child: Ink(
              decoration: BoxDecoration(
                color: Colours.grey50,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colours.grey700.withOpacity(0.45),
                    blurRadius: 2,
                    spreadRadius: 1,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    material.content,
                    textAlign: TextAlign.justify,
                  ),
                  if (isAdmin) const SizedBox(height: 8),
                  if (isAdmin)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                          ),
                          onPressed: onEdit,
                          icon: Icon(
                            Icons.edit_rounded,
                            color: context.colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        IconButton(
                          style: IconButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                          ),
                          onPressed: onDelete,
                          icon: Icon(
                            Icons.delete_rounded,
                            color: context.colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
