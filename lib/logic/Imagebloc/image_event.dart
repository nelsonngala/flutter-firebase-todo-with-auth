part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class UploadImageEvent extends ImageEvent {
  @override
  List<Object> get props => [];
}
