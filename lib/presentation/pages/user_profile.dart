import 'package:flutter/material.dart';
import '../widgets/user_profile/profile_header.dart';
import '../widgets/user_profile/profile_stats.dart';
import '../widgets/user_profile/profile_about.dart';
import '../widgets/user_profile/profile_social_links.dart';
import '../widgets/user_profile/profile_trip_plans.dart';
import '../widgets/user_profile/profile_bookmark.dart';
import '../widgets/user_profile/profile_tab_button.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _selectedTab = 'About me';

  void _handleTabChange(String tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  void _onEditProfile() {
    // TODO: Navigate to edit-profile screen or open an edit modal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            ProfileStats(),

            // --- Tab Buttons + Edit Profile ---
            ProfileTabButtons(
              selectedTab: _selectedTab,
              onTabSelected: _handleTabChange,
              onEditProfile: _onEditProfile,
            ),

            const SizedBox(height: 20),

            // --- Conditional Content ---
            if (_selectedTab == 'About me') ...[
              ProfileAbout(),
              ProfileSocialLinks(),
            ] else if (_selectedTab == 'Trip plans') ...[
              ProfileTripPlans(),
            ] else if (_selectedTab == 'Bookmark') ...[
              ProfileBookmark(),
            ],
          ],
        ),
      ),
    );
  }
}
