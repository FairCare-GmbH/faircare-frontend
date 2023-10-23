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

final sources = [
  'FairCare Website',
  'Google',
  'Persönliche Empfehlung',
  'Facebook',
  'Instagram',
];

final hoursTypes = [
  'Minijob',
  'Teilzeit',
  'Vollzeit',
];

final distances = [1, 3, 5, 10, 15];

final days = [
  'Montag',
  'Dienstag',
  'Mittwoch',
  'Donnerstag',
  'Freitag',
  'Samstag',
  'Sonntag',
];

final months = [
  'Januar',
  'Februar',
  'Marsch',
  'April',
  'Mai',
  'Juni',
  'Juli',
  'August',
  'September',
  'Oktober',
  'November',
  'Dezember'
];

final tourType = ['Frühdienst', 'Spätdienst'];

var tourExample1 = TourModel(
  id: 0,
  ownerNurseId: 0,
  actualFromTime: '08:00',
  actualToTime: '10:45',
  plannedFromTime: '08:00',
  plannedToTime: '11:00',
  hasInfectiousDisease: true,
  hasMedicalCare: true,
  hasBasicCare: false,
  hasWoundCare: false,
  hasHousekeeping: false,
  bonus: 0,
  dayOfWeek: 1,
  type: 1,
  centerLongitude: 1.1,
  centerLatitude: 2.2,
  revenue: 85,
  maximumCareRadius: 3,
  fromDate: DateTime(2023, 10, 10),
  toDate: DateTime(2023, 10, 10),
);

var tourExample2 = TourModel(
  id: 0,
  ownerNurseId: 0,
  actualFromTime: '08:00',
  actualToTime: '11:15',
  plannedFromTime: '08:00',
  plannedToTime: '11:00',
  hasInfectiousDisease: true,
  hasMedicalCare: true,
  hasBasicCare: false,
  hasWoundCare: false,
  hasHousekeeping: false,
  bonus: 25,
  dayOfWeek: 1,
  type: 2,
  centerLongitude: 1.1,
  centerLatitude: 2.2,
  revenue: 85,
  maximumCareRadius: 3,
  fromDate: DateTime(2023, 10, 10),
  toDate: DateTime(2023, 10, 12),
);

final tourExample3 = TourModel(
  id: 0,
  ownerNurseId: 0,
  actualFromTime: '08:00',
  actualToTime: '11:00',
  plannedFromTime: '08:00',
  plannedToTime: '11:00',
  hasInfectiousDisease: true,
  hasMedicalCare: true,
  hasBasicCare: false,
  hasWoundCare: false,
  hasHousekeeping: false,
  bonus: 0,
  dayOfWeek: 1,
  type: 1,
  centerLongitude: 1.1,
  centerLatitude: 2.2,
  revenue: 85,
  maximumCareRadius: 3,
  fromDate: DateTime(2023, 10, 10),
  toDate: DateTime(2023, 10, 10),
);
