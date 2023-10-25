import 'package:faircare/global/constants.dart';
import 'package:faircare/models/notification_model.dart';

class NotificationsRepo {
  Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      NotificationModel(
        id: 0,
        nurseId: 0,
        dateCreated: DateTime(2023, 10, 10),
        tourPlan: tourExample1,
        icon: 'check',
        title: 'Tour abgegeben',
        subtitle: 'Frühdienst, Montags',
        isRead: true,
      ),
      NotificationModel(
        id: 0,
        nurseId: 0,
        dateCreated: DateTime(2023, 10, 10),
        tourPlan: tourExample2,
        icon: 'check',
        title: 'Tour abgegeben',
        subtitle: 'Frühdienst, Montags',
        isRead: true,
      ),
    ];
  }

  Future<void> deleteNotification() async {}
}
