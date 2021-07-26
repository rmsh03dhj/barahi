
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../entities/image_details.dart';

abstract class DashboardRepository {
  Future<List<ImageDetails>> loadImages(String loadFrom,String uid);
  Future<void> uploadImage(String uploadTo, String uid, File pickedImage) ;
  Future<void> deleteImage(String deleteImageFrom, String uid, String fileName);
  }
