import React from 'react';
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  Platform,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { StatusBar } from 'expo-status-bar';

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export default function WelcomeInTheNetherlandsScreen() {
  const mottoValues = [
    'Be grateful',
    'Be on purpose', 
    'Be of service',
    'Be here now',
    'Be first',
    'Be curious'
  ];

  return (
    <SafeAreaView style={styles.container} edges={['bottom']}>
      <StatusBar style="auto" />
      
      <ScrollView 
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
        <View style={styles.content}>
          {/* Header Section */}
          <View style={styles.headerSection}>
            <View style={styles.headerIcon}>
              <Ionicons name="heart-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>Welcome to the Netherlands!</Text>
            <Text style={styles.headerSubtitle}>
              We are excited to have you join our Rotary Youth Exchange family
            </Text>
          </View>

          {/* Welcome Message */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="people-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Our Community</Text>
            </View>
            
            <View style={styles.welcomeCard}>
              <View style={styles.highlightBox}>
                <Ionicons name="globe-outline" size={20} color="#2196F3" />
                <Text style={styles.highlightText}>35-50 exchange students annually</Text>
              </View>
              <Text style={styles.welcomeText}>
                We are very excited about your upcoming stay with us and looking forward to meeting you. We hope and believe that you will enjoy your stay with us. We have an exciting and active Rotary International Youth Exchange Program with students from around the world.
              </Text>
              <View style={styles.friendsBox}>
                <Ionicons name="heart-outline" size={16} color="#4CAF50" />
                <Text style={styles.friendsText}>
                  You will make friends from all over the world, in addition to making many Dutch friends in your school and Rotary.
                </Text>
              </View>
            </View>
          </View>

          {/* Exchange Experience */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="star-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Your Exchange Experience</Text>
            </View>
            
            <View style={styles.experienceCard}>
              <View style={styles.experienceHeader}>
                <Ionicons name="sparkles-outline" size={20} color="#9C27B0" />
                <Text style={styles.experienceSubtitle}>One of the best years of your life</Text>
              </View>
              <Text style={styles.experienceText}>
                A wonderful experience in a new culture, with a new language but also with some rules to make sure that your stay will be both enjoyable for you and us alike. These rules are consistent with the International Rotary rules.
              </Text>
            </View>
          </View>

          {/* Ambassador Role */}
          <View style={styles.section}>
            <View style={styles.ambassadorCard}>
              <View style={styles.ambassadorHeader}>
                <Ionicons name="ribbon-outline" size={24} color="#FF6B35" />
                <Text style={styles.ambassadorTitle}>Ambassador Role</Text>
              </View>
              <Text style={styles.ambassadorText}>
                Please remember that under all circumstances you are an ambassador of Rotary and will have to behave accordingly. Also you will be an ambassador of your country. Both functions will be with you at all times and you will be regarded and judged as such at all times during your exchange!
              </Text>
            </View>
          </View>

          {/* Rotary Motto */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="trophy-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Our Motto</Text>
            </View>
            
            <View style={styles.mottoCard}>
              <Text style={styles.mottoIntro}>Live by these values during your exchange:</Text>
              <View style={styles.mottoGrid}>
                {mottoValues.map((value, index) => (
                  <View style={styles.mottoItem} key={index}>
                    <Ionicons name="checkmark-circle" size={16} color="#4CAF50" />
                    <Text style={styles.mottoText}>{value}</Text>
                  </View>
                ))}
              </View>
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
    backgroundColor: '#FFE0B2',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
    borderWidth: 2,
    borderColor: '#FFCC80',
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
  
  // Info Card
  infoCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    ...shadowStyle,
  },
  
  // Welcome Card
  welcomeCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#2196F3',
    ...shadowStyle,
  },
  highlightBox: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#E3F2FD',
    padding: 12,
    borderRadius: 8,
    marginBottom: 16,
  },
  highlightText: {
    fontSize: 14,
    fontWeight: '600',
    color: '#1976D2',
    marginLeft: 8,
  },
  welcomeText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
    marginBottom: 16,
  },
  friendsBox: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    backgroundColor: '#F1F8E9',
    padding: 12,
    borderRadius: 8,
  },
  friendsText: {
    fontSize: 14,
    color: '#388E3C',
    marginLeft: 8,
    flex: 1,
    fontStyle: 'italic',
  },
  
  // Experience Card
  experienceCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#9C27B0',
    ...shadowStyle,
  },
  experienceHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  experienceSubtitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#7B1FA2',
    marginLeft: 8,
  },
  experienceText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  
  // Ambassador Card
  ambassadorCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#FF6B35',
    ...shadowStyle,
  },
  ambassadorHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  ambassadorTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  ambassadorText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  
  // Motto Card
  mottoCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50',
    ...shadowStyle,
  },
  mottoIntro: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
    marginBottom: 16,
    fontWeight: '500',
    textAlign: 'center',
    backgroundColor: '#F8F9FA',
    padding: 12,
    borderRadius: 8,
  },
  mottoGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  mottoItem: {
    flexDirection: 'row',
    alignItems: 'center',
    width: '48%',
    marginBottom: 16,
    backgroundColor: '#F1F8E9',
    padding: 12,
    borderRadius: 8,
  },
  mottoText: {
    fontSize: 14,
    color: '#2E7D32',
    marginLeft: 8,
    fontWeight: '600',
  },
  
  infoText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  
  bulletPoint: {
    flexDirection: 'row',
    marginBottom: 8,
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
});
