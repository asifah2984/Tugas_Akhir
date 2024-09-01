import 'package:alquran_app/core/common/transitions/transitions.dart';
import 'package:alquran_app/core/injection/injection.dart';
import 'package:alquran_app/core/utils/logger.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/juz.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/audio_player_bloc/audio_player_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/bookmark_bloc/bookmark_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/juz_bloc/juz_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/last_read/last_read_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/surah_bloc/surah_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/views/al_quran_screen.dart';
import 'package:alquran_app/src/al_quran/presentation/views/juz_detail_screen.dart';
import 'package:alquran_app/src/al_quran/presentation/views/surah_detail_screen.dart';
import 'package:alquran_app/src/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:alquran_app/src/auth/presentation/views/forgot_password_screen.dart';
import 'package:alquran_app/src/auth/presentation/views/login_screen.dart';
import 'package:alquran_app/src/auth/presentation/views/register_screen.dart';
import 'package:alquran_app/src/home/presentation/views/home_screen.dart';
import 'package:alquran_app/src/profile/presentation/blocs/bloc/profile_bloc.dart';
import 'package:alquran_app/src/profile/presentation/views/profile_screen.dart';
import 'package:alquran_app/src/settings/presentation/blocs/settings_bloc/settings_bloc.dart';
import 'package:alquran_app/src/settings/presentation/views/setting_email_screen.dart';
import 'package:alquran_app/src/settings/presentation/views/setting_password_screen.dart';
import 'package:alquran_app/src/settings/presentation/views/setting_profile_screen.dart';
import 'package:alquran_app/src/settings/presentation/views/settings_screen.dart';
import 'package:alquran_app/src/splash/presentation/views/splash_screen.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/thumbnail_bloc/thumbnail_bloc.dart';
import 'package:alquran_app/src/tajwid/presentation/views/add_tajwid_material_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/add_tajwid_question_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/add_tajwid_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/edit_tajwid_material_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/edit_tajwid_question_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/edit_tajwid_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_material_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_question_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_test_result_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_test_results_screen.dart';
import 'package:alquran_app/src/welcome/presentation/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'observer.router.dart';

