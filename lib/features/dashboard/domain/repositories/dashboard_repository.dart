import '../entities/image_details.dart';

abstract class DashboardRepository {
  Future<List<ImageDetails>> loadImages(String loadFrom);
  Future<void> uploadImage(String uploadImageTo, ImageDetails imageDetails);
  Future<void> deleteImage(String deleteImageFrom, String fileName);
}
