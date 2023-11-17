import 'package:drinks_app/core/utils/colors.dart';
import 'package:drinks_app/presentation/screens/auth_screens/register_screen.dart';
import 'package:drinks_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/cache_helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  bool isLast = false;

  List pageImages = [
    [
      "assets/images/part_orange.png",
      "assets/images/orange.png",
    ],
    ["assets/images/mangoo.png", "assets/images/ananas.png"],
    ["assets/images/Pineapple.png", "assets/images/coconut.png"],
  ];

  void submit() {
    CacheHelper.saveData(
      key: "onBoarding",
      value: true,
    ).then((value) {
      if (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterScreen(),
          ),
        );
      }
    }).catchError((e) {
      print('error message');
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16,),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () => submit(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text("Skip"),
                ),
                const SizedBox(width: 16,)
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: 3,
                itemBuilder: (context, index) =>
                    ViewPageItem(images: pageImages[index]),
                onPageChanged: (index) {
                  if (index == pageImages.length - 1)
                    setState(() {
                      isLast = true;
                    });
                  else
                    setState(() {
                      isLast = false;
                    });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isLast) {
            submit();
          } else {
            setState(() {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.bounceOut);
            });
          }
        },
        backgroundColor: AppColors.yellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            child: SvgPicture.asset(
              "assets/images/arrow_forward.svg",
              width: 48,
              colorFilter:
                  const ColorFilter.mode(AppColors.green, BlendMode.srcATop),
            ),
          ),
        ),
      ),
    );
  }
}

class ViewPageItem extends StatelessWidget {
  final List<String> images;

  const ViewPageItem({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackGroundItem(),
        Transform(
          transform: Matrix4.identity()
            ..translate(0.0, 0.0)
            ..rotateZ(-0.03),
          child: Container(
            width: 249,
            height: 249,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(images[0]),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 500,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bottel.png")
              )
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Transform.translate(
            offset: const Offset(-10.0, -10.0),
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(images[1]),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BackGroundItem extends StatelessWidget {
  const BackGroundItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.red,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(100.0, 10.0)
                ..rotateZ(0),
              child: Container(
                width: 520,
                height: 280,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/leafes.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Transform(
              transform: Matrix4.identity()..translate(100.0, 0.0)..rotateZ(-.9),
              child: Container(
                width: 198.16,
                height: 140.58,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/leafes_two.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Transform.translate(
              offset: const Offset(-150.0, -40.0),
              child: Container(
                width: 543,
                height: 387,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/leafes_three.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
