import 'dart:io';

import 'package:barahi/features/dashboard/domain/entities/image_details.dart';
import 'package:barahi/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import '../../domain/entities/image_details.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl();

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<ImageDetails>> loadImages(String from, String uid) async {
    List<ImageDetails> files = [];
    final ListResult result = await storage.ref("/" + from + "/" + uid).list();
    final List<Reference> allFiles = result.items;
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      ImageDetails imageDetails = ImageDetails(
         url: fileUrl,
        fileName:  file.fullPath,
         uploadedBy: fileMeta.customMetadata['uploaded_by'] ?? 'Nobody',
         myFavourite: fileMeta.customMetadata['my_favourite'] ?? false,
         uploadedAt: fileMeta.customMetadata['uploadedAt'] ?? 'No description');
      files.add(imageDetails);
    });

    return files;
  }

  Future<void> uploadImage(String uploadImageTo, String uid, File pickedImage) async {
    final String fileName = path.basename(pickedImage.path);
    try {
      await storage.ref("/" + uploadImageTo + "/" + uid + "/" + fileName).putFile(
          pickedImage,
          SettableMetadata(
              customMetadata: {'uploaded_by': 'A bad guy', 'uploadedAt': 'Some description...'}));
    } on FirebaseException catch (error) {
      print(error);
    } catch (err) {
      print(err);
    }
  }

  Future<void> deleteImage(String deleteImageFrom, String uid, String fileName) async {
    try {
      await storage.ref(fileName).delete();
    } on FirebaseException catch (error) {
      print(error);
    } catch (err) {
      print(err);
    }
  }
}
