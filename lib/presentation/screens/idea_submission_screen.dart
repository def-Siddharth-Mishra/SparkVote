import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/idea_provider.dart';

class IdeaSubmissionScreen extends StatefulWidget {
  const IdeaSubmissionScreen({Key? key}) : super(key: key);

  @override
  _IdeaSubmissionScreenState createState() => _IdeaSubmissionScreenState();
}

class _IdeaSubmissionScreenState extends State<IdeaSubmissionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _taglineController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _taglineController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitIdea() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      await context.read<IdeaProvider>().submitIdea(
        name: _nameController.text,
        tagline: _taglineController.text,
        description: _descriptionController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Idea submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Your Idea')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Startup Name'),
                validator: (v) => v!.trim().isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _taglineController,
                decoration: const InputDecoration(labelText: 'Tagline'),
                validator: (v) =>
                    v!.trim().isEmpty ? 'Tagline is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 5,
                validator: (v) =>
                    v!.trim().isEmpty ? 'Description is required' : null,
              ),
              const SizedBox(height: 24),
              _isSubmitting
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      onPressed: _submitIdea,
                      icon: const Icon(Icons.send),
                      label: const Text('Submit Idea'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
