import 'package:flutter/material.dart';

class NewsForm extends StatelessWidget {
  const NewsForm({
    Key? key,
    required this.newTitle,
    required this.imageUrl,
    required this.content,
    required this.onTap,
  }) : super(key: key);
  final String imageUrl;
  final String newTitle;
  final String content;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      shadowColor: Colors.black,
      color: Colors.white.withOpacity(.8),
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          style: ListTileStyle.list,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          onTap: onTap,
          //*this will hold the image for the new
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              imageUrl,
            ),
          ),
          //*this is the title of the news
          title: Text(
            newTitle,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }
}
