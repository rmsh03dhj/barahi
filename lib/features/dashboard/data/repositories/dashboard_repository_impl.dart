
import 'dart:io';

import 'package:barahi/features/dashboard/domain/entities/image_details.dart';
import 'package:barahi/features/dashboard/domain/repositories/weather_repository.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class DashboardRepositoryImpl implements DashboardRepository {

  DashboardRepositoryImpl();

  FirebaseStorage storage = FirebaseStorage.instance;


  @override
  Future<ImageDetails> getImages() async {
    try {
    } catch (e) {
      throw errorMessageSomethingWentWrong;
    }
  }

  Future<List<Map<String, dynamic>>> loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata['uploaded_by'] ?? 'Nobody',
        "description":
        fileMeta.customMetadata['description'] ?? 'No description'
      });
    });

    return files;
  }

  Future<void> upload(File pickedImage) async {

      final String fileName = path.basename(pickedImage.path);
      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            pickedImage,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'A bad guy',
              'description': 'Some description...'
            }));

        // Refresh the UI
      } on FirebaseException catch (error) {
        print(error);
    } catch (err) {
      print(err);
    }
  }

}
