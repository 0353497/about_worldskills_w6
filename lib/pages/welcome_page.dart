import 'package:about_worldskills/providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  bool _startalpha = false;
  bool _startIcon = false;
  final provider = Get.find<PageProvider>();

  late AnimationController iconController;

  @override
  void initState() {
    super.initState();
    iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    iconController.repeat(reverse: true);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _startalpha = true);
    });
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) setState(() => _startIcon = true);
    });
  }

  @override
  void dispose() {
    iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Tween<double> apha = Tween(begin: 0, end: _startalpha ? 255 : 0);
    final Tween<double> lampTransform = Tween(begin: -0.3, end: 0);
    final iconTransform = Tween(
      begin: -12.0,
      end: 12.0,
    ).animate(CurvedAnimation(parent: iconController, curve: Curves.easeInOut));

    return TweenAnimationBuilder(
      tween: apha,
      duration: 1.seconds,
      builder: (context, alphaValue, child) {
        return Stack(
          children: [
            Container(color: const Color(0xffe90267)),
            Transform.translate(
              offset: const Offset(0, 40),
              child: ClipPath(
                clipper: TriangleClip(),
                child: Container(
                  color: Colors.white.withAlpha(alphaValue.toInt()),
                ),
              ),
            ),
            TweenAnimationBuilder(
              tween: lampTransform,
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Align(
                  alignment: Alignment(0, -1 + value),
                  child: Image.asset("assets/images/lamp.png", width: 110),
                );
              },
            ),
            Opacity(
              opacity: alphaValue / 255,
              child: Align(
                alignment: Alignment(0, -.35),
                child: Text(
                  "Master Skills \n Change the World",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Opacity(
              opacity: alphaValue / 255,
              child: Align(
                alignment: Alignment(0, .5),
                child: Image.asset(
                  "assets/images/world-map.png",
                  width: Get.width / 2,
                ),
              ),
            ),
            if (_startIcon)
              AnimatedBuilder(
                animation: iconTransform,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment(0, .8),
                    child: IconButton(
                      onPressed: () {
                        provider.toPage(1);
                      },
                      icon: Transform.translate(
                        offset: Offset(0, iconTransform.value),
                        child: Icon(Icons.arrow_downward),
                      ),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class TriangleClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    int addAngle = 100;
    path.addPolygon([
      Offset(-addAngle.toDouble(), size.height),
      Offset(size.width / 2, 0),
      Offset(size.width + addAngle, size.height),
    ], true);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
