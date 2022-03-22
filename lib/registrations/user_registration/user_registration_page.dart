import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_me/registrations/user_registration/user_registration_model.dart';

class UserRegistrationPage extends StatefulWidget {
  UserRegistrationPage({Key? key}) : super(key: key);

  @override
  _UserRegistrationPageState createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {

  Map userInformation = {
    'name':'',
    'mail_address':'',
    'password':'',
    'age':'',
    'sex':'',
    'invitation_code':''
  };

  final FirebaseAuth auth = FirebaseAuth.instance;
  late UserCredential result;
  String infoText = '';
  late User user;

  var _radVal = null;

  void _onChanged(value) {
    setState(() {
      userInformation['sex'] = value;
      _radVal = value;
    });
  }

  bool _flag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
        children: [
          Text('新規登録'),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
            child:Text(infoText,
              style: TextStyle(color: Colors.red),),
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'お名前(ニックネーム)'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Can\'t be empty';
              }
              return null;
            },
            onChanged: (value) {
              userInformation['name'] = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'メールアドレス'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Can\'t be empty';
              }
              if (text.length < 4) {
                return 'Too short';
              }
              return null;
            },
            onChanged: (value) {
              userInformation['mail_address'] = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'パスワード'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Can\'t be empty';
              }
              if (text.length < 5) {
                return 'Too short';
              }
              return null;
            },
            onChanged: (value) {
              userInformation['password'] = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'パスワード(確認用)'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Can\'t be empty';
              }
              if (text != userInformation['password']) {
                return '上のpasswordと違います';
              }
              return null;
            },
          ),
          TextFormField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
                labelText: '年齢'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Can\'t be empty';
              }
              return null;
            },
            onChanged: (value) {
              userInformation['age'] = value;
            },
          ),
          Row(
            children: [
              Expanded(child: RadioListTile(
                  title: Text('男性'),
                  value: '男',
                  groupValue: _radVal,
                  onChanged: _onChanged
              )),
              Expanded(child: RadioListTile(
                  title: Text('女性'),
                  value: '女',
                  groupValue: userInformation['sex'],
                  onChanged: _onChanged
              )),
              Expanded(child: RadioListTile(
                  title: Text('その他'),
                  value: 'その他',
                  groupValue: userInformation['sex'],
                  onChanged: _onChanged
              )),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: '招待コード(任意)'),
            onChanged: (value) {
              userInformation['invitation_code'] = value;
            },
          ),
          CheckboxListTile(
            title: Text('利用規約及びプライバシーポリシー規約に同意する'),
            activeColor: Colors.blue,
            value: _flag,
            onChanged: (bool? value) {
              setState(() {
                _flag = value!;
              });
            },
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    try {
                      result = await auth.createUserWithEmailAndPassword(
                          email: userInformation['mail_address'],
                          password: userInformation['password']);
                      UserRegistration().addFirestoreUser(userInformation);
                      Navigator.pop(context);
                    } catch (e) {
                      setState(() {
                        infoText = "登録に失敗しました：${e.toString()}";
                      });
                    }
                  },
                  child: Text('登録')
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
    );
  }
}
