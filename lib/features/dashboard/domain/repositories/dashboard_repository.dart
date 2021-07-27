
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../entities/image_details.dart';

abstract class DashboardRepository {
  Future<List<ImageDetails>> loadImages(String loadFrom,String uid);
  Future<void> uploadImage(String uploadImageTo, String uid, ImageDetails imageDetails );
    Future<void> deleteImage(String deleteImageFrom, String uid, String fileName);
  }
