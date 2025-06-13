// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../data/models/actividad.dart';
import '../data/database_helper.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Actividad> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final activities = await _dbHelper.getActivities();
    setState(() {
      _activities = activities;
    });
  }

  String _formatDate(String fecha) {
    try {
      final dt = DateTime.parse(fecha);
      return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return fecha;
    }
  }

  Future<void> _addActivityDialog() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva Actividad'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nombre de la actividad'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final nombre = controller.text.trim();
              if (nombre.isNotEmpty) {
                final now = DateTime.now();
                final fechaStr = now.toIso8601String();
                final actividad = Actividad(
                  fecha: fechaStr,
                  nombre: nombre,
                );
                await _dbHelper.insertActivity(actividad);
                Navigator.pop(context);
                _loadActivities();
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  Future<void> _editActivityDialog(Actividad actividad) async {
    final controller = TextEditingController(text: actividad.nombre);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Actividad'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nuevo nombre'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final nuevoNombre = controller.text.trim();
              if (nuevoNombre.isNotEmpty) {
                final nuevaActividad = Actividad(
                  id: actividad.id,
                  fecha: actividad.fecha,
                  nombre: nuevoNombre,
                );
                await _dbHelper.updateActivity(nuevaActividad);
                Navigator.pop(context);
                _loadActivities();
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteActivity(int id) async {
    await _dbHelper.deleteActivity(id);
    _loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Actividades'),
      ),
      body: _activities.isEmpty
          ? const Center(child: Text('No hay actividades registradas'))
          : ListView.builder(
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                final actividad = _activities[index];
                return ListTile(
                  title: Text(actividad.nombre),
                  subtitle: Text('Fecha: ${_formatDate(actividad.fecha)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editActivityDialog(actividad),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteActivity(actividad.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addActivityDialog,
        label: const Text('Agregar Actividad'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
