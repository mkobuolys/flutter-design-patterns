class NetflixApi {
  bool connect() {
    return true;
  }

  bool disconnect() {
    return false;
  }

  void play(String title) {
    print("'$title' has started started playing on Netflix.");
  }
}