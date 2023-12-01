import 'package:bloc/bloc.dart';
import 'package:faircare/features/performance/tour_list_performance_display_type.enum.dart';

class PerformanceTabsCubit extends Cubit<TourListPerformanceDisplayType> {
  PerformanceTabsCubit(TourListPerformanceDisplayType initialState)
      : super(initialState);

  void setSelectedIndex(TourListPerformanceDisplayType value) {
    emit(value);
  }
}
