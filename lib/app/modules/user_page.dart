import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_auth_form/app/data/services/server_connection.dart';
import 'package:user_auth_form/app/modules/login_page.dart';
import 'package:user_auth_form/app/data/models/user_data.dart';
import 'package:user_auth_form/app/global_widgets/user_details_tile.dart';

class UserPage extends StatelessWidget {
  UserPage(this.token);

  factory UserPage.fromBase64(String token) => UserPage(token);

  final String token;

  final ServerConnection connect = ServerConnection();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            style: TextButton.styleFrom(primary: Colors.deepOrange),
            onPressed: () => Get.off(() => LoginPage()),
            child: Text('Log out'),
          ),
        ],
      ),
      body: FutureBuilder<UserData>(
          future: connect.getUserData(token),
          builder: (context, snapshot) {
            final userData = snapshot.data;
            return (snapshot.hasData)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 88),
                          Flexible(
                            child: Text('Welcome back ${userData!.firstName} ${userData.lastName}!',
                                textAlign: TextAlign.center, style: TextStyle(fontSize: 48)),
                          ),
                          SizedBox(height: 52),
                          UserDetailsTile(
                            title: 'First name:',
                            content: '${userData.firstName}',
                          ),
                          UserDetailsTile(
                            title: 'Last name',
                            content: '${userData.lastName}',
                          ),
                        ],
                      ),
                    ),
                  )
                : (snapshot.hasError)
                    ? Text('An error occured')
                    : Scaffold(
                        body: Center(
                            child: CircularProgressIndicator(
                        color: Colors.deepOrange,
                      )));
          }),
    );
  }
}
