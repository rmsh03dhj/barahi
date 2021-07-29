import 'dart:io';

import '../entities/image_details.dart';

abstract class DashboardRepository {
  Future<List<ImageDetails>> loadImages();
  Future<void> uploadImage(
      String uploadImageTo, File fileToUpload, String fileName);
  Future<void> deleteImage(String deleteImageFrom, String url);
  Future<void> updateImageDetails(ImageDetails imageDetails);
  Future<ImageDetails> searchImage(String searchText);
  Future<List<ImageDetails>> sortByFileName(bool ascending);
  Future<List<ImageDetails>> sortByDate(bool ascending);
  Future<List<ImageDetails>> sortByMyFav(bool ascending);
}
