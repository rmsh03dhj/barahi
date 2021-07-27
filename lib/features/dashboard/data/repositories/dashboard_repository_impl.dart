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

  Future<List<ImageDetails>> loadImages(String from) async {
    try {
      List<ImageDetails> images = [];
      final firebaseUser = FirebaseAuth.instance.currentUser;
      final querySnapshot =
          await fsInstance.collection("users").doc(firebaseUser.uid).get();
      if(querySnapshot.data()!=null) {
        images = querySnapshot.data()['uploads'].map<ImageDetails>((item) {
          return ImageDetails.fromMap(item);
        }).toList();
      }
      return images;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> uploadImage(
      String uploadImageTo, File fileToUpload, String fileName) async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      final addingImage = await storage
          .ref("/" + uploadImageTo + "/" + firebaseUser.uid + "/" + fileName)
          .putFile(fileToUpload);
      if (addingImage.state == TaskState.success) {
        final String downloadUrl = await addingImage.ref.getDownloadURL();
        var list = [
          {
            "uploaded_at":
                DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
            "fileName": fileName,
            "url": downloadUrl,
            "myFavourite": false,
          }
        ];
        final exists = await fsInstance.collection("users").doc(firebaseUser.uid).get();
        print(exists.data());
        if(exists.data()!=null) {
          await fsInstance
              .collection("users")
              .doc(firebaseUser.uid)
              .update({"uploads": FieldValue.arrayUnion(list)},);
        }else{
          await fsInstance
              .collection("users")
              .doc(firebaseUser.uid)
              .set({"uploads": FieldValue.arrayUnion(list)},SetOptions(merge: true));
        }
      } else {
        throw "Something went wrong.";
      }
    } on FirebaseException catch (error) {
      print(error);
      throw (error);
    } catch (err) {
      print(err);
      throw (err);
    }
  }

  Future<void> deleteImage(String deleteImageFrom, String fileName) async {
    try {
      await storage.ref(fileName).delete();
    } on FirebaseException catch (error) {
      throw (error);
    } catch (err) {
      throw (err);
    }
  }
}
