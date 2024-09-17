import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perf_energie/pages/Access_Page.dart';
import 'package:perf_energie/pages/LoginPage.dart';
import 'package:perf_energie/pages/PageNotFound.dart';
import 'package:perf_energie/pages/PassForgot.dart';
import 'package:perf_energie/pages/Pilotage/Pilotage1.dart';
import 'package:perf_energie/pages/Pilotage/PilotagePage.dart';
import 'package:perf_energie/pages/Pilotage/entite/entity_view_frame.dart';
import 'package:perf_energie/pages/gestion/gestion_screen.dart';
import 'package:perf_energie/widgets/Composant/LoadingWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

class RouteClass {
  static final supabase = Supabase.instance.client;

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: supabase.auth.currentSession != null ? "/" : "/account/login",
    errorBuilder: (context, state) {
      return const  PageNotFound();
    },
    routes: [
      GoRoute(
          path: '/',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: const AccessPage(),
          ),
      ),
      GoRoute(
          path: '/pilotage',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: const Pilotage1(),
            ),
          // routes: [
          //   GoRoute(
          //     path: 'espace/tableau-de-bord', // mauvaise definition de route : definir parametre id pour entite
          //       pageBuilder: (context, state) => NoTransitionPage<void>(
          //           key: state.pageKey,
          //           restorationId: state.pageKey.value,
          //           child: const Scaffold(
          //             backgroundColor: Colors.white,
          //             body: Center(
          //               child: LoadingWidget(),
          //             ),
          //           ) //const PilotageEntiteOverview(urlPath: "profil"),
          //           ),
          //     routes: [
          //       ShellRoute(
          //         navigatorKey: _shellNavigatorKey,
          //           builder: (BuildContext context, GoRouterState state,
          //               Widget child) {
          //             return EntityViewFrame(
          //                 //parametre a definir... entiteId: state.pathParameters['entiteId'],
          //                 child: child);
          //           },
          //         routes: <RouteBase>[
                    
