import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromRGBO(22, 42, 58, 1),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Edit Profile
          _buildProfileOption(
            context,
            icon: Icons.edit,
            title: 'Edit Profile',
            onTap: () {
            },
          ),
          
          const Divider(),
          
          // Favorites
          _buildProfileOption(
            context,
            icon: Icons.favorite,
            title: 'Favorites',
            onTap: () {
             
            },
          ),
          
          const Divider(),
          
          // Notifications
          _buildProfileOption(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {
              
            },
          ),
          
          const Divider(),
          
          // Settings
          _buildProfileOption(
            context,
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              
            },
          ),
          
          const Divider(),
          
          // Help & Support
          _buildProfileOption(
            context,
            icon: Icons.help,
            title: 'Help & Support',
            onTap: () {
              
            },
          ),
          
          const Divider(),
          
          // Terms & Conditions
          _buildProfileOption(
            context,
            icon: Icons.description,
            title: 'Terms & Conditions',
            onTap: () {
              
            },
          ),
          
          const Divider(),
          
          // Logout
          _buildProfileOption(
            context,
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              
            },
          ),
          
        ],
      ),
    );
  }
  
  // Method to build a profile option
  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey,
        size: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 18,
      ),
      onTap: onTap,
    );
  }
}