enum AuthenticationState { signedIn, signedOut }
enum AuthenticationResult { success, failure }

class Authentication {
  final String? username;
  final String? uid;
  final AuthenticationState state;

  Authentication({required this.state, this.username, this.uid});
}
