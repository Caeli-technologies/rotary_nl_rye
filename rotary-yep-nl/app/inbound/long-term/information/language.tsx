import React from 'react';
import { StyleSheet, View, Text, ScrollView, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export default function LanguageScreen() {
  return (
    <SafeAreaView style={styles.container} edges={['bottom']}>
      <ScrollView
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic">
        <View style={styles.content}>
          {/* Header Section */}
          <View style={styles.headerSection}>
            <View style={styles.headerIcon}>
              <Ionicons name="chatbubble-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>Language</Text>
            <Text style={styles.headerSubtitle}>
              Learning Dutch for a successful exchange experience
            </Text>
          </View>

          {/* Language Challenge */}
          <View style={styles.section}>
            <View style={styles.challengeCard}>
              <View style={styles.challengeHeader}>
                <Ionicons name="trending-up-outline" size={24} color="#FF9800" />
                <Text style={styles.challengeTitle}>The Challenge</Text>
              </View>
              <Text style={styles.challengeText}>
                There's no hiding it: Dutch is a very difficult language to learn. However, we do
                expect you to master the language and that within months after your arrival you will
                be fluent in our language.
              </Text>
            </View>
          </View>

          {/* DOC Course */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="school-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Dutch Orientation Course (DOC)</Text>
            </View>

            <View style={styles.docCard}>
              <View style={styles.docDetails}>
                <View style={styles.docItem}>
                  <Ionicons name="calendar-outline" size={16} color="#2196F3" />
                  <Text style={styles.docText}>
                    September (August group) & February (new arrivals)
                  </Text>
                </View>
                <View style={styles.docItem}>
                  <Ionicons name="time-outline" size={16} color="#2196F3" />
                  <Text style={styles.docText}>6 days intensive course</Text>
                </View>
                <View style={styles.docItem}>
                  <Ionicons name="people-outline" size={16} color="#2196F3" />
                  <Text style={styles.docText}>Small groups with fellow exchange students</Text>
                </View>
                <View style={styles.docItem}>
                  <Ionicons name="globe-outline" size={16} color="#2196F3" />
                  <Text style={styles.docText}>Language learning + cultural insights</Text>
                </View>
              </View>
              <Text style={styles.docNote}>
                Lots of fun included with students from around the world!
              </Text>
            </View>
          </View>

          {/* Host Family Support */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="home-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Host Family Support</Text>
            </View>

            <View style={styles.supportCard}>
              <View style={styles.supportHeader}>
                <Ionicons name="heart-outline" size={20} color="#4CAF50" />
                <Text style={styles.supportTitle}>Your Learning Partners</Text>
              </View>
              <Text style={styles.supportText}>
                Your first host family will also help you to learn Dutch and you will receive books
                to start learning the language as soon as you are in the Netherlands.
              </Text>
            </View>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F2F2F7',
  },
  scrollView: {
    flex: 1,
  },
  content: {
    padding: 16,
    paddingBottom: 34,
  },

  // Header Section
  headerSection: {
    alignItems: 'center',
    paddingVertical: 24,
    marginBottom: 32,
  },
  headerIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#E3F2FD',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
  },
  headerTitle: {
    fontSize: Platform.OS === 'ios' ? 28 : 24,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    color: '#1A237E',
    textAlign: 'center',
    marginBottom: 8,
  },
  headerSubtitle: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    lineHeight: 22,
    paddingHorizontal: 20,
  },

  // Section Styles
  section: {
    marginBottom: 24,
  },
  sectionHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 12,
  },

  // Main Card
  mainCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 24,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#2196F3',
    ...shadowStyle,
  },
  mainText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },

  // Info Card
  infoCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    ...shadowStyle,
  },

  // Challenge Card
  challengeCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#FF9800',
    ...shadowStyle,
  },
  challengeHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  challengeTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  challengeText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },

  // DOC Card
  docCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    ...shadowStyle,
  },
  docDetails: {
    marginBottom: 16,
  },
  docItem: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  docText: {
    fontSize: 14,
    color: '#333',
    marginLeft: 8,
    flex: 1,
  },
  docNote: {
    fontSize: 14,
    color: '#4CAF50',
    fontStyle: 'italic',
    textAlign: 'center',
    paddingTop: 12,
    borderTopWidth: 1,
    borderTopColor: '#E0E0E0',
    fontWeight: '500',
  },

  // Support Card
  supportCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50',
    ...shadowStyle,
  },
  supportHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  supportTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  supportText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },

  // Encouragement Card
  encouragementCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50',
    ...shadowStyle,
  },
  encouragementHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  encouragementTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  encouragementText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },

  bulletPoint: {
    flexDirection: 'row',
    marginBottom: 12,
    alignItems: 'flex-start',
  },
  bullet: {
    fontSize: 16,
    fontWeight: '700',
    color: '#FF6B35',
    marginRight: 12,
    marginTop: 2,
  },
  bulletText: {
    flex: 1,
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  infoText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
});
