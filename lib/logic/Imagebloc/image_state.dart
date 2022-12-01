part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();
}

class ImageInitial extends ImageState {
  @override
  List<Object> get props => [];
}

class ImageLoading extends ImageState {
  @override
  List<Object> get props => [];
}

class ImageUploaded extends ImageState {
  final ImageModel imgUrl;
  const ImageUploaded({
    required this.imgUrl,
  });
  @override
  List<Object> get props => [imgUrl];
}

class ImageError extends ImageState {
  final String error;
  const ImageError({
    required this.error,
  });
  @override
  List<Object> get props => [];
}
