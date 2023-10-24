import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:faircare/repos/tours/tours_repo.dart';

part 'available_tours_event.dart';
part 'available_tours_state.dart';

class AvailableToursBloc
    extends Bloc<AvailableToursEvent, AvailableToursState> {
  AvailableToursBloc() : super(AvailableToursInitial()) {
    on<GetAvailableTours>(
      (event, emit) async {
        try {
          emit(AvailableToursLoading());
          final tours = await ToursRepo().getAvailableTours();
          emit(AvailableToursLoaded(tours));
        } catch (e) {
          emit(AvailableToursError(e.toString()));
        }
      },
    );
  }
}
