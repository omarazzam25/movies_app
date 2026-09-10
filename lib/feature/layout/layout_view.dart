import 'package:flutter/material.dart';
import 'package:movies_app/feature/layout/browse/presentation/browse_view.dart';
import 'package:movies_app/feature/layout/home/presentation/home_view.dart';
import 'package:movies_app/feature/layout/profile/presentation/profile_view.dart';
import 'package:movies_app/feature/layout/search/presentation/search_view.dart';
import 'package:movies_app/feature/layout/widgets/custom_bottom_navbar.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeView(),
    const SearchView(),
    const BrowseView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: SafeArea(
        child: CustomBottomNavBar(
            currentIndex: currentIndex,
            onTap: (index){
              currentIndex = index;
              setState(() {

              });
            }
            ),
      )

    );
  }
}
