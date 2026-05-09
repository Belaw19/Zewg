// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import 'package:z/core/constants/route_paths.dart';
// import 'package:z/core/routing/navigation_helpers.dart';

// class EditOpportunityPage extends StatelessWidget {
//   const EditOpportunityPage({super.key});

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
//           'Edit Opportunity',
//           style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Core Details Section
//             _buildSectionHeader(null, 'Core Details', hasVerticalBar: true),
//             _buildLabel('Position Title'),
//             _buildTextField('Senior UX Research Intern'),
//             _buildLabel('Category'),
//             _buildDropdownField('Internship'),
//             _buildLabel('Application Deadline'),
//             _buildTextField('10/24/2023', suffixIcon: Icons.calendar_today_outlined),

//             const SizedBox(height: 32),
            
//             // Work Context Section
//             _buildSectionHeader(Icons.work_outline, 'Work Context'),
//             _buildFormCard([
//               _buildLabel('WORK TYPE', isSmall: true),
//               _buildTextField('Remote', prefixIcon: Icons.cloud_outlined, isLight: false),
//               _buildLabel('COMPENSATION', isSmall: true),
//               _buildTextField('\$45 - \$55 / hr', isLight: false),
//               _buildLabel('LOCATION', isSmall: true),
//               _buildTextField('San Francisco, CA', isLight: false),
//             ]),

//             const SizedBox(height: 32),

//             // Key Requirements Section
//             _buildSectionHeader(null, 'Key Requirements', hasVerticalBar: true, barColor: Colors.brown),
//             _buildRequirementCard(
//               Icons.school_outlined, 
//               'Education', 
//               'Master\'s or PhD candidate in HCI, Psychology, Anthropology, or a related social science'
//             ),
//             _buildRequirementCard(
//               Icons.assignment_outlined, 
//               'Experience', 
//               '1+ years of industry experience conducting end-to-end qualitative research studies in a'
//             ),
            
//             // Skills section with Tags
//             _buildFormCard([
//               Row(
//                 children: [
//                   const Icon(Icons.settings_outlined, size: 18, color: Color(0xFF004D61)),
//                   const SizedBox(width: 8),
//                   const Text('Skills', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D61))),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 children: [
//                   _buildSkillTag('Figma'),
//                   _buildSkillTag('Dovetail'),
//                   _buildSkillTag('UserTesting'),
//                   _buildSkillTag('Qualitative Coding'),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 4.0),
//                     child: Text('+ Edit Skills', style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.bold, fontSize: 12)),
//                   ),
//                 ],
//               ),
//             ]),

//             const SizedBox(height: 32),
//             const Text('Detailed Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D61))),
//             const SizedBox(height: 12),
//             _buildTextField(
//               'As a Senior UX Research Intern, you will be embedded within our Core Experience team. You will lead high-impact research projects that influence the product roadmap for the upcoming academic year.\n\nKey Responsibilities:\n- Design and execute qualitative research studies, including semi-structured interviews, diary studies, and usability testing.',
//               maxLines: 10
//             ),

//             const SizedBox(height: 32),

//             // Application Roadmap
//             _buildFormCard([
//               const Text('Application Roadmap', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF004D61))),
//               const SizedBox(height: 20),
//               _buildRoadmapStep(1, 'Portfolio Review', 'Initial screening of past research artifacts and methodologies.'),
//               _buildRoadmapStep(2, 'Technical Interview', '60-minute session focusing on study design and analytical depth.'),
//               _buildRoadmapStep(3, 'Executive Sync', 'Final culture-fit and strategic alignment with the Head of Research.', isLast: true),
//             ], bgColor: const Color(0xFFEDF2F4)),

//             const SizedBox(height: 32),

//             // Cover Photo
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Image.network(
//                 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800', 
//                 height: 200, 
//                 width: double.infinity, 
//                 fit: BoxFit.cover
//               ),
//             ),
//             Center(
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text('Change cover photo', style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.bold)),
//               ),
//             ),

//             const SizedBox(height: 24),
//             _buildLabel('Application URL'),
//             _buildTextField('https://careers.zewg.edu/apply', prefixIcon: Icons.link),

//             const SizedBox(height: 40),

