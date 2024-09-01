part of 'tajwid_bloc.dart';

@freezed
class TajwidEvent with _$TajwidEvent {
  const factory TajwidEvent.getTajwidsEvent() = _GetTajwidsEvent;

  const factory TajwidEvent.addTajwidEvent({
    required String tajwidName,
    required String tajwidDescription,
    required File thumbnailImage,
  }) = _AddTajwidEvent;

  const factory TajwidEvent.editTajwidEvent({
    required String id,
    required String? newTajwidName,
    required String? newTajwidDescription,
    required File? newThumbnailImage,
  }) = _EditTajwidEvent;

  const factory TajwidEvent.deleteTajwidEvent({
    required String id,
  }) = _DeleteTajwidEvent;

  const factory TajwidEvent.getTajwidMaterialsEvent({
    required String tajwidId,
  }) = _GetTajwidMaterialsEvent;

  const factory TajwidEvent.addTajwidMaterialEvent({
    required String tajwidId,
    required String content,
  }) = _AddTajwidMaterialEvent;

  const factory TajwidEvent.editTajwidMaterialEvent({
    required String id,
    required String newContent,
  }) = _EditTajwidMaterialEvent;

  const factory TajwidEvent.deleteTajwidMaterialEvent({
    required String id,
  }) = _DeleteTajwidMaterialEvent;

  const factory TajwidEvent.getTajwidQuestionsEvent({
    required String tajwidId,
  }) = _GetTajwidQuestionsEvent;

  const factory TajwidEvent.addTajwidQuestionEvent({
    required String tajwidId,
    required String question,
    required List<String> choices,
    required String answer,
  }) = _AddTajwidQuestionEvent;

  const factory TajwidEvent.editTajwidQuestionEvent({
    required String id,
    required String newQuestion,
    required List<String> newChoices,
    required String newAnswer,
  }) = _EditTajwidQuestionEvent;

  const factory TajwidEvent.deleteTajwidQuestionEvent({
    required String id,
  }) = _DeleteTajwidQuestionEvent;

  const factory TajwidEvent.submitTestEvent({
    required String tajwidId,
    required Map<String, String> answers,
  }) = _SubmitTestEvent;

  const factory TajwidEvent.getTestResultEvent({
    required String tajwidId,
    String? userId,
  }) = _GetTestResultEvent;

  const factory TajwidEvent.getTestResultsEvent({
    required String tajwidId,
  }) = _GetTestResultsEvent;
}
