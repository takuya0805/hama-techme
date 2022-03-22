import 'package:flutter/material.dart';
import 'package:tech_me/registrations/registrations_page.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム'),
      ),
      body: Row(
        children: [
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
              onPressed: null,
              child: Text('ログイン')
          )
        ],
      ),
    );
  }
}
