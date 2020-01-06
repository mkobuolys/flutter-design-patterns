abstract class Command {
  void execute();
  String getTitle();
  void undo();
}