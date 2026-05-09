// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import 'package:zewg/core/constants/route_paths.dart';
// import 'package:zewg/core/routing/navigation_helpers.dart';

// class AddOpportunityPage extends StatelessWidget {
//   const AddOpportunityPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9FB),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF004D61)),
//           onPressed: () => popOrGo(context, RoutePaths.adminDashboard),
//         ),
//         title: const Text(
//           'Add Opportunity',
//           style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Curate Excellence',
//               style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF004D61)),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Create a new entry for the global student community. Your precision helps shape professional futures.',
//               style: TextStyle(fontSize: 14, color: Color(0xFF555555), height: 1.4),
//             ),
//             const SizedBox(height: 32),

//             // Form Fields
//             _buildLabel('Opportunity Title'),
//             _buildTextField('e.g. Senior Research Fellowship 2024'),

//             _buildLabel('Category'),
//             _buildDropdownField('Job'),

//             _buildLabel('Deadline'),
//             _buildTextField('mm/dd/yyyy', suffixIcon: Icons.calendar_today_outlined),

//             const SizedBox(height: 32),
            
//             // Work Context Section
//             _buildSectionHeader(Icons.work_outline, 'Work Context'),
//             _buildFormCard([
//               _buildLabel('WORK TYPE', isSmall: true),
//               _buildDropdownField('Remote', isLight: true),
//               _buildLabel('COMPENSATION', isSmall: true),
//               _buildDropdownField('Paid', isLight: true),
//               _buildTextField('Amount or range (e.g. 50k - 70k)', prefixIcon: Icons.attach_money, isLight: true),
//               _buildLabel('LOCATION', isSmall: true),
//               _buildTextField('e.g. San Francisco, CA or Global', prefixIcon: Icons.location_on_outlined, isLight: true),
//             ]),

//             const SizedBox(height: 32),

//             // Key Requirements Section
//             _buildSectionHeader(Icons.verified_outlined, 'Key Requirements'),
//             _buildLabel('Education'),
//             _buildTextField('Degree, major, or specific academic standing...', maxLines: 3),
//             _buildLabel('Experience'),
//             _buildTextField('Years of experience, specific industry roles...', maxLines: 3),
//             _buildLabel('Skills'),
//             _buildTextField('Technical proficiencies, soft skills, or certifications...', maxLines: 2),

//             _buildLabel('Detailed Description'),
//             _buildTextField('Describe the benefits and expectations of this opportunity...', maxLines: 6),

//             const SizedBox(height: 32),

//             // Application Roadmap
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildSectionHeader(Icons.account_tree_outlined, 'Application Roadmap'),
//                 TextButton.icon(
//                   onPressed: () {},
//                   icon: const Icon(Icons.add_circle_outline, size: 18),
//                   label: const Text('ADD STEP', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//                 )
//               ],
//             ),
//             _buildRoadmapStep(1, 'Step Title (e.g. Submit Portfolio)', 'Brief description of this phase...', isActive: true),
//             _buildRoadmapStep(2, 'Step Title (e.g. Interview)', 'Brief description of this phase...', isActive: false, isLast: true),

//             const SizedBox(height: 32),

//             _buildLabel('Application URL'),
//             _buildTextField('https://opportunity.com/apply', prefixIcon: Icons.link),

//             const SizedBox(height: 24),

//             // Upload Area
//             _buildUploadPlaceholder(),

//             const SizedBox(height: 40),

//             // Publish Button
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF003D4C),
//                 minimumSize: const Size(double.infinity, 64),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//               ),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Publish Opportunity', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//                   SizedBox(width: 12),
//                   Icon(Icons.send_outlined, color: Colors.white),
//                 ],
//               ),
//             ),
            
//             const Center(
//               child: Padding(
//                 padding: EdgeInsets.only(top: 16.0),
//                 child: Text('SAVED AS DRAFT AUTOMATICALLY', style: TextStyle(fontSize: 10, color: Colors.grey, letterSpacing: 1.2)),
//               ),
//             ),
//             const SizedBox(height: 100),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNav(context),
//     );
//   }

//   // --- Helper UI Components ---

//   Widget _buildLabel(String text, {bool isSmall = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
//       child: Text(
//         isSmall ? text : text,
//         style: TextStyle(
//           color: const Color(0xFF004D61),
//           fontWeight: FontWeight.bold,
//           fontSize: isSmall ? 11 : 16,
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String hint, {IconData? suffixIcon, IconData? prefixIcon, int maxLines = 1, bool isLight = false}) {
//     return TextField(
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
//         prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey[400]) : null,
//         suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.grey[400]) : null,
//         filled: true,
//         fillColor: isLight ? Colors.white : const Color(0xFFE8E8E8),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       ),
//     );
//   }

//   Widget _buildDropdownField(String value, {bool isLight = false}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: isLight ? Colors.white : const Color(0xFFE8E8E8),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           isExpanded: true,
//           icon: const Icon(Icons.expand_more),
//           items: [value].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//           onChanged: (v) {},
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeader(IconData icon, String title) {
//     return Row(
//       children: [
//         Icon(icon, size: 20, color: const Color(0xFF004D61)),
//         const SizedBox(width: 8),
//         Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D61))),
//       ],
//     );
//   }

//   Widget _buildFormCard(List<Widget> children) {
//     return Container(
//       margin: const EdgeInsets.only(top: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF1F1F3),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
//     );
//   }

//   Widget _buildRoadmapStep(int number, String title, String desc, {bool isActive = false, bool isLast = false}) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           children: [
//             CircleAvatar(
//               radius: 12,
//               backgroundColor: isActive ? const Color(0xFF003D4C) : const Color(0xFFCAD4D9),
//               child: Text('$number', style: const TextStyle(color: Colors.white, fontSize: 10)),
//             ),
//             if (!isLast) Container(width: 1, height: 100, color: const Color(0xFFE0E0E0)),
//           ],
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             children: [
//               _buildTextField(title, isLight: true),
//               const SizedBox(height: 8),
//               _buildTextField(desc, isLight: true),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildUploadPlaceholder() {
//     return Container(
//       height: 180,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: const Color(0xFFE8E8E8),
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid), // In reality, use dotted_border package
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.add_a_photo_outlined, size: 32, color: Colors.grey[600]),
//           const SizedBox(height: 12),
//           const Text('Upload Cover Image', style: TextStyle(fontWeight: FontWeight.bold)),
//           const Text('Recommended: 1200 x 600px', style: TextStyle(fontSize: 10, color: Colors.grey)),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomNav(BuildContext context) {
//     return Container(
//       height: 90,
//       padding: const EdgeInsets.symmetric(horizontal: 40),
//       decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           InkWell(
//             onTap: () => context.go(RoutePaths.adminDashboard),
//             borderRadius: BorderRadius.circular(12),
//             child: const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [Icon(Icons.grid_view, color: Colors.grey), Text('Dashboard', style: TextStyle(fontSize: 10, color: Colors.grey))],
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: () => context.go(RoutePaths.adminAddOpportunity),
//             customBorder: const CircleBorder(),
//             child: Transform.translate(
//               offset: const Offset(0, -20),
//               child: const CircleAvatar(
//                 radius: 30,
//                 backgroundColor: Color(0xFF003D4C),
//                 child: Icon(Icons.add, color: Colors.white, size: 30),
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: () => context.go(RoutePaths.adminAddOpportunity),
//             borderRadius: BorderRadius.circular(12),
//             child: const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [Icon(Icons.add, color: Colors.transparent), Text('Add New', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF003D4C)))],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

