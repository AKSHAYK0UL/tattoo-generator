part of 'gimage_bloc.dart';

sealed class GimageState {}

final class GimageInitial extends GimageState {
  String Quote;
  String auth;

  GimageInitial({this.Quote = '', this.auth = ''});
}

final class ImageGenerateState extends GimageState {
  final List<String> images;

  ImageGenerateState(this.images);
}

final class LoadingState extends GimageState {}

final class FailureState extends GimageState {
  final String error;

  FailureState(this.error);
}
