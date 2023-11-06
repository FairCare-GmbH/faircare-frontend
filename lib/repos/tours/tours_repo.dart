import 'package:dio/dio.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/models/tour_model.dart';

import '../../api/api.dart';

class ToursRepo {
  Future<List<TourModel>> getAvailableTours() async {
    try{
      return (await Api.request<List>('/tour-plans', options: Options(method: 'GET')))
          .map((e) => TourModel.fromJson(e))
          .toList(growable: false);
    }catch(error, stack){
      print(error);
      print(stack);
      rethrow;
    }
  }

  Future<List<TourModel>> getMyTours() async {
    return (await Api.request<List>('/tour-plans/${Api.getUser()!.id}', options: Options(method: 'GET')))
        .map((e) => TourModel.fromJson(e))
        .toList(growable: false);
  }


  Future<List<TourModel>> getCompletedTours() async {
    try{
      return (await Api.request<List>('/tour-actuals/${Api.getUser()!.id}', options: Options(method: 'GET')))
          .map((e) => TourModel.fromJson(e))
          .toList(growable: false);
    }catch(error, stack){
      print(error);
      print(stack);
      rethrow;
    }
  }
}
