import 'package:flutter/material.dart';

class LanguageSelectorPage extends StatelessWidget {
  final void Function(Locale) onSelectLocale;

  const LanguageSelectorPage({super.key, required this.onSelectLocale});

  static const languages = [
    {"locale": Locale('en'), "name": "English", "flag": "🇬🇧"},
    {"locale": Locale('pt'), "name": "Português", "flag": "🇵🇹"},
    {"locale": Locale('es'), "name": "Español", "flag": "🇪🇸"},
    {"locale": Locale('fr'), "name": "Français", "flag": "🇫🇷"},
    {"locale": Locale('de'), "name": "Deutsch", "flag": "🇩🇪"},
    {"locale": Locale('it'), "name": "Italiano", "flag": "🇮🇹"},
    {"locale": Locale('zh'), "name": "中文", "flag": "🇨🇳"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Language")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Choose your language", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: languages.map((lang) {
                  return GestureDetector(
                    onTap: () => onSelectLocale(lang["locale"] as Locale),
                    child: Column(
                      children: [
                        Text(lang["flag"] as String, style: const TextStyle(fontSize: 40)),
                        const SizedBox(height: 4),
                        Text(lang["name"] as String),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}