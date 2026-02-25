import 'package:hive_flutter/hive_flutter.dart';
import '../models/message.dart';
import '../models/contact.dart';
import '../models/keys.dart';
import '../models/settings.dart';
import '../models/media.dart';
import '../models/state.dart';

/// Box names
class BoxNames {
  static const String messages = 'messages';
  static const String contacts = 'contacts';
  static const String keys = 'keys';
  static const String settings = 'settings';
  static const String media = 'media';
  static const String states = 'states';
  static const String chats = 'chats'; // Metadata de chats
}

/// Initialize Hive and register adapters
Future<void> initHive() async {
  // Initialize Hive for Flutter
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(KeysAdapter());
  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(MediaAdapter());
  Hive.registerAdapter(StateAdapter());
  // Enum adapters se generan automáticamente con hive_generator

  // Open boxes
  await Hive.openBox<Message>(BoxNames.messages);
  await Hive.openBox<Contact>(BoxNames.contacts);
  await Hive.openBox<Keys>(BoxNames.keys);
  await Hive.openBox<Settings>(BoxNames.settings);
  await Hive.openBox<Media>(BoxNames.media);
  await Hive.openBox<State>(BoxNames.states);
  await Hive.openBox<Map>(BoxNames.chats);
}

/// Get Hive box for messages
Box<Message> get messagesBox => Hive.box<Message>(BoxNames.messages);

/// Get Hive box for contacts
Box<Contact> get contactsBox => Hive.box<Contact>(BoxNames.contacts);

/// Get Hive box for keys
Box<Keys> get keysBox => Hive.box<Keys>(BoxNames.keys);

/// Get Hive box for settings
Box<Settings> get settingsBox => Hive.box<Settings>(BoxNames.settings);

/// Get Hive box for media
Box<Media> get mediaBox => Hive.box<Media>(BoxNames.media);

/// Get Hive box for states
Box<State> get statesBox => Hive.box<State>(BoxNames.states);

/// Get Hive box for chats metadata
Box<Map> get chatsBox => Hive.box<Map>(BoxNames.chats);
