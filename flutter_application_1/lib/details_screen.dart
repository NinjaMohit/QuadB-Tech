// screens/details_screen.dart
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['name'] ?? "No Title"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth *
                0.05, // Adjust horizontal padding based on screen width
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              movie['image'] != null
                  ? Image.network(
                      movie['image']['original'],
                      width:
                          screenWidth, // Make the image width fill the screen
                      height: screenHeight *
                          0.4, // Set image height as 40% of screen height
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: screenWidth,
                      height: screenHeight * 0.4,
                      color: Colors.grey[900],
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 100,
                        ),
                      ),
                    ),
              SizedBox(
                  height: screenHeight *
                      0.02), // Adjust spacing based on screen height
              Text(
                movie['name'] ?? "No Title",
                style: TextStyle(
                  fontSize:
                      screenWidth * 0.06, // Font size based on screen width
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                movie['summary']?.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '') ??
                    "No summary available.",
                style: TextStyle(
                    fontSize:
                        screenWidth * 0.045), // Font size based on screen width
              ),
              SizedBox(height: screenHeight * 0.02),

              // Additional movie details
              if (movie['type'] != null)
                Text(
                  'Type: ${movie['type']}',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
              SizedBox(height: screenHeight * 0.01),
              if (movie['language'] != null)
                Text(
                  'Language: ${movie['language']}',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
              SizedBox(height: screenHeight * 0.01),
              if (movie['status'] != null)
                Text(
                  'Status: ${movie['status']}',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
              SizedBox(height: screenHeight * 0.01),
              if (movie['runtime'] != null)
                Text(
                  'Runtime: ${movie['runtime']} minutes',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
              SizedBox(height: screenHeight * 0.01),
              if (movie['premiered'] != null)
                Text(
                  'Premiere Date: ${movie['premiered']}',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
              SizedBox(height: screenHeight * 0.01),
              if (movie['rating'] != null && movie['rating']['average'] != null)
                Text(
                  'Rating: ${movie['rating']['average']}',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
              SizedBox(height: screenHeight * 0.01),
              if (movie['network'] != null &&
                  movie['network']['country'] != null)
                Text(
                  'Country: ${movie['network']['country']['name']}',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
              SizedBox(height: screenHeight * 0.01),
              if (movie['genres'] != null && movie['genres'].isNotEmpty)
                Text(
                  'Genres: ${movie['genres'].join(', ')}',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
