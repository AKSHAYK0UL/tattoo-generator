part of 'gimage_bloc.dart';

sealed class GimageEvent {}

final class GenerateQuotes extends GimageEvent {}

final class SetToGintitailState extends GimageEvent {}

final class OnPressedGenerateImageEvent extends GimageEvent {
  final String prompt;
  final int imageCount;

  OnPressedGenerateImageEvent({required this.prompt, required this.imageCount});
}
