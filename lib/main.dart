import 'package:about_worldskills/pages/about_page.dart';
import 'package:about_worldskills/pages/photos_page.dart';
import 'package:about_worldskills/pages/skills_page.dart';
import 'package:about_worldskills/pages/statistic_page.dart';
import 'package:about_worldskills/pages/welcome_page.dart';
import 'package:about_worldskills/providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put<PageProvider>(PageProvider());
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final PageProvider provider = Get.find<PageProvider>();
  bool hasChangedView = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: "Frutiger"),
      home: Obx(() {
        return Scaffold(
          body: Row(
            children: [
              if (hasChangedView)
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
                        tile: 1,
                      ),
                      SelectableSidebarTile(
                        provider: provider,
                        text: "Statistic",
                        tile: 2,
                      ),
                      SelectableSidebarTile(
                        provider: provider,
                        text: "Photos",
                        tile: 3,
                      ),
                      SelectableSidebarTile(
                        provider: provider,
                        text: "Skills",
                        tile: 4,
                      ),
                    ],
                  ),
                ),
              Expanded(
                flex: 5,
                child: PageView(
                  onPageChanged: (value) {
                    provider.selectedPage.value = value;
                    setState(() {
                      hasChangedView = true;
                    });
                  },
                  scrollDirection: Axis.vertical,
                  controller: provider.pageController.value,
                  children: [
                    if (!hasChangedView) WelcomePage(),
                    if (hasChangedView) SizedBox(),
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
      }),
    );
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
