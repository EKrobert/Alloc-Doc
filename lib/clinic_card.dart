import 'package:flutter/material.dart';

class ClinicCard extends StatelessWidget {
  final String name;
  final String address;
  final double rating;
  final int reviews;
  final String imagePath; // Chemin de l'image locale
  final String distance; // Distance en kilomètres
  final String time; // Temps en minutes

  ClinicCard({
    required this.name,
    required this.address,
    required this.rating,
    required this.reviews,
    required this.imagePath,
    required this.distance, // Ajout de la distance
    required this.time, // Ajout du temps
  });

  // Fonction pour générer les étoiles en fonction de la note
  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Largeur inchangée
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // Fond semi-transparent
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView( // Permet le défilement si le contenu est trop long
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image de l'hôpital (taille réduite)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath, // Chemin de l'image locale
                  width: double.infinity, // Prend toute la largeur
                  height: 100, // Hauteur réduite pour l'image
                  fit: BoxFit.cover, // Ajuste l'image pour couvrir l'espace
                ),
              ),
              SizedBox(height: 10),

              // Nom de la clinique
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Adresse
              Text(
                address,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 10),

              // Note et reviews
              Row(
                children: [
                  _buildRatingStars(rating), // Affiche les étoiles
                  SizedBox(width: 5),
                  Text(
                    "($reviews Reviews)",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Ligne du bas avec localisation et tag "Hospital"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligne les éléments à gauche et à droite
                children: [
                  // Icône de localisation avec la distance et le temps
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue, size: 20),
                      SizedBox(width: 5),
                      Text(
                        "$distance/$time", // Utilisation des paramètres distance et time
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),

                  // Tag "Hospital"
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Hospital",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue[800],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}