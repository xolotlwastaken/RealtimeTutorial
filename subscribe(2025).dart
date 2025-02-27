// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:supabase_flutter/supabase_flutter.dart';

/// Subscribes to a specified table in Supabase to receive real-time updates.

Future<void> subscribe(
    String table, Future Function() callbackAction, String sessionId) async {
  try {
    final channel = SupaFlow.client
        .channel('public:$table')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert, // Correct parameter
          schema: 'public',
          table: table,
          filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: "session_id",
              value: sessionId), // Correct filter type
          callback: (payload) async {
            await callbackAction();
          },
        )
        .subscribe();

    print('Subscribed to $table for session_id=$sessionId');
  } catch (e) {
    print('Error subscribing to $table: $e');
  }
}
