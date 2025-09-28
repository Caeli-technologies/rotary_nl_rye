import React from 'react';
import { View, StyleSheet, TouchableOpacity } from 'react-native';
import { ThemedText } from './themed-text';
import { ThemedView } from './themed-view';
import { makePhoneCall, sendEmail } from '../utils/communications';

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
  const handleCall = () => {
    if (phone) {
      makePhoneCall(phone, name);
    }
  };

  const handleEmail = () => {
    if (email) {
      sendEmail(email, name);
    }
  };

  return (
    <TouchableOpacity style={styles.card} onPress={onPress} disabled={!onPress}>
      <ThemedView style={styles.content}>
        <ThemedView style={styles.info}>
          <ThemedText style={styles.name}>{name}</ThemedText>
          <ThemedText style={styles.function}>{jobFunction}</ThemedText>
          {organization && (
            <ThemedText style={styles.organization}>{organization}</ThemedText>
          )}
        </ThemedView>
        
        {showActions && (phone || email) && (
          <ThemedView style={styles.actions}>
            {phone && (
              <TouchableOpacity style={styles.actionButton} onPress={handleCall}>
                <ThemedText style={styles.actionText}>📞</ThemedText>
              </TouchableOpacity>
            )}
            {email && (
              <TouchableOpacity style={styles.actionButton} onPress={handleEmail}>
                <ThemedText style={styles.actionText}>✉️</ThemedText>
              </TouchableOpacity>
            )}
          </ThemedView>
        )}
      </ThemedView>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: '#fff',
    borderRadius: 8,
    marginBottom: 8,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 3,
    elevation: 3,
  },
  content: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
  },
  info: {
    flex: 1,
  },
  name: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
    color: '#333',
  },
  function: {
    fontSize: 14,
    color: '#666',
    marginBottom: 2,
  },
  organization: {
    fontSize: 12,
    color: '#999',
  },
  actions: {
    flexDirection: 'row',
    gap: 8,
  },
  actionButton: {
    width: 40,
    height: 40,
    backgroundColor: '#f0f0f0',
    borderRadius: 20,
    alignItems: 'center',
    justifyContent: 'center',
  },
  actionText: {
    fontSize: 18,
  },
});