import 'package:about_worldskills/pages/about_page.dart';
import 'package:about_worldskills/pages/photos_page.dart';
import 'package:about_worldskills/pages/skills_page.dart';
import 'package:about_worldskills/pages/statistic_page.dart';
import 'package:about_worldskills/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';

class PageProvider extends GetxController {
  final selectedPage = 0.obs;

  final Rx<PageController> pageController = PageController(initialPage: 0).obs;

  Widget get getSelectedPage {
    if (selectedPage.value == 0) return const WelcomePage();
    if (selectedPage.value == 1) return const AboutPage();
    if (selectedPage.value == 2) return const StatisticPage();
    if (selectedPage.value == 3) return const PhotosPage();
    if (selectedPage.value == 4) return const SkillsPage();
    return const WelcomePage();
  }

  void toPage(int index) {
    pageController.value.animateToPage(
      index,
      duration: 500.milliseconds,
      curve: Curves.easeIn,
    );
    selectedPage.value = index;
  }
}
