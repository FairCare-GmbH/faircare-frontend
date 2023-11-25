import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/features/patients/patient.model.dart';
import 'package:flutter/foundation.dart';

import '../../api/api.dart';

class PatientsBloc extends Bloc<MyPatientsEvent, MyPatientsState> {
  PatientsBloc() : super(MyPatientsInitial()) {
    on<GetMyPatients>(
      (event, emit) async {
        try {
          emit(MyPatientsLoading());
          final patients = (await Api.request<List>('/patients/mine',
                  options: Options(method: 'GET'),
                  queryParameters: {
                'from': DateTime.now().ymd.subtract(const Duration(days: 30)),
                'to': DateTime.now().ymd.add(const Duration(days: 30)),
              }))
              .map((e) => PatientModel.fromJson(e))
              .toList(growable: false);
          emit(MyPatientsLoaded(patients));
        } catch (e, s) {
          if (kDebugMode) {
            print(e.toString());
            print(s);
          }
          emit(MyPatientsError(e.toString()));
        }
      },
    );
  }
}

abstract class MyPatientsEvent {
  MyPatientsEvent();
}

class GetMyPatients extends MyPatientsEvent {}

abstract class MyPatientsState {
  const MyPatientsState();
}

class MyPatientsInitial extends MyPatientsState {}

class MyPatientsLoading extends MyPatientsState {}

class MyPatientsLoaded extends MyPatientsState {
  final List<PatientModel> patients;

  const MyPatientsLoaded(this.patients);
}

class MyPatientsError extends MyPatientsState {
  final String error;

  const MyPatientsError(this.error);
}
