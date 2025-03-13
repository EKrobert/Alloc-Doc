import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'clinic_card.dart'; // Import du widget personnalisé

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();
  LatLng? _selectedClinicPosition; // Position de la clinique sélectionnée
  final TextEditingController _searchController = TextEditingController(); // Contrôleur pour la barre de recherche
  List<Map<String, dynamic>> filteredClinics = []; // Liste filtrée des cliniques

  final List<Map<String, dynamic>> clinics = [
    {
      "name": "Sunrise Health Clinic",
      "address": "12.2 Oak Street, CA 88785",
      "rating": 5.0,
      "reviews": 65,
      "position": LatLng(45.691563, -122.727433), // Coin supérieur gauche
      "imagePath": "assets/clinic/cl1.jpg",
      "markerImage": "assets/markers/marker1.jpg",
      "distance": "2km", // Ajout de la distance
      "time": "40min", // Ajout du temps
    },
    {
      "name": "City Medical Center",
      "address": "34.5 Pine Street, CA 88785",
      "rating": 4.8,
      "reviews": 120,
      "position": LatLng(45.691563, -122.687433), // Coin supérieur droit
      "imagePath": "assets/clinic/cl2.jpg",
      "markerImage": "assets/markers/marker2.jpg",
      "distance": "3km", // Ajout de la distance
      "time": "45min", // Ajout du temps
    },
    {
      "name": "Green Valley Hospital",
      "address": "56.7 Elm Street, CA 88785",
      "rating": 4.5,
      "reviews": 90,
      "position": LatLng(45.651563, -122.727433), // Coin inférieur gauche
      "imagePath": "assets/clinic/cl3.png",
      "markerImage": "assets/markers/marker3.jpg",
      "distance": "4km", // Ajout de la distance
      "time": "50min", // Ajout du temps
    },
    {
      "name": "Blue Sky Clinic",
      "address": "78.9 Maple Street, CA 88785",
      "rating": 4.7,
      "reviews": 110,
      "position": LatLng(45.651563, -122.687433), // Coin inférieur droit
      "imagePath": "assets/clinic/cl4.jpeg",
      "markerImage": "assets/markers/marker4.jpg",
      "distance": "6km", // Ajout de la distance
      "time": "51min", // Ajout du temps
    },
    {
      "name": "Golden Health Center",
      "address": "101.1 Maple Street, CA 88785",
      "rating": 4.9,
      "reviews": 150,
      "position": LatLng(45.671563, -122.707433), // Centre du rectangle
      "imagePath": "assets/clinic/cl5.jpg",
      "markerImage": "assets/markers/marker5.jpg",
      "distance": "9km", // Ajout de la distance
      "time": "1H", // Ajout du temps
    },
    {
      "name": "Silver Care Clinic",
      "address": "202.2 Elm Street, CA 88785",
      "rating": 4.6,
      "reviews": 80,
      "position": LatLng(45.671563, -122.667433), // À droite du centre
      "imagePath": "assets/clinic/cl6.jpeg",
      "markerImage": "assets/markers/marker6.jpg",
      "distance": "10km", // Ajout de la distance
      "time": "1h02min", // Ajout du temps
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredClinics = clinics; // Initialise la liste filtrée avec toutes les cliniques
    _searchController.addListener(_filterClinics); // Écoute les changements dans la barre de recherche
  }

  @override
  void dispose() {
    _searchController.dispose(); // Nettoie le contrôleur
    super.dispose();
  }

  // Fonction pour filtrer les cliniques en fonction de la recherche
  void _filterClinics() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredClinics = clinics.where((clinic) {
        final name = clinic["name"].toString().toLowerCase();
        final address = clinic["address"].toString().toLowerCase();
        return name.contains(query) || address.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Carte OpenStreetMap
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: LatLng(45.671563, -122.707433), // Centre de la carte
              zoom: 12.0, // Zoom ajusté pour que tous les points soient visibles
              onTap: (_, __) {
                // Ferme la popup si l'utilisateur clique ailleurs sur la carte
                setState(() {
                  _selectedClinicPosition = null;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: filteredClinics.map((clinic) {
                  return Marker(
                    point: clinic["position"],
                    width: 50.0, // Taille du marqueur
                    height: 50.0,
                    builder: (ctx) => GestureDetector(
                      onTap: () {
                        // Affiche la popup pour cette clinique
                        setState(() {
                          _selectedClinicPosition = clinic["position"];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.purple, // Contour violet
                            width: 2.0,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            clinic["markerImage"], // Image du marqueur
                            width: 46.0, // Taille de l'image
                            height: 46.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // Barre de recherche en haut
          Positioned(
            top: 25,
            left: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search Doctor, Hospital",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                            _filterClinics();
                          },
                        )
                      : null,
                ),
              ),
            ),
          ),

          // Liste horizontale des cartes des détails (en bas)
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Container(
              height: 280, // Hauteur augmentée pour les cartes des détails
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: filteredClinics.length,
                itemBuilder: (context, index) {
                  final clinic = filteredClinics[index];
                  return ClinicCard(
                    name: clinic["name"],
                    address: clinic["address"],
                    rating: clinic["rating"],
                    reviews: clinic["reviews"],
                    imagePath: clinic["imagePath"],
                    distance: clinic["distance"], // Ajout de la distance
                    time: clinic["time"], // Ajout du temps
                  );
                },
              ),
            ),
          ),

          // Popup pour afficher les détails de la clinique (au-dessus des cartes en bas)
          if (_selectedClinicPosition != null)
            Positioned(
              left: 16,
              right: 16,
              bottom: 320, // Ajuste la position pour ne pas chevaucher les cartes en bas
              child: ClinicCard(
                name: filteredClinics.firstWhere((clinic) =>
                    clinic["position"] == _selectedClinicPosition)["name"],
                address: filteredClinics.firstWhere((clinic) =>
                    clinic["position"] == _selectedClinicPosition)["address"],
                rating: filteredClinics.firstWhere((clinic) =>
                    clinic["position"] == _selectedClinicPosition)["rating"],
                reviews: filteredClinics.firstWhere((clinic) =>
                    clinic["position"] == _selectedClinicPosition)["reviews"],
                imagePath: filteredClinics.firstWhere((clinic) =>
                    clinic["position"] == _selectedClinicPosition)["imagePath"],
                distance: filteredClinics.firstWhere((clinic) =>
                    clinic["position"] == _selectedClinicPosition)["distance"], // Ajout de la distance
                time: filteredClinics.firstWhere((clinic) =>
                    clinic["position"] == _selectedClinicPosition)["time"], // Ajout du temps
              ),
            ),
        ],
      ),
    );
  }
}