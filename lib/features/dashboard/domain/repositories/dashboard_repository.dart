import 'dart:io';

import '../entities/image_details.dart';

abstract class DashboardRepository {
  Future<List<ImageDetails>> loadImages(String loadFrom);
  Future<void> uploadImage(
      String uploadImageTo, File fileToUpload, String fileName);
  Future<void> deleteImage(String deleteImageFrom, String url);
  Future<void> updateImageDetails(ImageDetails imageDetails) ;
  }
