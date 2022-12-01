import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo/data/image_model.dart';

import 'package:flutter_firebase_todo/data/profile_image_repo.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ProfileImage _profileImage;
  ImageBloc(
    this._profileImage,
  ) : super(ImageInitial()) {
    on<ImageEvent>((event, emit) async {
      if (event is UploadImageEvent) {
        emit(ImageLoading());
        try {
          final ImageModel imageLink = await _profileImage.getImageLink();
          return emit(ImageUploaded(imgUrl: imageLink));
          // add(UploadImageEvent());
        } catch (e) {
          emit(ImageError(error: '$e'));
        }
      }
    });
  }
}
