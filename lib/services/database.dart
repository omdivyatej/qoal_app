import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:qoal_app/models/leaderboard_model.dart';
import 'package:qoal_app/models/my_rewards.dart';
import 'package:qoal_app/models/rewards_model.dart';
import 'package:qoal_app/models/user_model.dart';

import '../models/activity_data_model.dart';
//import 'package:qoal_app/screens/home/leaderboard_model.dart';
//import 'package:qoal_app/screens/rewards/myRewards/my_rewards.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference challengesCollection =
      FirebaseFirestore.instance.collection("challenges");

  final CollectionReference bettingCollection =
      FirebaseFirestore.instance.collection("betting");
  final CollectionReference rewardsCollection =
      FirebaseFirestore.instance.collection("rewards");
//generate referal code
  String generateReferralCode(int length) {
    final random = Random();
    const availableChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return randomString;
  }

  //-----------------------------------------------------Profile-------------------------------------------------
  Future<void> profileCreation(
      String fullName,
      String age,
      String height,
      String weight,
      String country,
      String city,
      String zip,
      String timezone,
      int total_trophies) async {
    var now = DateTime.now();
    var formatter = DateFormat('MM-dd-yyyy hh:mm:ss');
    String formatted = formatter.format(now);
    String referral_code = generateReferralCode(6);
    String secret_code = generateReferralCode(7);
    var game_sessions = [
      {
        "calories": 0,
        "coins": 0,
        "score": 0,
        "session_time": "0",
        "time": 0,
      },
    ];
    var sessions = ["0"];
///////////////////////!!!!!!!!Don't forget to subtract 1 from sessions and game_sessions coz they have dummy data initially"////////////////
    var ref = userCollection.doc(uid).set({
      "name": fullName,
      "age": int.parse(age),
      "height": int.parse(height),
      "weight": int.parse(weight),
      "registerDateTime": formatted,
      "country": country,
      "city": city,
      "zip": zip,
      "timezone": timezone,
      "total_trophies": total_trophies,
      "referral_code": referral_code,
      "total_coins": 0,
      "total_sessions": 1,
      "total_calories_burnt": 0,
      "total_time_h": 0,
      "total_points": 0,
      "game_sessions": game_sessions,
      "sessions": sessions,
      "secret_code": secret_code,
    });
    return await ref;
  }

  //-------------------------------------------------------homepageData-------------------------------------------------

  //Stream - Get Homepage User Data
  Stream<UserData?> get userHomeData {
    return userCollection.doc(uid).snapshots().map(convertToUserDataModel);
  }

  //Convert Stream Homepage Data to UserDataModel
  UserData convertToUserDataModel(DocumentSnapshot documentSnapshot) {
    return UserData(
      uid: uid,
      name: documentSnapshot['name'],
      total_coins: documentSnapshot['total_coins'].toString(),
      age: documentSnapshot['age'].toString(),
      height: documentSnapshot['height'].toString(),
      weight: documentSnapshot['weight'].toString(),
      total_calories_burnt: documentSnapshot['total_calories_burnt'].toString(),
      total_points: documentSnapshot['total_points'].toString(),
      total_time_h: documentSnapshot['total_time_h'].toString(),
      total_sessions: (documentSnapshot['total_sessions'] - 1).toString(),
      total_trophies: documentSnapshot['total_trophies'].toString(),
      secret_code: documentSnapshot['secret_code'],
    );
  }

  //
  Future<dynamic> referalIsValid(String code) async {
    dynamic result = -1;
    await userCollection.where("referal_code", isEqualTo: code).get().then(
      (res) {
        if (res.size == 1) {
          result = 1;
        }
      },
      onError: (e) {
        // print("Error completing: $e");
        result = -1;
      },
    );

    return result;
  }

//----------------------------------------------------Leaderboard------------------------------------------------------------
  Stream<List<LeaderboardModel>> get listOfUserNameRanking {
    return userCollection
        .orderBy("total_trophies", descending: true)
        .snapshots()
        .map((querySnapshot) {
      var k = 2;
      return querySnapshot.docs.map((e) {
        return LeaderboardModel(
            userName: e["name"], total_trophies: e["total_trophies"]);
      }).toList();
    });
  }
