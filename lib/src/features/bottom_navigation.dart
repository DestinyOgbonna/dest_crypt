import 'package:dest_crypt/src/features/dashboard/presentation/dashboard.dart';

import 'package:dest_crypt/src/features/marketplace/market_place.dart';
import 'package:dest_crypt/src/features/profile/presentation/portfolio_screen.dart';
import 'package:dest_crypt/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _selectedIndex = 0;

  final List<Widget> _routes = [
    const DashboardScreen(),
    const MarketPlaceScreen(),
    const PortfolioRiskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _routes),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          backgroundColor: AppColors.containerColor,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.whiteColor,
          unselectedItemColor: AppColors.greyColor,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedLabelStyle: AppStyles.blackSemi13,
          unselectedLabelStyle: AppStyles.blackSemi13.copyWith(
            color: const Color.fromARGB(255, 123, 126, 131),
          ),
          elevation: 0,
          onTap: _onTap,
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                'assets/icons/home.png',
                height: 20,
                color: AppColors.whiteColor,
              ),
              icon: Image.asset(
                'assets/icons/home.png',
                height: 20,
                color: const Color.fromARGB(255, 123, 126, 131),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                'assets/icons/market.png',
                height: 20,
                color: AppColors.whiteColor,
              ),
              icon: Image.asset(
                'assets/icons/market.png',
                height: 20,
                color: Color.fromARGB(255, 123, 126, 131),
              ),
              label: 'Market',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                'assets/icons/user.png',
                height: 20,
                color: AppColors.whiteColor,
              ),
              icon: Image.asset(
                'assets/icons/user.png',
                height: 20,
                color: Color.fromARGB(255, 123, 126, 131),
              ),
              label: 'Portfolio',
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
