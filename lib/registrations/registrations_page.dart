import 'package:flutter/material.dart';
import 'package:tech_me/base_page.dart';
import 'package:tech_me/registrations/company_registration/company_registration_page.dart';
import 'package:tech_me/registrations/mentor_registration/mentor_registration_page.dart';
import 'package:tech_me/registrations/user_registration/user_registration_page.dart';

class RegistrationsPage extends StatelessWidget {
  const RegistrationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text('無料登録'),
        content: Row(
          children: [
            OutlinedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return BasePage(pageName: UserRegistrationPage());                    });
                },
              child: const Text(
                '一般ユーザー',
              ),
            ),
            OutlinedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return BasePage(pageName: MentorRegistrationPage());
                    });
              },
              child: const Text(
                'メンター・講師',
              ),
            ),
            OutlinedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CompanyRegistrationPage();
                    });
              },
              child: const Text(
                '企業・自営業',
              ),
            )
          ],
        ),
      ),
    );
  }
}
