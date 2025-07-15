import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/presentation/pages/edit_route_page.dart';
import 'package:triptery/presentation/pages/trip/trip_flow_control_sheet.dart';

class FloatingMenu extends StatefulWidget {
  const FloatingMenu({Key? key}) : super(key: key);

  @override
  State<FloatingMenu> createState() => _FloatingMenuState();
}

class _FloatingMenuState extends State<FloatingMenu> with SingleTickerProviderStateMixin {
  bool isOpen = false;

  void toggleMenu() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  void _openBottomModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      showDragHandle: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: TripFlowControlSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // 1st Button
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          right: 20,
          bottom: isOpen ? 140 : 80,
          child: AnimatedOpacity(
            opacity: isOpen ? 1 : 0,
            duration: Duration(milliseconds: 300),
            child: Row(
              children: [
                _buildLabel("Trip\nSetting"),
                const SizedBox(width: 8),
                _buildCircleIcon(LucideIcons.briefcase, "TripSetting"),
              ],
            ),
          ),
        ),

        // 2nd Button
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          right: 20,
          bottom: isOpen ? 80 : 80,
          child: AnimatedOpacity(
            opacity: isOpen ? 1 : 0,
            duration: Duration(milliseconds: 300),
            child: Row(
              children: [
                _buildLabel("Edit\nRouting"),
                const SizedBox(width: 8),
                _buildCircleIcon(LucideIcons.route, "EditRouting"),
              ],
            ),
          ),
        ),

        // Main FAB
        Positioned(
          right: 16,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: toggleMenu,
            elevation: 4,
            shape: CircleBorder(),
            backgroundColor: Colors.transparent,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFFEB755), Color(0xFFFE7D57)],
                ),
              ),
              child: Icon(LucideIcons.pencilLine, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircleIcon(IconData icon, String type) {
    return GestureDetector(
      onTap: () {
        if(type == "TripSetting") {
          _openBottomModal(); 
          toggleMenu(); 
        } else if(type == "EditRouting") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditRoutePage()),
          );
          toggleMenu();
        }
      }, 
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        padding: EdgeInsets.all(12),
        child: Icon(icon, color: Color(0xFFFE7D57)),
      )
    ); 
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            shadows: [Shadow(blurRadius: 3, color: Colors.black)],
          )),
    );
  }
}