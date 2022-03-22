import 'package:flutter/material.dart';
import 'package:tech_me/find_mentor/find_mentor_page.dart';
import 'package:tech_me/home_page.dart';
import 'package:tech_me/log_in/log_in_page.dart';
import 'package:tech_me/registrations/registrations_page.dart';

class BasePage extends StatefulWidget {
  BasePage({Key? key, required this.pageName}) : super(key: key);
  var pageName;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

    //Widget currentPage = HomePage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム'),
        backgroundColor: Colors.yellow,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Row(
            children: [
              TextButton(onPressed: null, child: Text('スクール')),
              TextButton(onPressed: () {
                setState(() {
                  widget.pageName = FindMentorPage();
                });
              }, child: Text('メンターを探す')),
              TextButton(onPressed: null, child: Text('イベント')),
              TextButton(onPressed: null, child: Text('ターミナル')),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return RegistrationsPage();
                        });
                  },
                  child: Text('新規登録')
              ),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return LogInPage();
                        });
                  },
                  child: Text('ログイン')
              )
            ],
          )
    ),
      ),
      body: widget.pageName,
    );
  }
}
