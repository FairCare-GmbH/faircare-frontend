import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:faircare/repos/tours/tours_repo.dart';

part 'completed_tours_event.dart';
part 'completed_tours_state.dart';

class CompletedToursBloc
    extends Bloc<CompletedToursEvent, CompletedToursState> {
  CompletedToursBloc() : super(CompletedToursInitial()) {
    on<GetCompletedTours>(
      (event, emit) async {
        try {
          emit(CompletedToursLoading());
          final tours = await ToursRepo().getCompletedTours();
          emit(CompletedToursLoaded(tours));
        } catch (e) {
          emit(CompletedToursError(e.toString()));
        }
      },
    );
  }
}
