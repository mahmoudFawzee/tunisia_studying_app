import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studying_app/data/models/news.dart';

class FirebaseNewsApi {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<List<News>> getNews() async {
    QuerySnapshot<Map<String, dynamic>> allFirebaseNews =
        await firebaseFirestore.collection('news').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> newsList =
        allFirebaseNews.docs;
    List<News> allNews = [];
    for (var news in newsList) {
      allNews.add(
        News.fromFirebase(
          news.data(),
        ),
      );
    }
    return allNews;
  }
}
