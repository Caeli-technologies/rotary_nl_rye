import React, { useState, useEffect, useCallback } from 'react';
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  TouchableOpacity,
  Modal,
  Image,
  Platform,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useVideoPlayer, VideoView } from 'expo-video';
import { useEvent } from 'expo';
import * as VideoThumbnails from 'expo-video-thumbnails';
import * as Haptics from 'expo-haptics';

type Video = { title: string; description: string; url: string };

function VideoRow({
  video,
  index,
  onPlayRequest,
}: {
  video: Video;
  index: number;
  onPlayRequest: (video: Video) => void;
}) {
  const [thumbnailUri, setThumbnailUri] = useState<string | null>(null);
  const [thumbnailLoading, setThumbnailLoading] = useState(true);

  // Generate video thumbnail
  useEffect(() => {
    const generateThumbnail = async () => {
      try {
        setThumbnailLoading(true);
        const { uri } = await VideoThumbnails.getThumbnailAsync(video.url, {
          time: 2000, // 2 seconds into the video
          quality: 0.7,
        });
        setThumbnailUri(uri);
      } catch (error) {
        console.warn('Error generating video thumbnail:', error);
      } finally {
        setThumbnailLoading(false);
      }
    };

    generateThumbnail();
  }, [video.url]);

  const onPress = async () => {
    try {
      if (Platform.OS === 'ios') await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      onPlayRequest(video);
    } catch (e) {
      onPlayRequest(video);
    }
  };

  return (
    <TouchableOpacity style={styles.videoCard} onPress={onPress}>
      <View style={styles.videoPreview}>
        {thumbnailLoading ? (
          <View style={styles.thumbnailLoading}>
            <Ionicons name="image-outline" size={48} color="#999" />
            <Text style={styles.loadingThumbnailText}>Thumbnail laden...</Text>
          </View>
        ) : thumbnailUri ? (
          <Image source={{ uri: thumbnailUri }} style={styles.thumbnail} resizeMode="cover" />
        ) : (
          <View style={styles.thumbnailFallback}>
            <Ionicons name="videocam-outline" size={48} color="#FFFFFF" />
          </View>
        )}
        <View style={styles.playButtonOverlay}>
          <View style={styles.playButton}>
            <Ionicons name="play" size={28} color="#FFFFFF" />
          </View>
        </View>
      </View>
      <View style={styles.videoInfo}>
        <Text style={styles.videoTitle}>{video.title}</Text>
        <Text style={styles.videoDescription}>{video.description}</Text>
      </View>
    </TouchableOpacity>
  );
}

const videos: Video[] = [
  {
    title: 'Waarom op exchange',
    description: 'Van Rotex - ontdek waarom een exchange ervaring zo waardevol is.',
    url: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/videos/promo/Rotary_Promo_Short.mp4',
  },
  {
    title: '5th Avenue Jeugd',
    description:
      'Een inspirerende video over het Rotary Youth Exchange programma en de ervaringen van jongeren.',
    url: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/videos/promo/5th-avenue-jeugd.mp4',
  },
];

