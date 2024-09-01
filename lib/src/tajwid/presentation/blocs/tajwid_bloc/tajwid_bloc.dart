import 'dart:io';

import 'package:alquran_app/core/utils/pair.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_material.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_question.dart';
import 'package:alquran_app/src/tajwid/domain/entities/test_response.dart';
import 'package:alquran_app/src/tajwid/domain/entities/test_result.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/add_tajwid.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/add_tajwid_material.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/add_tajwid_question.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/delete_tajwid.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/delete_tajwid_material.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/delete_tajwid_question.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/edit_tajwid.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/edit_tajwid_material.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/edit_tajwid_question.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/get_tajwid_materials.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/get_tajwid_questions.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/get_tajwids.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/get_test_result.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/get_test_results.dart';
import 'package:alquran_app/src/tajwid/domain/usecases/submit_test.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'tajwid_bloc.freezed.dart';
part 'tajwid_event.dart';
part 'tajwid_state.dart';

@injectable
class TajwidBloc extends Bloc<TajwidEvent, TajwidState> {
  TajwidBloc({
    required GetTajwids getTajwids,
    required AddTajwid addTajwid,
    required EditTajwid editTajwid,
    required DeleteTajwid deleteTajwid,
    required GetTajwidMaterials getTajwidMaterials,
    required AddTajwidMaterial addTajwidMaterial,
    required EditTajwidMaterial editTajwidMaterial,
    required DeleteTajwidMaterial deleteTajwidMaterial,
    required GetTajwidQuestions getTajwidQuestions,
    required AddTajwidQuestion addTajwidQuestion,
    required EditTajwidQuestion editTajwidQuestion,
    required DeleteTajwidQuestion deleteTajwidQuestion,
    required SubmitTest submitTest,
    required GetTestResult getTestResult,
    required GetTestResults getTestResults,
  })  : _getTajwids = getTajwids,
        _addTajwid = addTajwid,
        _editTajwid = editTajwid,
        _deleteTajwid = deleteTajwid,
        _getTajwidMaterials = getTajwidMaterials,
        _addTajwidMaterial = addTajwidMaterial,
        _editTajwidMaterial = editTajwidMaterial,
        _deleteTajwidMaterial = deleteTajwidMaterial,
        _getTajwidQuestions = getTajwidQuestions,
        _addTajwidQuestion = addTajwidQuestion,
        _editTajwidQuestion = editTajwidQuestion,
        _deleteTajwidQuestion = deleteTajwidQuestion,
        _submitTest = submitTest,
        _getTestResult = getTestResult,
        _getTestResults = getTestResults,
        super(const _Initial()) {
    on<_GetTajwidsEvent>(_getTajwidsHandler);
    on<_AddTajwidEvent>(_addTajwidHandler);
    on<_EditTajwidEvent>(_editTajwidHandler);
    on<_DeleteTajwidEvent>(_deleteTajwidHandler);
    on<_GetTajwidMaterialsEvent>(_getTajwidMaterialsHandler);
    on<_AddTajwidMaterialEvent>(_addTajwidMaterialHandler);
    on<_EditTajwidMaterialEvent>(_editTajwidMaterialHandler);
    on<_DeleteTajwidMaterialEvent>(_deleteTajwidMaterialHandler);
    on<_GetTajwidQuestionsEvent>(_getTajwidQuestionsHandler);
    on<_AddTajwidQuestionEvent>(_addTajwidQuestionHandler);
    on<_EditTajwidQuestionEvent>(_editTajwidQuestionHandler);
    on<_DeleteTajwidQuestionEvent>(_deleteTajwidQuestionHandler);
    on<_SubmitTestEvent>(_submitTestHandler);
    on<_GetTestResultEvent>(_getTestResultHandler);
    on<_GetTestResultsEvent>(_getTestResultsHandler);
  }

  final GetTajwids _getTajwids;
  final AddTajwid _addTajwid;
  final EditTajwid _editTajwid;
  final DeleteTajwid _deleteTajwid;
  final GetTajwidMaterials _getTajwidMaterials;
  final AddTajwidMaterial _addTajwidMaterial;
  final EditTajwidMaterial _editTajwidMaterial;
  final DeleteTajwidMaterial _deleteTajwidMaterial;
  final GetTajwidQuestions _getTajwidQuestions;
  final AddTajwidQuestion _addTajwidQuestion;
  final EditTajwidQuestion _editTajwidQuestion;
  final DeleteTajwidQuestion _deleteTajwidQuestion;
  final SubmitTest _submitTest;
  final GetTestResult _getTestResult;
  final GetTestResults _getTestResults;

  List<TajwidQuestion>? _questions;
  List<Tajwid>? _tajwids;

  List<TajwidQuestion>? get questions => _questions;
  List<Tajwid>? get tajwids => _tajwids;

  Future<void> _getTajwidsHandler(
    _GetTajwidsEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _GettingTajwids());

    final result = await _getTajwids();

    if (isClosed) return;

