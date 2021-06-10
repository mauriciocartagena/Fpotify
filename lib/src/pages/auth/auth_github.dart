import 'package:flutter_application_1/src/pages/FollowingPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/providers/UserProvider.dart';

class AuthGitHub extends StatefulWidget {
  @override
  _AuthGitHubState createState() => _AuthGitHubState();
}

class _AuthGitHubState extends State<AuthGitHub> {
  TextEditingController _controller = TextEditingController();
  void _getUser() {
    if (_controller.text == '') {
      Provider.of<UserProvider>(context, listen: false)
          .setMessage('Please Enter your username');
    } else {
      Provider.of<UserProvider>(context, listen: false)
          .fetchUser(_controller.text)
          .then((value) {
        if (value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FollowingPage()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Container(
                  width: 80,
                  height: 80,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        'https://icon-library.net/images/github-icon-png/github-icon-png-29.jpg'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'GitHub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(.1)),
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'GitHub username',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  padding: EdgeInsets.all(20),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    child: Provider.of<UserProvider>(context).isLoading()
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 2,
                          )
                        : Text(
                            'Get Your Following Now',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                  onPressed: () {
                    _getUser();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
