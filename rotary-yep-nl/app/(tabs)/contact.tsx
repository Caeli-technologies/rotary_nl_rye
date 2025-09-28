import { Platform, ScrollView, StyleSheet, TouchableOpacity, Linking, View, Text } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { ContactCard } from '@/components/contact-card';
import { useState } from 'react';

interface Contact {
  name: string;
  function: string;
  organization?: string;
  phone?: string;
  email?: string;
}

export default function ContactScreen() {
  const [activeTab, setActiveTab] = useState(0);

  const mdjcContacts: Contact[] = [
    {
      name: 'Barbara Tusveld',
      function: 'Chair exchange program',
      organization: 'MDJC',
      phone: '+31655128529',
    },
    {
      name: 'Clasine Scheepers',
      function: 'Secretary Board',
      organization: 'MDJC',
      phone: '+31652710977',
    },
  ];

  const rotexContacts: Contact[] = [
    {
      name: 'Emma de Vries',
      function: 'ROTEX Representative',
      organization: 'ROTEX Netherlands',
      email: 'emma.devries@rotex.nl',
    },
    {
      name: 'Lars Jansen',
      function: 'ROTEX Coordinator',
      organization: 'ROTEX Netherlands',
      email: 'lars.jansen@rotex.nl',
    },
  ];

  const longTermContacts: Contact[] = [
    {
      name: 'Patty van Vierzen',
      function: 'Inbound Coordinator',
      organization: 'Long Term Exchange',
      phone: '+31634021403',
    },
    {
      name: 'Marga Oosterveld',
      function: 'Outbound Coordinator',
      organization: 'Long Term Exchange',
      phone: '+31629586813',
    },
  ];

  const shortTermContacts: Contact[] = [
    {
      name: 'Hans de Jong',
      function: 'Short Term Coordinator',
      organization: 'Short Term Exchange',
      email: 'hans.dejong@ryenl.org',
    },
    {
      name: 'Marie van Dijk',
      function: 'Camp Coordinator',
      organization: 'Short Term Exchange',
      email: 'marie.vandijk@ryenl.org',
    },
  ];

  const tabs = [
    { title: 'MDJC', contacts: mdjcContacts },
    { title: 'ROTEX', contacts: rotexContacts },
    { title: 'Long Term', contacts: longTermContacts },
    { title: 'Short Term', contacts: shortTermContacts },
  ];

  const makeCall = (phoneNumber: string) => {
    Linking.openURL(`tel:${phoneNumber}`);
  };

  const sendEmail = (email: string) => {
    Linking.openURL(`mailto:${email}`);
  };

  const ContactItem = ({ contact }: { contact: Contact }) => (
    <ContactCard
      name={contact.name}
      function={contact.function}
      organization={contact.organization}
      phone={contact.phone}
      email={contact.email}
      showActions={true}
    />
  );

  return (
    <SafeAreaView style={styles.safeArea} edges={['top']}>
      <View style={styles.header}>
        <Text style={styles.title}>Contact List</Text>
      </View>

      <View style={styles.container}>
        <View style={styles.tabContainer}>
        {tabs.map((tab, index) => (
          <TouchableOpacity
            key={index}
            style={[styles.tab, activeTab === index && styles.activeTab]}
            onPress={() => setActiveTab(index)}
          >
            <Text style={[
              styles.tabText, 
              activeTab === index && styles.activeTabText
            ]}>
              {tab.title}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      <ScrollView style={styles.content} contentContainerStyle={styles.scrollContent}>
        {tabs[activeTab].contacts.map((contact, index) => (
          <ContactItem key={index} contact={contact} />
        ))}
        
        {tabs[activeTab].contacts.length === 0 && (
          <View style={styles.emptyState}>
            <Text style={styles.emptyText}>No contacts available</Text>
          </View>
        )}
      </ScrollView>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#1f4e79',
  },
  container: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  header: {
    paddingHorizontal: 20,
    paddingBottom: 20,
    backgroundColor: '#1f4e79',
    alignItems: 'center',
  },
  title: {
    color: '#fff',
    fontSize: Platform.OS === 'ios' ? 34 : 28,
    fontWeight: Platform.OS === 'ios' ? '700' : 'bold',
  },
  tabContainer: {
    flexDirection: 'row',
    backgroundColor: Platform.OS === 'ios' ? '#FFFFFF' : '#f5f5f5',
    paddingHorizontal: 16,
    ...(Platform.OS === 'ios' ? {
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 1 },
      shadowOpacity: 0.1,
      shadowRadius: 2,
    } : {}),
  },
  tab: {
    flex: 1,
    paddingVertical: 12,
    alignItems: 'center',
    borderBottomWidth: 2,
    borderBottomColor: 'transparent',
  },
  activeTab: {
    borderBottomColor: '#1f4e79',
  },
  tabText: {
    fontSize: Platform.OS === 'ios' ? 16 : 14,
    fontWeight: Platform.OS === 'ios' ? '500' : '600',
    color: '#666',
  },
  activeTabText: {
    color: '#1f4e79',
    fontWeight: Platform.OS === 'ios' ? '600' : '700',
  },
  content: {
    flex: 1,
    padding: 16,
  },
  scrollContent: {
    paddingBottom: Platform.OS === 'android' ? 100 : 34,
  },
  emptyState: {
    padding: 40,
    alignItems: 'center',
  },
  emptyText: {
    color: '#666',
    fontSize: 16,
  },
});