import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool _themeChange = Get.isDarkMode.obs;
  set themeChange(val) => this._themeChange.value = val;
  get themeChange => this._themeChange.value;
}
