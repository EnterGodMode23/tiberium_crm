import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';

@RoutePage()
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) => AutoTabsScaffold(
        routes: const [
          ScheduleRoute(),
          HomeRoute(),
          ProfileRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) => BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              label: 'Schedule',
              icon: Icon(Icons.calendar_month_outlined),
              activeIcon: Icon(
                Icons.calendar_month,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person_2_outlined),
              activeIcon: Icon(
                Icons.person_2_rounded,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
}
