import React from 'react';
import { StyleSheet, Pressable, View, Text, Platform } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { makePhoneCall, sendEmail } from '../utils/communications';
import * as Haptics from 'expo-haptics';

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

interface ContactCardProps {
  name: string;
  function: string;
  organization?: string;
  phone?: string;
  email?: string;
  onPress?: () => void;
  showActions?: boolean;
}

export function ContactCard({
  name,
  function: jobFunction,
  organization,
  phone,
  email,
  onPress,
  showActions = true,
}: ContactCardProps) {
  const handleCall = async () => {
    if (phone) {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
      }
      makePhoneCall(phone, name);
    }
  };

  const handleEmail = async () => {
    if (email) {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
      }
      sendEmail(email, name);
    }
  };

  return (
    <Pressable 
      style={({ pressed }) => [
        styles.card,
        pressed && styles.cardPressed
      ]}
      onPress={onPress} 
      disabled={!onPress}
    >
      <View style={styles.content}>
        <View style={styles.info}>
          <Text style={styles.name}>{name}</Text>
          <Text style={styles.function}>{jobFunction}</Text>
          {organization && (
            <Text style={styles.organization}>{organization}</Text>
          )}
        </View>
        
        {showActions && (phone || email) && (
          <View style={styles.actions}>
            {phone && (
              <Pressable 
                style={({ pressed }) => [
                  styles.actionButton,
                  pressed && styles.actionButtonPressed
                ]}
                onPress={handleCall}
              >
                <Ionicons name="call" size={18} color="#1A237E" />
              </Pressable>
            )}
            {email && (
              <Pressable 
                style={({ pressed }) => [
                  styles.actionButton,
                  pressed && styles.actionButtonPressed
                ]}
                onPress={handleEmail}
              >
                <Ionicons name="mail" size={18} color="#1A237E" />
              </Pressable>
            )}
          </View>
        )}
      </View>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    marginBottom: Platform.OS === 'ios' ? 12 : 8,
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 2,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  cardPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 0.6,
    backgroundColor: Platform.OS === 'ios' ? '#F8F9FA' : '#F5F5F5',
  },
  content: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    minHeight: Platform.OS === 'ios' ? 80 : 88,
  },
  info: {
    flex: 1,
  },
  name: {
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 4,
    color: '#1A237E',
  },
  function: {
    fontSize: 14,
    color: '#666',
    marginBottom: 2,
  },
  organization: {
    fontSize: 12,
    color: '#9FA8DA',
    fontWeight: '500',
  },
  actions: {
    flexDirection: 'row',
    gap: 8,
  },
  actionButton: {
    width: Platform.OS === 'ios' ? 44 : 48,
    height: Platform.OS === 'ios' ? 44 : 48,
    backgroundColor: '#E8EAF6',
    borderRadius: Platform.OS === 'ios' ? 22 : 24,
    alignItems: 'center',
    justifyContent: 'center',
  },
  actionButtonPressed: {
    backgroundColor: '#C5CAE9',
    opacity: 0.8,
  },
});