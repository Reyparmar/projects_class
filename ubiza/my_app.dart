import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubiza_app/app_local/app_localization.dart';
import 'package:ubiza_app/app_local/app_localization_setup.dart';
import 'package:ubiza_app/app_local/lang_key.dart';
import 'package:ubiza_app/app_route/app_router.dart';
import 'package:ubiza_app/bloc/app_bloc/app_cubit.dart';
import 'package:ubiza_app/repository/api_service/api.dart';
import 'package:ubiza_app/repository/firebase/chat_service.dart';
import 'package:ubiza_app/src/utils/app_colors.dart';
import 'package:ubiza_app/src/widgets/app_scaffold_widget.dart';
import 'package:ubiza_app/src/widgets/error_widget.dart';
import 'package:ubiza_app/utility/constants.dart';
import 'package:ubiza_app/utility/shared_pre.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    /* FirebaseDynamicLinks.instance
        .getInitialLink()
        .then((value) => _parseData(value));*/
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        /*FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
          _parseData(dynamicLinkData);
        }).onError((error) {
          debugPrint('____FirebaseDynamicLinks error');
        });*/
        updateUserStatus(status: true);
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        updateUserStatus(status: false);
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  Future<void> updateUserStatus({required bool status}) async {
    final user = await SharedPre.instance.getLoginUser();
    if (user != null) {
      ChatService.instance.updateUserStatus(
        userId: user.userId!,
        status: status,
      );
      if (!status) {
        Api.instance.updateSwipeCount(
          count: user.swipeCount ?? 0,
          userId: user.userId ?? '',
        );
        final userLikesData =
            await SharedPre.instance.getListString(SharedPre.userLikes);
        if (userLikesData.isNotEmpty) {
          Api.instance.insertLikes(user: user, likesList: userLikesData).then(
              (value) =>
                  SharedPre.instance.setListString(SharedPre.userLikes, []));
        }
      }
    }
  }

  /*void _parseData(PendingDynamicLinkData? pendingLinkData) async {
    if (pendingLinkData != null) {
      debugPrint('_____ short link ${pendingLinkData.link.toString()}');
      final params = pendingLinkData.link.queryParameters;
      debugPrint('____ --params${params.toString()}');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..init()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (previousState, currentState) =>
            previousState != currentState,
        builder: (context, state) {
          if (state is AppLoaded) {
            return ScreenUtilInit(
              designSize: const Size(428, 926),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp.router(
                  routerConfig:
                      state.isNoInternet ?? false ? noInternetRoutes : router,
                  debugShowCheckedModeBanner: false,
                  title: Constants.appName,
                  locale: state.locale,
                  theme: Theme.of(context).copyWith(
                    primaryColor: primaryColor,
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          secondary: secondaryColor,
                        ),
                  ),
                  supportedLocales: AppLocalizationsSetup.supportedLocales,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  localeResolutionCallback:
                      AppLocalizationsSetup.localeResolutionCallback,
                );
              },
            );
          } else {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Constants.appName,
              home: AppScaffold(
                body: ErrorWidgetView(errorMsg: LangKey.somethingWentWrong),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
