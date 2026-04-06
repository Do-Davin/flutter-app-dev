// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Adaptive Profile')),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           final isWide = constraints.maxWidth >= 600;

//           final avatar = const _AvatarSection();
//           final details = const _DetailSection();

//           if (isWide) {
//             // Wide: 2-column Row layout
//             return Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 avatar,
//                 Expanded(child: details), // fills remaining horizontal space
//               ],
//             );
//           } else {
//             // Narrow: single-column Column layout
//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [avatar, details],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class _AvatarSection extends StatelessWidget {
//   const _AvatarSection();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           CircleAvatar(
//             radius: 56,
//             backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//             child: Icon(
//               Icons.person,
//               size: 64,
//               color: Theme.of(context).colorScheme.onPrimaryContainer,
//             ),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             'VinZz Dev',
//             style: Theme.of(
//               context,
//             ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'Full-Stack Engineer',
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//               color: Theme.of(context).colorScheme.secondary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DetailSection extends StatelessWidget {
//   const _DetailSection();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _InfoTile(icon: Icons.location_on, label: 'Phnom Penh, Cambodia'),
//           _InfoTile(icon: Icons.school, label: 'Year 3 · Software Engineering'),
//           _InfoTile(icon: Icons.code, label: 'NestJS · React · Flutter'),
//           _InfoTile(icon: Icons.work, label: 'Building DT Academy'),
//         ],
//       ),
//     );
//   }
// }

// class _InfoTile extends StatelessWidget {
//   const _InfoTile({required this.icon, required this.label});

//   final IconData icon;
//   final String label;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: BackButton(onPressed: () => context.go('/home')),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.push('/settings'),
          child: const Text('Open Settings'),
        ),
      ),
    );
  }
}
