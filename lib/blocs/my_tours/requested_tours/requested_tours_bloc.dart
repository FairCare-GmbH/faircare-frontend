import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:faircare/repos/tours/tours_repo.dart';

part 'requested_tours_event.dart';
part 'requested_tours_state.dart';

class RequestedToursBloc
    extends Bloc<RequestedToursEvent, RequestedToursState> {
  RequestedToursBloc() : super(RequestedToursInitial()) {
    on<GetRequestedTours>(
      (event, emit) async {
        try {
          emit(RequestedToursLoading());
          final tours = await ToursRepo().getRequestedTours();
          emit(RequestedToursLoaded(tours));
        } catch (e) {
          emit(RequestedToursError(e.toString()));
        }
      },
    );
  }
}
