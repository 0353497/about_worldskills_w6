import 'package:about_worldskills/services/json_reader.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  int _currentIndex = 0;
  late final Future<List<dynamic>> _skillsFuture;

  @override
  void initState() {
    super.initState();
    _skillsFuture = JsonReader.readSkills();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(),
          Text(
            "Skills",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
          ),
          Container(
            width: 20,
            height: 4,
            decoration: BoxDecoration(
              color: Color(0xffdd0a76),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _skillsFuture,
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Waiting"));
                }
                if (!asyncSnapshot.hasData) return Text("no data");
                final skills = asyncSnapshot.data!;
                final canGoPrev = _currentIndex > 0;
                final canGoNext = _currentIndex < skills.length - 1;
                return Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height / 1.4,
                      width: double.maxFinite,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        children: skills
                            .asMap()
                            .entries
                            .map(
                              (entry) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: CarouselSkills(
                                  image:
                                      "assets/images/${entry.value["image"]}",
                                  title: entry.value["skill"],
                                  description: entry.value["description"],
                                  isActive: entry.key == _currentIndex,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 12,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 12,
                          children: [
                            for (int i = 0; i < skills.length; i++)
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: i == _currentIndex
                                      ? Color(0xffd52068)
                                      : Color(0xfff2a3c3),
                                ),
                              ),
                          ],
                        ),
                        IconButton.outlined(
                          style: ButtonStyle(
                            side: WidgetStatePropertyAll(
                              BorderSide(width: 3, color: Color(0xffd52068)),
                            ),
                          ),
                          onPressed: canGoPrev
                              ? () {
                                  _pageController.previousPage(
                                    duration: 250.milliseconds,
                                    curve: Curves.easeOut,
                                  );
                                }
                              : null,
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xffd52068),
                          ),
                        ),
                        IconButton.outlined(
                          style: ButtonStyle(
                            side: WidgetStatePropertyAll(
                              BorderSide(width: 3, color: Color(0xffd52068)),
                            ),
                          ),
                          onPressed: canGoNext
                              ? () {
                                  _pageController.nextPage(
                                    duration: 250.milliseconds,
                                    curve: Curves.easeOut,
                                  );
                                }
                              : null,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffd52068),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselSkills extends StatelessWidget {
  const CarouselSkills({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.isActive,
  });
  final String image;
  final String title;
  final String description;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(image, fit: BoxFit.cover)),
        Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            width: Get.width / 3,
            height: Get.height / 3,
            child: Stack(
              children: [
                Container(
                  color: Color(0xffdd0a76),
                  width: Get.width / 3,
                  height: Get.height / 3,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            description,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/images/pattern.png",
                    height: Get.height / 8,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: isActive ? 0 : 1),
              duration: 500.milliseconds,
              curve: Curves.easeOut,
              builder: (context, value, child) {
                if (value == 0) return SizedBox();
                return Opacity(opacity: value, child: child);
              },
              child: Container(color: Colors.white60),
            ),
          ),
        ),
      ],
    );
  }
}
