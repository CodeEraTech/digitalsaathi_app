import 'dart:convert';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/ui/more/poster/poster_font_size_adjuster/FontSizeModel.dart';
import 'package:digitalsaathi/utils/prefrence/pref_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

// class FontSizeController extends GetxController {
//   RxDouble fontSizeName = 20.0.obs;
//   RxDouble fontSizeDesignation = 14.0.obs;
//
//   RxDouble tempFontSizeName = 20.0.obs;
//   RxDouble tempFontSizeDesignation = 14.0.obs;
//
//   RxBool isLoading = false.obs;
//   RxBool isEditing = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fontSizeName.value = PrefUtils.getFontSizeName();
//     fontSizeDesignation.value = PrefUtils.getFontSizeDesignation();
//
//     tempFontSizeName.value = fontSizeName.value;
//     tempFontSizeDesignation.value = fontSizeDesignation.value;
//   }
//
//   void increaseFontSizeName() {
//     if (tempFontSizeName.value < 25) {
//       tempFontSizeName.value++;
//       isEditing.value = true;
//     }
//   }
//
//   void decreaseFontSizeName() {
//     if (tempFontSizeName.value > 14) {
//       tempFontSizeName.value--;
//       isEditing.value = true;
//     }
//   }
//
//   void increaseFontSizeDesignation() {
//     if (tempFontSizeDesignation.value < 25) {
//       tempFontSizeDesignation.value++;
//       isEditing.value = true;
//     }
//   }
//
//   void decreaseFontSizeDesignation() {
//     if (tempFontSizeDesignation.value > 14) {
//       tempFontSizeDesignation.value--;
//       isEditing.value = true;
//     }
//   }
//
//   Future<void> saveFontSizeNameAndDesignation() async {
//     isLoading.value = true;
//
//     final data = {
//       'api_token': AppUrl.apiToken,
//       'primary_font_size': fontSizeName.value.toString(),
//       'secondry_font_size': fontSizeDesignation.value.toString(),
//     };
//
//     final response = await http.post(Uri.parse(AppUrl.submitFontSize), body: data);
//
//     if (response.statusCode == 200) {
//       final result = FontSizeModel.fromJson(jsonDecode(response.body));
//       if (result.statusCode == 200) {
//         fontSizeName.value = tempFontSizeName.value;
//         fontSizeDesignation.value = tempFontSizeDesignation.value;
//         PrefUtils.setFontSizeName(fontSizeName.value);
//         PrefUtils.setFontSizeDesignation(fontSizeDesignation.value);
//         isEditing.value = false;
//         EasyLoading.showSuccess(result.statusText ?? "Saved");
//         print("----------->GET Name Font Size :- ${PrefUtils.getFontSizeName()}");
//         print("----------->Get Designation Font Size :- ${PrefUtils.getFontSizeDesignation()}");
//       } else {
//         EasyLoading.showError(result.statusText ?? "Failed");
//       }
//     } else {
//       EasyLoading.showError("Server error ${response.statusCode}");
//     }
//   }
///
class FontSizeController extends GetxController {
  // Saved font sizes
  RxDouble fontSizeName = 20.0.obs;
  RxDouble fontSizeDesignation = 14.0.obs;

  // Temp font sizes for preview
  RxDouble tempFontSizeName = 20.0.obs;
  RxDouble tempFontSizeDesignation = 14.0.obs;

  RxBool isLoading = false.obs;
  RxBool isEditing = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved values or fallback to default
    fontSizeName.value = PrefUtils.getFontSizeName() ?? 20.0;
    fontSizeDesignation.value = PrefUtils.getFontSizeDesignation() ?? 14.0;

    tempFontSizeName.value = fontSizeName.value;
    tempFontSizeDesignation.value = fontSizeDesignation.value;
  }

  // Unified update method for temp values
  void _updateTempFontSize(RxDouble tempFontSize, double min, double max, bool increase) {
    if (increase && tempFontSize.value < max) {
      tempFontSize.value++;
      isEditing.value = true;
    } else if (!increase && tempFontSize.value > min) {
      tempFontSize.value--;
      isEditing.value = true;
    }
  }

  // Public methods to change temp font sizes
  void increaseFontSizeName() => _updateTempFontSize(tempFontSizeName, 14, 25, true);
  void decreaseFontSizeName() => _updateTempFontSize(tempFontSizeName, 14, 25, false);
  void increaseFontSizeDesignation() => _updateTempFontSize(tempFontSizeDesignation, 14, 25, true);
  void decreaseFontSizeDesignation() => _updateTempFontSize(tempFontSizeDesignation, 14, 25, false);

  // Save to server and local preferences
  Future<void> saveFontSizeNameAndDesignation() async {
    isLoading.value = true;

    final data = {
      'api_token': AppUrl.apiToken,
      'primary_font_size': tempFontSizeName.value.toString(),
      'secondry_font_size': tempFontSizeDesignation.value.toString(),
    };

    try {
      final response = await http.post(Uri.parse(AppUrl.submitFontSize), body: data);

      if (response.statusCode == 200) {
        final result = FontSizeModel.fromJson(jsonDecode(response.body));

        if (result.statusCode == 200) {
          // Save confirmed temp values
          fontSizeName.value = tempFontSizeName.value;
          fontSizeDesignation.value = tempFontSizeDesignation.value;

          // Save to local
          PrefUtils.setFontSizeName(fontSizeName.value);
          PrefUtils.setFontSizeDesignation(fontSizeDesignation.value);

          isEditing.value = false;
          EasyLoading.showSuccess(result.statusText ?? "Saved");
          print("Saved Name Font Size: ${PrefUtils.getFontSizeName()}");
          print("Saved Designation Font Size: ${PrefUtils.getFontSizeDesignation()}");
        } else {
          EasyLoading.showError(result.statusText ?? "Save failed");
        }
      } else {
        EasyLoading.showError("Server error: ${response.statusCode}");
      }
    } catch (e) {
      EasyLoading.showError("Network error");
      print("Error saving font sizes: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // UI display helpers
  String get displayFontSizeName => (isEditing.value ? tempFontSizeName.value : fontSizeName.value).toInt().toString();

  String get displayFontSizeDesignation => (isEditing.value ? tempFontSizeDesignation.value : fontSizeDesignation.value).toInt().toString();

  double get effectiveFontSizeName => isEditing.value ? tempFontSizeName.value : fontSizeName.value;

  double get effectiveFontSizeDesignation => isEditing.value ? tempFontSizeDesignation.value : fontSizeDesignation.value;


}