    result.fold(
      (failure) => emit(_GetTajwidsFailed(message: failure.errorMessage)),
      (tajwids) {
        _tajwids = tajwids;
        emit(_TajwidsLoaded(tajwids: tajwids));
      },
    );
  }

  Future<void> _addTajwidHandler(
    _AddTajwidEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _AddingTajwid());

    final result = await _addTajwid(
      AddTajwidParams(
        tajwidName: event.tajwidName,
        tajwidDescription: event.tajwidDescription,
        thumbnailImage: event.thumbnailImage,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(_AddTajwidFailed(message: failure.errorMessage)),
      (_) => emit(const _TajwidAdded()),
    );
  }

  Future<void> _editTajwidHandler(
    _EditTajwidEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _EditingTajwid());

    final result = await _editTajwid(
      EditTajwidParams(
        id: event.id,
        newTajwidName: event.newTajwidName,
        newTajwidDescription: event.newTajwidDescription,
        newThumbnailImage: event.newThumbnailImage,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(_EditTajwidFailed(message: failure.errorMessage)),
      (_) => emit(const _TajwidEdited()),
    );
  }

  Future<void> _deleteTajwidHandler(
    _DeleteTajwidEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _DeletingTajwid());

    final result = await _deleteTajwid(
      DeleteTajwidParams(id: event.id),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(_DeleteTajwidFailed(message: failure.errorMessage)),
      (_) => emit(const _TajwidDeleted()),
    );
  }

  Future<void> _getTajwidMaterialsHandler(
    _GetTajwidMaterialsEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _GettingTajwidMaterials());

    final result = await _getTajwidMaterials(
      GetTajwidMaterialsParams(tajwidId: event.tajwidId),
    );

    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(_GetTajwidMaterialsFailed(message: failure.errorMessage)),
      (materials) => emit(_TajwidMaterialsLoaded(materials: materials)),
    );
  }

  Future<void> _addTajwidMaterialHandler(
    _AddTajwidMaterialEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _AddingTajwidMaterial());

    final result = await _addTajwidMaterial(
      AddTajwidMaterialParams(
        tajwidId: event.tajwidId,
        content: event.content,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(_AddTajwidMaterialFailed(message: failure.errorMessage)),
      (_) => emit(const _TajwidMaterialAdded()),
    );
  }

  Future<void> _editTajwidMaterialHandler(
    _EditTajwidMaterialEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _EditingTajwidMaterial());

    final result = await _editTajwidMaterial(
      EditTajwidMaterialParams(
        id: event.id,
        newContent: event.newContent,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(_EditTajwidMaterialFailed(message: failure.errorMessage)),
      (_) => emit(const _TajwidMaterialEdited()),
    );
  }

  Future<void> _deleteTajwidMaterialHandler(
    _DeleteTajwidMaterialEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _DeletingTajwidMaterial());

    final result = await _deleteTajwidMaterial(
      DeleteTajwidMaterialParams(id: event.id),
    );

    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(_DeleteTajwidMaterialFailed(message: failure.errorMessage)),
      (_) => emit(const _TajwidMaterialDeleted()),
    );
  }

  Future<void> _addTajwidQuestionHandler(
    _AddTajwidQuestionEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _AddingTajwidQuestion());

    final result = await _addTajwidQuestion(
      AddTajwidQuestionParams(
        tajwidId: event.tajwidId,
        question: event.question,
        choices: event.choices,
        answer: event.answer,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(_AddTajwidQuestionFailed(message: failure.errorMessage)),
      (_) => emit(const _TajwidQuestionAdded()),
    );
  }

  Future<void> _getTajwidQuestionsHandler(
    _GetTajwidQuestionsEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _GettingTajwidQuestions());

    final result = await _getTajwidQuestions(
      GetTajwidQuestionsParams(
        tajwidId: event.tajwidId,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(_GetTajwidQuestionsFailed(message: failure.errorMessage)),
      (questions) {
        _questions = questions;
        emit(_TajwidQuestionsLoaded(questions: questions));
      },
    );
  }

  Future<void> _editTajwidQuestionHandler(
    _EditTajwidQuestionEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _EditingTajwidQuestion());

    final result = await _editTajwidQuestion(
      EditTajwidQuestionParams(
        id: event.id,
        newQuestion: event.newQuestion,
        newChoices: event.newChoices,
        newAnswer: event.newAnswer,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(_EditTajwidQuestionFailed(message: failure.errorMessage)),
      (_) => emit(const _TajwidQuestionEdited()),
    );
  }

  Future<void> _deleteTajwidQuestionHandler(
    _DeleteTajwidQuestionEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _DeletingTajwidQuestion());

    final result = await _deleteTajwidQuestion(
      DeleteTajwidQuestionParams(id: event.id),
    );

    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(_DeleteTajwidQuestionFailed(message: failure.errorMessage)),
      (_) => emit(const _TajwidQuestionDeleted()),
    );
  }

  Future<void> _submitTestHandler(
    _SubmitTestEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _SubmittingTest());

    final result = await _submitTest(
      SubmitTestParams(
        tajwidId: event.tajwidId,
        answers: event.answers,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(_SubmitTestFailed(message: failure.errorMessage)),
      (_) => emit(const _TestSubmitted()),
    );
  }

  Future<void> _getTestResultHandler(
    _GetTestResultEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _GettingTestResult());

    final result = await _getTestResult(
      GetTestResultParams(
        tajwidId: event.tajwidId,
        userId: event.userId,
      ),
    );

    result.fold(
      (failure) => emit(_GetTestResultFailed(message: failure.errorMessage)),
      (testResult) {
        if (testResult.second == null) {
          emit(const _TestResultEmpty());
          return;
        }

        emit(
          _TestResultLoaded(
            testResult: Pair<List<TajwidQuestion>, TestResponse>(
              testResult.first,
              testResult.second!,
            ),
          ),
        );
      },
    );
  }

  Future<void> _getTestResultsHandler(
    _GetTestResultsEvent event,
    Emitter<TajwidState> emit,
  ) async {
    emit(const _GettingTestResults());

    final result = await _getTestResults(
      GetTestResultsParams(
        tajwidId: event.tajwidId,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(_GetTestResultsFailed(message: failure.errorMessage)),
      (results) => emit(_TestResultsLoaded(results: results)),
    );
  }
}
