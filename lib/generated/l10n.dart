// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `imperial`
  String get units {
    return Intl.message(
      'imperial',
      name: 'units',
      desc: '',
      args: [],
    );
  }

  /// `en`
  String get language {
    return Intl.message(
      'en',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `F`
  String get temp_units {
    return Intl.message(
      'F',
      name: 'temp_units',
      desc: '',
      args: [],
    );
  }

  /// `Feels like `
  String get feels_like {
    return Intl.message(
      'Feels like ',
      name: 'feels_like',
      desc: '',
      args: [],
    );
  }

  /// `Updated`
  String get updated {
    return Intl.message(
      'Updated',
      name: 'updated',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection. Last update:`
  String get internet_connection_error {
    return Intl.message(
      'No internet connection. Last update:',
      name: 'internet_connection_error',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get minutes {
    return Intl.message(
      'min',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `d`
  String get days {
    return Intl.message(
      'd',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `h`
  String get hours {
    return Intl.message(
      'h',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Enter city name`
  String get enter_city_name {
    return Intl.message(
      'Enter city name',
      name: 'enter_city_name',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Jan`
  String get jan {
    return Intl.message(
      'Jan',
      name: 'jan',
      desc: '',
      args: [],
    );
  }

  /// `Feb`
  String get feb {
    return Intl.message(
      'Feb',
      name: 'feb',
      desc: '',
      args: [],
    );
  }

  /// `Mar`
  String get mar {
    return Intl.message(
      'Mar',
      name: 'mar',
      desc: '',
      args: [],
    );
  }

  /// `Apr`
  String get apr {
    return Intl.message(
      'Apr',
      name: 'apr',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get may {
    return Intl.message(
      'May',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `Jun`
  String get jun {
    return Intl.message(
      'Jun',
      name: 'jun',
      desc: '',
      args: [],
    );
  }

  /// `Jul`
  String get jul {
    return Intl.message(
      'Jul',
      name: 'jul',
      desc: '',
      args: [],
    );
  }

  /// `Aug`
  String get aug {
    return Intl.message(
      'Aug',
      name: 'aug',
      desc: '',
      args: [],
    );
  }

  /// `Sep`
  String get sep {
    return Intl.message(
      'Sep',
      name: 'sep',
      desc: '',
      args: [],
    );
  }

  /// `Oct`
  String get oct {
    return Intl.message(
      'Oct',
      name: 'oct',
      desc: '',
      args: [],
    );
  }

  /// `Nov`
  String get nov {
    return Intl.message(
      'Nov',
      name: 'nov',
      desc: '',
      args: [],
    );
  }

  /// `Dec`
  String get dec {
    return Intl.message(
      'Dec',
      name: 'dec',
      desc: '',
      args: [],
    );
  }

  /// `Location permission denied`
  String get location_permission_denied {
    return Intl.message(
      'Location permission denied',
      name: 'location_permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `Please enable location access in the settings.`
  String get location_permission_denied_content {
    return Intl.message(
      'Please enable location access in the settings.',
      name: 'location_permission_denied_content',
      desc: '',
      args: [],
    );
  }

  /// `No results found for`
  String get search_result_null {
    return Intl.message(
      'No results found for',
      name: 'search_result_null',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
