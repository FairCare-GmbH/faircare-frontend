import 'package:faircare/models/tour_model.dart';

final qualifications = [
  'Pflegefachkraft (3J Ausbildung)',
  'Pflegehilfskraft (1-2J Ausbildung)',
  'Ungelernte Pflegehilfskraft',
  'Keine Erfahrung in der Pflege',
];

final driverLicenseAvailable = [
  'Vorhanden',
  'Nicht vorhanden',
];

var defaultTour = TourModel(
  id: 1,
  ownerNurseId: 2,
  actualFromTime: '',
  actualToTime: '',
  plannedFromTime: '',
  plannedToTime: '',
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
  fromDate: DateTime.now(),
  toDate: DateTime.now(),
);
