import 'package:absolutemen_app/autentication/otp_verification_page.dart';
import 'package:absolutemen_app/autentication/sign_up_page.dart';
import 'package:absolutemen_app/home_page/home_page.dart';
import 'package:auto_route/auto_route.dart';

import '../autentication/login_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: OtpVerificationRoute.page),
      ];
}
