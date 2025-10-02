import { Stack } from 'expo-router';
import { Platform, Pressable, Share, Alert } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import * as Sharing from 'expo-sharing';

export default function SettingsLayout() {
  const handleShare = async () => {
    try {
      // Check if sharing is available
      const isAvailable = await Sharing.isAvailableAsync();

      if (isAvailable) {
        // Use React Native's built-in Share API for sharing text/links
        await Share.share({
          message: 'Check out the Rotary Youth Exchange Netherlands app! 📱✈️',
          title: 'Rotary Youth Exchange Netherlands',
          url: Platform.OS === 'ios' ? 'https://apps.apple.com/app/rotary-yep-nl' : undefined, // Add your app store URL when available
        });
      } else {
        // Fallback for platforms that don't support sharing
        Alert.alert(
          'Share App',
          'Share the Rotary Youth Exchange Netherlands app with friends!\n\nRotary Youth Exchange Netherlands - Connect with young global citizens worldwide! 📱✈️',
          [{ text: 'OK' }],
        );
      }
    } catch (error) {
      console.error('Error sharing:', error);
      Alert.alert('Share Error', 'Unable to share at this time. Please try again later.');
    }
  };

  return (
    <Stack>
      <Stack.Screen
        name="index"
        options={{
          title: 'Settings',
          headerShown: true,
          headerStyle: {
            backgroundColor: '#FFFFFF',
          },
          headerTitleStyle: {
            color: '#000000',
            fontWeight: '600',
            fontSize: Platform.OS === 'ios' ? 20 : 22,
          },
          headerShadowVisible: Platform.OS === 'ios',
          headerRight: () => (
            <Pressable
              style={{
                padding: 8,
                justifyContent: 'center',
                alignItems: 'center',
              }}
              onPress={handleShare}
              hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
              <Ionicons
                name={Platform.OS === 'ios' ? 'share-outline' : 'share-social-outline'}
                size={24}
                color="#007AFF"
              />
            </Pressable>
          ),
        }}
      />
    </Stack>
  );
}
