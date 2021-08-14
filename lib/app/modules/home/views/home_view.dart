import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () => ListView.builder(
            itemCount: controller.userList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(controller.userList[index].id.toString()),
                subtitle: Text(controller.userList[index].login),
                // leading: Text(controller.userList[index].password),
              );
            },
          ),
        ),
      ),
    );
  }
}
