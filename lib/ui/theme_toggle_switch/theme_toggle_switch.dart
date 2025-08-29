import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digitalsaathi/provider/theme_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ThemeToggleSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ToggleSwitch(
        minWidth: 55.0,
        minHeight: 30,
        cornerRadius: 20.0,
        activeBgColors: const [
          [ColorUtils.primaryColor],
          [ColorUtils.primaryColor]
        ],
        activeFgColor:themeProvider.darkTheme ?  ColorUtils.colorBlack: ColorUtils.colorWhite,
        inactiveBgColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
        inactiveFgColor:themeProvider.darkTheme ?  ColorUtils.colorBlack: ColorUtils.colorWhite,
        initialLabelIndex: themeProvider.darkTheme ? 0 : 1,
        totalSwitches: 2,
        labels: const ['Dark', 'Light'],
        radiusStyle: true,
        onToggle: (index) {
          themeProvider.darkTheme = index == 0; // 0 for Dark, 1 for Light
          print('switched to: $index');
        },
      ),
    );
  }
}
