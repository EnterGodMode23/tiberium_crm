import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:auto_route/auto_route.dart';
import 'package:tiberium_crm/features/profile/profile_screen.dart';
import 'package:tiberium_crm/features/profile/widgets/user_info.dart';
import 'package:tiberium_crm/features/profile/widgets/info_body.dart';
import 'package:tiberium_crm/data/models/user.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/infra/network/base/shared_prefs_keys.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'dart:convert';

@GenerateNiceMocks([
  MockSpec<SharedPreferences>(),
  MockSpec<StackRouter>(),
])
import 'profile_screen_test.mocks.dart';

void main() {
  late MockSharedPreferences mockStorage;
  late MockStackRouter mockRouter;
  late User testUser;

  setUp(() {
    mockStorage = MockSharedPreferences();
    mockRouter = MockStackRouter();
    
    testUser = User(
      uid: '123',
      phoneNumber: '+79001234567',
      role: Role.harvestManager,
      firstName: 'Test',
      lastName: 'User',
      created: '2024-03-14',
      updated: '2024-03-14',
    );

    // Setup GetIt
    GetIt.I.registerSingleton<SharedPreferences>(mockStorage);

    // Setup mock storage with correct key
    when(mockStorage.getString(userKey))
        .thenReturn(jsonEncode(testUser.toJson()));
  });

  tearDown(() {
    GetIt.I.reset();
  });

  testWidgets('ProfilePage displays user info correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: StackRouterScope(
          controller: mockRouter,
          stateHash: 0,
          child: const ProfilePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Find the UserInfo widget
    final userInfoFinder = find.byType(UserInfo);
    expect(userInfoFinder, findsOneWidget);

    // Find InfoBody widget
    final infoBodyFinder = find.byType(InfoBody);
    expect(infoBodyFinder, findsOneWidget);

    // Verify InfoBody has correct data
    final infoBody = tester.widget<InfoBody>(infoBodyFinder);
    expect(infoBody.fio, equals(testUser.firstName));
    expect(infoBody.role, equals(testUser.role.toStringX()));
    expect(infoBody.id, equals(testUser.uid));
  });

  testWidgets('Logout button clears storage and navigates to auth',
      (WidgetTester tester) async {
    when(mockStorage.clear()).thenAnswer((_) async => true);
    when(mockRouter.replaceAll(any))
        .thenAnswer((_) async => [const AuthRoute()]);

    await tester.pumpWidget(
      MaterialApp(
        home: StackRouterScope(
          controller: mockRouter,
          stateHash: 0,
          child: const ProfilePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Find and tap logout button in BottomAppBar
    final logoutButton = find.descendant(
      of: find.byType(BottomAppBar),
      matching: find.text('Log out'),
    );
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pumpAndSettle();

    // Verify storage was cleared and navigation occurred
    verify(mockStorage.clear()).called(1);
    verify(mockRouter.replaceAll([const AuthRoute()])).called(1);
  });

  testWidgets('Support button is displayed with correct styling',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: StackRouterScope(
          controller: mockRouter,
          stateHash: 0,
          child: const ProfilePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Find support button
    final supportButton = find.widgetWithText(InkWell, 'Support');
    expect(supportButton, findsOneWidget);

    // Verify SvgPicture is present
    final svgPicture = find.byWidgetPredicate(
      (widget) => widget.toString().contains('SvgPicture') && 
                  widget.toString().contains('support_icon.svg'),
    );
    expect(svgPicture, findsOneWidget);
  });
} 