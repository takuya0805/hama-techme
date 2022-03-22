import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  late String email;
  late String password;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late UserCredential result;
  String infoText = '';
  late User user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
          title: Text('ログイン'),
          content: Form(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
                  child:Text(infoText,
                    style: TextStyle(color: Colors.red),),
                ),                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'メールアドレス'),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'パスワード'),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                CheckboxListTile(
                  title: Text('ログインしたままにする'),
                  activeColor: Colors.blue,
                  value: false,
                  onChanged: null,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      child: Text('ログイン'),
                      onPressed: () async {
                        try {
                        result = await auth.signInWithEmailAndPassword(
                            email: email,
                            password: password,);
                          // ログイン成功// ログインユーザーのIDを取得
                          user = result.user!;
                          Navigator.pop(context);
                          print('ログイン成功');
                        }
                        catch (e) {
                          print('ログイン失敗');
                          infoText = 'ログインに失敗しました:${e.toString()}';
                        }
                      }
                    ),
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('キャンセル')
                    ),
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}
