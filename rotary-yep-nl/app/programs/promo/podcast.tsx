import React, { useState, useCallback, useEffect } from 'react';
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  TouchableOpacity,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useAudioPlayer, useAudioPlayerStatus } from 'expo-audio';
import type { AudioStatus } from 'expo-audio';
import * as Haptics from 'expo-haptics';

type Podcast = { title: string; description: string; url: string };

// Helper function to format time in seconds to MM:SS
const formatTime = (timeInSeconds: number): string => {
  const minutes = Math.floor(timeInSeconds / 60);
  const seconds = Math.floor(timeInSeconds % 60);
  return `${minutes}:${seconds.toString().padStart(2, '0')}`;
};

interface PodcastRowProps {
  index: number;
  podcast: Podcast;
  isActive: boolean;
  onPress: (index: number) => Promise<void>;
  player: any;
  status: AudioStatus;
}

function PodcastRow({
  index,
  podcast,
  isActive,
  onPress,
  player,
  status,
}: PodcastRowProps) {
  const [duration, setDuration] = useState<string>('');
  const [position, setPosition] = useState<string>('0:00');

  // Update duration when it becomes available and this is the active podcast
  useEffect(() => {
    if (isActive && status.duration && status.duration > 0) {
      setDuration(formatTime(status.duration));
    } else if (isActive && (!status.duration || status.duration === 0)) {
      setDuration(''); // Clear duration if not available yet
    }
  }, [isActive, status.duration]);

  // Update position when this is the active podcast
  useEffect(() => {
    if (isActive && status.currentTime) {
      setPosition(formatTime(status.currentTime));
    } else if (!isActive) {
      setPosition('0:00'); // Reset position when not active
    }
  }, [isActive, status.currentTime]);

  const handleTogglePlayback = async () => {
    try {
      await Haptics.selectionAsync();
      await onPress(index);
    } catch (error) {
      console.warn('Playback toggle error:', error);
    }
  };

  const isPlaying = isActive && status.playing;
  const isBuffering = isActive && status.isBuffering;
  const isLoaded = isActive && status.isLoaded;
  const progress =
    isActive && status.duration && status.currentTime
      ? (status.currentTime / status.duration) * 100
      : 0;

  // Determine button state and icon
  const getPlayButtonIcon = () => {
    if (isBuffering) return 'reload-outline';
    if (isPlaying) return 'pause';
    return 'play';
  };

  return (
    <TouchableOpacity
      style={[
        styles.podcastCard,
        !isLoaded && isActive && styles.podcastCardLoading,
      ]}
      onPress={handleTogglePlayback}
      activeOpacity={0.7}
      disabled={isActive && !isLoaded}
    >
      <View style={styles.podcastContent}>
        <View
          style={[styles.playButton, isBuffering && styles.playButtonBuffering]}
        >
          <Ionicons
            name={getPlayButtonIcon()}
            size={24}
            color={isActive && !isLoaded ? '#999' : '#FF6B35'}
          />
        </View>

        <View style={styles.podcastInfo}>
          <Text style={styles.podcastTitle} numberOfLines={2}>
            {podcast.title}
          </Text>
          <Text style={styles.podcastDescription} numberOfLines={3}>
            {podcast.description}
          </Text>

          {isActive && (
            <>
              {/* Loading/Buffering Status */}
              {(!isLoaded || isBuffering) && (
                <Text style={styles.statusText}>
                  {!isLoaded ? 'Loading...' : 'Buffering...'}
                </Text>
              )}

              {/* Progress Bar - only show when loaded */}
              {isLoaded && (
                <View style={styles.progressBar}>
                  <View
                    style={[styles.progressFill, { width: `${progress}%` }]}
                  />
                </View>
              )}

              {/* Time Info - show when loaded, with dynamic duration */}
              {isLoaded && (
                <View style={styles.timeInfo}>
                  <Text style={styles.timeText}>{position}</Text>
                  <Text style={styles.timeText}>
                    {status.duration && status.duration > 0
                      ? duration
                      : '--:--'}
                  </Text>
                </View>
              )}
            </>
          )}
        </View>
      </View>
    </TouchableOpacity>
  );
}

const podcasts: Podcast[] = [
  {
    title: 'Episode 1: Sharon en Michel Teunissen',
    description:
      'Hoe is het nou om een paar maanden ouders te zijn van een exchange student? Sharon en Michel vertellen over hun ervaringen als gastouders.',
    url: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/podcast/rotary-sharon-en-michel-teunissen.mp3',
  },
  {
    title: 'Episode 2: Ellen en Steven Stolp',
    description:
      'Ellen en Steven delen hun verhaal als gastouders en geven tips voor andere families die overwegen om een exchange student op te nemen.',
    url: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/podcast/rotary-ellen-en-steven-stolp.mp3',
  },
];

