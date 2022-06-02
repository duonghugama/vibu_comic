import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future downloadURL(String imageName) async {
    String downloadURL = await storage.ref('comicData/$imageName').getDownloadURL();
    return downloadURL;
  }
}
