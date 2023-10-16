import 'package:faircare/models/tour_model.dart';

var defaultTour = TourModel(
  id: 1,
  ownerNurseId: 2,
  fromTime: "example from time",
  toTime: "example to time",
  hasInfectiousDisease: true,
  hasMedicalCare: true,
  hasBasicCare: true,
  hasWoundCare: true,
  hasHousekeeping: true,
  bonus: 100,
  dayOfWeek: 3,
  type: 1,
  centerLongitude: 1.23456,
  centerLatitude: 2.34567,
  revenue: 0,
  maximumCareRadius: 10,
  careDuration: 30,
  commuteDuration: 15,
  fromDate: DateTime.now(),
  toDate: DateTime.now(),
);