export default function PodcastPromo() {
  const [playingIndex, setPlayingIndex] = useState<number | null>(null);

  // Create a single audio player with no initial source (null)
  const player = useAudioPlayer(null);
  const status = useAudioPlayerStatus(player);

  const handlePodcastPress = useCallback(
    async (index: number) => {
      try {
        const podcast = podcasts[index];

        // Don't allow interaction if currently loading/buffering a different podcast
        if (
          playingIndex !== null &&
          playingIndex !== index &&
          (status.isBuffering || !status.isLoaded)
        ) {
          console.warn('Please wait for current podcast to load');
          return;
        }

        if (playingIndex === index) {
          // Same podcast - toggle play/pause
          if (status.playing) {
            player.pause();
          } else {
            // If finished, restart from beginning
            if (status.didJustFinish) {
              await player.seekTo(0);
            }
            // Only play if loaded
            if (status.isLoaded) {
              player.play();
            }
          }
        } else {
          // Different podcast - load new source and play
          setPlayingIndex(index);
          await player.replace(podcast.url);
          // The player will automatically play once loaded
          player.play();
        }
      } catch (error) {
        console.warn('Podcast playback error:', error);
        // Reset playing index on error
        if (playingIndex === index) {
          setPlayingIndex(null);
        }
      }
    },
    [
      playingIndex,
      status.playing,
      status.didJustFinish,
      status.isBuffering,
      status.isLoaded,
      player,
    ],
  );

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      <ScrollView contentContainerStyle={styles.container}>
        {/* Header Section */}
        <View style={styles.headerSection}>
          <View style={styles.headerIcon}>
            <Ionicons name="headset-outline" size={32} color="#FF6B35" />
          </View>
          <Text style={styles.headerTitle}>Promo Podcast</Text>
          <Text style={styles.headerSubtitle}>
            Hoe is het nou om een paar maanden ouders te zijn van een exchange
            student? Luister naar de ervaringen van gastouders.
          </Text>
        </View>

        {/* Podcast List */}
        {podcasts.map((podcast, index) => (
          <PodcastRow
            key={index}
            index={index}
            podcast={podcast}
            isActive={playingIndex === index}
            onPress={handlePodcastPress}
            player={player}
            status={status}
          />
        ))}

        <View style={{ height: 40 }} />
      </ScrollView>
    </SafeAreaView>
  );
}

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#F2F2F7',
  },
  container: {
    padding: 16,
    paddingBottom: 40,
  },

  // Header Styles
  headerSection: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 20,
    alignItems: 'center',
    ...shadowStyle,
  },
  headerIcon: {
    width: 64,
    height: 64,
    borderRadius: 32,
    backgroundColor: '#FFF4F1',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 16,
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: '700',
    color: '#1A237E',
    marginBottom: 8,
    textAlign: 'center',
  },
  headerSubtitle: {
    fontSize: 15,
    lineHeight: 22,
    color: '#666',
    textAlign: 'center',
    paddingHorizontal: 10,
  },

  // Podcast Card Styles
  podcastCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    marginBottom: 12,
    ...shadowStyle,
  },
  podcastCardDisabled: {
    opacity: 0.6,
  },
  row: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
  },
  iconWrap: {
    marginRight: 16,
  },
  itemTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  itemDescription: {
    fontSize: 14,
    lineHeight: 18,
    color: '#666',
    marginBottom: 6,
  },
  itemSubtitle: {
    fontSize: 12,
    color: '#FF6B35',
    fontWeight: '500',
  },
  playingIndicator: {
    marginLeft: 8,
  },

  // New PodcastRow Styles
  podcastContent: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
  },
  playButton: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: '#FFF4F1',
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 16,
  },
  podcastInfo: {
    flex: 1,
  },
  podcastTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  podcastDescription: {
    fontSize: 14,
    lineHeight: 18,
    color: '#666',
    marginBottom: 8,
  },
  progressBar: {
    height: 4,
    backgroundColor: '#F0F0F0',
    borderRadius: 2,
    marginBottom: 8,
  },
  progressFill: {
    height: '100%',
    backgroundColor: '#FF6B35',
    borderRadius: 2,
  },
  timeInfo: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  timeText: {
    fontSize: 12,
    color: '#666',
    fontWeight: '500',
  },
  podcastCardLoading: {
    opacity: 0.7,
  },
  playButtonBuffering: {
    backgroundColor: '#F5F5F5',
  },
  statusText: {
    fontSize: 12,
    color: '#FF6B35',
    fontWeight: '500',
    marginBottom: 8,
    fontStyle: 'italic',
  },
});
