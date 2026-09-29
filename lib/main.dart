import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/utilities/theme_provider.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:flutter_architecture/modules/test/view_model/test_view_model.dart';
import 'package:flutter_architecture/modules/user/profile/view_model/profile_view_model.dart';
import 'package:flutter_architecture/modules/user/user_view_model.dart';
import 'package:flutter_architecture/modules/watchout/view_model/watchout_view_model.dart';
import 'package:flutter_architecture/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'common/routing/app_routes.dart';
import 'language.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserViewModel>.value(value: UserViewModel()),
          ChangeNotifierProvider<StudyViewModel>.value(value: StudyViewModel()),
          ChangeNotifierProvider<Language>.value(value: Language()),
          ChangeNotifierProvider<WatchOutViewModel>.value(
              value: WatchOutViewModel()),
          ChangeNotifierProvider<TestViewModel>.value(value: TestViewModel()),
          ChangeNotifierProvider<ProfileViewModel>.value(
              value: ProfileViewModel()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return Consumer<Language>(
              builder: (context, language, _) {
                return MaterialApp(
                  navigatorKey: navigatorKey,
                  onGenerateTitle: (context) =>
                      AppLocalizations.of(context)!.helloWorld,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: language.currentLocale,
                  theme: ThemeData(
                      primaryColor: themeProvider.primary,
                      scaffoldBackgroundColor: AppColors.white,
                      secondaryHeaderColor: AppColors.black,
                      iconTheme: IconThemeData(color: themeProvider.primary)),
                  initialRoute: AppRoutes.splash,
                  routes: AppRoutes.routes,
                );
              },
            );
          },
        ),
      ),
    ),
  );
}
