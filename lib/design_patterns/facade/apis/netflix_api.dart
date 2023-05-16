class NetflixApi {
  const NetflixApi();

  bool connect() => true;

  bool disconnect() => false;

  void play(String title) {
    // ignore: avoid_print
    print("'$title' has started started playing on Netflix.");
  }
}
