import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:test_fl_kanban/constants/Locales.dart';
import 'package:test_fl_kanban/l10n/messages_all.dart';

// flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/localizations/MainLocalizations.dart
// flutter pub run intl_translation:generate_from_arb \ --output-dir=lib/l10n --no-use-deferred-loading \ lib/main.dart lib/l10n/intl_en.arb lib/l10n/intl_ru.arb lib/localizations/MainLocalizations.dart

class MainLocalizations {
  static Locale locale = Locales.en;
  static Future<MainLocalizations> load(Locale locale) {
    final String name = locale.countryCode == null || locale.countryCode.isEmpty
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;

      return MainLocalizations();
    });
  }

  static MainLocalizations of(BuildContext context) {
    return Localizations.of<MainLocalizations>(context, MainLocalizations);
  }

  String get enterYourUsername {
    return Intl.message('Enter your username', name: 'enterYourUsername');
  }

  String get enterYourPassword {
    return Intl.message('Enter your password', name: 'enterYourPassword');
  }

  String get login {
    return Intl.message('Log in', name: 'login');
  }

  String get passwordValidationMessage {
    return Intl.message('Minimum is 8 characters',
        name: 'passwordValidationMessage');
  }

  String get usernameValidationMessage {
    return Intl.message('Minimum is 4 characters',
        name: 'usernameValidationMessage');
  }
}

class MainLocalizationsDelegate
    extends LocalizationsDelegate<MainLocalizations> {
  final Locale overridenLocale;

  const MainLocalizationsDelegate(this.overridenLocale);

  @override
  bool isSupported(Locale locale) =>
      locale != null ? Languages.all.contains(locale.languageCode) : false;

  @override
  Future<MainLocalizations> load(Locale locale) =>
      MainLocalizations.load(locale);

  @override
  bool shouldReload(MainLocalizationsDelegate old) => false;
}
