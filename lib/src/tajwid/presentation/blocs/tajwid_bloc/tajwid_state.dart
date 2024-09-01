part of 'tajwid_bloc.dart';

@freezed
class TajwidState with _$TajwidState {
  const factory TajwidState.initial() = _Initial;

  const factory TajwidState.gettingTajwids() = _GettingTajwids;

  const factory TajwidState.tajwidsLoaded({
    required List<Tajwid> tajwids,
  }) = _TajwidsLoaded;

  const factory TajwidState.getTajwidsFailed({
    required String message,
  }) = _GetTajwidsFailed;

  const factory TajwidState.addingTajwid() = _AddingTajwid;

  const factory TajwidState.tajwidAdded() = _TajwidAdded;

  const factory TajwidState.addTajwidFailed({
    required String message,
  }) = _AddTajwidFailed;

  const factory TajwidState.editingTajwid() = _EditingTajwid;

  const factory TajwidState.tajwidEdited() = _TajwidEdited;

  const factory TajwidState.editTajwidFailed({
    required String message,
  }) = _EditTajwidFailed;

  const factory TajwidState.deletingTajwid() = _DeletingTajwid;

  const factory TajwidState.tajwidDeleted() = _TajwidDeleted;

  const factory TajwidState.deleteTajwidFailed({
    required String message,
  }) = _DeleteTajwidFailed;

  const factory TajwidState.gettingTajwidMaterials() = _GettingTajwidMaterials;

  const factory TajwidState.tajwidMaterialsLoaded({
    required List<TajwidMaterial> materials,
  }) = _TajwidMaterialsLoaded;

  const factory TajwidState.getTajwidMaterialsFailed({
    required String message,
  }) = _GetTajwidMaterialsFailed;

  const factory TajwidState.addingTajwidMaterial() = _AddingTajwidMaterial;

  const factory TajwidState.tajwidMaterialAdded() = _TajwidMaterialAdded;

  const factory TajwidState.addTajwidMaterialFailed({
    required String message,
  }) = _AddTajwidMaterialFailed;

  const factory TajwidState.editingTajwidMaterial() = _EditingTajwidMaterial;

  const factory TajwidState.tajwidMaterialEdited() = _TajwidMaterialEdited;

  const factory TajwidState.editTajwidMaterialFailed({
    required String message,
  }) = _EditTajwidMaterialFailed;

  const factory TajwidState.deletingMaterial() = _DeletingTajwidMaterial;

  const factory TajwidState.tajwidMaterialDeleted() = _TajwidMaterialDeleted;

  const factory TajwidState.deleteTajwidMaterialFailed({
    required String message,
  }) = _DeleteTajwidMaterialFailed;

  const factory TajwidState.gettingTajwidQuestions() = _GettingTajwidQuestions;

  const factory TajwidState.tajwidQuestionsLoaded({
    required List<TajwidQuestion> questions,
  }) = _TajwidQuestionsLoaded;

  const factory TajwidState.getTajwidQuestionsFailed({
    required String message,
  }) = _GetTajwidQuestionsFailed;

  const factory TajwidState.addingTajwidQuestion() = _AddingTajwidQuestion;

  const factory TajwidState.tajwidQuestionAdded() = _TajwidQuestionAdded;

  const factory TajwidState.addTajwidQuestionFailed({
    required String message,
  }) = _AddTajwidQuestionFailed;

  const factory TajwidState.editingTajwidQuestion() = _EditingTajwidQuestion;

  const factory TajwidState.tajwidQuestionEdited() = _TajwidQuestionEdited;

  const factory TajwidState.editTajwidQuestionFailed({
    required String message,
  }) = _EditTajwidQuestionFailed;

  const factory TajwidState.deletingTajwidQuestion() = _DeletingTajwidQuestion;

  const factory TajwidState.tajwidQuestionDeleted() = _TajwidQuestionDeleted;

  const factory TajwidState.deleteTajwidQuestionFailed({
    required String message,
  }) = _DeleteTajwidQuestionFailed;

  const factory TajwidState.submittingTest() = _SubmittingTest;

  const factory TajwidState.testSubmitted() = _TestSubmitted;

  const factory TajwidState.submitTestFailed({
    required String message,
  }) = _SubmitTestFailed;

  const factory TajwidState.gettingTestResult() = _GettingTestResult;

  const factory TajwidState.testResultEmpty() = _TestResultEmpty;

  const factory TajwidState.testResultLoaded({
    required Pair<List<TajwidQuestion>, TestResponse> testResult,
  }) = _TestResultLoaded;

  const factory TajwidState.getTestResultFailed({
    required String message,
  }) = _GetTestResultFailed;

  const factory TajwidState.gettingTestResults() = _GettingTestResults;

  const factory TajwidState.testResultsLoaded({
    required List<TestResult> results,
  }) = _TestResultsLoaded;

  const factory TajwidState.getTestResultsFailed({
    required String message,
  }) = _GetTestResultsFailed;
}
