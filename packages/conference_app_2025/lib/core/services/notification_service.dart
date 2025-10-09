import 'dart:async';
import 'dart:io';

import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

/// {@template notification_service}
/// Service for managing local notifications (iOS only).
///
/// Handles:
/// - Permission requests
/// - Scheduling notifications 10 minutes before conference start
/// - Deep link payload for navigation when tapped
/// - Canceling notifications
///
/// Example:
/// ```dart
/// await notificationService.initialize();
/// await notificationService.scheduleConferenceNotification(session);
/// ```
/// {@endtemplate}
class NotificationService {
  /// {@macro notification_service}
  NotificationService();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool _permissionGranted = false;

  Future<void> initializePlugin() async {
    // Only initialize on iOS
    if (!Platform.isIOS) return;

    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
    );

    await _plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _isInitialized = true;
  }

  /// Handles notification tap - extracts deep link and navigates
  void _onNotificationTapped(final NotificationResponse response) {
    // The payload contains the conference ID
    // Deep link navigation is handled by the router
    final conferenceId = ConferenceSessionId.fromJson(response.payload);
    if (conferenceId.isNotEmpty) {
      // The deep link will be handled by GoRouter
      // Format: myapp://conference/{id}
    }
  }

  /// Request notification permissions on iOS
  ///
  /// Returns true if permissions were granted
  Future<bool> requestPermissions() async {
    if (!Platform.isIOS || !_isInitialized) return false;

    final result = await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    return _permissionGranted = result ?? false;
  }

  /// Schedule a notification 10 minutes before conference starts
  ///
  /// Returns true if the notification was scheduled successfully
  Future<bool> scheduleConferenceNotification(
    final ConferenceSession session,
  ) async {
    if (!Platform.isIOS || !_isInitialized) return false;

    // Request permissions if not already granted
    if (!_permissionGranted) {
      final granted = await requestPermissions();
      if (!granted) return false;
    }

    final startAt = session.startAt;
    if (startAt == null) return false;

    // Schedule 10 minutes before start
    final notificationTime = startAt.subtract(const Duration(minutes: 10));

    // Don't schedule if notification time is in the past
    if (notificationTime.isBefore(DateTime.now())) return false;

    const notificationDetails = NotificationDetails(
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'default',
      ),
    );

    try {
      // Convert to TZDateTime for scheduling
      final tzDateTime = tz.TZDateTime.from(notificationTime, tz.local);

      await _plugin.zonedSchedule(
        session.id.value.hashCode, // Use session ID hash as notification ID
        'Conference Starting Soon',
        '${session.title} starts in 10 minutes',
        tzDateTime,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: session.id.value, // Pass conference ID for deep link
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Cancel a scheduled notification for a conference
  Future<void> cancelConferenceNotification(
    final ConferenceSessionId sessionId,
  ) async {
    if (!Platform.isIOS || !_isInitialized) return;

    await _plugin.cancel(sessionId.value.hashCode);
  }

  /// Cancel all scheduled notifications
  Future<void> cancelAllNotifications() async {
    if (!Platform.isIOS || !_isInitialized) return;

    await _plugin.cancelAll();
  }

  /// Get pending notifications (for debugging)
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    if (!Platform.isIOS || !_isInitialized) return [];

    return _plugin.pendingNotificationRequests();
  }
}
