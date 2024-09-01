import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/reload_button.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_material.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:alquran_app/src/tajwid/presentation/views/add_tajwid_material_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/edit_tajwid_material_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_question_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_test_result_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/widgets/delete_tajwid_material_alert_dialog.dart';
import 'package:alquran_app/src/tajwid/presentation/widgets/tajwid_material_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TajwidMaterialScreen extends StatefulWidget {
  const TajwidMaterialScreen({
    required this.tajwidId,
    super.key,
  });

  final String tajwidId;

  static const name = 'materials';
  static const path = 'materials/:tajwidId';

  @override
  State<TajwidMaterialScreen> createState() => _TajwidMaterialScreenState();
}

class _TajwidMaterialScreenState extends State<TajwidMaterialScreen> {
  late bool _isAdmin;

  void _getTajwidMaterials() {
    context.read<TajwidBloc>().add(
          TajwidEvent.getTajwidMaterialsEvent(tajwidId: widget.tajwidId),
        );
  }

  void _addMaterial() {
    context.pushNamed(
      AddTajwidMaterialScreen.name,
      pathParameters: {
        'tajwidId': widget.tajwidId,
      },
      extra: context.read<TajwidBloc>(),
    );
  }

  void _editMaterial(TajwidMaterial material) {
    context.pushNamed(
      EditTajwidMaterialScreen.name,
      pathParameters: {
        'materialId': material.id,
        'tajwidId': widget.tajwidId,
      },
      extra: {
        'bloc': context.read<TajwidBloc>(),
        'content': material.content,
      },
    );
  }

  Future<void> _deleteMaterial(TajwidMaterial material) async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        return DeleteTajwidMaterialAlertDialog(
          id: material.id,
          tajwidId: widget.tajwidId,
          bloc: context.read<TajwidBloc>(),
        );
      },
    );
  }

  void _checkTestResult() {
    context.pushNamed(
      TajwidTestResultScreen.name,
      pathParameters: {
        'tajwidId': widget.tajwidId,
      },
    );
  }

  double _calculateTextWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: Typographies.medium16,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.width + 28; // Add padding for the Container
  }

  double _calculateLongestTextWidth(List<int> indexes) {
    var maxLength = 0.0;
    for (final index in indexes) {
      final stringifiedIndex = index.toString();
      final stringifiedIndexWidth = _calculateTextWidth(stringifiedIndex);
      if (stringifiedIndexWidth <= maxLength) continue;
      maxLength = stringifiedIndexWidth;
    }

    return maxLength;
  }

  @override
  void initState() {
    _isAdmin = context.read<UserNotifier>().user?.isAdmin ?? false;
    _getTajwidMaterials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TajwidBloc, TajwidState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('MATERI'),
            actions: [
              if (_isAdmin)
                IconButton(
                  onPressed: _addMaterial,
                  icon: const Icon(Icons.add),
                )
              else
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: context.colorScheme.secondary,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: _checkTestResult,
                  child: const Text('Hasil Test'),
                ),
            ],
          ),
          body: state.maybeWhen(
            gettingTajwidMaterials: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
            tajwidMaterialsLoaded: (materials) {
              if (materials.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Builder(
                      builder: (context) {
                        if (_isAdmin) {
                          return const Text(
                            'Belum ada materi yang dibuat. '
                            "Buatlah materi dengan menekan tombol '+'",
                            textAlign: TextAlign.center,
                          );
                        }

                        return const Text(
                          'Belum ada materi yang dibuat.',
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                );
              }

              // all indexes
              final indexes = materials.asMap().keys.map((i) => i + 1).toList();
              final longestTextWidth = _calculateLongestTextWidth(indexes);

              return RefreshIndicator.adaptive(
                onRefresh: () async => _getTajwidMaterials(),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: materials.length,
                  itemBuilder: (context, index) {
                    final material = materials[index];
                    return TajwidMaterialItem(
                      index: index,
                      material: material,
                      isAdmin: _isAdmin,
                      onEdit: () => _editMaterial(material),
                      onDelete: () => _deleteMaterial(material),
                      textWidth: longestTextWidth,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                ),
              );
            },
            getTajwidMaterialsFailed: (message) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      message,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ReloadButton(
                      onPressed: _getTajwidMaterials,
                      label: 'Muat Ulang',
                    ),
                  ],
                ),
              );
            },
            orElse: Container.new,
          ),
          bottomNavigationBar: state.maybeWhen(
            tajwidMaterialsLoaded: (materials) {
              return _buildNavigationBar(context, materials: materials);
            },
            orElse: () => null,
          ),
        );
      },
    );
  }

  Widget? _buildNavigationBar(
    BuildContext context, {
    required List<TajwidMaterial> materials,
  }) {
    if (materials.isEmpty) {
      return null;
    }

    return Container(
      width: context.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        boxShadow: const [
          BoxShadow(
            color: Colours.grey400,
            offset: Offset(0, -3),
            blurRadius: 5,
          ),
        ],
      ),
      child: Builder(
        builder: (context) {
          if (!_isAdmin) {
            return ActionButton(
              onPressed: () => context.pushNamed(
                TajwidQuestionScreen.name,
                pathParameters: {'tajwidId': widget.tajwidId},
              ),
              child: const Text('Kerjakan Soal'),
            );
          }

          return ActionButton(
            onPressed: () => context.pushNamed(
              TajwidQuestionScreen.name,
              pathParameters: {'tajwidId': widget.tajwidId},
            ),
            child: const Text('Buat Soal'),
          );
        },
      ),
    );
  }
}
