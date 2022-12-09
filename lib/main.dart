import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qoal_app/models/activity_data_model.dart';
import 'package:qoal_app/models/leaderboard_model.dart';
import 'package:qoal_app/screens/activity_home/activity_home.dart';
import 'package:qoal_app/screens/game_stats/game_stats.dart';
import 'package:qoal_app/screens/leaderboard/leaderboard.dart';
import 'package:qoal_app/screens/profile/profile_page.dart';
import 'package:qoal_app/services/auth.dart';
import 'package:qoal_app/services/database.dart';
import 'package:qoal_app/wrapper.dart';

import 'models/my_rewards.dart';
import 'models/rewards_model.dart';
import 'models/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerList,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          theme: ThemeData(fontFamily: 'Poppins'),
          home: const Wrapper(),
          routes: {
            //'/': (context) => const HomeView(),
            ActivityHome.routeName: (context) => const ActivityHome(),
            '/Leaderboard': (context) => const Leaderboard(),
            '/GameStats': (context) => const GameStats(),
            // Leaderboard.routeName: (context) => const Leaderboard(),
            // RewardScreen.routeName: (context) => const RewardScreen(),
            ProfilePage.routeName: (context) => const ProfilePage(),
            // LoginPage.routeName: (context) => const LoginPage(),
            // RegisterProfile.routeName: (context) => const RegisterProfile(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

var providerList = [
  StreamProvider.value(
    value: AuthService().authChange,
    initialData: null,
    catchError: (_, __) => null,
  ),
  StreamProvider<UserModel?>.value(
    value: AuthService().authChange,
    initialData: null,
    catchError: (_, __) => null,
  ),
  StreamProvider<UserData?>.value(
    value: DatabaseService(
            uid: FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.uid
                : null.toString())
        .userHomeData,
    initialData: null,
    // initialData: UserData(
    //     total_sessions: "2",
    //     total_points: "2",
    //     total_time_h: "2",
    //     total_calories_burnt: "total_calories_burnt",
    //     height: "height",
    //     weight: "weight",
    //     age: "age",
    //     uid: "uid",
    //     name: "2",
    //     total_coins: "total_coins",
    //     total_trophies: "total_trophies",
    //     secret_code: "secret_code"),
    catchError: (_, __) => null,
  ),
  StreamProvider<List<LeaderboardModel?>?>.value(
    value: DatabaseService(uid: "").listOfUserNameRanking,
    initialData: null,
    catchError: (_, __) => null,
  ),
  StreamProvider<List<Rewards_Model?>?>.value(
    value: DatabaseService(
            uid: FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.uid
                : null.toString())
        .allRewardsStream,
    initialData: null,
    catchError: (_, __) => null,
  ),
  StreamProvider<List<MyRewardsModel?>?>.value(
    value: DatabaseService(
            uid: FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.uid
                : null.toString())
        .myRewardsStream,
    initialData: null,
    catchError: (_, __) => null,
  ),
  StreamProvider<List<ActivityDataModel?>?>.value(
    value: DatabaseService(
            uid: FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.uid
                : null.toString())
        .AllActivityDataStream,
    initialData: null,
    catchError: (_, __) => null,
  ),
];
