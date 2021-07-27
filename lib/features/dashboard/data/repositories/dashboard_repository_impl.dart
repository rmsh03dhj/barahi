import 'dart:io';

import 'package:barahi/features/dashboard/domain/entities/image_details.dart';
import 'package:barahi/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl();

  final storage = FirebaseStorage.instance;
  final fsInstance = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;

  Future<List<ImageDetails>> loadImages(String from, String uid) async {
    try {
      final querySnapshot = await fsInstance
          .collection("users")
          .doc(firebaseUser.uid)
          .get();
    var images =  querySnapshot.data()['uploads'].map<ImageDetails>((item) {
        return ImageDetails.fromMap(item);
      }).toList();
    return images;
    } catch (e) {
      throw(e);
    }
  }

  Future<void> uploadImage(
      String uploadImageTo, String uid, ImageDetails imageDetails) async {
    try {
      final addingImage = await storage
          .ref("/" +
              uploadImageTo +
              "/" +
              firebaseUser.uid +
              "/" +
              imageDetails.fileName)
          .putFile(File(imageDetails.fileName));
      if (addingImage.state == TaskState.success) {
        final String downloadUrl = await addingImage.ref.getDownloadURL();
        var list = [
          {
            "uploaded_at":
                DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
            "fileName": imageDetails.fileName,
            "url": downloadUrl,
            "myFavourite": imageDetails.myFavourite,
          }
        ];
        await fsInstance
            .collection("users")
            .doc(firebaseUser.uid)
            .update({"uploads": FieldValue.arrayUnion(list)});
      } else {
        throw "Something went wrong.";
      }
    } on FirebaseException catch (error) {
      throw (error);
    } catch (err) {
      throw (err);
    }
  }

  Future<void> deleteImage(
      String deleteImageFrom, String uid, String fileName) async {
    try {
      await storage.ref(fileName).delete();
    } on FirebaseException catch (error) {
      throw(error);
    } catch (err) {
      throw(err);
    }
  }
}
