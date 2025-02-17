import 'package:auto_route/auto_route.dart';
import 'package:tiberium_crm/features/home/home_screen.dart';
import 'package:tiberium_crm/features/profile/profile_screen.dart';
import 'package:tiberium_crm/features/schedule/schedule_screen.dart';
import 'package:tiberium_crm/features/schedule/widgets/harvest_task_page.dart';
import 'package:tiberium_crm/features/schedule/widgets/processing_task_page.dart';
import 'package:tiberium_crm/features/schedule/widgets/new_task_page.dart';
import 'package:tiberium_crm/features/schedule/widgets/new_plan_page.dart';
import 'package:tiberium_crm/features/splash/splash_screen.dart';
import 'package:tiberium_crm/features/auth/auth_screen.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task.dart';
import 'package:tiberium_crm/data/models/tasks/main_task.dart';
import 'package:tiberium_crm/data/models/tasks/processing_task.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/features/schedule/widgets/main_task_page.dart';

import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType {
    return const RouteType.adaptive();
  }

  @override
  List<AutoRoute> get routes => [
        AdaptiveRoute(
          path: '/auth',
          page: AuthRoute.page,
        ),
        AdaptiveRoute(
          page: RootRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: ProfileRoute.page),
            AutoRoute(page: ScheduleRoute.page),
          ],
        ),
        AdaptiveRoute(page: HarvestTaskRoute.page),
        AdaptiveRoute(page: NewTaskRoute.page),
        AdaptiveRoute(page: NewPlanRoute.page),
        AdaptiveRoute(page: ProcessingTaskRoute.page),
        AdaptiveRoute(page: MainTaskRoute.page),
      ];
}
