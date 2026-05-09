// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import 'package:Zewg/core/constants/route_paths.dart';

// class AdminDashboard extends StatelessWidget {
//   const AdminDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F2F2),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'The Academic Curator',
//               style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             Text(
//               'ADMIN DASHBOARD',
//               style: TextStyle(color: Colors.grey[500], fontSize: 10, letterSpacing: 1.2),
//             ),
//           ],
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(24.0),
//         children: [
//           const Text(
//             'Welcome back,\nCurator.',
//             style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF004D61)),
//           ),
//           const SizedBox(height: 12),
//           const Text(
//             'Manage your academic ecosystem and student opportunities from one central hub.',
//             style: TextStyle(fontSize: 15, color: Color(0xFF555555), height: 1.4),
//           ),
//           const SizedBox(height: 24),
          
//           // New Post Button
//           ElevatedButton.icon(
//             onPressed: () => context.go(RoutePaths.adminAddOpportunity),
//             icon: const Icon(Icons.add_circle_outline, size: 20),
//             label: const Text('New Post', style: TextStyle(fontWeight: FontWeight.bold)),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF003D4C),
//               foregroundColor: Colors.white,
//               minimumSize: const Size(double.infinity, 56),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//             ),
//           ),
          
//           const SizedBox(height: 32),

//           // Top Stats Cards
//           _buildStatCard('TOTAL POSTS', '1,284', Colors.white, const Color(0xFF004D61)),
//           const SizedBox(height: 16),
//           _buildStatCard('PENDING APPROVAL', '42', const Color(0xFFE8E8E8), const Color(0xFF7A542E)),
//           const SizedBox(height: 16),
//           _buildStatCard('ACTIVE STUDENTS', '8.6k', const Color(0xFF005F73), Colors.white),

//           const SizedBox(height: 40),
//           const Text(
//             'Managed Opportunities',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF004D61)),
//           ),
//           const SizedBox(height: 16),

//           // Filter Chips
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 _buildFilterChip('All', true),
//                 _buildFilterChip('Jobs', false),
//                 _buildFilterChip('Internships', false),
//                 _buildFilterChip('Scholarships', false),
//               ],
//             ),
//           ),

//           const SizedBox(height: 24),

//           // Opportunity List
//           _buildOpportunityItem(
//             imageUrl: 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=800',
//             label: 'INTERNSHIP',
//             title: 'Senior UX Research Intern',
//             posted: 'Posted 2h ago',
//             tags: ['Remote', 'Paid', 'London, UK'],
//             company: 'DesignSphere Global',
//             views: '1.2k',
//             isNew: true,
//             onEdit: () => context.go(RoutePaths.adminEditOpportunity),
//           ),
//           const SizedBox(height: 20),
//           _buildOpportunityItem(
//             imageUrl: 'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=800',
//             label: 'SCHOLARSHIP',
//             title: 'Merit-Based Research Grant 2024',
//             posted: 'Posted yesterday',
//             tags: ['Global', 'Fully Funded', 'Academic'],
//             company: 'Ivy Academic Foundation',
//             views: '4.8k',
//             onEdit: () => context.go(RoutePaths.adminEditOpportunity),
//           ),
          
//           const SizedBox(height: 100),
//         ],
//       ),
//       bottomNavigationBar: _buildAdminBottomNav(context),
//     );
//   }

//   Widget _buildStatCard(String label, String value, Color bg, Color textColor) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
//       decoration: BoxDecoration(
//         color: bg,
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: TextStyle(color: textColor.withOpacity(0.6), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
//           const SizedBox(height: 8),
//           Text(value, style: TextStyle(color: textColor, fontSize: 36, fontWeight: FontWeight.w900)),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterChip(String label, bool isSelected) {
//     return Container(
//       margin: const EdgeInsets.only(right: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       decoration: BoxDecoration(
//         color: isSelected ? const Color(0xFF003D4C) : const Color(0xFFE0E0E0),
//         borderRadius: BorderRadius.circular(100),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF555555), fontWeight: FontWeight.w600),
//       ),
//     );
//   }

//   Widget _buildOpportunityItem({
//     required String imageUrl,
//     required String label,
//     required String title,
//     required String posted,
//     required List<String> tags,
//     required String company,
//     required String views,
//     bool isNew = false,
//     VoidCallback? onEdit,
//   }) {
//     return Container(
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               Image.network(imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover),
//               Positioned(
//                 top: 12,
//                 left: 12,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
//                   child: Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     if (isNew) ...[
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                         decoration: BoxDecoration(color: const Color(0xFFFFEAD2), borderRadius: BorderRadius.circular(4)),
//                         child: const Text('NEW', style: TextStyle(color: Color(0xFFD68A3E), fontSize: 9, fontWeight: FontWeight.bold)),
//                       ),
//                       const SizedBox(width: 8),
//                     ],
//                     Text(posted, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF003D4C))),
//                 const SizedBox(height: 12),
//                 Wrap(
//                   spacing: 8,
//                   children: tags.map((tag) => Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(color: const Color(0xFFE8E8E8), borderRadius: BorderRadius.circular(8)),
//                     child: Text(tag, style: const TextStyle(fontSize: 11, color: Color(0xFF666666))),
//                   )).toList(),
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Icon(Icons.business_outlined, size: 16, color: Colors.grey[600]),
//                     const SizedBox(width: 6),
//                     Text(company, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
//                     const Spacer(),
//                     _buildActionButton(
//                       Icons.edit_outlined,
//                       const Color(0xFFE0E0E0),
//                       onTap: onEdit,
//                     ),
//                     const SizedBox(width: 8),
//                     _buildActionButton(Icons.delete_outline, const Color(0xFFFFEBEE), iconColor: Colors.red),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(Icons.visibility_outlined, size: 16, color: Colors.grey[600]),
//                     const SizedBox(width: 6),
//                     Text('$views views', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButton(IconData icon, Color bg, {Color iconColor = Colors.black87, VoidCallback? onTap}) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         customBorder: const CircleBorder(),
//         child: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
//           child: Icon(icon, size: 18, color: iconColor),
//         ),
//       ),
//     );
//   }

//   Widget _buildAdminBottomNav(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildAdminNavItem(context, Icons.dashboard, 'DASHBOARD', true, () => context.go(RoutePaths.adminDashboard)),
//           _buildAdminNavItem(context, Icons.add_circle_outline, 'ADD NEW', false, () => context.go(RoutePaths.adminAddOpportunity)),
//         ],
//       ),
//     );
//   }

//   Widget _buildAdminNavItem(BuildContext context, IconData icon, String label, bool isActive, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, color: isActive ? const Color(0xFF003D4C) : Colors.grey),
//             const SizedBox(height: 4),
//             Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isActive ? const Color(0xFF003D4C) : Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }
// }
