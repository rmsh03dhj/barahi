
import 'package:barahi/features/dashboard/domain/entities/image_details.dart';

abstract class DashboardRepository {
  Future<ImageDetails> getImages();
}
