import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seen/core/keys.dart';
import 'package:seen/helper/custom_transition_page.dart';
import 'package:seen/view/ads/ads.dart';
import 'package:seen/view/auth/login/login.dart';
import 'package:seen/view/auth/register/register.dart';
import 'package:seen/view/contact/contact.dart';
import 'package:seen/view/home/home.dart';
import 'package:seen/view/intro/intro.dart';
import 'package:seen/view/on_boarding/on_boarding.dart';
import 'package:seen/view/profile/profile.dart';
import 'package:seen/view/reels/reel_categories.dart';
import 'package:seen/view/reels/reels.dart';
import 'package:seen/view/scaffold_withNavbar.dart';
import 'package:seen/view/show/show.dart';
import 'package:seen/view/stream/radio.dart';
import 'package:seen/view/stream/radio_channels.dart';
import 'package:seen/view/stream/streamFullScreen.dart';

import 'package:seen/view/stream/stream_view.dart';
import 'package:seen/view/video_player/video_player.dart';
import 'package:video_player/video_player.dart';

class RoutesConfig {
  static final router = GoRouter(
    initialLocation: '/',
    navigatorKey: Keys.parentKey,
    routes: [
      ShellRoute(
        navigatorKey: Keys.shellKey,
        pageBuilder: (context, state, child) {
          print(state);
          return NoTransitionPage(
              child: ScaffoldWithNavBar(
            location: state.pageKey.toString(),
            child: child,
          ));
        },
        routes: [
          GoRoute(
            path: '/profile',
            parentNavigatorKey: Keys.shellKey,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition<void>(
                  context: context, state: state, child: ProfileView());
            },
          ),
          GoRoute(
            path: '/home',
            parentNavigatorKey: Keys.shellKey,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: HomeView()),
          ),
          GoRoute(
            path: '/reels',
            parentNavigatorKey: Keys.shellKey,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: ReelCategories()),
          ),
          GoRoute(
            path: '/stream',
            parentNavigatorKey: Keys.shellKey,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: StreamView()),
          ),
          GoRoute(
            path: '/ads',
            parentNavigatorKey: Keys.shellKey,
            pageBuilder: (context, state) => NoTransitionPage(child: AdsView()),
          ),
          GoRoute(
            path: '/contact',
            parentNavigatorKey: Keys.shellKey,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: RadioChannelsView()),
          ),
          GoRoute(
            path: '/reel_videos',
            parentNavigatorKey: Keys.shellKey,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: ReelsView()),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: Keys.parentKey,
        path: '/login',
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition<void>(
              context: context, state: state, child: LoginView());
        },
      ),
      GoRoute(
        parentNavigatorKey: Keys.parentKey,
        path: '/register',
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition<void>(
              context: context, state: state, child: RegisterView());
        },
      ),
      // GoRoute(
      //   path: '/radio/:id',
      //   parentNavigatorKey: Keys.parentKey,
      //   pageBuilder: (context, state) => NoTransitionPage(
      //       child: RadioView(
      //     id: state.pathParameters['id'] ?? '',
      //   )),
      // ),
      GoRoute(
        path: '/video-player',
        parentNavigatorKey: Keys.parentKey,
        pageBuilder: (context, state) =>
            NoTransitionPage(child: StreamFullScreenView()),
      ),
      GoRoute(
        parentNavigatorKey: Keys.parentKey,
        path: '/onBoard',
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition<void>(
              context: context, state: state, child: OnBoardingView());
        },
      ),
      GoRoute(
        parentNavigatorKey: Keys.parentKey,
        path: '/',
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition<void>(
              context: context, state: state, child: IntroView());
        },
      ),
      GoRoute(
        parentNavigatorKey: Keys.parentKey,
        path: '/show',
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition<void>(
              context: context, state: state, child: ShowView());
        },
      ),
    ],
  );
}
