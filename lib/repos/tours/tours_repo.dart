import 'package:dio/dio.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/models/tour_model.dart';

import '../../api/api.dart';

class ToursRepo {
  Future<List<TourModel>> getAvailableTours() async {
    return (await Api.request<List>('/tour-plans', options: Options(method: 'GET')))
        .map((e) => TourModel.fromJson(e))
        .toList(growable: false);
  }

  Future<List<TourModel>> getRequestedTours() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [tourExample1, tourExample2, tourExample3];
  }

  Future<List<TourModel>> getAssignedTours() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [tourExample1, tourExample2, tourExample3];
  }

  Future<List<TourModel>> getCompletedTours() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [tourExample1, tourExample2, tourExample3];
  }
}
