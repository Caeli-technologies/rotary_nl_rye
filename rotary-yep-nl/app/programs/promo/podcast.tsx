import React, { useState, useCallback, useMemo } from 'react';
import { StyleSheet, View, Text, ScrollView, TouchableOpacity } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useAudioPlayer, useAudioPlayerStatus } from 'expo-audio';
import type { AudioStatus } from 'expo-audio';
import * as Haptics from 'expo-haptics';

type Podcast = { title: string; description: string; url: string };

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

// Helper function to format time in seconds to MM:SS
const formatTime = (timeInSeconds: number): string => {
  if (!timeInSeconds || timeInSeconds === 0) return '0:00';
  const minutes = Math.floor(timeInSeconds / 60);
  const seconds = Math.floor(timeInSeconds % 60);
  return `${minutes}:${seconds.toString().padStart(2, '0')}`;
};

interface PodcastRowProps {
  index: number;
  podcast: Podcast;
  isActive: boolean;
  onPress: (index: number) => Promise<void>;
  status: AudioStatus;
}

function PodcastRow({ index, podcast, isActive, onPress, status }: PodcastRowProps) {
  const handlePress = useCallback(async () => {
    try {
      await Haptics.selectionAsync();
      await onPress(index);
    } catch (error) {
      console.warn('Playback toggle error:', error);
    }
  }, [index, onPress]);

  // Compute derived state using useMemo for better performance
  const playbackState = useMemo(() => {
    if (!isActive) {
      return {
        isPlaying: false,
        isBuffering: false,
        isLoaded: false,
        currentTime: 0,
        duration: 0,
        progress: 0,
        buttonIcon: 'play' as const,
        showProgress: false,
      };
    }

    const { playing, isBuffering, isLoaded, currentTime, duration } = status;
    const progress = duration > 0 ? (currentTime / duration) * 100 : 0;

    let buttonIcon: 'play' | 'pause' | 'reload-outline' = 'play';
    if (isBuffering) buttonIcon = 'reload-outline';
    else if (playing) buttonIcon = 'pause';

    return {
      isPlaying: playing,
      isBuffering,
      isLoaded,
      currentTime: currentTime || 0,
      duration: duration || 0,
      progress,
      buttonIcon,
      showProgress: isLoaded && duration > 0,
    };
  }, [isActive, status]);

  return (
    <TouchableOpacity
      style={[styles.podcastCard, isActive && !playbackState.isLoaded && styles.podcastCardLoading]}
      onPress={handlePress}
      activeOpacity={0.7}
      disabled={isActive && !playbackState.isLoaded}>
      <View style={styles.podcastContent}>
        <View style={[styles.playButton, playbackState.isBuffering && styles.playButtonBuffering]}>
          <Ionicons
            name={playbackState.buttonIcon}
            size={24}
            color={isActive && !playbackState.isLoaded ? '#999' : '#FF6B35'}
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
              {/* Status indicator */}
              {(!playbackState.isLoaded || playbackState.isBuffering) && (
                <Text style={styles.statusText}>
                  {!playbackState.isLoaded ? 'Loading...' : 'Buffering...'}
                </Text>
              )}

              {/* Progress bar */}
              {playbackState.showProgress && (
                <>
                  <View style={styles.progressBar}>
                    <View style={[styles.progressFill, { width: `${playbackState.progress}%` }]} />
                  </View>
                  <View style={styles.timeInfo}>
                    <Text style={styles.timeText}>{formatTime(playbackState.currentTime)}</Text>
                    <Text style={styles.timeText}>{formatTime(playbackState.duration)}</Text>
                  </View>
                </>
              )}
            </>
          )}
        </View>
      </View>
    </TouchableOpacity>
  );
}

export default function PodcastPromo() {
  const [playingIndex, setPlayingIndex] = useState<number | null>(null);
  const player = useAudioPlayer(null);
  const status = useAudioPlayerStatus(player);

  const handlePodcastPress = useCallback(
    async (index: number) => {
      try {
        if (playingIndex === index) {
          // Toggle play/pause for current podcast
          if (status.playing) {
            player.pause();
          } else {
            if (status.didJustFinish) {
              await player.seekTo(0);
            }
            player.play();
          }
        } else {
          // Switch to new podcast
          const podcast = podcasts[index];
          setPlayingIndex(index);
          await player.replace(podcast.url);
          player.play();
        }
      } catch (error) {
        console.warn('Podcast playback error:', error);
        setPlayingIndex(null);
      }
    },
    [playingIndex, status.playing, status.didJustFinish, player],
  );

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      <ScrollView contentContainerStyle={styles.container}>
        {/* Header */}
        <View style={styles.headerSection}>
          <View style={styles.headerIcon}>
            <Ionicons name="headset-outline" size={32} color="#FF6B35" />
          </View>
          <Text style={styles.headerTitle}>Promo Podcast</Text>
          <Text style={styles.headerSubtitle}>
            Hoe is het nou om een paar maanden ouders te zijn van een exchange student? Luister naar
            de ervaringen van gastouders.
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
