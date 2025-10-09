# iOS Features Documentation

This document describes the iOS-specific features implemented in the Conference App 2025.

## Features Overview

1. **Deep Links** - Navigate directly to conference details via `myapp://conference/{id}`
2. **Local Notifications** - Receive notifications 10 minutes before scheduled conferences
3. **Golden Tests** - Visual regression tests for all screens

---

## 1. Deep Links

### Configuration

Deep links are configured to work with the custom URL scheme `myapp://`.

#### iOS Setup (Info.plist)

The `ios/Runner/Info.plist` has been configured with:
- URL Type: `com.conference.app.2025`
- URL Scheme: `myapp`

#### Usage

**Format:** `myapp://conference/{conference_id}`

**Example:**
```
myapp://conference/c1
```

#### Behavior

- **Cold Start**: Opens app and navigates to conference details, fetching data from API
- **Warm Start**: App switches to conference details while preserving state
- **Invalid ID**: Shows error screen if conference not found

#### Implementation

- Router handles deep link parsing in `app_router.dart`
- Conference details screen loads data if not provided via navigation
- Works with both `/conferences/{id}` and `/schedule/{id}` routes

---

## 2. Local Notifications (iOS Only)

### Features

- Schedules notification 10 minutes before conference starts
- Includes conference title and time
- Tapping notification opens conference details via deep link
- Auto-cancels when conference removed from schedule

### Permissions

Permissions are requested automatically when:
- User adds first conference to schedule
- Permissions requested: Alert, Badge, Sound

### Implementation

#### Service Layer
`lib/services/notification_service.dart` handles:
- iOS notification initialization
- Permission requests
- Scheduling/canceling notifications
- Deep link payload generation

#### Commands
- `ScheduleConferenceNotificationCommand` - Schedule notification
- `CancelConferenceNotificationCommand` - Cancel notification

#### Integration
Automatically triggered in `ui_conference_details_screen.dart`:
- **Add to Schedule** → Schedules notification
- **Remove from Schedule** → Cancels notification

### Platform Check

All notification code includes `Platform.isIOS` checks and gracefully handles:
- Running on non-iOS platforms
- Permission denials
- Past conference times

### Dependencies

- `flutter_local_notifications: ^18.0.1`
- `timezone: ^0.9.4`

---

## 3. Golden Tests

### Overview

Golden tests capture visual snapshots of all screens for regression testing.

### Test Files

Located in `test/golden/`:
1. `ui_splash_screen_test.dart` - Splash screen
2. `ui_home_screen_test.dart` - Bottom navigation bar
3. `ui_all_conferences_screen_test.dart` - Conferences list
4. `ui_conference_details_screen_test.dart` - Conference details
5. `ui_my_schedule_screen_test.dart` - My schedule
6. `ui_profile_screen_test.dart` - Profile/settings

### Running Golden Tests

#### Generate Golden Images (First Time)
```bash
flutter test --update-goldens
```

#### Run Golden Tests
```bash
flutter test test/golden/
```

#### Update Specific Test
```bash
flutter test --update-goldens test/golden/ui_splash_screen_test.dart
```

### Configuration

- Test config: `test/flutter_test_config.dart`
- Golden images stored: `test/golden/goldens/`
- Device size: iPhone SE (375x667)
- Theme: Light mode

### Dependencies

- `golden_toolkit: ^0.15.0`

---

## Testing Deep Links on iOS

### Using Simulator

```bash
xcrun simctl openurl booted "myapp://conference/c1"
```

### Using Terminal (Device)

```bash
xcrun simctl openurl <device-id> "myapp://conference/c1"
```

### Using Safari

Create an HTML page:
```html
<a href="myapp://conference/c1">Open Conference</a>
```

---

## Testing Notifications

### Requirements

1. Run on iOS device or simulator
2. Grant notification permissions
3. Add conference to schedule
4. Conference must start more than 10 minutes in future

### Viewing Scheduled Notifications

Use `NotificationService.getPendingNotifications()` for debugging.

---

## Architecture Notes

### Deep Links
- Handled at router level via `GoRouter.redirect`
- No additional state management required
- Works seamlessly with existing navigation

### Notifications
- Service registered in DI container
- Commands follow existing command pattern
- Integrated with existing resource management

### Golden Tests
- Use `golden_toolkit` for consistent rendering
- Mock resources/providers as needed
- Run in CI/CD for visual regression detection

---

## Known Limitations

1. **Notifications**: iOS only (intentional design)
2. **Timezone**: Uses device local timezone
3. **Golden Tests**: Single device size and theme tested
4. **Deep Links**: Requires app to be installed

---

## Future Enhancements

Potential improvements:
- [ ] Multiple notification intervals (30min, 1hr)
- [ ] Custom notification sounds
- [ ] Deep link analytics
- [ ] Dark mode golden tests
- [ ] Multiple device size golden tests
- [ ] Android notification support

---

## Troubleshooting

### Deep Links Not Working
1. Check Info.plist configuration
2. Verify URL scheme matches `myapp`
3. Reinstall app after Info.plist changes

### Notifications Not Appearing
1. Check permissions granted
2. Verify conference time is in future (>10min)
3. Check iOS notification settings
4. Ensure device not in Do Not Disturb

### Golden Tests Failing
1. Run `flutter test --update-goldens` to regenerate
2. Check font loading in `flutter_test_config.dart`
3. Verify device size consistency
4. Check for platform-specific rendering differences

---

## Code References

### Deep Links
- `ios/Runner/Info.plist` - iOS URL scheme config
- `lib/app_router.dart` - Deep link handling
- `lib/ui_conferences/ui_conference_details_screen.dart` - Data loading

### Notifications
- `lib/services/notification_service.dart` - Core service
- `lib/data_commands/low/conference/schedule_conference_notification.cmd.dart`
- `lib/data_commands/low/conference/cancel_conference_notification.cmd.dart`
- `lib/di/di.dart` - Service registration

### Golden Tests
- `test/flutter_test_config.dart` - Test configuration
- `test/golden/*.dart` - Individual screen tests
- `test/golden/goldens/` - Generated golden images

---

**Last Updated:** October 2025
**Platform:** iOS only (Deep Links work cross-platform, Notifications iOS-specific)