//--------------------------------------Personal Best-------------------------------------------

  //-------------------------------------Rewards-----------------------------------------------------------

  Stream<List<Rewards_Model?>> get allRewardsStream {
    try {
      print("Rewards thing");

      return rewardsCollection
          .doc("all")
          .snapshots()
          .map(convertToRewardModelObject);
    } catch (e) {
      print(e.toString());
      return Stream.error(e);
    }
  }

  List<Rewards_Model> convertToRewardModelObject(
      DocumentSnapshot documentSnapshot) {
    final ref = documentSnapshot.get("RewardList") as List<dynamic>;
    print("john");
    print(ref);
    try {
      return ref.map((data) {
        return Rewards_Model(
          title: data["title"] ?? "",
          description: data["description"] ?? "",
          price: data["coins"],
          id: data["id"],
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      throw "Error hai bhai kuch";
    }
  }

  Future<void> purchaseReward(
      int price, String id, String title, String description) async {
    var val = [];
    var data = {
      "id": id,
      "title": title,
      "description": description,
      "coins": price,
      "description": description,
    };
    val.add(data);
    print(val);
    userCollection.doc(uid).update({
      "MyRewards": FieldValue.arrayUnion(val),
    });
  }

  Future<dynamic> updateProfile(double weight) async {
    var ref = await userCollection.doc(uid).update({"weight": weight});
    return ref;
  }

  //---------------------------------------------activity home-------------------------------------------------------
  Stream<List<ActivityDataModel?>> get AllActivityDataStream {
    return userCollection
        .doc(uid)
        .snapshots()
        .map(convertToActivityDataModelObject);
  }

  List<ActivityDataModel> convertToActivityDataModelObject(
      DocumentSnapshot documentSnapshot) {
    var d = documentSnapshot.get("game_sessions") as List<dynamic>;
    return d.map((data) {
      return ActivityDataModel(
          score: data["score"],
          coins: data["coins"],
          time: data["time"],
          calories: data["calories"].round(),
          dateTime: data["session_time"]);
    }).toList();
  }

//---------------------------------------------MyRewards-----------------------------------------------------------

  Stream<List<MyRewardsModel?>> get myRewardsStream {
    try {
      return userCollection.doc(uid).snapshots().map(convertToMyRewardObject);
    } catch (e) {
      print(e.toString());
      return Stream.error(e);
    }
  }

  List<MyRewardsModel> convertToMyRewardObject(
      DocumentSnapshot documentSnapshot) {
    try {
      final ref = documentSnapshot.get("MyRewards") as List<dynamic>;
      print(ref);
      return ref.map((data) {
        return MyRewardsModel(
            title: data["title"] ?? "",
            description: data["description"] ?? "",
            price: data["coins"],
            id: data["id"]);
      }).toList();
    } catch (e) {
      print(e.toString());
      throw "Bhao kuch error hai!";
    }
  }

//---------------------------------------------Available Players for Duel------------------------------------------
//
// Stream<List<DuelAvailaibilityandOpponent>>? get a {
//   try {
//     return userCollection
//         .where("inDuel", isEqualTo: true)
//         .snapshots()
//         .map((querySnapshot) {
//           print(querySnapshot);
//       return querySnapshot.docs.map((s) {
//         print(s['level']);
//         print(s["name"]);
//         print(s["total_matches"]);
//         print(s["total_wins"]);
//         return DuelAvailaibilityandOpponent(
//           level: s["level"],
//           name: s["name"],
//           total_matches: s["total_matches"],
//           total_wins: s["total_wins"],
//         );
//       }).toList();
//     });
//   } catch (e) {
//     print("dkdmemdkmwkfmeefmwefwefwefkmwefkmwefkwef");
//     print(e.toString());
//     return null;
//   }
// }
}
