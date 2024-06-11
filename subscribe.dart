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
    String table, Future Function() callbackAction, int chatId) async {
  // Accessing the Supabase client and subscribing to a specific channel.
  SupaFlow.client
      .channel('public:$table')
      // Setting up an event listener on the channel.
      // It listens for insert actions only (i.e.when messages are sent)
      // specifically where messages are sent to the group chat we are currently on.
      .on(
        RealtimeListenTypes.postgresChanges,
        ChannelFilter(
            event: "insert",
            schema: 'public',
            table: table,
            filter: "receipient_id=eq.$chatId"),

        // callbackAction is the action to be taken whenever a new message is sent
        (payload, [ref]) => callbackAction(),
      )
      .subscribe();
}
