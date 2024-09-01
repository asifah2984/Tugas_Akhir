import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/reload_button.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_test_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TajwidTestResultsScreen extends StatefulWidget {
  const TajwidTestResultsScreen({
    required this.tajwidId,
    super.key,
  });

  final String tajwidId;

  static const path = 'results';
  static const name = 'results';

  @override
  State<TajwidTestResultsScreen> createState() =>
      _TajwidTestResultsScreenState();
}

class _TajwidTestResultsScreenState extends State<TajwidTestResultsScreen> {
  void _getTestResults() {
    context.read<TajwidBloc>().add(
          TajwidEvent.getTestResultsEvent(
            tajwidId: widget.tajwidId,
          ),
        );
  }

  void _backToHome() {
    context.goNamed(TajwidScreen.name);
  }

  @override
  void initState() {
    _getTestResults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TajwidBloc, TajwidState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('NILAI'),
          ),
          body: state.maybeWhen(
            gettingTestResults: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
            getTestResultsFailed: (message) {
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
                      onPressed: _getTestResults,
                      label: 'Muat Ulang',
                    ),
                  ],
                ),
              );
            },
            testResultsLoaded: (results) {
              if (results.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      'Belum ada pengguna yang menyelesaikan test ini',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final result = results[index];
                  final createdAt =
                      DateFormat.yMMMMd().format(result.createdAt.toDate());
                  final grade = result.grade.toStringAsFixed(2);
                  return ListTile(
                    dense: true,
                    onTap: () => context.pushNamed(
                      TajwidTestResultScreen.name,
                      pathParameters: {
                        'tajwidId': widget.tajwidId,
                      },
                      extra: result.userId,
                    ),
                    title: Text(
                      result.userName,
                      style: Typographies.bold13,
                    ),
                    subtitle: Text(
                      createdAt,
                      style: Typographies.regular11,
                    ),
                    trailing: Text(
                      grade,
                      style: Typographies.bold23.copyWith(color: Colors.amber),
                    ),
                  );
                },
              );
            },
            orElse: Container.new,
          ),
          bottomNavigationBar: _buildNavigationBar(context),
        );
      },
    );
  }

  Widget? _buildNavigationBar(BuildContext context) {
    return Builder(
      builder: (context) {
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
              return ActionButton(
                onPressed: _backToHome,
                child: const Text('Kembali ke Tajwid'),
              );
            },
          ),
        );
      },
    );
  }
}
