import 'dart:math';

class NurseRatingModel {
  double? ratingVector5;
  double? ratingVector4;
  double? ratingVector3;
  double? ratingVector2;
  double? ratingVector1;
  int? ratingCount;

  NurseRatingModel({
    required this.ratingVector5,
    required this.ratingVector4,
    required this.ratingVector3,
    required this.ratingVector2,
    required this.ratingVector1,
    required this.ratingCount,
  });

  double? getAverageRating() {
    final avg = ((ratingVector1 ?? 0) +
            (ratingVector2 ?? 0) +
            (ratingVector3 ?? 0) +
            (ratingVector4 ?? 0) +
            (ratingVector5 ?? 0)) /
        max(
            1,
            (((ratingVector1 ?? 0) > 0 ? 1 : 0) +
                ((ratingVector2 ?? 0) > 0 ? 1 : 0) +
                ((ratingVector3 ?? 0) > 0 ? 1 : 0) +
                ((ratingVector4 ?? 0) > 0 ? 1 : 0) +
                ((ratingVector5 ?? 0) > 0 ? 1 : 0)));
    return avg == 0 ? null : avg;
  }

  NurseRatingModel copyWith({
    double? ratingVector5,
    double? ratingVector4,
    double? ratingVector3,
    double? ratingVector2,
    double? ratingVector1,
    int? ratingCount,
  }) =>
      NurseRatingModel(
        ratingVector5: ratingVector5 ?? this.ratingVector5,
        ratingVector4: ratingVector4 ?? this.ratingVector4,
        ratingVector3: ratingVector3 ?? this.ratingVector3,
        ratingVector2: ratingVector2 ?? this.ratingVector2,
        ratingVector1: ratingVector1 ?? this.ratingVector1,
        ratingCount: ratingCount ?? this.ratingCount,
      );

  factory NurseRatingModel.fromJson(Map<String, dynamic> json) => NurseRatingModel(
        ratingVector5: json["ratingVector5"]?.toDouble(),
        ratingVector4: json["ratingVector4"]?.toDouble(),
        ratingVector3: json["ratingVector3"]?.toDouble(),
        ratingVector2: json["ratingVector2"]?.toDouble(),
        ratingVector1: json["ratingVector1"]?.toDouble(),
        ratingCount: json["ratingCount"],
      );

  Map<String, dynamic> toJson() => {
        "ratingVector5": ratingVector5,
        "ratingVector4": ratingVector4,
        "ratingVector3": ratingVector3,
        "ratingVector2": ratingVector2,
        "ratingVector1": ratingVector1,
        "ratingCount": ratingCount,
      };
}
