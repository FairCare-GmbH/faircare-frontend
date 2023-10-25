import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/vacation_model.dart';
import 'package:faircare/repos/preferences/preferences_repo.dart';

part 'vacation_requests_event.dart';
part 'vacation_requests_state.dart';

class VacationRequestsBloc
    extends Bloc<VacationRequestsEvent, VacationRequestsState> {
  VacationRequestsBloc() : super(VacationRequestsInitial()) {
    on<GetVacationRequests>(
      (event, emit) async {
        try {
          emit(VacationRequestsLoading());
          final vacations = await PreferencesRepo().getVacationRequests();
          emit(VacationRequestsLoaded(vacations));
        } catch (e) {
          emit(VacationRequestsError(e.toString()));
        }
      },
    );
  }
}
