import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:faircare/repos/tours/tours_repo.dart';

part 'assigned_tours_event.dart';
part 'assigned_tours_state.dart';

class AssignedToursBloc extends Bloc<AssignedToursEvent, AssignedToursState> {
  AssignedToursBloc() : super(AssignedToursInitial()) {
    on<GetAssignedTours>(
      (event, emit) async {
        try {
          emit(AssignedToursLoading());
          final tours = await ToursRepo().getAssignedTours();
          emit(AssignedToursLoaded(tours));
        } catch (e) {
          emit(AssignedToursError(e.toString()));
        }
      },
    );
  }
}