export default function VideoPromo() {
  const [selectedVideo, setSelectedVideo] = useState<Video | null>(null);
  const [isVideoModalVisible, setIsVideoModalVisible] = useState(false);

  const player = useVideoPlayer(selectedVideo?.url || '', (player) => {
    player.loop = false;
  });

  const { status } = useEvent(player, 'statusChange', {
    status: player.status,
  });

  const onPlayRequest = useCallback((video: Video) => {
    setSelectedVideo(video);
    setIsVideoModalVisible(true);
  }, []);

  const handleCloseVideo = useCallback(() => {
    player.pause();
    setIsVideoModalVisible(false);
  }, [player]);

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      <ScrollView contentContainerStyle={styles.container}>
        {/* Header Section */}
        <View style={styles.headerSection}>
          <View style={styles.headerIcon}>
            <Ionicons name="videocam-outline" size={32} color="#FF6B35" />
          </View>
          <Text style={styles.headerTitle}>Promo Video&apos;s</Text>
          <Text style={styles.headerSubtitle}>
            Ontdek inspirerende verhalen en ervaringen van Youth Exchange studenten
          </Text>
        </View>

        {/* Video List */}
        {videos.map((video, index) => (
          <VideoRow key={index} index={index} video={video} onPlayRequest={onPlayRequest} />
        ))}

        <View style={{ height: 40 }} />
      </ScrollView>

      {/* Video Modal */}
      <Modal
        visible={isVideoModalVisible}
        animationType="slide"
        presentationStyle="fullScreen"
        onRequestClose={handleCloseVideo}>
        <SafeAreaView style={styles.videoModalContainer} edges={['top', 'bottom', 'left', 'right']}>
          <View style={styles.videoModalHeader}>
            <TouchableOpacity style={styles.closeButton} onPress={handleCloseVideo}>
              <Ionicons name="close" size={28} color="#FFFFFF" />
            </TouchableOpacity>
          </View>

          <View style={styles.videoContainer}>
            {status === 'loading' && (
              <View style={styles.loadingContainer}>
                <Text style={styles.loadingText}>Video laden...</Text>
              </View>
            )}
            <VideoView
              style={styles.video}
              player={player}
              allowsFullscreen
              allowsPictureInPicture
              nativeControls
              contentFit="contain"
            />
          </View>

          <View style={styles.videoInfoModal}>
            <Text style={styles.videoTitleModal}>{selectedVideo?.title}</Text>
            <Text style={styles.videoSubtitleModal}>{selectedVideo?.description}</Text>
          </View>
        </SafeAreaView>
      </Modal>
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

  // Video Card Styles
  videoCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    marginBottom: 16,
    overflow: 'hidden',
    ...shadowStyle,
  },
  videoPreview: {
    position: 'relative',
    aspectRatio: 16 / 9,
    backgroundColor: '#000',
  },
  thumbnail: {
    width: '100%',
    height: '100%',
  },
  thumbnailLoading: {
    width: '100%',
    height: '100%',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#f5f5f5',
  },
  loadingThumbnailText: {
    fontSize: 13,
    color: '#999',
    marginTop: 8,
  },
  thumbnailFallback: {
    width: '100%',
    height: '100%',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#FF6B35',
  },
  playButtonOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    alignItems: 'center',
    justifyContent: 'center',
  },
  playButton: {
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: 'rgba(0, 0, 0, 0.7)',
    alignItems: 'center',
    justifyContent: 'center',
  },
  videoInfo: {
    padding: 16,
  },
  videoTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 8,
  },
  videoDescription: {
    fontSize: 14,
    lineHeight: 20,
    color: '#666',
  },

  // Video Modal Styles
  videoModalContainer: {
    flex: 1,
    backgroundColor: '#000',
  },
  videoModalHeader: {
    flexDirection: 'row',
    justifyContent: 'flex-end',
    padding: 16,
    paddingTop: 24,
  },
  closeButton: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    alignItems: 'center',
    justifyContent: 'center',
  },
  videoContainer: {
    flex: 1,
    justifyContent: 'center',
  },
  video: {
    width: '100%',
    aspectRatio: 16 / 9,
  },
  loadingContainer: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    alignItems: 'center',
    justifyContent: 'center',
    zIndex: 1,
  },
  loadingText: {
    color: '#FFFFFF',
    fontSize: 16,
  },
  videoInfoModal: {
    padding: 20,
    paddingBottom: 40,
  },
  videoTitleModal: {
    fontSize: 20,
    fontWeight: '700',
    color: '#FFFFFF',
    marginBottom: 8,
  },
  videoSubtitleModal: {
    fontSize: 15,
    lineHeight: 22,
    color: 'rgba(255, 255, 255, 0.8)',
  },
});
