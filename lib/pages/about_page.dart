import 'package:about_worldskills/services/json_reader.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int? _selectedIndex;
  late final Future<List<dynamic>> _aboutFuture;

  @override
  void initState() {
    super.initState();
    _aboutFuture = JsonReader.readAbout();
  }

  void _toggleSelection(int index) {
    setState(() {
      _selectedIndex = _selectedIndex == index ? null : index;
    });
  }

  Widget _buildPanel({
    required int index,
    required double width,
    required double height,
    required String imagePath,
    required Color overlayColor,
    required String label,
    required String labelDescription,
    Alignment? alignment,
    double? right,
  }) {
    final panel = SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.maxFinite,
            height: double.maxFinite,
          ),
          Positioned.fill(
            child: Container(
              color: overlayColor,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (index == _selectedIndex)
                      Text(
                        labelDescription,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final gesture = GestureDetector(
      onTap: () => _toggleSelection(index),
      child: panel,
    );

    if (alignment != null) {
      return Align(alignment: alignment, child: gesture);
    }

    if (right != null) {
      return Positioned(right: right, child: gesture);
    }

    return gesture;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _aboutFuture,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text("loading data"));
        }
        if (!asyncSnapshot.hasData) {
          return Center(child: Text("no data"));
        }

        final aboutItems = asyncSnapshot.data!;
        final panelImages = [
          "assets/images/inspire.jpg",
          "assets/images/develop.jpg",
          "assets/images/influence.jpg",
        ];
        final panelOverlays = [
          const Color.fromARGB(255, 5, 80, 140).withAlpha(170),
          Colors.deepPurple.withAlpha(100),
          const Color(0xafdd0a76),
        ];

        return LayoutBuilder(
          builder: (context, constraints) {
            final fullWidth = constraints.maxWidth;
            final fullHeight = constraints.maxHeight;
            final twoThirdsWidth = constraints.maxWidth / 3 * 2;
            final oneThirdWidth = constraints.maxWidth / 3;
            final halfHeight = constraints.maxHeight / 2;
            final selected = _selectedIndex;

            Rect panelRect(int index) {
              if (selected == index) {
                return Rect.fromLTWH(0, 0, fullWidth, fullHeight);
              }

              if (index == 0) {
                return Rect.fromLTWH(0, 0, twoThirdsWidth, halfHeight);
              }
              if (index == 1) {
                return Rect.fromLTWH(0, halfHeight, twoThirdsWidth, halfHeight);
              }
              return Rect.fromLTWH(
                twoThirdsWidth,
                0,
                oneThirdWidth,
                fullHeight,
              );
            }

            Widget panelWidget({
              required int index,
              required String imagePath,
              required Color overlayColor,
              required String label,
              required String labelDescription,
            }) {
              final rect = panelRect(index);
              final isHidden = selected != null && selected != index;

              return AnimatedPositioned(
                key: ValueKey(index),
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeInOutCubic,
                left: rect.left,
                top: rect.top,
                width: rect.width,
                height: rect.height,
                child: IgnorePointer(
                  ignoring: isHidden,
                  child: _buildPanel(
                    index: index,
                    width: rect.width,
                    height: rect.height,
                    imagePath: imagePath,
                    overlayColor: overlayColor,
                    labelDescription: labelDescription,
                    label: label,
                  ),
                ),
              );
            }

            final panelCount = [
              aboutItems.length,
              panelImages.length,
              panelOverlays.length,
            ].reduce((value, element) => value < element ? value : element);

            final panels = List.generate(panelCount, (index) {
              final item = aboutItems[index] as Map<String, dynamic>;
              final label = item["title"]?.toString() ?? "";
              final description = item["content"]?.toString() ?? "";
              return panelWidget(
                index: index,
                imagePath: panelImages[index],
                overlayColor: panelOverlays[index],
                label: label,
                labelDescription: description,
              );
            });

            if (selected != null && selected < panels.length) {
              final selectedPanel = panels.removeAt(selected);
              panels.add(selectedPanel);
            }
            return Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(),
                Text(
                  "About",
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
                Expanded(child: Stack(children: panels)),
              ],
            );
          },
        );
      },
    );
  }
}
