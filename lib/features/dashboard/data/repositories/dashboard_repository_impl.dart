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

  Future<List<ImageDetails>> loadImages() async {
    try {
      List<ImageDetails> images = [];
      final firebaseUser = FirebaseAuth.instance.currentUser;
      final querySnapshot =
          await fsInstance.collection("users").doc(firebaseUser.uid).get();
      if (querySnapshot.data() != null) {
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

  Future<List<ImageDetails>> sortByFileName(bool ascending) async {
    try {
      List<ImageDetails> images = [];
      final firebaseUser = FirebaseAuth.instance.currentUser;
      final querySnapshot =
          await fsInstance.collection("users").doc(firebaseUser.uid).get();
      if (querySnapshot.data() != null) {
        images = querySnapshot.data()['uploads'].map<ImageDetails>((item) {
          return ImageDetails.fromMap(item);
        }).toList();
      }
      if (ascending) {
        images.sort((a, b) => a.fileName.compareTo(b.fileName));
      } else {
        images.sort((b, a) => a.fileName.compareTo(b.fileName));
      }
      return images;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<List<ImageDetails>> sortByMyFav(bool ascending) async {
    try {
      List<ImageDetails> images = [];
      final firebaseUser = FirebaseAuth.instance.currentUser;
      final querySnapshot =
          await fsInstance.collection("users").doc(firebaseUser.uid).get();
      if (querySnapshot.data() != null) {
        images = querySnapshot.data()['uploads'].map<ImageDetails>((item) {
          return ImageDetails.fromMap(item);
        }).toList();
      }
      if (ascending) {
        images.sort((a, b) {
          if(b.myFavourite) {
            return 1;
          }
          return -1;
        });
      } else {
        images.sort((a, b) {
          if(a.myFavourite) {
            return 1;
          }
          return -1;
        });
      }
      return images;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<List<ImageDetails>> sortByDate(bool ascending) async {
    try {
      List<ImageDetails> images = [];
      final firebaseUser = FirebaseAuth.instance.currentUser;
      final querySnapshot =
          await fsInstance.collection("users").doc(firebaseUser.uid).get();
      if (querySnapshot.data() != null) {
        images = querySnapshot.data()['uploads'].map<ImageDetails>((item) {
          return ImageDetails.fromMap(item);
        }).toList();
      }
      if (ascending) {
        images.sort((a, b) => a.uploadedAt.compareTo(b.uploadedAt));
      } else {
        images.sort((b, a) => a.uploadedAt.compareTo(b.uploadedAt));
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
                DateFormat('yyyyMMdd').format(DateTime.now()),
            "fileName": fileName,
            "url": downloadUrl,
            "myFavourite": false,
            "shared": false,
          }
        ];
        final exists =
            await fsInstance.collection("users").doc(firebaseUser.uid).get();
        if (exists.data() != null) {
          await fsInstance.collection("users").doc(firebaseUser.uid).update(
            {"uploads": FieldValue.arrayUnion(list)},
          );
        } else {
          await fsInstance.collection("users").doc(firebaseUser.uid).set(
              {"uploads": FieldValue.arrayUnion(list)},
              SetOptions(merge: true));
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

  Future<void> deleteImage(String deleteImageFrom, String url) async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      final querySnapshot =
          await fsInstance.collection("users").doc(firebaseUser.uid).get();
      if (querySnapshot.data() != null) {
        List data = querySnapshot.data()['uploads'];
        data.retainWhere((element) => element['url'] != url);
        await fsInstance
            .collection("users")
            .doc(firebaseUser.uid)
            .set({"uploads": data});
        print(storage.refFromURL(url));
        storage.refFromURL(url).delete();
      }
    } on FirebaseException catch (error) {
      print(error);
      throw (error);
    } catch (err) {
      print(err);
      throw (err);
    }
  }

  Future<void> updateImageDetails(ImageDetails imageDetails) async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      final querySnapshot =
          await fsInstance.collection("users").doc(firebaseUser.uid).get();
      if (querySnapshot.data() != null) {
        List data = querySnapshot.data()['uploads'];
        List updatedDetails = [];
        data.forEach((element) {
          if (element['url'] != imageDetails.url) {
            updatedDetails.add(element);
          } else {
            updatedDetails.add({
              "uploaded_at":imageDetails.uploadedAt,
              "fileName": imageDetails.fileName,
              "url": imageDetails.url,
              "myFavourite": imageDetails.myFavourite,
              "shared": imageDetails.shared
            });
          }
        });
        await fsInstance
            .collection("users")
            .doc(firebaseUser.uid)
            .set({"uploads": updatedDetails});
      }
    } on FirebaseException catch (error) {
      print(error);
      throw (error);
    } catch (err) {
      print(err);
      throw (err);
    }
  }

  Future<ImageDetails> searchImage(String searchText) async {
    try {
      ImageDetails imageDetails;

      final firebaseUser = FirebaseAuth.instance.currentUser;
      final querySnapshot =
          await fsInstance.collection("users").doc(firebaseUser.uid).get();
      if (querySnapshot.data() != null) {
        List data = querySnapshot.data()['uploads'];
        data.forEach((element) {
          if (element['fileName'] == searchText) {
            imageDetails = ImageDetails(
                url: element['url'],
                myFavourite: element['myFavourite'],
                fileName: element['fileName'],
                shared: element['shared'],
                uploadedAt: element['uploadedAt']);
          }
        });
      }
      return imageDetails;
    } on FirebaseException catch (error) {
      print(error);
      throw (error);
    } catch (err) {
      print(err);
      throw (err);
    }
  }
}
