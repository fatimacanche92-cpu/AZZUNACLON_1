import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/profile_model.dart';
import '../../services/profile_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _profileService = ProfileService();
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _floreriaController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _locationController = TextEditingController();
  final _businessHoursController = TextEditingController();
  final _businessDescriptionController = TextEditingController();
  final List<TextEditingController> _socialMediaControllers = [];

  late Future<Profile> _profileFuture;
  Profile? _profile;
  String? _avatarUrl;
  bool _isEditing = false;
  bool _isSaving = false;

  static const Color primaryColor = Color(0xFF340A6B);

  @override
  void initState() {
    super.initState();
    _profileFuture = _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _floreriaController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _locationController.dispose();
    _businessHoursController.dispose();
    _businessDescriptionController.dispose();
    for (var controller in _socialMediaControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<Profile> _loadProfile() async {
    try {
      final profile = await _profileService.getProfile();
      if (mounted) {
        setState(() {
          _profile = profile;
          _avatarUrl = profile.avatarUrl; // Assuming avatarUrl is now part of the Profile model
          _updateControllers(profile);
        });
      }
      return profile;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar el perfil: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
      rethrow;
    }
  }

  void _updateControllers(Profile profile) {
    _nameController.text = profile.name ?? '';
    _floreriaController.text = profile.floristeria ?? '';
    _emailController.text = profile.email ?? '';
    _telefonoController.text = profile.telefono ?? '';
    _locationController.text = profile.location ?? '';
    _businessHoursController.text = profile.businessHours ?? '';
    _businessDescriptionController.text = profile.businessDescription ?? '';

    _socialMediaControllers.clear();
    if (profile.socialMediaLinks != null) {
      for (var link in profile.socialMediaLinks!) {
        _socialMediaControllers.add(TextEditingController(text: link));
      }
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() => _isSaving = true);

    try {
      final updatedProfile = _profile!.copyWith(
        name: _nameController.text,
        floristeria: _floreriaController.text,
        telefono: _telefonoController.text,
        location: _locationController.text,
        businessHours: _businessHoursController.text,
        businessDescription: _businessDescriptionController.text,
        socialMediaLinks: _socialMediaControllers.map((e) => e.text).toList(),
        avatarUrl: _avatarUrl, // Include avatarUrl in copyWith
      );

      await _profileService.updateProfile(updatedProfile);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perfil actualizado con éxito.'), backgroundColor: Colors.green),
        );
      }
      setState(() {
        _profile = updatedProfile;
        _isEditing = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar el perfil: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _pickAndUploadAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);

    try {
      final newAvatarUrl = await _profileService.uploadAvatar(imageFile);
      setState(() {
        _avatarUrl = newAvatarUrl;
        _profile = _profile?.copyWith(avatarUrl: newAvatarUrl); // Update profile with new avatar URL
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Imagen de perfil actualizada.'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al subir la imagen: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _changePassword() async {
    try {
      await _profileService.resetPassword(_emailController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Se ha enviado un correo para restablecer la contraseña.'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al solicitar cambio de contraseña: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _logout() async {
    try {
      await _profileService.signOut();
      if (mounted) {
        // Navigate to login page or welcome page
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cerrar sesión: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Perfil', style: GoogleFonts.poppins(color: primaryColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isSaving ? null : () {
              if (_isEditing) {
                _saveChanges();
              } else {
                setState(() => _isEditing = true);
              }
            },
            child: _isSaving
                ? const CircularProgressIndicator(color: primaryColor)
                : Text(
                    _isEditing ? 'Guardar' : 'Editar',
                    style: GoogleFonts.poppins(color: primaryColor, fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
      body: FutureBuilder<Profile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: primaryColor));
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No se pudo cargar el perfil.'),
                  TextButton(onPressed: () => setState(() { _profileFuture = _loadProfile(); }), child: const Text('Reintentar')),
                ],
              ),
            );
          }

          return _buildProfileForm();
        },
      ),
    );
  }

  Widget _buildProfileForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 32),
            _buildTextField(_nameController, 'Nombre', Icons.person),
            const SizedBox(height: 16),
            _buildTextField(_floreriaController, 'Florería', Icons.store),
            const SizedBox(height: 16),
            _buildTextField(_telefonoController, 'Teléfono', Icons.phone),
            const SizedBox(height: 16),
            _buildTextField(_locationController, 'Ubicación', Icons.location_on),
            const SizedBox(height: 16),
            _buildTextField(_businessHoursController, 'Horario de Atención', Icons.access_time),
            const SizedBox(height: 16),
            _buildTextField(_businessDescriptionController, 'Descripción del Negocio', Icons.description, maxLines: 3),
            const SizedBox(height: 16),
            _buildTextField(_emailController, 'Correo', Icons.email, isEditable: false),
            const SizedBox(height: 16),
            _buildSocialMediaLinksSection(),
            const SizedBox(height: 32),
            _buildPasswordSection(),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'Cerrar Sesión',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _isEditing ? _pickAndUploadAvatar : null,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: primaryColor,
                  backgroundImage: _avatarUrl != null ? NetworkImage(_avatarUrl!) : null,
                  child: _avatarUrl == null
                      ? const Icon(Icons.person, size: 60, color: Colors.white)
                      : null,
                ),
                if (_isEditing)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, color: primaryColor, size: 20),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _nameController.text,
            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isEditable = true,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: !_isEditing || !isEditable,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(),
        prefixIcon: Icon(icon, color: primaryColor),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      validator: (value) {
        if (label == 'Nombre' && (value == null || value.isEmpty)) {
          return 'El nombre no puede estar vacío';
        }
        return null;
      },
    );
  }

  Widget _buildSocialMediaLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Redes Sociales',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ..._socialMediaControllers.asMap().entries.map((entry) {
          int index = entry.key;
          TextEditingController controller = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildTextField(controller, 'Enlace de Red Social', Icons.link, isEditable: _isEditing),
                ),
                if (_isEditing)
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        controller.dispose();
                        _socialMediaControllers.removeAt(index);
                      });
                    },
                  ),
              ],
            ),
          );
        }).toList(),
        if (_isEditing)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _socialMediaControllers.add(TextEditingController());
                });
              },
              icon: const Icon(Icons.add, color: primaryColor),
              label: Text('Añadir Enlace', style: GoogleFonts.poppins(color: primaryColor)),
            ),
          ),
      ],
    );
  }

  Widget _buildPasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contraseña',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        _buildTextField(TextEditingController(text: '********'), 'Contraseña', Icons.lock, isEditable: false),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: _changePassword,
            child: Text(
              'Cambiar Contraseña',
              style: GoogleFonts.poppins(color: primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