          //         ]
          //         )
          //     ]
          //     )
          // ]    
      ),
      GoRoute(
          path: '/gestion',
          pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                restorationId: state.pageKey.value,
                child: const GestionScreen(),
              )
      ),


      // Evaluation

      // GoRoute(
      //   path: '/evaluation',
      //   pageBuilder: (context, state) => NoTransitionPage<void>(
      //     key: state.pageKey,
      //     restorationId: state.pageKey.value,
      //     child: const EvaluationScreen(child: EvaluationHome(),),
      //   ),
      // ),

      // GoRoute(
      //   path: '/evaluation/liste-des-evaluations',
      //   pageBuilder: (context, state) => NoTransitionPage<void>(
      //     key: state.pageKey,
      //     restorationId: state.pageKey.value,
      //     child: const EvaluationScreen(child: EvaluationHome(),),
      //   ),
      // ),

      //
      // GoRoute(
      //   path: '/reload-page',
      //   pageBuilder: (context, state) => NoTransitionPage<void>(
      //     key: state.pageKey,
      //     restorationId: state.pageKey.value,
      //     child: ReloadScreen(redirection: state.extra.toString(),),
      //   ),
      // ),
      // GoRoute(
      //     path: '/pilotage',
      //     pageBuilder: (context, state) => NoTransitionPage<void>(
      //       key: state.pageKey,
      //       restorationId: state.pageKey.value,
      //       child: const PilotageHome(),
      //     ),
      //     routes: [
      //       GoRoute(
      //           path: 'espace/:entiteId',
      //           name: "Sucrivoire Siège",
      //           pageBuilder: (context, state) => NoTransitionPage<void>(
      //               key: state.pageKey,
      //               restorationId: state.pageKey.value,
      //               child: const Scaffold(
      //                 backgroundColor: Colors.white,
      //                 body: Center(
      //                   child: LoadingWidget(),
      //                 ),
      //               )//const PilotageEntiteOverview(urlPath: "profil"),
      //           ),
      //           routes:[
      //             ShellRoute(
      //               navigatorKey: _shellNavigatorKey,
      //               builder: (BuildContext context, GoRouterState state, Widget child) {
      //                 return EntityPilotageMain(child: child,entiteId: state.pathParameters['entiteId']);
      //               },
      //               routes: <RouteBase>[
      //                 GoRoute(
      //                   path: 'accueil',
      //                   pageBuilder: (context, state) => NoTransitionPage<void>(
      //                       key: state.pageKey,
      //                       child: const ScreenOverviewPilotage()
      //                   ),
      //                 ),
      //                 GoRoute(
      //                   path: 'tableau-de-bord',
      //                   pageBuilder: (context, state) => NoTransitionPage<void>(
      //                       key: state.pageKey,
      //                       child: const ScreenTableauBordPilotage()
      //                   ),
      //                   routes: [
      //                     GoRoute(
      //                         path: 'indicateurs',
      //                         pageBuilder: (context, state) => NoTransitionPage<void>(
      //                             key: state.pageKey,
      //                             child: const IndicateurScreen()
      //                         ),
      //                     )
      //                   ]
      //                 ),
      //                 GoRoute(
      //                   path: 'profil',
      //                   pageBuilder: (context, state) => NoTransitionPage<void>(
      //                       key: state.pageKey,
      //                       child: const ScreenPilotageProfil()
      //                   ),
      //                 ),
      //                 //
      //                 GoRoute(
      //                   path: 'performances',
      //                   pageBuilder: (context, state) => NoTransitionPage<void>(
      //                       key: state.pageKey,
      //                       child: const ScreenPilotagePerform()
      //                   ),
      //                 ),
      //                 GoRoute(
      //                   path: 'suivi-des-donnees',
      //                   pageBuilder: (context, state) => NoTransitionPage<void>(
      //                       key: state.pageKey,
      //                       child: const ScreenPilotageSuivi()
      //                   ),
      //                 ),
      //                 GoRoute(
      //                   path: 'admin',
      //                   pageBuilder: (context, state) => NoTransitionPage<void>(
      //                       key: state.pageKey,
      //                       child: const ScreenPilotageAdmin()
      //                   ),
      //                 ),
      //                 GoRoute(
      //                   path: 'support-client',
      //                   pageBuilder: (context, state) => NoTransitionPage<void>(
      //                       key: state.pageKey,
      //                       child: const ScreenSupportClient()
      //                   ),
      //                 ),
      //                 GoRoute(
      //                   path: 'historique-des-modifications',
      //                   pageBuilder: (context, state) => NoTransitionPage<void>(
      //                       key: state.pageKey,
      //                       child: const ScreenModificationHistory()
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ]
      //       ),
      //     ]),
      GoRoute(
          path: '/account/login',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: const LoginPage(),
          )
      ),
      // GoRoute(
      //     path: '/account/change-password',
      //     pageBuilder: (context, state) => NoTransitionPage<void>(
      //       key: state.pageKey,
      //       restorationId: state.pageKey.value,
      //       child: ChangePassWordScreen(event: state.extra.toString()),
      //     )
      // ),
      GoRoute(
          path: '/account/forgot-password',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: const PassForgot(),
          )
      ),
      // GoRoute(
      //     path: '/mise-a-jour',
      //     pageBuilder: (context, state) => NoTransitionPage<void>(
      //       key: state.pageKey,
      //       restorationId: state.pageKey.value,
      //       child: const UpdatedPage(),
      //     )
      // ),
    ],
    
    // redirect: (context ,state) async {

    //   if (state.fullPath!=null && state.fullPath =="/account/forgot-password"){
    //     return null;
    //   }

    //   const storage = FlutterSecureStorage();
    //   String? loggedPref = await storage.read(key: 'logged');
    //   String? email = await storage.read(key: 'email');
    //   String? isInitTime = await storage.read(key: 'isInitTime');
      
    //   if ( state.fullPath!=null && state.fullPath =="/account/change-password" ){
    //     return null;
    //   }
      
    //   bool sessionVerification = false;
    //   final session = supabase.auth.currentSession;
      
    //   if (session != null) {
    //     sessionVerification = true;
    //   } else {
    //     sessionVerification = false;
    //   }
    //   if (loggedPref == "true" && email!=null && isInitTime == "true" && GetUtils.isEmail(email) && sessionVerification ==true) {
    //     return null;
    //   }
    //   return "/account/login";
    // },
  );
}
