import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptery/l10n/support_locale.dart';


class LanguageController extends GetxController{
  final Rx<Locale?> _lang = Rx<Locale?>(null);
  Locale? get lang => _lang.value;

  void setLocale(Locale loc) {
    if (!L10n.support.contains(loc)) return;
    _lang.value = loc;
    Get.updateLocale(loc); //change application language globally, relooad all translated string 
  }

  void clearLocale() {
    _lang.value = null;
    Get.updateLocale(Get.deviceLocale ?? const Locale('en', '')); 
  }

}