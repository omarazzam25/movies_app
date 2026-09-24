import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/config/routes/app_routes_name.dart';
import 'package:movies_app/core/config/them/app_color.dart';
import 'package:movies_app/core/config/them/text_them.dart';
import 'package:movies_app/core/service/snack_bar.dart';
import 'package:movies_app/core/utils/firebase_auth_service.dart';
import 'package:movies_app/core/utils/firebase_utils.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/feature/layout/profile/presentation/history_view.dart';
import 'package:movies_app/feature/layout/profile/presentation/watch_list_view.dart';
import 'package:movies_app/main.dart';

import '../../../../core/api/model/inner_classes/movie.dart';
import '../../../../core/api/model/my_user.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return const Scaffold(
        body: Center(
          child: Text('Please login first'),
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              FutureBuilder<MyUser?>(
                future: FirebaseUtils.readUserFromFireStore(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primary,
                      ),
                    );
                  }

                  final user = snapshot.data;


                  return Container(
                    width: double.infinity,
                    color: const Color(0xff212121),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;

                        final avatarRadius =
                        (width * 0.14).clamp(42.0, 55.0);

                        final numberSize =
                        (width * 0.09).clamp(28.0, 36.0);

                        final titleSize =
                        (width * 0.055).clamp(18.0, 24.0);

                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [

                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: avatarRadius,
                                        backgroundImage:
                                        const AssetImage(
                                           'assets/images/gamer_profile .png',
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          user?.name ?? 'User',
                                          maxLines: 1,
                                          style: TextThem
                                              .robotoBold20White,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                                Expanded(
                                  child: StreamBuilder<
                                      QuerySnapshot<Movie>>(
                                    stream: FirebaseUtils
                                        .getWatchListMovies(userId),
                                    builder: (context, snapshot) {
                                      final count =
                                          snapshot.data?.docs.length ?? 0;

                                      return Column(
                                        children: [
                                          Text(
                                            '$count',
                                            style: TextThem
                                                .robotoBold36White
                                                .copyWith(
                                              fontSize: numberSize,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'Wish List',
                                              style: TextThem
                                                  .robotoBold24White
                                                  .copyWith(
                                                fontSize: titleSize,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),


                                Expanded(
                                  child: StreamBuilder<
                                      QuerySnapshot<Movie>>(
                                    stream: FirebaseUtils
                                        .getHistoryMovies(userId),
                                    builder: (context, snapshot) {
                                      final count =
                                          snapshot.data?.docs.length ?? 0;

                                      return Column(
                                        children: [
                                          Text(
                                            '$count',
                                            style: TextThem
                                                .robotoBold36White
                                                .copyWith(
                                              fontSize: numberSize,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'History',
                                              style: TextThem
                                                  .robotoBold24White
                                                  .copyWith(
                                                fontSize: titleSize,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
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
                                        AppRoutesName.editProfile,arguments: user
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: CustomButton(
                                    text: 'Exit',
                                    titleColor:
                                    TextThem.robotoRegular20White,
                                    background: AppColor.redColor,
                                    rightIcon: const Icon(
                                      Icons.login_outlined,
                                      color: AppColor.whiteColor,
                                    ),
                                    onTap: () async {
                                      final success =
                                      await FirebaseAuthService
                                          .signOut();

                                      if (success) {
                                        SnackBarHelper
                                            .showSuccessSnackBar(
                                          'Logout Success',
                                        );

                                        navigatorKey.currentState
                                            ?.pushNamedAndRemoveUntil(
                                          AppRoutesName.login,
                                              (route) => false,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            TabBar(
                              dividerHeight: 0,
                              labelColor: AppColor.primary,
                              unselectedLabelColor:
                              AppColor.whiteColor,
                              indicatorColor: AppColor.primary,
                              indicatorSize:
                              TabBarIndicatorSize.tab,
                              overlayColor:
                              WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                              tabs: [
                                Tab(
                                  icon: SvgPicture.asset(
                                    'assets/icons/list.svg',
                                    width: 26,
                                    height: 26,
                                  ),
                                  text: 'Watch List',
                                ),
                                Tab(
                                  icon: SvgPicture.asset(
                                    'assets/icons/folder.svg',
                                    width: 26,
                                    height: 26,
                                  ),
                                  text: 'History',
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),

              const Expanded(
                child: TabBarView(
                  children: [
                    WatchListView(),
                    HistoryView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}