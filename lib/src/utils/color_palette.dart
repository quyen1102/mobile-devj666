import 'dart:ui';

import 'package:dynamic_system_colors/dynamic_system_colors.dart';
import 'package:flutter/material.dart' show ColorScheme;
import 'package:material_color_utilities/material_color_utilities.dart';

typedef ColorSchemes = ({ColorScheme light, ColorScheme dark});

ColorSchemes? _dynamicColorSchemes;

// TODO migrate
// ignore_for_file: deprecated_member_use
CorePalette? _corePalette;

/// Set the system core palette if available (android 12+ only).
void setSystemColors(CorePalette? palette, ColorSchemes? schemes) {
  _corePalette ??= palette;
  _dynamicColorSchemes ??= schemes;

  if (palette != null) {
    _dynamicColorSchemes ??= (
      light: palette.toColorScheme(),
      dark: palette.toColorScheme(brightness: Brightness.dark),
    );
  }
}

/// Get the core palette if available (android 12+ only).
CorePalette? getCorePalette() {
  return _corePalette;
}

/// Get the system color schemes based on the core palette, if available (android 12+).
ColorSchemes? getDynamicColorSchemes() {
  return _dynamicColorSchemes;
}
