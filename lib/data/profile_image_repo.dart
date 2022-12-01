import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_todo/data/image_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage {
  final String email = FirebaseAuth.instance.currentUser!.email!;
  final FirebaseStorage storage = FirebaseStorage.instance;

  // String get getUrl => ref.getDownloadURL();
  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final dispPhoto = await picker.pickImage(source: ImageSource.gallery);
    if (dispPhoto == null) {
      return;
    }
    final Reference ref = storage.ref().child("profileImages/$email");
    final UploadTask uploadTask = ref.putFile(File(dispPhoto.path));
    final snapshot = await uploadTask.snapshot.ref.getDownloadURL();
    ImageModel imageModel = ImageModel(imgPath: snapshot);
    final doc = FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('images')
        .doc('profile');
    imageModel.id = doc.id;
    await doc.set(imageModel.toMap());
  }

  Future<ImageModel> getImageLink() async {
    final response = await FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('images')
        .doc('profile')
        .get();

    final imgModel =
        ImageModel.fromMap(response.data() as Map<String, dynamic>);
    return imgModel;
  }
}
