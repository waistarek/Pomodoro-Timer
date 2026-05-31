import 'package:flutter/material.dart';





class AppSettings {
  const AppSettings({
    this.workMinutes = 25,
    this.shortBreakMinutes = 5,
    this.longBreakMinutes = 15,
    this.longBreakAfter = 4,
    this.autoStart = false,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.theme = 'system',
    this.colorName = 'red',
  });

  final int workMinutes;
  final int shortBreakMinutes;
  final int longBreakMinutes;
  final int longBreakAfter;
  final bool autoStart;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final String theme;
  final String colorName;

  ThemeMode get themeMode {
    switch (theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  Color get themeColor {
    switch (colorName) {
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'purple':
        return Colors.deepPurple;
      default:
        return Colors.red;
    }
  }


    @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is AppSettings &&
        other.workMinutes == workMinutes &&
        other.shortBreakMinutes == shortBreakMinutes &&
        other.longBreakMinutes == longBreakMinutes &&
        other.longBreakAfter == longBreakAfter &&
        other.autoStart == autoStart &&
        other.soundEnabled == soundEnabled &&
        other.vibrationEnabled == vibrationEnabled &&
        other.theme == theme &&
        other.colorName == colorName;
  }

  @override
  int get hashCode {
    return Object.hash(
      workMinutes,
      shortBreakMinutes,
      longBreakMinutes,
      longBreakAfter,
      autoStart,
      soundEnabled,
      vibrationEnabled,
      theme,
      colorName,
    );
  }
  AppSettings copyWith({
    int? workMinutes,
    int? shortBreakMinutes,
    int? longBreakMinutes,
    int? longBreakAfter,
    bool? autoStart,
    bool? soundEnabled,
    bool? vibrationEnabled,
    String? theme,
    String? colorName,
  }) {
    return AppSettings(
      workMinutes: workMinutes ?? this.workMinutes,
      shortBreakMinutes: shortBreakMinutes ?? this.shortBreakMinutes,
      longBreakMinutes: longBreakMinutes ?? this.longBreakMinutes,
      longBreakAfter: longBreakAfter ?? this.longBreakAfter,
      autoStart: autoStart ?? this.autoStart,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      theme: theme ?? this.theme,
      colorName: colorName ?? this.colorName,
    );
  }

  Map<String, dynamic> toJson() => {
        'work_minutes': workMinutes,
        'short_break_minutes': shortBreakMinutes,
        'long_break_minutes': longBreakMinutes,
        'long_break_after': longBreakAfter,
        'auto_start': autoStart,
        'sound_enabled': soundEnabled,
        'vibration_enabled': vibrationEnabled,
        'theme': theme,
        'color_name': colorName,
      };

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      workMinutes: json['work_minutes'] ?? 25,
      shortBreakMinutes: json['short_break_minutes'] ?? 5,
      longBreakMinutes: json['long_break_minutes'] ?? 15,
      longBreakAfter: json['long_break_after'] ?? 4,
      autoStart: json['auto_start'] ?? false,
      soundEnabled: json['sound_enabled'] ?? true,
      vibrationEnabled: json['vibration_enabled'] ?? true,
      theme: json['theme'] ?? 'system',
      colorName: json['color_name'] ?? 'red',
    );
  }
}
