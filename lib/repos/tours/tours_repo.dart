import 'package:faircare/global/constants.dart';
import 'package:faircare/models/tour_model.dart';

class ToursRepo {
  Future<List<TourModel>> getAvailableTours() async {
    return [
      tourExample1,
      tourExample2,
      tourExample3,
    ];
  }

  Future<List<TourModel>> getRequestedTours() async {
    return [
      tourExample1,
      tourExample2,
      tourExample3,
    ];
  }

  Future<List<TourModel>> getAssignedTours() async {
    return [
      tourExample1,
      tourExample2,
      tourExample3,
    ];
  }

  Future<List<TourModel>> getCompletedTours() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      tourExample1,
      tourExample2,
      tourExample3,
    ];
  }
}
