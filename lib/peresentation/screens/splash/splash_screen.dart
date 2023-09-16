import 'dart:async';
import '/peresentation/screens/home/home_screen.dart';
import '/peresentation/widgets/shared_widgets/header_image.dart';
import '/utilities/constants/colors.dart';
import '/utilities/constants/images.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'Splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Timer timer;
  late AnimationController _animationController;
  late Animation<double> _animation;

  goNext() => Navigator.pushReplacementNamed(context, HomeScreen.id);

  startDelay() {
    timer = Timer(const Duration(milliseconds: 4000), () => goNext());
  }

  @override
  void initState() {
    super.initState();
    startDelay();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Define the animation
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: const HeaderImage(),
                  );
                },
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(ImageConstants.sliderPic),
            ),
          ),
        ],
      ),
    );
  }
}
