import 'dart:convert';

import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

class User {
  final int id;
  final String login;
  final String password;

  User({
    required this.id,
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      login: map['login'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(id: $id, login: $login, password: $password)';
}

class HomeController extends GetxController {
  final count = 0.obs;

  final userList = RxList<User>();

  @override
  void onInit() async {
    super.onInit();
    final String url = 'http://10.0.2.2:8080/v1/graphql';
    HasuraConnect hasuraConnect = HasuraConnect(url);

    final String docQuery = '''
      query MyQuery {
        user {
          id
          login
          password
        }
      }
    ''';

    // var r = await hasuraConnect.query(docQuery);
    // print(r);
    // print('OnInit');

    final String docQuerySubscription = r'''
      subscription MySubscription($order_by: asc) {
        user(order_by: {id: asc}) {
          id
          login
          password
        }
      }
    ''';

    Snapshot snapshot = await hasuraConnect.subscription(docQuerySubscription);
    snapshot.listen((data) {

      
      

      userList.value =
          (data['data']['user'] as List).map((e) => User.fromMap(e)).toList();
      userList.refresh();
      
      print(userList);
    }).onError((err) {
      print(err);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