//             // Action Buttons
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF003D4C),
//                 minimumSize: const Size(double.infinity, 56),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//               ),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Save Changes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                   SizedBox(width: 8),
//                   Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//             OutlinedButton(
//               onPressed: () {},
//               style: OutlinedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 56),
//                 side: const BorderSide(color: Color(0xFFFFE0E0)),
//                 backgroundColor: const Color(0xFFFFF9F9),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//               ),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.delete_outline, color: Colors.red, size: 18),
//                   SizedBox(width: 8),
//                   Text('Delete Post', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
            
//             const Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20),
//                 child: Column(
//                   children: [
//                     Text('LAST EDITED', style: TextStyle(fontSize: 10, color: Colors.grey, letterSpacing: 1.2)),
//                     Text('Today at 10:42 AM by Admin', style: TextStyle(fontSize: 12, color: Colors.grey)),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 80),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNav(context),
//     );
//   }

//   // --- Helper Widgets ---

//   Widget _buildSectionHeader(IconData? icon, String title, {bool hasVerticalBar = false, Color barColor = const Color(0xFF004D61)}) {
//     return Row(
//       children: [
//         if (hasVerticalBar) 
//           Container(width: 4, height: 24, decoration: BoxDecoration(color: barColor, borderRadius: BorderRadius.circular(2))),
//         if (icon != null) Icon(icon, size: 20, color: const Color(0xFF004D61)),
//         const SizedBox(width: 8),
//         Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF004D61))),
//       ],
//     );
//   }

//   Widget _buildLabel(String text, {bool isSmall = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
//       child: Text(text, style: TextStyle(color: const Color(0xFF004D61), fontWeight: FontWeight.bold, fontSize: isSmall ? 12 : 14)),
//     );
//   }

//   Widget _buildTextField(String initialValue, {IconData? suffixIcon, IconData? prefixIcon, int maxLines = 1, bool isLight = true}) {
//     return TextFormField(
//       initialValue: initialValue,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey[600], size: 20) : null,
//         suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.black87) : null,
//         filled: true,
//         fillColor: isLight ? const Color(0xFFE8E8E8) : Colors.white.withOpacity(0.5),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
//         contentPadding: const EdgeInsets.all(16),
//       ),
//     );
//   }

//   Widget _buildDropdownField(String value) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(color: const Color(0xFFE8E8E8), borderRadius: BorderRadius.circular(16)),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           isExpanded: true,
//           items: [value].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//           onChanged: (v) {},
//         ),
//       ),
//     );
//   }

//   Widget _buildFormCard(List<Widget> children, {Color bgColor = const Color(0xFFF1F1F3)}) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(top: 12),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(24)),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
//     );
//   }

//   Widget _buildRequirementCard(IconData icon, String title, String content) {
//     return Container(
//       margin: const EdgeInsets.only(top: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFEEEEEE)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, size: 18, color: const Color(0xFF004D61)),
//               const SizedBox(width: 8),
//               Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D61))),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(content, style: const TextStyle(color: Color(0xFF555555), fontSize: 13, height: 1.4)),
//         ],
//       ),
//     );
//   }

//   Widget _buildSkillTag(String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(color: const Color(0xFFCFDEE3), borderRadius: BorderRadius.circular(100)),
//       child: Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF004D61), fontWeight: FontWeight.w500)),
//     );
//   }

//   Widget _buildRoadmapStep(int number, String title, String desc, {bool isLast = false}) {
//     return IntrinsicHeight(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             children: [
//               CircleAvatar(radius: 12, backgroundColor: const Color(0xFF003D4C), child: Text('$number', style: const TextStyle(color: Colors.white, fontSize: 10))),
//               if (!isLast) Expanded(child: Container(width: 1, color: const Color(0xFF003D4C).withOpacity(0.3))),
//             ],
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                 Text(desc, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
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
//               child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.grid_view, color: Colors.grey), Text('Dashboard', style: TextStyle(fontSize: 10, color: Colors.grey))]),
//             ),
//           ),
//           InkWell(
//             onTap: () => context.go(RoutePaths.adminAddOpportunity),
//             borderRadius: BorderRadius.circular(12),
//             child: const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.add_circle_outline, color: Colors.grey), Text('Add New', style: TextStyle(fontSize: 10, color: Colors.grey))]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }