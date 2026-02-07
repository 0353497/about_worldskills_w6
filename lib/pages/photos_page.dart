import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  @override
  Widget build(BuildContext context) {
    const double layoutSpacing = 8;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(),
          Text(
            "Photos",
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
            child: Row(
              spacing: layoutSpacing,
              children: [
                Expanded(
                  child: Column(
                    spacing: layoutSpacing,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          spacing: layoutSpacing,
                          children: [
                            Expanded(
                              child: Column(
                                spacing: layoutSpacing,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showImage("assets/images/photo-3.jpg");
                                      },
                                      child: Hero(
                                        tag: "assets/images/photo-3.jpg",
                                        child: Image.asset(
                                          "assets/images/photo-3.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showImage("assets/images/photo-5.jpg");
                                      },
                                      child: Hero(
                                        tag: "assets/images/photo-5.jpg",
                                        child: Image.asset(
                                          "assets/images/photo-5.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                spacing: layoutSpacing,

                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showImage("assets/images/photo-4.jpg");
                                      },
                                      child: Hero(
                                        tag: "assets/images/photo-4.jpg",
                                        child: Image.asset(
                                          "assets/images/photo-4.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showImage("assets/images/photo-6.jpg");
                                      },
                                      child: Hero(
                                        tag: "assets/images/photo-6.jpg",
                                        child: Image.asset(
                                          "assets/images/photo-6.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            showImage("assets/images/photo-2.jpg");
                          },
                          child: Hero(
                            tag: "assets/images/photo-2.jpg",
                            child: Image.asset(
                              width: double.maxFinite,
                              "assets/images/photo-2.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: layoutSpacing,
                    children: [
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            showImage("assets/images/photo-1.jpg");
                          },
                          child: Hero(
                            tag: "assets/images/photo-1.jpg",
                            child: Image.asset(
                              "assets/images/photo-1.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          spacing: layoutSpacing,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showImage("assets/images/photo-7.jpg");
                                },
                                child: Hero(
                                  tag: "assets/images/photo-7.jpg",
                                  child: Image.asset(
                                    height: double.maxFinite,
                                    "assets/images/photo-7.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showImage("assets/images/photo-8.jpg");
                                },
                                child: Hero(
                                  tag: "assets/images/photo-8.jpg",
                                  child: Image.asset(
                                    height: double.maxFinite,
                                    "assets/images/photo-8.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showImage(String image) {
    return Get.dialog(
      transitionDuration: 500.milliseconds,
      SizedBox(
        width: Get.width - 100,
        height: Get.height - 200,
        child: Dialog(
          child: Stack(
            children: [
              Positioned.fill(
                child: Hero(
                  tag: image,
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
              ),
              Align(
                alignment: Alignment(1, -1),
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
