import 'package:allodoc/screens/booking/appointment.dart';
import 'package:flutter/material.dart';

class DoctorSearchScreen extends StatefulWidget {
  const DoctorSearchScreen({Key? key}) : super(key: key);

  @override
  _DoctorSearchScreenState createState() => _DoctorSearchScreenState();
}

class _DoctorSearchScreenState extends State<DoctorSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  List<String> categories = ['All', 'General', 'Cardiologue', 'Dentiste', 'Pédiatre', 'Ophtalmologue', 'Dermatologue', 'Neurologue'];
  List<Map<String, dynamic>> filteredDoctors = [];
  
  // Données fictives des docteurs
  final List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. Roberto",
      "specialty": "Cardiologue",
      "location": "Rabat, Maroc",
      "rating": 4.8,
      "reviews": 124,
      "image": "assets/doctors/doctor1.png",
      "isFavorite": false,
    },
    {
      "name": "Dr. Thomas Bernard",
      "specialty": "Généraliste",
      "location": "Salé, Maroc",
      "rating": 4.5,
      "reviews": 89,
      "image": "assets/doctors/doctor2.png",
      "isFavorite": false,
    },
    {
      "name": "Dr. Sophie Dubois",
      "specialty": "Pédiatre",
      "location": "Rabat, Maroc",
      "rating": 4.9,
      "reviews": 156,
      "image": "assets/doctors/doctor3.png",
      "isFavorite": false,
    },
    {
      "name": "Dr. Michel Leroy",
      "specialty": "Dentiste",
      "location": "Salé, Maroc",
      "rating": 4.6,
      "reviews": 78,
      "image": "assets/doctors/doctor4.png",
      "isFavorite": false,
    },
    {
      "name": "Dr. Clara Petit",
      "specialty": "Dermatologue",
      "location": "Toulouse, Maroc",
      "rating": 4.7,
      "reviews": 102,
      "image": "assets/doctors/doctor4.png",
      "isFavorite": false,
    },
    {
      "name": "Dr. Antoine Roux",
      "specialty": "Ophtalmologue",
      "location": "Casa, Maroc",
      "rating": 4.4,
      "reviews": 67,
      "image": "assets/doctors/doctor3.png",
      "isFavorite": false,
    },
    {
      "name": "Dr. Juliette Moreau",
      "specialty": "Neurologue",
      "location": "Medina, Maroc",
      "rating": 4.8,
      "reviews": 115,
      "image": "assets/doctors/doctor2.png",
      "isFavorite": false,
    },
    {
      "name": "Dr. Nicolas Lambert",
      "specialty": "Généraliste",
      "location": "Temara, Maroc",
      "rating": 4.3,
      "reviews": 94,
      "image": "assets/doctors/doctor1.png",
      "isFavorite": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredDoctors = List.from(doctors);
    _searchController.addListener(_filterDoctors);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filtrer les docteurs en fonction de la recherche et de la catégorie
  void _filterDoctors() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredDoctors = doctors.where((doctor) {
        final nameMatches = doctor["name"].toString().toLowerCase().contains(query);
        final specialtyMatches = doctor["specialty"].toString().toLowerCase().contains(query);
        final locationMatches = doctor["location"].toString().toLowerCase().contains(query);
        final categoryMatches = _selectedCategory == 'All' || 
                               doctor["specialty"] == _selectedCategory;
        
        return (nameMatches || specialtyMatches || locationMatches) && categoryMatches;
      }).toList();
    });
  }

  // Mettre à jour la catégorie sélectionnée
  void _updateCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _filterDoctors();
  }

  // Basculer l'état favori d'un docteur
  void _toggleFavorite(int index) {
    setState(() {
      final doctorName = filteredDoctors[index]["name"];
      // Trouver le docteur dans la liste originale et mettre à jour son état favori
      final originalIndex = doctors.indexWhere((d) => d["name"] == doctorName);
      if (originalIndex != -1) {
        doctors[originalIndex]["isFavorite"] = !doctors[originalIndex]["isFavorite"];
        filteredDoctors[index]["isFavorite"] = doctors[originalIndex]["isFavorite"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        automaticallyImplyLeading: true, // Active la flèche de retour automatique
        title: Text(
          'All doctors',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Barre de recherche
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search doctors, specialties...",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              _searchController.clear();
                              _filterDoctors();
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ),
            
            // Liste de catégories horizontale
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == _selectedCategory;
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: GestureDetector(
                      onTap: () => _updateCategory(category),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color.fromRGBO(22, 42, 58, 1) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Nombre de docteurs trouvés
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${filteredDoctors.length} doctors found',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
            
            // Liste des docteurs
Expanded(
  child: ListView.builder(
    padding: EdgeInsets.symmetric(horizontal: 16),
    itemCount: filteredDoctors.length,
    itemBuilder: (context, index) {
      final doctor = filteredDoctors[index];
      
      return GestureDetector(
        onTap: () {
          // Rediriger vers la page de réservation
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookAppointmentScreen(doctor: doctor),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image du docteur
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  child: Image.asset(
                    doctor["image"],
                    width: 100,
                    height: 140,
                    fit: BoxFit.cover,
                    // Utilisation d'un placeholder si l'image n'existe pas
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 100,
                      height: 140,
                      color: Colors.grey[300],
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                  ),
                ),
                
                // Informations du docteur
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nom et icône de favori
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                doctor["name"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _toggleFavorite(index),
                              child: Icon(
                                doctor["isFavorite"] 
                                    ? Icons.favorite 
                                    : Icons.favorite_border,
                                color: doctor["isFavorite"] 
                                    ? Colors.red 
                                    : Colors.grey,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                        
                        // Ligne séparatrice
                        Divider(height: 16, thickness: 1),
                        
                        // Spécialité
                        Text(
                          doctor["specialty"],
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6),
                        
                        // Localisation
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: Colors.grey),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                doctor["location"],
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        
                        // Évaluation et nombre d'avis
                        Row(
                          children: [
                            // Étoiles
                            Row(
                              children: List.generate(5, (i) {
                                return Icon(
                                  i < doctor["rating"].floor() 
                                      ? Icons.star 
                                      : (i < doctor["rating"] 
                                          ? Icons.star_half 
                                          : Icons.star_border),
                                  color: Colors.amber,
                                  size: 16,
                                );
                              }),
                            ),
                            SizedBox(width: 4),
                            Text(
                              doctor["rating"].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              " | ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "${doctor["reviews"]} reviews",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),
          ],
        ),
      ),
    );
  }
}