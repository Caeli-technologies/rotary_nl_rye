import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/features/contact/presentation/models/contact.dart';

import '../../../../core/presentation/pages/organization_contact_details_page.dart';
import '../../../../core/presentation/uniform_widgets/rotary_list_tile.dart';
import '../../../../core/presentation/uniform_widgets/rotary_list_view.dart';
import '../../../../core/presentation/uniform_widgets/uniform_circle_avatar.dart';

class ContactListView extends RotaryListView {
  ContactListView({required List<Contact> contacts, required BuildContext context})
      : super(
          listTiles: contacts
              .map(
                (contact) => RotaryListTile(
                  action: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactDetailsPage(contact: contact),
                    ),
                  ),
                  title: contact.name,
                  subtitle: contact.functions.join(' & '),
                  leading: UniformCircleAvatar(
                    imageUrl: contact.imageUrl,
                  ),
                ),
              )
              .toList(),
        );
}
