import 'package:http/http.dart' as http;

class Github {
  final String userName;
  final String url = 'https://api.github.com/';

  Github(this.userName);

  Future<http.Response> fetchUser() {
    return http.get(Uri.parse(url + 'users/' + userName));
  }

  Future<http.Response> fetchFollowing() {
    return http.get(Uri.parse(url + 'users/' + userName + '/following'));
  }
}
