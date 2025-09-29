import { Platform, ScrollView, StyleSheet, View, Text } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';

export default function AboutScreen() {
  return (
    <SafeAreaView style={styles.safeArea} edges={['top']}>
      <StatusBar style="auto" />
      <View style={styles.header}>
        <Text style={styles.title}>About Us</Text>
      </View>
      
      <View style={styles.container}>
        <ScrollView 
          style={styles.scrollView}
          contentContainerStyle={styles.scrollContent}
          showsVerticalScrollIndicator={false}
          contentInsetAdjustmentBehavior="automatic"
        >
          <View style={styles.content}>
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>
            Nederland MDJC : Multi district Jeugd Commissie
          </Text>
          <Text style={styles.text}>
            Internationale jeugduitwisselingen met Rotary worden al 55 jaar met succes georganiseerd. 
            Jeugduitwisselingen zit in het DNA van Rotary. De jeugd heeft de toekomst, niet alleen voor 
            de Rotary, maar ook voor de wereld. In 2010 is Jeugdzaken met jeugduitwisseling de vijfde 
            Avenue binnen Rotary geworden. Jaarlijks zijn er 7000 Exchanges wereldwijd.
          </Text>
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>
            Our Mission
          </Text>
          <Text style={styles.text}>
            To provide young people with opportunities for international cultural exchange, 
            fostering understanding, friendship, and peace among nations through Rotary's 
            global network.
          </Text>
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>
            Exchange Programs
          </Text>
          <Text style={styles.text}>
            We offer various exchange programs including:
          </Text>
          <Text style={styles.listItem}>• Long-term exchanges (6-12 months)</Text>
          <Text style={styles.listItem}>• Short-term family-to-family programs</Text>
          <Text style={styles.listItem}>• Summer camps and tours</Text>
          <Text style={styles.listItem}>• New Generations Service Exchange</Text>
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>
            Values
          </Text>
          <Text style={styles.listItem}>• Cultural understanding and respect</Text>
          <Text style={styles.listItem}>• Personal growth and development</Text>
          <Text style={styles.listItem}>• Global friendship and peace</Text>
          <Text style={styles.listItem}>• Service above self</Text>
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
    backgroundColor: '#1f4e79',
  },
  container: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    paddingBottom: Platform.OS === 'android' ? 100 : 34,
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
  content: {
    padding: 20,
  },
  section: {
    marginBottom: 32,
    backgroundColor: Platform.OS === 'ios' ? '#FFFFFF' : 'transparent',
    ...(Platform.OS === 'ios' ? {
      padding: 16,
      borderRadius: 12,
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 1 },
      shadowOpacity: 0.05,
      shadowRadius: 2,
    } : {
      paddingBottom: 16,
      borderBottomWidth: 1,
      borderBottomColor: '#E5E5E5',
    }),
  },
  sectionTitle: {
    fontSize: Platform.OS === 'ios' ? 20 : 18,
    marginBottom: 12,
    color: '#1f4e79',
    fontWeight: Platform.OS === 'ios' ? '600' : 'bold',
  },
  text: {
    fontSize: Platform.OS === 'ios' ? 16 : 15,
    lineHeight: Platform.OS === 'ios' ? 24 : 22,
    color: Platform.OS === 'ios' ? '#1C1C1E' : '#333',
    marginBottom: 8,
  },
  listItem: {
    fontSize: Platform.OS === 'ios' ? 16 : 15,
    lineHeight: Platform.OS === 'ios' ? 24 : 22,
    color: Platform.OS === 'ios' ? '#1C1C1E' : '#333',
    marginBottom: 6,
    paddingLeft: 8,
  },
});