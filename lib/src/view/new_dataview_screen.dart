import 'package:flutter/material.dart';
import 'package:newapp/src/model/new_model.dart';
import 'package:newapp/src/utils/spacer/spacer.dart';

class NewsDetailScreen extends StatelessWidget {
  final Newmodel article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.imageUrl.isNotEmpty
                ? Image.network(
                  article.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                : voidBox,
            vSpace8,
            Text(
              article.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            vSpace4,

            Text(article.description, style: const TextStyle(fontSize: 16)),

            vSpace8,
            Text(
              "Published: ${article.publishedAt}",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
