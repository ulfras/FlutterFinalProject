import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: IconButton(
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        color: Colors.red,
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Tap'),
                  content: const Text('Favorite Button Tapped.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}

class MealDetailScreen extends StatelessWidget {
  final String mealName;
  final String mealImage;
  final String category;
  final String area;
  final String instructions;
  final String tags;
  final String youtubeLink;
  final String sourceLink;

  MealDetailScreen({
    required this.mealName,
    required this.mealImage,
    required this.category,
    required this.area,
    required this.instructions,
    required this.tags,
    required this.youtubeLink,
    required this.sourceLink,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealName),
        backgroundColor: Colors.amber,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FavoriteButton(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: Image.network(
                      mealImage,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                buildHorizontalLabels(),
                SizedBox(height: 16),
                buildVerticalButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHorizontalLabels() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel('Category', category),
        buildLabel('Area', area),
        buildLabel('Instructions', instructions),
        buildLabel('Tags', tags),
      ],
    );
  }

  Widget buildLabel(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(content),
        ],
      ),
    );
  }

  Widget buildVerticalButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () => launchURL(context, youtubeLink),
            child: Text('Watch on YouTube'),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => launchURL(context, sourceLink),
            child: Text('Source'),
          ),
        ],
      ),
    );
  }

  void launchURL(BuildContext context, String url) async {
    if (url.isNotEmpty) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      // Show alert for empty URL
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('No URL'),
            content: const Text('There is No URL Provided.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
