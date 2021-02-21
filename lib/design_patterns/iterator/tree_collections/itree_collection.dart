import '../tree_iterators/itree_iterator.dart';

abstract class ITreeCollection {
  ITreeIterator createIterator();
  String getTitle();
}
