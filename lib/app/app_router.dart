import 'package:go_router/go_router.dart';
import 'package:pemrograman_mobile/features/expenses/domain/models/category.dart';
import 'package:pemrograman_mobile/features/expenses/presentation/widgets/add_expense_screen.dart';
import 'package:pemrograman_mobile/features/expenses/presentation/widgets/category_screen.dart';
import 'package:pemrograman_mobile/features/expenses/presentation/widgets/edit_expense_screen.dart';
import 'package:pemrograman_mobile/features/expenses/presentation/widgets/statistics_screen.dart';

// Screens
import '../features/home/presentation/screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../features/messages/presentation/screens/messages_screen.dart';
import '../features/messages/presentation/screens/message_detail_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/help/presentation/screens/help_screen.dart';
import '../features/about/presentation/screens/about_screen.dart';
import '../features/feedback/presentation/screens/feedback_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/', name: 'home', builder: (c, s) => const HomeScreen()),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (c, s) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (c, s) => const RegisterScreen(),
    ),

    // Expense Feature
    GoRoute(path: '/add-expense', builder: (_, __) => const AddExpenseScreen()),
    GoRoute(
      path: '/edit-expense',
      builder: (_, __) => const EditExpenseScreen(),
    ),
    GoRoute(path: '/statistics', builder: (_, __) => const StatisticsScreen()),
    GoRoute(path: '/categories', builder: (_, __) => const CategoryScreen()),

    // Tambahan route lain
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (c, s) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/messages',
      name: 'messages',
      builder: (c, s) => const MessagesScreen(),
    ),
    GoRoute(
      path: '/message/:id',
      name: 'messageDetail',
      builder:
          (c, s) => MessageDetailScreen(messageId: s.pathParameters['id']!),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (c, s) => const SettingsScreen(),
    ),
    GoRoute(path: '/help', name: 'help', builder: (c, s) => const HelpScreen()),
    GoRoute(
      path: '/about',
      name: 'about',
      builder: (c, s) => const AboutScreen(),
    ),
    GoRoute(
      path: '/feedback',
      name: 'feedback',
      builder: (c, s) => const FeedbackScreen(),
    ),
  ],
);
