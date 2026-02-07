import 'package:about_worldskills/pages/about_page.dart';
import 'package:about_worldskills/pages/photos_page.dart';
import 'package:about_worldskills/pages/skills_page.dart';
import 'package:about_worldskills/pages/statistic_page.dart';
import 'package:about_worldskills/providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final PageProvider provider = Get.find<PageProvider>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                spacing: 12,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Image.asset(
                      "assets/images/logo_pink.png",
                      height: Get.height / 6,
                    ),
                  ),
                  SizedBox(height: 64),
                  SelectableSidebarTile(
                    provider: provider,
                    text: "About",
                    tile: 0,
                  ),
                  SelectableSidebarTile(
                    provider: provider,
                    text: "Statistic",
                    tile: 1,
                  ),
                  SelectableSidebarTile(
                    provider: provider,
                    text: "Photos",
                    tile: 2,
                  ),
                  SelectableSidebarTile(
                    provider: provider,
                    text: "Skills",
                    tile: 3,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: PageView(
                onPageChanged: (value) {
                  provider.selectedPage.value = value;
                },
                scrollDirection: Axis.vertical,
                controller: provider.pageController.value,
                children: [
                  AboutPage(),
                  StatisticPage(),
                  PhotosPage(),
                  SkillsPage(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class SelectableSidebarTile extends StatelessWidget {
  const SelectableSidebarTile({
    super.key,
    required this.provider,
    required this.text,
    required this.tile,
  });
  final String text;
  final int tile;
  final PageProvider provider;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          provider.toPage(tile);
        },
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (provider.selectedPage.value == tile)
                Container(
                  width: 4,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xffd80d66),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              if (provider.selectedPage.value != tile) SizedBox(),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: provider.selectedPage.value == tile
                      ? FontWeight.bold
                      : null,
                ),
              ),
              SizedBox(),
            ],
          ),
        ),
      );
    });
  }
}
