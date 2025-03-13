import 'package:flutter/material.dart';
import 'package:newapp/src/model/new_model.dart';
import 'package:newapp/src/utils/router/router.dart';
import 'package:newapp/src/view/new_dataview_screen.dart';
import 'package:newapp/src/widget/shimmer_container.dart';

class NewsCard extends StatelessWidget {
  final Newmodel? article;
  final bool isLoading;

  const NewsCard({super.key, this.article, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isLoading && article != null) {
          MyRouter.push(screen: NewsDetailScreen(article: article!));
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child:
            isLoading
                ? const ShimmerNewsCard()
                : _buildNewsContent(),
      ),
    );
  }


  Widget _buildNewsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        article!.imageUrl.isNotEmpty
            ? ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Image.network(
                article!.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  );
                },
              ),
            )
            : Container(height: 200, color: Colors.grey),

        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article!.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                article!.description,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article!.source,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    article!.publishedAt,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