class AppRouter {
  static final routerConfig = GoRouter(
    observers: [
      RouterObserver(),
    ],
    initialLocation: SplashScreen.path,
    routes: [
      GoRoute(
        path: SplashScreen.path,
        name: SplashScreen.name,
        pageBuilder: (context, state) {
          return SlideUpRouteTransition(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const SplashScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: WelcomeScreen.path,
        name: WelcomeScreen.name,
        pageBuilder: (context, state) {
          return SlideUpRouteTransition(
            key: state.pageKey,
            child: const WelcomeScreen(),
          );
        },
      ),
      GoRoute(
        path: LogInScreen.path,
        name: LogInScreen.name,
        pageBuilder: (context, state) {
          return SlideUpRouteTransition(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const LogInScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: RegisterScreen.path,
        name: RegisterScreen.name,
        pageBuilder: (context, state) {
          return SlideUpRouteTransition(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const RegisterScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: ForgotPasswordScreen.path,
        name: ForgotPasswordScreen.name,
        pageBuilder: (context, state) {
          return SlideRouteTransition(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const ForgotPasswordScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: HomeScreen.path,
        name: HomeScreen.name,
        pageBuilder: (context, state) {
          return SlideUpRouteTransition(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const HomeScreen(),
            ),
          );
        },
        routes: [
          GoRoute(
            path: ProfileScreen.path,
            name: ProfileScreen.name,
            pageBuilder: (context, state) {
              return SlideRouteTransition(
                key: state.pageKey,
                child: BlocProvider(
                  create: (context) => sl<ProfileBloc>(),
                  child: const ProfileScreen(),
                ),
              );
            },
          ),
          GoRoute(
            path: AlQuranScreen.path,
            name: AlQuranScreen.name,
            pageBuilder: (context, state) {
              return SlideRouteTransition(
                key: state.pageKey,
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => sl<SurahBloc>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<JuzBloc>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<BookmarkBloc>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<LastReadBloc>(),
                    ),
                  ],
                  child: const AlQuranScreen(),
                ),
              );
            },
            routes: [
              GoRoute(
                path: SurahDetailScreen.path,
                name: SurahDetailScreen.name,
                pageBuilder: (context, state) {
                  final extra = state.extra! as DataMap;
                  final title = extra['title'] as String;
                  final bloc = extra['bloc'] as BookmarkBloc;
                  final number =
                      int.tryParse(state.pathParameters['number']!) ?? 0;
                  return SlideRouteTransition(
                    key: state.pageKey,
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => sl<SurahBloc>(),
                        ),
                        BlocProvider(
                          create: (context) => sl<AudioPlayerBloc>(),
                        ),
                        BlocProvider.value(
                          value: bloc,
                        ),
                      ],
                      child: SurahDetailScreen(
                        number: number,
                        title: title,
                      ),
                    ),
                  );
                },
              ),
              GoRoute(
                path: JuzDetailScreen.path,
                name: JuzDetailScreen.name,
                pageBuilder: (context, state) {
                  final extra = state.extra! as DataMap;
                  final juz = extra['juz'] as Juz;
                  final bloc = extra['bloc'] as BookmarkBloc;
                  return SlideRouteTransition(
                    key: state.pageKey,
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => sl<AudioPlayerBloc>(),
                        ),
                        BlocProvider.value(
                          value: bloc,
                        ),
                      ],
                      child: JuzDetailScreen(juz: juz),
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: SettingsScreen.path,
            name: SettingsScreen.name,
            pageBuilder: (context, state) {
              return SlideRouteTransition(
                key: state.pageKey,
                child: const SettingsScreen(),
              );
            },
            routes: [
              GoRoute(
                path: SettingProfileScreen.path,
                name: SettingProfileScreen.name,
                pageBuilder: (context, state) {
                  return SlideRouteTransition(
                    key: state.pageKey,
                    child: const SettingProfileScreen(),
                  );
                },
              ),
              GoRoute(
                path: SettingEmailScreen.path,
                name: SettingEmailScreen.name,
                pageBuilder: (context, state) {
                  return SlideRouteTransition(
                    key: state.pageKey,
                    child: BlocProvider(
                      create: (context) => sl<SettingsBloc>(),
                      child: const SettingEmailScreen(),
                    ),
                  );
                },
              ),
              GoRoute(
                path: SettingPasswordScreen.path,
                name: SettingPasswordScreen.name,
                pageBuilder: (context, state) {
                  return SlideRouteTransition(
                    key: state.pageKey,
                    child: BlocProvider(
                      create: (context) => sl<SettingsBloc>(),
                      child: const SettingPasswordScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: TajwidScreen.path,
            name: TajwidScreen.name,
            pageBuilder: (context, state) {
              return SlideRouteTransition(
                key: state.pageKey,
                child: BlocProvider(
                  create: (context) => sl<TajwidBloc>(),
                  child: const TajwidScreen(),
                ),
              );
            },
            routes: [
              GoRoute(
                path: AddTajwidScreen.path,
                name: AddTajwidScreen.name,
                pageBuilder: (context, state) {
                  final bloc = state.extra! as TajwidBloc;
                  return SlideRouteTransition(
                    key: state.pageKey,
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: bloc,
                        ),
                        BlocProvider(
                          create: (context) => sl<ThumbnailBloc>(),
                        ),
                      ],
                      child: const AddTajwidScreen(),
                    ),
                  );
                },
              ),
              GoRoute(
                path: EditTajwidScreen.path,
                name: EditTajwidScreen.name,
                pageBuilder: (context, state) {
                  final extra = state.extra! as DataMap;
                  final bloc = extra['bloc'] as TajwidBloc;
                  final currentTajwid = extra['tajwid'] as Tajwid;

                  return SlideRouteTransition(
                    key: state.pageKey,
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: bloc,
                        ),
                        BlocProvider(
                          create: (context) => sl<ThumbnailBloc>(),
                        ),
                      ],
                      child: EditTajwidScreen(
                        currentTajwid: currentTajwid,
                      ),
                    ),
                  );
                },
              ),
              GoRoute(
                path: TajwidMaterialScreen.path,
                name: TajwidMaterialScreen.name,
                pageBuilder: (context, state) {
                  final tajwidId = state.pathParameters['tajwidId']!;
                  return SlideRouteTransition(
                    key: state.pageKey,
                    child: BlocProvider(
                      create: (context) => sl<TajwidBloc>(),
                      child: TajwidMaterialScreen(
                        tajwidId: tajwidId,
                      ),
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: AddTajwidMaterialScreen.path,
                    name: AddTajwidMaterialScreen.name,
                    pageBuilder: (context, state) {
                      final tajwidId = state.pathParameters['tajwidId']!;
                      final bloc = state.extra! as TajwidBloc;
                      return SlideRouteTransition(
                        key: state.pageKey,
                        child: BlocProvider.value(
                          value: bloc,
                          child: AddTajwidMaterialScreen(
                            tajwidId: tajwidId,
                          ),
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: EditTajwidMaterialScreen.path,
                    name: EditTajwidMaterialScreen.name,
                    pageBuilder: (context, state) {
                      final tajwidId = state.pathParameters['tajwidId']!;
                      final id = state.pathParameters['materialId']!;

                      final extra = state.extra! as DataMap;
                      final bloc = extra['bloc'] as TajwidBloc;
                      final content = extra['content'] as String;
                      return SlideRouteTransition(
                        key: state.pageKey,
                        child: BlocProvider.value(
                          value: bloc,
                          child: EditTajwidMaterialScreen(
                            id: id,
                            tajwidId: tajwidId,
                            content: content,
                          ),
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: TajwidQuestionScreen.path,
                    name: TajwidQuestionScreen.name,
                    pageBuilder: (context, state) {
                      final tajwidId = state.pathParameters['tajwidId']!;
                      return SlideUpRouteTransition(
                        key: state.pageKey,
                        child: BlocProvider(
                          create: (context) => sl<TajwidBloc>(),
                          child: TajwidQuestionScreen(
                            tajwidId: tajwidId,
                          ),
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: AddTajwidQuestionScreen.path,
                        name: AddTajwidQuestionScreen.name,
                        pageBuilder: (context, state) {
                          final tajwidId = state.pathParameters['tajwidId']!;
                          final bloc = state.extra! as TajwidBloc;
                          return SlideRouteTransition(
                            key: state.pageKey,
                            child: BlocProvider.value(
                              value: bloc,
                              child: AddTajwidQuestionScreen(
                                tajwidId: tajwidId,
                              ),
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: EditTajwidQuestionScreen.path,
                        name: EditTajwidQuestionScreen.name,
                        pageBuilder: (context, state) {
                          final tajwidId = state.pathParameters['tajwidId']!;
                          final extra = state.extra! as DataMap;
                          final bloc = extra['bloc'] as TajwidBloc;
                          final id = extra['id'] as String;
                          final question = extra['question'] as String;
                          final choices = extra['choices'] as List<String>;
                          final answer = extra['answer'] as String;
                          return SlideRouteTransition(
                            key: state.pageKey,
                            child: BlocProvider.value(
                              value: bloc,
                              child: EditTajwidQuestionScreen(
                                id: id,
                                tajwidId: tajwidId,
                                question: question,
                                choices: choices,
                                answer: answer,
                              ),
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: TajwidTestResultsScreen.path,
                        name: TajwidTestResultsScreen.name,
                        pageBuilder: (context, state) {
                          final tajwidId = state.pathParameters['tajwidId']!;
                          return SlideRouteTransition(
                            key: state.pageKey,
                            child: BlocProvider(
                              create: (context) => sl<TajwidBloc>(),
                              child: TajwidTestResultsScreen(
                                tajwidId: tajwidId,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: TajwidTestResultScreen.path,
                    name: TajwidTestResultScreen.name,
                    pageBuilder: (context, state) {
                      final tajwidId = state.pathParameters['tajwidId']!;
                      final userId = state.extra as String?;
                      return SlideRouteTransition(
                        key: state.pageKey,
                        child: BlocProvider(
                          create: (context) => sl<TajwidBloc>(),
                          child: TajwidTestResultScreen(
                            tajwidId: tajwidId,
                            userId: userId,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
