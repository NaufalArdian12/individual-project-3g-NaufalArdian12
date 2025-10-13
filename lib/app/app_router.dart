import 'package:go_router/go_router.dart';

// 🧭 Expenses Feature
import 'package:pemrograman_mobile/features/expenses/presentation/widgets/add_expense_screen.dart';
import 'package:pemrograman_mobile/features/expenses/presentation/widgets/category_screen.dart';
import 'package:pemrograman_mobile/features/expenses/presentation/widgets/edit_expense_screen.dart';
import 'package:pemrograman_mobile/features/expenses/presentation/widgets/statistics_screen.dart';

// 🏠 Core Screens
import '../features/home/presentation/screens/home_screen.dart';

// 👤 Auth Screens
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';

// 💬 Messages
import '../features/messages/presentation/screens/messages_screen.dart';
import '../features/messages/presentation/screens/message_detail_screen.dart';

// 👤 Profile
import '../features/profile/presentation/screens/profile_screen.dart';

// ⚙️ Settings
import '../features/settings/presentation/screens/settings_screen.dart';

// 🆘 Help & About
import '../features/help/presentation/screens/help_screen.dart';
import '../features/about/presentation/screens/about_screen.dart';
import '../features/feedback/presentation/screens/feedback_screen.dart';

/// 🌍 Global App Router
final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/add-expense',
      name: 'addExpense',
      builder: (context, state) => const AddExpenseScreen(),
    ),
    GoRoute(
      path: '/edit-expense',
      name: 'editExpense',
      builder: (context, state) => const EditExpenseScreen(),
    ),
    GoRoute(
      path: '/statistics',
      name: 'statistics',
      builder: (context, state) => const StatisticsScreen(),
    ),
    GoRoute(
      path: '/categories',
      name: 'categories',
      builder: (context, state) => const CategoryScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/messages',
      name: 'messages',
      builder: (context, state) => const MessagesScreen(),
    ),
    GoRoute(
      path: '/message/:id',
      name: 'messageDetail',
      builder:
          (context, state) =>
              MessageDetailScreen(messageId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/help',
      name: 'help',
      builder: (context, state) => const HelpScreen(),
    ),
    GoRoute(
      path: '/about',
      name: 'about',
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/feedback',
      name: 'feedback',
      builder: (context, state) => const FeedbackScreen(),
    ),
  ],
);
