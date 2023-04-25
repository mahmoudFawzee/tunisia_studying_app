import 'package:flutter/material.dart';
import 'package:studying_app/view/theme/app_colors.dart';

class NewDetails extends StatelessWidget {
  const NewDetails({Key? key}) : super(key: key);
  static const pageRoute = '/news_details';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    Map<String, String> newsPageRoute =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String title = newsPageRoute['title'] as String;
    final String imageUrl = newsPageRoute['imageUrl'] as String;
    final String content = newsPageRoute['content'] as String;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.scaffoldGradientColors.first,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            gradient: AppColors.containerGradient,
          ),
          child: ListView(
            children: [
              SizedBox(
                width: double.infinity,
                height: height * .4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                    bottom: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontSize: 18,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
