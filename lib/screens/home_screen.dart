import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/contact.dart';
import '../utils/app_colors.dart';
import '../widgets/contact_card.dart';
import 'add_contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Contact> _contacts = [];

  void _addContact(Contact contact) {
    setState(() {
      _contacts.add(contact);
    });
  }

  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  void _navigateToAddContact() async {
    final result = await AddContactBottomSheet.show(context);
    if (result != null) {
      _addContact(result);
    }
  }

  void _showDeleteAllConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Delete All Contacts',
          style: TextStyle(
            color: AppColors.white,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        content: const Text(
          'Are you sure you want to delete all contacts?',
          style: TextStyle(
            color: AppColors.white70,
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.white70,
                fontFamily: 'Inter',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _contacts.clear();
              });
            },
            child: const Text(
              'Delete All',
              style: TextStyle(
                color: AppColors.red,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: _buildAppBar(),
      body: _contacts.isEmpty ? _buildEmptyState() : _buildContactGrid(),
      floatingActionButton: _buildFloatingActionButtons(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryDark,
      elevation: 0,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(left: 20, top: 38),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 125,
            height: 50,
            padding: const EdgeInsets.all(4),
            child: Image.asset(
              'assets/images/route_logo (2).png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/empty_list.json'),
          const SizedBox(height: 20),
          const Text(
            'There Is No Contacts Added Here',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactGrid() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 120),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _contacts.length,
      itemBuilder: (context, index) {
        return ContactCard(
          contact: _contacts[index],
          onDelete: () => _deleteContact(index),
        );
      },
    );
  }

  Widget _buildFloatingActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_contacts.isNotEmpty) ...[
            FloatingActionButton(
              heroTag: 'delete_all',
              onPressed: _showDeleteAllConfirmation,
              backgroundColor: AppColors.red,
              child: const Icon(
                Icons.delete,
                color: AppColors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
          ],
          FloatingActionButton(
            heroTag: 'add',
            onPressed: _navigateToAddContact,
            backgroundColor: const Color(0xFFFFF1D4),
            child: const Icon(
              Icons.add,
              color: AppColors.primaryDark,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}