import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spotify_clone_provider/controllers/main_controller.dart';

class RecentSearch extends StatelessWidget {
  final MainController con;
  const RecentSearch({
    Key? key,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> data = [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10),
        if(Hive.box('Recentsearch').length ! = 0)
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16,),
        child: Text('Recent Searches'.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 16,),),)
      ],
    );
  }
}
