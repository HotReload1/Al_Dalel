import 'package:al_dalel/core/routing/route_path.dart';
import 'package:al_dalel/layers/view/screens/auth/signup_screen.dart';
import 'package:al_dalel/layers/view/screens/auth/welcome_screen.dart';
import 'package:al_dalel/layers/view/screens/google_map_screen/google_map_screen.dart';
import 'package:al_dalel/layers/view/screens/place_detail_screen/place_detail_screen.dart';
import 'package:al_dalel/layers/view/screens/places_list/places_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../layers/view/home_screen.dart';
import '../../layers/view/screens/auth/login_screen.dart';
import '../../layers/view/screens/intro/splash_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RoutePaths.SplashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RoutePaths.LogIn:
        return MaterialPageRoute(builder: (_) => LogInScreen());
      case RoutePaths.SignUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case RoutePaths.WelcomeScreen:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case RoutePaths.PlacesScreen:
        return MaterialPageRoute(builder: (_) => PlacesListScreen());
      case RoutePaths.PlaceDetailScreen:
        final arguments = settings.arguments ?? <String, dynamic>{} as Map;
        return MaterialPageRoute(
            builder: (_) => PlaceDetailScreen(
                  place: (arguments as Map)["place"],
                ));
      case RoutePaths.GoogleMapScreen:
        final arguments = settings.arguments ?? <String, dynamic>{} as Map;
        return MaterialPageRoute(
            builder: (_) => GoogleMapScreen(
                  places: (arguments as Map)["places"],
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
                // child: Text('No route defined for ${settings.name}'),
                ),
          ),
        );
    }
  }
}
