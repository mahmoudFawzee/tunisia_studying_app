import 'package:flutter/material.dart';
import 'package:studying_app/data/firebase_apis/fire_base_news_api.dart';
import 'package:studying_app/data/models/news.dart';
import 'package:studying_app/view/screens/news_details.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/news_form.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);
  static const pageRoute = '/news_page';

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  FirebaseNewsApi firebaseNewsApi = FirebaseNewsApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: AppColors.scaffoldGradientColors.first,
        centerTitle: true,
        title: Text(
          'اخر الاخبار',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.black,
                fontSize: 24,
              ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: AppColors.containerGradient,
        ),
        child: FutureBuilder<List<News>>(
            future: firebaseNewsApi.getNews(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final String title = snapshot.data![index].title;
                    final String imageUrl = snapshot.data![index].imageUrl;
                    final String content = snapshot.data![index].content;
                    return NewsForm(
                      newTitle: title,
                      imageUrl: imageUrl,
                      content: content,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          NewDetails.pageRoute,
                          arguments: {
                            'title': title,
                            'imageUrl': imageUrl,
                            'content': content,
                          },
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      endIndent: 20,
                      indent: 20,
                      height: 20,
                      color: Colors.black.withOpacity(.4),
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.buttonsLightColor),
                );
              }
            }),
      ),
    );
  }
}
