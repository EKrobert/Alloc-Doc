import 'package:allodoc/screens/booking/all_doctors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart'; // Pour la localisation
import 'dart:math' as math;
import 'clinic_card.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();
  LatLng? _selectedClinicPosition; // Position de la clinique sélectionnée
  
  List<Map<String, dynamic>> filteredClinics =
      []; // Liste filtrée des cliniques
  List<Map<String, dynamic>> clinics =[]; // Liste des cliniques (sera générée dynamiquement)
  LatLng? _userLocation; // Position de l'utilisateur
  bool _isLoading = true; // Indicateur de chargement

  // Liste des données de base pour les cliniques
  final List<Map<String, dynamic>> clinicData = [
    {
      "name": "Sunrise Health Clinic",
      "address": "Oak Street, CA",
      "rating": 5.0,
      "reviews": 65,
      "imagePath": "assets/clinic/cl1.jpg",
      "markerImage": "assets/markers/marker1.jpg",
    },
    {
      "name": "City Medical Center",
      "address": "Pine Street, CA",
      "rating": 4.8,
      "reviews": 120,
      "imagePath": "assets/clinic/cl2.jpg",
      "markerImage": "assets/markers/marker2.jpg",
    },
    {
      "name": "Green Valley Hospital",
      "address": "Elm Street, CA",
      "rating": 4.5,
      "reviews": 90,
      "imagePath": "assets/clinic/cl3.png",
      "markerImage": "assets/markers/marker3.jpg",
    },
    {
      "name": "Blue Sky Clinic",
      "address": "Maple Street, CA",
      "rating": 4.7,
      "reviews": 110,
      "imagePath": "assets/clinic/cl4.jpeg",
      "markerImage": "assets/markers/marker4.jpg",
    },
    {
      "name": "Golden Health Center",
      "address": "Maple Street, CA",
      "rating": 4.9,
      "reviews": 150,
      "imagePath": "assets/clinic/cl5.jpg",
      "markerImage": "assets/markers/marker5.jpg",
    },
    {
      "name": "Silver Care Clinic",
      "address": "Elm Street, CA",
      "rating": 4.6,
      "reviews": 80,
      "imagePath": "assets/clinic/cl6.jpeg",
      "markerImage": "assets/markers/marker6.jpg",
    },
  ];

  @override
  void initState() {
    super.initState();
    _getUserLocation(); // Obtient la localisation de l'utilisateur au démarrage
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Fonction pour obtenir la localisation de l'utilisateur
  void _getUserLocation() async {
    setState(() {
      _isLoading = true;
    });

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Si le service de localisation est désactivé, demande à l'utilisateur de l'activer
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Veuillez activer la localisation pour utiliser cette fonctionnalité.")),
      );
      _generateClinicsAroundDefaultLocation();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Si l'utilisateur refuse la permission, affiche un message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("La permission de localisation est requise.")),
        );
        _generateClinicsAroundDefaultLocation();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Si l'utilisateur a refusé la permission de manière permanente
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "La permission de localisation est refusée de manière permanente.")),
      );
      _generateClinicsAroundDefaultLocation();
      return;
    }

    try {
      // Obtient la position actuelle de l'utilisateur
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
      });

      // Génère les cliniques autour de la position de l'utilisateur
      _generateClinicsAroundUserLocation();

      // Centre la carte sur la position de l'utilisateur
      mapController.move(_userLocation!, 13.0);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Erreur lors de l'obtention de la position: $e")),
      );
      _generateClinicsAroundDefaultLocation();
    }
  }

  // Fonction pour générer des cliniques autour d'une position par défaut
  void _generateClinicsAroundDefaultLocation() {
    final defaultLocation =
        LatLng(45.671563, -122.707433); // Position par défaut
    _generateClinicsAroundLocation(defaultLocation);
  }

  // Fonction pour générer des cliniques autour de la position de l'utilisateur
  void _generateClinicsAroundUserLocation() {
    if (_userLocation != null) {
      _generateClinicsAroundLocation(_userLocation!);
    } else {
      _generateClinicsAroundDefaultLocation();
    }
  }

  // Fonction pour générer des cliniques autour d'une position donnée
  void _generateClinicsAroundLocation(LatLng centerPosition) {
    final random = math.Random();
    List<Map<String, dynamic>> generatedClinics = [];

    for (var i = 0; i < clinicData.length; i++) {
      // Génère une position aléatoire dans un rayon de 5 km autour de la position centrale
      // 0.045 degré ≈ 5 km (approximation)
      final double latOffset = (random.nextDouble() - 0.5) * 0.045;
      final double lngOffset = (random.nextDouble() - 0.5) * 0.045;
      final LatLng clinicPosition = LatLng(
        centerPosition.latitude + latOffset,
        centerPosition.longitude + lngOffset,
      );

      // Calcule la distance réelle entre la position centrale et la position de la clinique
      final double distanceInMeters = Geolocator.distanceBetween(
        centerPosition.latitude,
        centerPosition.longitude,
        clinicPosition.latitude,
        clinicPosition.longitude,
      );

      // Convertit la distance en km et la formatte pour l'affichage
      final double distanceInKm = distanceInMeters / 1000;
      final String formattedDistance = distanceInKm.toStringAsFixed(1) + "km";

      // Calcule un temps estimé basé sur la distance (vitesse moyenne de marche ~ 5 km/h)
      final int timeInMinutes = (distanceInKm / 5 * 60).round();
      String formattedTime;
      if (timeInMinutes >= 60) {
        final int hours = timeInMinutes ~/ 60;
        final int minutes = timeInMinutes % 60;
        formattedTime =
            "${hours}h${minutes > 0 ? minutes.toString().padLeft(2, '0') : ''}";
      } else {
        formattedTime = "${timeInMinutes}min";
      }

      // Crée une adresse plus précise avec une numéro aléatoire
      final String streetNumber =
          ((random.nextDouble() * 200) + 1).toStringAsFixed(1);
      final String address = "$streetNumber ${clinicData[i]["address"]}";

      // Crée l'entrée pour la clinique
      Map<String, dynamic> clinic = {
        ...clinicData[i],
        "address": address, // Adresse avec numéro
        "position": clinicPosition,
        "distance": formattedDistance,
        "time": formattedTime,
        "distanceValue": distanceInKm, // Pour le tri
      };

      generatedClinics.add(clinic);
    }

    // Trie les cliniques par distance croissante
    generatedClinics.sort((a, b) =>
        (a["distanceValue"] as double).compareTo(b["distanceValue"] as double));

    setState(() {
      clinics = generatedClinics;
      filteredClinics = generatedClinics;
      _isLoading = false;
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
              center: _userLocation ??
                  LatLng(45.671563, -122.707433), // Centre sur la position de l'utilisateur ou une position par défaut
              zoom: 12.0,
              onTap: (_, __) {
                setState(() {
                  _selectedClinicPosition = null;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  // Marqueur pour la position de l'utilisateur
                  if (_userLocation != null)
                    Marker(
                      point: _userLocation!,
                      width: 40.0,
                      height: 40.0,
                      builder: (ctx) => Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 40.0,
                      ),
                    ),

                  // Marqueurs pour les cliniques
                  ...filteredClinics.map((clinic) {
                    return Marker(
                      point: clinic["position"],
                      width: 50.0,
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
                              color: Colors.purple,
                              width: 2.0,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              clinic["markerImage"],
                              width: 46.0,
                              height: 46.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ],
          ),

          // Indicateur de chargement
          if (_isLoading)
            Container(
              color: Colors.white.withOpacity(0.7),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),

          // Barre de recherche en haut
          Positioned(
            top: 40, // Augmenter la distance par rapport au haut de l'écran
            left: 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                // Redirige vers la page de recherche
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorSearchScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12), // Plus de padding
                height: 50, // Hauteur fixe pour la barre de recherche
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(12), // Bordure plus arrondie
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6, // Ombre plus douce
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search,
                        color: Colors.grey,
                        size: 24), 
                    SizedBox(width: 12), 
                    Text(
                      "Search Doctor, Hospital",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16, 
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Liste horizontale des cartes des détails 
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Container(
              height: 280,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: filteredClinics.length,
                itemBuilder: (context, index) {
                  final clinic = filteredClinics[index];
                  return GestureDetector(
                    onTap: () {
                      // Centre la carte sur la clinique sélectionnée
                      mapController.move(clinic["position"], 15.0);
                      setState(() {
                        _selectedClinicPosition = clinic["position"];
                      });
                    },
                    child: ClinicCard(
                      name: clinic["name"],
                      address: clinic["address"],
                      rating: clinic["rating"],
                      reviews: clinic["reviews"],
                      imagePath: clinic["imagePath"],
                      distance: clinic["distance"],
                      time: clinic["time"],
                    ),
                  );
                },
              ),
            ),
          ),

          // Popup pour afficher les détails de la clinique 
          if (_selectedClinicPosition != null && filteredClinics.isNotEmpty)
            Positioned(
              left: 16,
              right: 16,
              bottom: 320,
              child: Builder(
                builder: (context) {
                  // Recherche la clinique correspondant à la position sélectionnée
                  final selectedClinic = filteredClinics.firstWhere(
                    (clinic) => clinic["position"] == _selectedClinicPosition,
                    orElse: () => filteredClinics[0],
                  );

                  return ClinicCard(
                    name: selectedClinic["name"],
                    address: selectedClinic["address"],
                    rating: selectedClinic["rating"],
                    reviews: selectedClinic["reviews"],
                    imagePath: selectedClinic["imagePath"],
                    distance: selectedClinic["distance"],
                    time: selectedClinic["time"],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
