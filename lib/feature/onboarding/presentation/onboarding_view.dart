import 'package:flutter/material.dart';
import 'package:movies_app/core/config/routes/app_routes_name.dart';
import 'package:movies_app/main.dart';
import '../../../core/config/them/app_color.dart';
import '../../../core/config/them/screen_size.dart';
import '../../../core/config/them/text_them.dart';
import '../widgets/onboarding_button.dart';



class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController controller =  PageController();
  int currentIndex = 0;

  final List<Color> gradientColors = [
    AppColor.blackGradientTop,
    AppColor.cyanGradiantColor,
    AppColor.orangeGradiantColor,
    AppColor.purpleGradiantColor,
    AppColor.redGradiantColor,
    AppColor.blackGradiantColor,
  ];

  @override
  void initState() {
    controller.addListener(() {
      currentIndex = controller.page!.toInt();
    },);
    setState(() {
      super.initState();
    });


  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> pages = [
    {
      "image": 'assets/images/onboarding_image1.png',
      "title": "Find Your Next Favorite Movie Here",
      "subtitle":
      "Get access to a huge library of movies to suit all tastes. You will surely like it.",
    },
    {
      "image": 'assets/images/onboarding_image2.png',
      "title": "Discover Movies",
      "subtitle":
      "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
    },
    {
      "image": 'assets/images/onboarding_image3.png',
      "title": "Explore All Genres",
      "subtitle":
      "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    },
    {
      "image": 'assets/images/onboarding_image4.png',
      "title": "Create Watchlists",
      "subtitle":
      "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
    },
    {
      "image": 'assets/images/onboarding_image5.png',
      "title": "Rate, Review, and Learn",
      "subtitle":
      "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    },
    {
      "image": 'assets/images/onboarding_image6.png',
      "title": "Start Watching Now",
    },
  ];

  void nextPage() {
    if (currentIndex < pages.length - 1) {
      controller.nextPage(
        duration:  Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      controller.previousPage(
        duration:  Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }


  void finishOnboarding()  {
    navigatorKey.currentState?.pushReplacementNamed(AppRoutesName.login);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: controller,
          itemCount: pages.length,
          onPageChanged: (index) {
            currentIndex = index;
            setState(() {

            });
          },
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    pages[index]["image"],
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.transparentColor,
                          gradientColors[index],
                        ],
                        stops:[0, 1.0],
                      ),
                    ),
                  ),
                ),

                //todo : first page only
                index == 0 ?
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: context.width * 0.01,
                      vertical:context.height * 0.05 ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        pages[index]["title"]!,
                        style: TextThem.interMedium36White,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: context.height * 0.01),
                      Text(
                        pages[index]["subtitle"]!,
                        style: TextThem.interRegular20White,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: context.height * 0.02),
                      OnboardinButtonWidget(
                        text: "Explore Now",
                        onPressed: nextPage,
                      ),
                    ],
                  ),
                )
                    : //todo : other pages
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: context.width,
                    padding:  EdgeInsets.symmetric(
                        horizontal: context.width * 0.06,
                        vertical:  context.height * 0.04),
                    decoration:  BoxDecoration(
                        color: AppColor.blackColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)
                        )
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            pages[index]["title"],
                            textAlign: TextAlign.center,
                            style: TextThem.interBold24white
                        ),
                        SizedBox(height: context.height * 0.02),
                        pages[index]["subtitle"] != null ? Text(
                            pages[index]["subtitle"],
                            textAlign: TextAlign.center,
                            style: TextThem.interRegular16White
                        ):SizedBox(),
                        SizedBox(height: context.height * 0.02),

                        if (index == pages.length - 1)
                          Column(
                            children: [
                              OnboardinButtonWidget(
                                text: "Finish",
                                onPressed: finishOnboarding,
                              ),
                              SizedBox(height: context.height * 0.01),
                              OnboardinButtonWidget(
                                text: "Back",
                                isOutlined: true,
                                onPressed: previousPage,
                              ),
                            ],
                          )
                        else if (index == 1)
                          OnboardinButtonWidget(
                            text: "Next",
                            onPressed: nextPage,
                          )
                        else
                          Column(
                            children: [
                              OnboardinButtonWidget(
                                text: "Next",
                                onPressed: nextPage,
                              ),
                              SizedBox(height: 12),
                              OnboardinButtonWidget(
                                text: "Back",
                                isOutlined: true,
                                onPressed: previousPage,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}