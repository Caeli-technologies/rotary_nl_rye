import { Platform, ScrollView, StyleSheet, Linking, Alert, View, Text } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Image } from 'expo-image';
import { ContactCard } from '@/components/contact-card';
import { StatusBar } from 'expo-status-bar';

interface EmergencyContact {
  name: string;
  function: string;
  phone: string;
  email?: string;
}

export default function EmergencyScreen() {
  const emergencyContacts: EmergencyContact[] = [
    {
      name: 'Patty van Vierzen',
      function: 'Inbound Coordinator',
      phone: '+31634021403',
    },
    {
      name: 'Toon ter Ellen',
      function: 'Inbound Coordinator',
      phone: '+31613602987',
    },
    {
      name: 'Marga Oosterveld',
      function: 'Outbound Coordinator',
      phone: '+31629586813',
    },
    {
      name: 'Judith Siebring',
      function: 'Outbound Coordinator',
      phone: '+31652682275',
    },
  ];

  const nationalCounselors: EmergencyContact[] = [
    {
      name: 'Barbara Tusveld',
      function: 'Chair exchange program',
      phone: '+31655128529',
    },
    {
      name: 'Hilleke van der Veer',
      function: 'National counselor',
      phone: '+31638300427',
    },
    {
      name: 'Carlo ter Ellen',
      function: 'National Counselor',
      phone: '+31653401477',
    },
  ];

  const confidants: EmergencyContact[] = [
    {
      name: 'Pauline Memelink',
      function: 'Lawyer',
      phone: '+31624235624',
      email: 'p.memelink@t-mobilethuis.nl',
    },
    {
      name: 'Reinout Vriesendorp',
      function: 'Doctor\'s office',
      phone: '+31182612676',
      email: 'info@medischcentrumwest.org',
    },
  ];

  const makeCall = (phoneNumber: string, name: string) => {
    Alert.alert(
      'Call Emergency Contact',
      `Do you want to call ${name}?`,
      [
        { text: 'Cancel', style: 'cancel' },
        { 
          text: 'Call', 
          onPress: () => Linking.openURL(`tel:${phoneNumber}`) 
        },
      ]
    );
  };

  const sendEmail = (email: string, name: string) => {
    Alert.alert(
      'Send Email',
      `Do you want to send an email to ${name}?`,
      [
        { text: 'Cancel', style: 'cancel' },
        { 
          text: 'Email', 
          onPress: () => Linking.openURL(`mailto:${email}`) 
        },
      ]
    );
  };

  const EmergencyContactCard = ({ contact }: { contact: EmergencyContact }) => (
    <ContactCard
      name={contact.name}
      function={contact.function}
      phone={contact.phone}
      email={contact.email}
      showActions={true}
    />
  );

  return (
    <SafeAreaView style={styles.safeArea} edges={['top']}>
      <StatusBar style="auto" />
      <View style={styles.header}>
        <View style={styles.headerTitleContainer}>
          <Text style={styles.headerTitle}>Emergency</Text>
        </View>
      </View>
      
      <View style={styles.container}>
        <ScrollView 
          style={styles.scrollView}
          contentContainerStyle={styles.scrollContent}
          showsVerticalScrollIndicator={false}
          contentInsetAdjustmentBehavior="automatic"
        >
          <View style={styles.content}>
          <View style={styles.emergencySection}>
            <Text style={styles.emergencyTitle}>112 for ambulance, fire brigade or police:</Text>
            <Image 
              source={require('@/assets/emergency/112_logo.png')}
              style={styles.emergencyImage}
              contentFit="contain"
            />
          </View>

          <View style={styles.section}>
            <Text style={styles.sectionTitle}>
              Neem direct contact op met Inbound coördinator en daaronder de Outbound coördinatoren:
            </Text>
            {emergencyContacts.map((contact, index) => (
              <EmergencyContactCard key={index} contact={contact} />
            ))}
          </View>

          <View style={styles.section}>
            <Text style={styles.sectionTitle}>Within Rotary Youth Exchange:</Text>
            {nationalCounselors.map((contact, index) => (
              <EmergencyContactCard key={index} contact={contact} />
            ))}
          </View>

          <View style={styles.section}>
            <Text style={styles.sectionTitle}>
              Confidants (not connected to Rotary) in case of f.e. sexual harassment:
            </Text>
            {confidants.map((contact, index) => (
              <EmergencyContactCard key={index} contact={contact} />
            ))}
          </View>

          <View style={styles.note}>
            <Text style={styles.noteTitle}>Note:</Text>
            <Text style={styles.noteText}>
              Make sure you always have your present host parent's phone numbers and home address at hand!
            </Text>
            <Text style={styles.noteText}>
              Also, your host parents know how to assist you in case you need to see a doctor, have to go to the hospital or visit a dentist.
            </Text>
          </View>
          </View>
        </ScrollView>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#d32f2f',
  },
  container: {
    flex: 1,
    backgroundColor: '#F2F2F7',
  },
  scrollView: {
    flex: 1,
  },
  header: {
    paddingHorizontal: 20,
    paddingTop: Platform.OS === 'android' ? 16 : 8,
    paddingBottom: 16,
    backgroundColor: '#d32f2f',
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: 'rgba(255, 255, 255, 0.2)',
  },
  headerTitleContainer: {
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: Platform.OS === 'ios' ? 20 : 22,
    fontWeight: '600',
    color: '#FFFFFF',
    letterSpacing: Platform.OS === 'ios' ? -0.41 : 0,
  },
  content: {
    padding: 16,
  },
  scrollContent: {
    paddingBottom: Platform.OS === 'android' ? 100 : 34,
  },
  emergencySection: {
    alignItems: 'center',
    marginBottom: 24,
  },
  emergencyTitle: {
    fontSize: 18,
    fontWeight: '600',
    textAlign: 'center',
    marginBottom: 0,
    color: '#1f4e79',
  },
  emergencyImage: {
    width: '100%',
    height: 120,
  },
  section: {
    marginBottom: 24,
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 12,
    color: '#1f4e79',
  },

  note: {
    backgroundColor: '#fff3cd',
    padding: 16,
    borderRadius: 8,
    borderLeftWidth: 4,
    borderLeftColor: '#FF9800',
  },
  noteTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 8,
    color: '#e65100',
  },
  noteText: {
    fontSize: 14,
    lineHeight: 20,
    marginBottom: 8,
    color: '#333',
  },
});