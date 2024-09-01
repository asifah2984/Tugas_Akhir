import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/common/widgets/reload_button.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/profile/presentation/blocs/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const path = 'profile';
  static const name = 'profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late double _totalGrade;

  String get _username => context.read<UserNotifier>().user!.name;

  void _getTajwidTestResults() {
    context
        .read<ProfileBloc>()
        .add(const ProfileEvent.getTajwidTestResultsEvent());
  }

  @override
  void initState() {
    _getTajwidTestResults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_username.toUpperCase()),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          state.whenOrNull(
            tajwidTestResultsLoaded: (results) {
              if (results.isEmpty) {
                return;
              }

              _totalGrade = results.fold<double>(
                    0,
                    (previousGrade, test) => previousGrade + test.grade,
                  ) /
                  results.length;
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            gettingTajwidTestResults: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
            getTajwidTestResultsFailed: (message) {
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
                      onPressed: _getTajwidTestResults,
                      label: 'Muat Ulang',
                    ),
                  ],
                ),
              );
            },
            tajwidTestResultsLoaded: (results) {
              if (results.isEmpty) {
                return const Center(
                  child: Text('Belum ada soal Tajwid yang pernah dikerjakan.'),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Pemahaman Tajwid pada Jilid',
                      style: Typographies.medium16,
                    ),
                    const SizedBox(height: 16),
                    RatingStars(
                      value: _totalGrade,
                      maxValue: 100,
                      starCount: 10,
                      maxValueVisibility: false,
                      valueLabelVisibility: false,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final result = results[index];
                          return ListTile(
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            title: Text(
                              result.tajwidName,
                              style: Typographies.medium16,
                            ),
                            subtitle: result.tajwidDescription.isNotEmpty
                                ? Text(result.tajwidDescription)
                                : null,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(minWidth: 36),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      result.grade.toStringAsFixed(0),
                                      style: Typographies.medium13.copyWith(
                                        color: context.colorScheme.onPrimary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                RatingStars(
                                  maxValue: 100,
                                  value: result.grade,
                                  maxValueVisibility: false,
                                  valueLabelVisibility: false,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            orElse: Container.new,
          );
        },
      ),
    );
  }
}
