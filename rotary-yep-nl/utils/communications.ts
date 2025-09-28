import { Linking, Alert } from 'react-native';

/**
 * Make a phone call with confirmation
 */
export const makePhoneCall = (phoneNumber: string, contactName?: string) => {
  const title = contactName ? `Call ${contactName}` : 'Make Call';
  const message = `Do you want to call ${phoneNumber}?`;
  
  Alert.alert(
    title,
    message,
    [
      { text: 'Cancel', style: 'cancel' },
      { 
        text: 'Call', 
        onPress: () => Linking.openURL(`tel:${phoneNumber}`) 
      },
    ]
  );
};

/**
 * Send an email with confirmation
 */
export const sendEmail = (email: string, contactName?: string, subject?: string) => {
  const title = contactName ? `Email ${contactName}` : 'Send Email';
  const message = `Do you want to send an email to ${email}?`;
  
  Alert.alert(
    title,
    message,
    [
      { text: 'Cancel', style: 'cancel' },
      { 
        text: 'Email', 
        onPress: () => {
          const mailtoUrl = subject ? `mailto:${email}?subject=${encodeURIComponent(subject)}` : `mailto:${email}`;
          Linking.openURL(mailtoUrl);
        }
      },
    ]
  );
};

/**
 * Open WhatsApp with a contact
 */
export const openWhatsApp = (phoneNumber: string, message?: string) => {
  // Remove any non-numeric characters except +
  const cleanNumber = phoneNumber.replace(/[^\d+]/g, '');
  let whatsappUrl = `whatsapp://send?phone=${cleanNumber}`;
  
  if (message) {
    whatsappUrl += `&text=${encodeURIComponent(message)}`;
  }
  
  Linking.canOpenURL(whatsappUrl).then(supported => {
    if (supported) {
      Linking.openURL(whatsappUrl);
    } else {
      Alert.alert('WhatsApp not found', 'Please install WhatsApp to use this feature');
    }
  });
};

/**
 * Open URL in browser
 */
export const openURL = (url: string) => {
  Linking.canOpenURL(url).then(supported => {
    if (supported) {
      Linking.openURL(url);
    } else {
      Alert.alert('Cannot open URL', 'Unable to open the requested link');
    }
  });
};

/**
 * Format phone number for display
 */
export const formatPhoneNumber = (phoneNumber: string): string => {
  // Simple formatting for Dutch phone numbers
  const cleaned = phoneNumber.replace(/\D/g, '');
  
  if (cleaned.startsWith('31')) {
    // International format +31
    return `+${cleaned.substring(0, 2)} ${cleaned.substring(2, 3)} ${cleaned.substring(3, 7)} ${cleaned.substring(7)}`;
  } else if (cleaned.startsWith('06')) {
    // Dutch mobile
    return `${cleaned.substring(0, 2)} ${cleaned.substring(2, 6)} ${cleaned.substring(6)}`;
  }
  
  return phoneNumber;
};

/**
 * Validate email format
 */
export const isValidEmail = (email: string): boolean => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

/**
 * Get initials from a name
 */
export const getInitials = (name: string): string => {
  return name
    .split(' ')
    .map(word => word.charAt(0).toUpperCase())
    .join('')
    .substring(0, 2);
};