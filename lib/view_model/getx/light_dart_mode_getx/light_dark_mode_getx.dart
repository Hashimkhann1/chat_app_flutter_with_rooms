


import 'package:get/get.dart';

class LightAndDarkModeGetx extends GetxController {

  RxBool isLightOrDark = false.obs;

  setLightOrDarkMode() {
    isLightOrDark.value = !isLightOrDark.value;
  }

}