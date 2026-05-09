import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/routing/navigation_helpers.dart';

class OpportunityDetails extends StatelessWidget {
  const OpportunityDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004D40)),
          onPressed: () => popOrGo(context, RoutePaths.homeAll),
        ),
        title: const Text('Zewg', style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => context.go(RoutePaths.profile),
              behavior: HitTestBehavior.opaque,
              child: CircleAvatar(backgroundColor: Colors.grey[300], child: const Icon(Icons.person, color: Colors.white)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 20),
            _buildInfoCard(Icons.business_outlined, "ORGANIZATION", "Global Innovation Lab"),
            _buildInfoCard(Icons.calendar_today_outlined, "DEADLINE", "Oct 24, 2023"),
            _buildInfoCard(Icons.location_on_outlined, "LOCATION", "Remote / San Francisco"),
            const SizedBox(height: 30),
            const Text("About the Opportunity", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
            const SizedBox(height: 12),
            const Text(
              "The Future Tech Innovators Fellowship is designed for undergraduate students who are pushing the boundaries of artificial intelligence and sustainable technology. This prestigious program provides not just financial support, but a direct pipeline into some of the most advanced research labs in the world.\n\nOver the course of 12 months, fellows will work under the mentorship of industry pioneers, attend exclusive summits, and receive a \$15,000 research stipend.",
              style: TextStyle(color: Colors.black54, height: 1.5),
            ),
            const SizedBox(height: 30),
            _buildRequirementsSection(),
            const SizedBox(height: 30),
            _buildApplicationSteps(),
            const SizedBox(height: 20),
            const Text("Link", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
              child: const Text("https://opportunity.com/apply", style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: ()=> context.go(RoutePaths.journey),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004D40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Completed", style: TextStyle(color: Colors.white, fontSize: 16)),
                    SizedBox(width: 8),
                    Icon(Icons.open_in_new, size: 18, color: Colors.white),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF002F2F),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFD1C4E9), borderRadius: BorderRadius.circular(4)),
            child: const Text("SCHOLARSHIP", style: TextStyle(color: Color(0xFF512DA8), fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          const Text(
            "Future Tech\nInnovators\nFellowship",
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, height: 1.1),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: const Color(0xFF00796B)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 1.1)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRequirementsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Key Requirements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
          const SizedBox(height: 16),
          _buildBulletItem("Currently enrolled in a full-time undergraduate program (Junior or Senior year preferred)."),
          _buildBulletItem("Minimum 3.5 GPA on a 4.0 scale within STEM-related disciplines."),
          _buildBulletItem("Demonstrated experience in independent research or community-led tech projects."),
        ],
      ),
    );
  }

  Widget _buildBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.teal, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.black87, fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildApplicationSteps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.rocket_launch_outlined, color: Color(0xFF004D40)),
            SizedBox(width: 8),
            Text("Application Steps", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
          ],
        ),
        const SizedBox(height: 20),
        _buildStep(1, "Submit Portfolio", "Upload your GitHub or Behance link", true),
        _buildStep(2, "Statement of Purpose", "500-word essay on your vision", false),
        _buildStep(3, "Letter of Recommendation", "From a professor or mentor", false),
      ],
    );
  }

  Widget _buildStep(int number, String title, String sub, bool isDone) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: isDone ? Colors.green : Colors.grey[300],
                child: isDone ? const Icon(Icons.check, size: 14, color: Colors.white) : Text("$number", style: const TextStyle(fontSize: 12, color: Colors.black)),
              ),
              Expanded(child: Container(width: 1, color: Colors.grey[300])),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
