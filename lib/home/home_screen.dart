import 'package:allodoc/clinic_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Permet de faire défiler l'écran pour éviter le débordement
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. En-tête avec location et icône de notification
              _buildHeader(),
              const SizedBox(height: 20),

              // 2. Barre de recherche
              _buildSearchBar(),
              const SizedBox(height: 20),

              // 3. Bannières (au moins 3)
              _buildBanners(),
              const SizedBox(height: 20),

              // 4. Titre "Categories" et "See All"
              _buildSectionTitle(title: 'Categories', seeAll: true),
              const SizedBox(height: 10),

              // 5. Icônes des catégories (4 par ligne, 2 lignes)
              _buildCategoryIcons(),
              const SizedBox(height: 20),

              // 6. Titre "Nearby Medical Center" et "See All"
              _buildSectionTitle(title: 'Nearby Medical Center', seeAll: true),
              const SizedBox(height: 10),

              // 7. Images défilantes avec un petit titre
              _buildNearbyClinics(),
            ],
          ),
        ),
      ),
    );
  }

  // 1. En-tête avec location et icône de notification
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Location',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Row(
              children: const [
                Icon(Icons.location_on, color: Colors.blue, size: 20),
                SizedBox(width: 4),
                Text(
                  'Raba, Maroc',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications, size: 30),
          onPressed: () {
            // Logique pour les notifications
          },
        ),
      ],
    );
  }

  // 2. Barre de recherche
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Rechercher...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  // 3. Bannières (au moins 3)
  // 3. Bannières avec carrousel automatique et points indicateurs
Widget _buildBanners() {
  final List<String> bannerImages = [
    'assets/banners/banner5.png',
    'assets/banners/banner2.jpg',
    'assets/banners/banner3.jpg',
  ];

  

  return Column(
    children: [
      CarouselSlider(
        items: List.generate(bannerImages.length, (index) {
          return _buildBanner(bannerImages[index]);
        }),
        options: CarouselOptions(
          height: 150, // Hauteur des bannières
          autoPlay: true, // Défilement automatique
          autoPlayInterval: const Duration(seconds: 3), // Intervalle de 3 secondes
          autoPlayAnimationDuration: const Duration(milliseconds: 800), // Durée de l'animation
          autoPlayCurve: Curves.fastOutSlowIn, // Courbe d'animation
          enlargeCenterPage: true, // Agrandir la bannière centrale
          viewportFraction: 0.9, // Fraction de la vue occupée par chaque bannière
        ),
      ),
      const SizedBox(height: 10),
      // Points indicateurs
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(bannerImages.length, (index) {
          return Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == 0 ? Colors.blue : Colors.grey, // Couleur du point actif
            ),
          );
        }),
      ),
    ],
  );
}

// Méthode pour construire une bannière
Widget _buildBanner(String imagePath) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
      ),
    ),
  );
}

  // 4. Titre de section avec "See All"
  Widget _buildSectionTitle({required String title, bool seeAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if (seeAll)
          TextButton(
            onPressed: () {
              // Logique pour "See All"
            },
            child: const Text(
              'See All',
              style: TextStyle(color: Colors.blue),
            ),
          ),
      ],
    );
  }

  // 5. Icônes des catégories (4 par ligne, 2 lignes)
  Widget _buildCategoryIcons() {
    final List<Map<String, String>> categories = [
      {'icon': 'assets/categories/dentist.png', 'name': 'Dentistry'},
      {'icon': 'assets/categories/heart.png', 'name': 'Cardiologue'},
      {'icon': 'assets/categories/poumon.png', 'name': 'Pulmonono'},
      {'icon': 'assets/categories/general.png', 'name': 'General'},
      {'icon': 'assets/categories/brain.png', 'name': 'Neurology'},
      {'icon': 'assets/categories/estomac.png', 'name': 'Gastroen'},
      {'icon': 'assets/categories/laboratoire.png', 'name': 'Labo'},
      {'icon': 'assets/categories/vaccination.png', 'name': 'Vaccina..'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Désactive le défilement interne
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 icônes par ligne
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Image.asset(
              categories[index]['icon']!,
              width: 40,
              height: 40,
            ),
            const SizedBox(height: 5),
            Text(
              categories[index]['name']!,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    );
  }

  // 7. Images défilantes avec un petit titre
  // 7. Liste des cliniques proches (horizontal)
Widget _buildNearbyClinics() {
  // Liste des cliniques (vous pouvez remplacer par des données dynamiques)
  final List<ClinicCard> clinics = [
    ClinicCard(
      name: 'Clinique du Nord',
      address: '123 Rue de la Santé, Paris',
      rating: 4.5,
      reviews: 120,
      imagePath: 'assets/clinic/cl3.png', 
      distance: '2.5 km', 
      time: '10 mins', 
    ),
    ClinicCard(
      name: 'Hôpital Central',
      address: '456 Avenue des Médecins, Lyon',
      rating: 4.2,
      reviews: 95,
      imagePath: 'assets/clinic/cl4.jpeg', // Chemin de l'image locale
      distance: '3.0 km', // Distance en kilomètres
      time: '15 mins', // Temps en minutes
    ),
    ClinicCard(
      name: 'Centre Médical Sud',
      address: '789 Boulevard des Soins, Marseille',
      rating: 4.7,
      reviews: 150,
      imagePath: 'assets/clinic/cl5.jpg', 
      distance: '1.8 km', 
      time: '8 mins', 
    ),
  ];

  return SizedBox(
    height: 220, // Hauteur fixe pour la liste horizontale
    child: ListView(
      scrollDirection: Axis.horizontal, // Défilement horizontal
      children: clinics, // Utilisez la liste des cliniques
    ),
  );
}
}