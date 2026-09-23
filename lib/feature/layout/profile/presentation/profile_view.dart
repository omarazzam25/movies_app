import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/config/routes/app_routes_name.dart';
import 'package:movies_app/core/config/them/app_color.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/main.dart';
import '../../../../core/config/them/text_them.dart';
import '../../../../core/service/snack_bar.dart';
import '../../../../core/utils/firebase_auth_service.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xff212121),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  final avatarRadius = width < 360 ? 42.0 : 55.0;
                  final numberSize = width < 360 ? 28.0 : 36.0;
                  final titleSize = width < 360 ? 18.0 : 24.0;

                  return Column(
                    children: [

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: avatarRadius,
                                  backgroundImage: const AssetImage(
                                    'assets/images/gamer_profile .png',
                                  ),
                                ),
                                const SizedBox(height: 12),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'John Safwat',
                                    style: TextThem.robotoBold20White,
                                  ),
                                ),
                              ],
                            ),
                          ),


                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '12',
                                  style: TextThem.robotoBold36White.copyWith(
                                    fontSize: numberSize,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Wish List',
                                    style: TextThem.robotoBold24White.copyWith(
                                      fontSize: titleSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '12',
                                  style: TextThem.robotoBold36White.copyWith(
                                    fontSize: numberSize,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'History',
                                    style: TextThem.robotoBold24White.copyWith(
                                      fontSize: titleSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomButton(
                              text: 'Edit Profile',
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutesName.editProfile,
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: CustomButton(
                              onTap: () async {
                                final success =
                                await FirebaseAuthService.signOut();

                                if (success) {
                                  SnackBarHelper.showSuccessSnackBar(
                                    'Logout Success',
                                  );

                                  navigatorKey.currentState
                                      ?.pushNamedAndRemoveUntil(
                                    AppRoutesName.login,
                                        (route) => false,
                                  );
                                }
                              },

                              titleColor: TextThem.robotoRegular20White ,
                              text: 'Exit',
                              rightIcon: const Icon(
                                Icons.login_outlined,
                                color: AppColor.whiteColor,
                              ),
                              background: AppColor.redColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;

                          final iconSize = (width * 0.065).clamp(22.0, 28.0);
                          final verticalPadding = (width * 0.015).clamp(4.0, 7.0);

                          return DefaultTabController(
                            length: 2,
                            child: TabBar(
                              overlayColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                              dividerHeight: 0,
                              padding: EdgeInsets.zero,
                              labelStyle: TextThem.robotoRegular20White,
                              labelColor: AppColor.primary,
                              unselectedLabelColor: AppColor.whiteColor,
                              indicatorColor: AppColor.primary,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelPadding: EdgeInsets.symmetric(
                                vertical: verticalPadding,
                              ),
                              tabs: [
                                Tab(
                                  icon: SvgPicture.asset(
                                    'assets/icons/list.svg',
                                    width: iconSize,
                                    height: iconSize,
                                  ),
                                  text: 'Watch List',
                                ),
                                Tab(
                                  icon: SvgPicture.asset(
                                    'assets/icons/folder.svg',
                                    width: 30,
                                    height: 30,
                                  ),
                                  text: 'History',
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(),

              child: Image.asset(
                'assets/images/empty.png',
                width: 124,
                height: 124,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


