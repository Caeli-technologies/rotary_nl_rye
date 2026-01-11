import { useState, useEffect } from "react";
import {
	StyleSheet,
	View,
	Text,
	ScrollView,
	Platform,
	Pressable,
	Modal,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";

import { Image } from "expo-image";
import { useVideoPlayer, VideoView } from "expo-video";
import { useEvent } from "expo";
import * as VideoThumbnails from "expo-video-thumbnails";
import { useTheme } from "@/hooks/use-theme";
const shadowStyle = {
	shadowColor: "#000",
	shadowOffset: { width: 0, height: 4 },
	shadowOpacity: 0.08,
	shadowRadius: 20,
	elevation: 4,
};

const videoUrl =
	"https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/videos/promo/proud_to_be_European.mp4";

export default function Top3CountriesScreen() {
	const { colors: themeColors } = useTheme();

	const [isVideoModalVisible, setIsVideoModalVisible] = useState(false);
	const [thumbnailUri, setThumbnailUri] = useState<string | null>(null);
	const [thumbnailLoading, setThumbnailLoading] = useState(true);

	const player = useVideoPlayer(videoUrl, (player) => {
		player.loop = false;
	});

	const { status } = useEvent(player, "statusChange", {
		status: player.status,
	});

	// Generate video thumbnail
	useEffect(() => {
		const generateThumbnail = async () => {
			try {
				setThumbnailLoading(true);
				const { uri } = await VideoThumbnails.getThumbnailAsync(videoUrl, {
					time: 15000, // 15 seconds into the video
					quality: 0.8, // High quality thumbnail
				});
				setThumbnailUri(uri);
			} catch (error) {
				console.warn("Error generating video thumbnail:", error);
				// If thumbnail generation fails, we'll show the fallback
			} finally {
				setThumbnailLoading(false);
			}
		};

		generateThumbnail();
	}, []);

	const handleCloseVideo = () => {
		player.pause();
		setIsVideoModalVisible(false);
	};
	return (
		<SafeAreaView
			style={[styles.container, { backgroundColor: themeColors.background }]}
			edges={["bottom"]}
		>
			<ScrollView
				style={styles.scrollView}
				showsVerticalScrollIndicator={false}
				contentInsetAdjustmentBehavior="automatic"
			>
				<View style={styles.content}>
					{/* Header Section */}
					<View style={styles.headerSection}>
						<View
							style={[
								styles.headerIcon,
								{ backgroundColor: `${themeColors.primary}20` },
							]}
						>
							<Ionicons
								name="earth-outline"
								size={32}
								color={themeColors.primary}
							/>
						</View>
						<Text style={[styles.headerTitle, { color: themeColors.text }]}>
							Goede top 3 van landen
						</Text>
						<Text
							style={[
								styles.headerSubtitle,
								{ color: themeColors.textSecondary },
							]}
						>
							Tips voor het kiezen van jouw voorkeursbestemmingen
						</Text>
					</View>

					{/* Tips */}
					<View style={styles.section}>
						<View style={styles.sectionHeader}>
							<Ionicons
								name="bulb-outline"
								size={24}
								color={themeColors.primary}
							/>
							<Text style={[styles.sectionTitle, { color: themeColors.text }]}>
								Tips voor een goede keuze
							</Text>
						</View>

						<View
							style={[
								styles.tipCard,
								{
									backgroundColor: themeColors.card,
									borderColor: themeColors.border,
								},
							]}
						>
							<View
								style={[
									styles.tipNumber,
									{ backgroundColor: themeColors.primary },
								]}
							>
								<Text
									style={[styles.tipNumberText, { color: themeColors.card }]}
								>
									1
								</Text>
							</View>
							<View style={styles.tipContent}>
								<Text style={[styles.tipText, { color: themeColors.text }]}>
									Lees in deze app de verhalen van exchange studenten
								</Text>
							</View>
						</View>

						<View
							style={[
								styles.tipCard,
								{
									backgroundColor: themeColors.card,
									borderColor: themeColors.border,
								},
							]}
						>
							<View
								style={[
									styles.tipNumber,
									{ backgroundColor: themeColors.primary },
								]}
							>
								<Text
									style={[styles.tipNumberText, { color: themeColors.card }]}
								>
									2
								</Text>
							</View>
							<View style={styles.tipContent}>
								<Text style={[styles.tipText, { color: themeColors.text }]}>
									Kijk op YouTube en google &ldquo;Rotary Youth Exchange&rdquo;
									dan kom je ook heel veel te weten.
								</Text>
							</View>
						</View>

						<View
							style={[
								styles.tipCard,
								{
									backgroundColor: themeColors.card,
									borderColor: themeColors.border,
								},
							]}
						>
							<View
								style={[
									styles.tipNumber,
									{ backgroundColor: themeColors.primary },
								]}
							>
								<Text
									style={[styles.tipNumberText, { color: themeColors.card }]}
								>
									3
								</Text>
							</View>
							<View style={styles.tipContent}>
								<Text style={[styles.tipText, { color: themeColors.text }]}>
									Praat met voormalige uitwisselingsstudenten over hun
									ervaringen in verschillende landen.
								</Text>
							</View>
						</View>
					</View>

					{/* Inspirational Video */}
					<View style={styles.section}>
						<View style={styles.sectionHeader}>
							<Ionicons
								name="play-circle-outline"
								size={24}
								color={themeColors.primary}
							/>
							<Text style={[styles.sectionTitle, { color: themeColors.text }]}>
								Inspiratie Video
							</Text>
						</View>

						<Pressable
							style={[
								styles.videoCard,
								{
									backgroundColor: themeColors.card,
									borderColor: themeColors.border,
								},
							]}
							onPress={() => setIsVideoModalVisible(true)}
						>
							<View style={styles.videoPreview}>
								{thumbnailLoading ? (
									<View style={styles.thumbnailLoading}>
										<Ionicons
											name="image-outline"
											size={48}
											color={themeColors.textTertiary}
										/>
										<Text
											style={[
												styles.loadingThumbnailText,
												{ color: themeColors.textTertiary },
											]}
										>
											Thumbnail laden...
										</Text>
									</View>
								) : thumbnailUri ? (
									<Image
										source={{ uri: thumbnailUri }}
										style={styles.thumbnail}
										contentFit="cover"
										transition={300}
									/>
								) : (
									<View
										style={[
											styles.thumbnailFallback,
											{ backgroundColor: themeColors.primary },
										]}
									>
										<Ionicons
											name="flag-outline"
											size={48}
											color={themeColors.card}
										/>
										<Text
											style={[styles.fallbackText, { color: themeColors.card }]}
										>
											Proud to be European
										</Text>
									</View>
								)}
								<View style={styles.playButtonOverlay}>
									<View
										style={[
											styles.playButton,
											{ backgroundColor: `${themeColors.primary}F0` },
										]}
									>
										<Ionicons name="play" size={32} color={themeColors.card} />
									</View>
								</View>
							</View>
							<View style={styles.videoInfo}>
								<Text style={[styles.videoTitle, { color: themeColors.text }]}>
									Proud to be European
								</Text>
								<Text
									style={[
										styles.videoDescription,
										{ color: themeColors.textSecondary },
									]}
								>
									Ontdek wat het betekent om een Europese uitwisselingsstudent
									te zijn en laat je inspireren door de verhalen van anderen.
								</Text>
							</View>
						</Pressable>
					</View>
				</View>
			</ScrollView>

			{/* Video Modal */}
			<Modal
				visible={isVideoModalVisible}
				animationType="slide"
				presentationStyle="fullScreen"
				onRequestClose={handleCloseVideo}
			>
				<SafeAreaView
					style={[styles.videoModalContainer, { backgroundColor: "#000" }]}
					edges={["top", "left", "right"]}
				>
					<View style={styles.videoModalHeader}>
						<Pressable style={styles.closeButton} onPress={handleCloseVideo}>
							<Ionicons name="close" size={28} color="#FFF" />
						</Pressable>
					</View>

					<View style={styles.videoContainer}>
						{status === "loading" && (
							<View style={styles.loadingContainer}>
								<Text style={[styles.loadingText, { color: "#FFF" }]}>
									Video laden...
								</Text>
							</View>
						)}
						<VideoView
							style={styles.video}
							player={player}
							fullscreenOptions={{ enable: true }}
							allowsPictureInPicture
							nativeControls
							contentFit="contain"
						/>
					</View>

					<View style={styles.videoInfoModal}>
						<Text style={[styles.videoTitleModal, { color: "#FFF" }]}>
							Proud to be European
						</Text>
						<Text style={[styles.videoSubtitleModal, { color: "#CCCCCC" }]}>
							Rotary Youth Exchange Inspiratie Video
						</Text>
					</View>
				</SafeAreaView>
			</Modal>
		</SafeAreaView>
	);
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
	},
	scrollView: {
		flex: 1,
	},
	content: {
		padding: Platform.OS === "ios" ? 16 : 12,
		paddingBottom: 30,
	},

	// Header Section
	headerSection: {
		alignItems: "center",
		paddingVertical: 24,
		marginBottom: 32,
	},
	headerIcon: {
		width: 80,
		height: 80,
		borderRadius: 40,
		justifyContent: "center",
		alignItems: "center",
		marginBottom: 16,
	},
	headerTitle: {
		fontSize: Platform.OS === "ios" ? 28 : 24,
		fontWeight: Platform.OS === "ios" ? "700" : "600",
		textAlign: "center",
		marginBottom: 8,
	},
	headerSubtitle: {
		fontSize: 16,
		textAlign: "center",
		lineHeight: 22,
		paddingHorizontal: 20,
	},

	// Section Styles
	section: {
		marginBottom: 32,
	},
	sectionHeader: {
		flexDirection: "row",
		alignItems: "center",
		marginBottom: 20,
	},
	sectionTitle: {
		fontSize: Platform.OS === "ios" ? 22 : 18,
		fontWeight: Platform.OS === "ios" ? "700" : "600",
		marginLeft: 12,
	},

	// Info Card
	infoCard: {
		borderRadius: Platform.OS === "ios" ? 16 : 12,
		padding: 20,
		...(Platform.OS === "ios"
			? shadowStyle
			: {
					elevation: 2,
					borderWidth: StyleSheet.hairlineWidth,
				}),
	},

	// Tip Card Styles
	tipCard: {
		borderRadius: Platform.OS === "ios" ? 12 : 8,
		padding: 16,
		marginBottom: 16,
		flexDirection: "row",
		alignItems: "flex-start",
		...(Platform.OS === "ios"
			? shadowStyle
			: {
					elevation: 1,
					borderWidth: StyleSheet.hairlineWidth,
				}),
	},
	tipNumber: {
		width: 32,
		height: 32,
		borderRadius: 16,
		justifyContent: "center",
		alignItems: "center",
		marginRight: 16,
	},
	tipNumberText: {
		fontSize: 16,
		fontWeight: "600",
	},
	tipContent: {
		flex: 1,
	},
	tipText: {
		fontSize: 14,
		lineHeight: 20,
	},

	// Video Card Styles
	videoCard: {
		borderRadius: Platform.OS === "ios" ? 16 : 12,
		overflow: "hidden",
		borderWidth: Platform.OS === "android" ? StyleSheet.hairlineWidth : 0,
		...(Platform.OS === "ios"
			? shadowStyle
			: {
					elevation: 2,
				}),
	},
	videoPreview: {
		height: 200,
		position: "relative",
		overflow: "hidden",
	},
	thumbnail: {
		width: "100%",
		height: "100%",
	},
	thumbnailLoading: {
		flex: 1,
		justifyContent: "center",
		alignItems: "center",
	},
	loadingThumbnailText: {
		marginTop: 8,
		fontSize: 14,
	},
	thumbnailFallback: {
		flex: 1,
		justifyContent: "center",
		alignItems: "center",
	},
	fallbackText: {
		marginTop: 8,
		fontSize: 16,
		fontWeight: "600",
		textAlign: "center",
	},
	playButtonOverlay: {
		position: "absolute",
		top: 0,
		left: 0,
		right: 0,
		bottom: 0,
		justifyContent: "center",
		alignItems: "center",
		backgroundColor: "rgba(0, 0, 0, 0.3)",
	},
	playButton: {
		width: 64,
		height: 64,
		borderRadius: 32,
		justifyContent: "center",
		alignItems: "center",
		shadowColor: "#000",
		shadowOffset: { width: 0, height: 2 },
		shadowOpacity: 0.3,
		shadowRadius: 4,
		elevation: 5,
	},
	videoInfo: {
		padding: 20,
	},
	videoTitle: {
		fontSize: 18,
		fontWeight: "600",
		marginBottom: 8,
	},
	videoDescription: {
		fontSize: 14,
		lineHeight: 20,
	},

	// Video Modal Styles
	videoModalContainer: {
		flex: 1,
	},
	videoModalHeader: {
		position: "absolute",
		top: 60,
		right: 20,
		zIndex: 10,
	},
	closeButton: {
		width: 44,
		height: 44,
		borderRadius: 22,
		backgroundColor: "rgba(0, 0, 0, 0.5)",
		justifyContent: "center",
		alignItems: "center",
	},
	videoContainer: {
		flex: 1,
		justifyContent: "center",
		alignItems: "center",
	},
	video: {
		width: "100%",
		height: "70%",
	},
	loadingContainer: {
		position: "absolute",
		justifyContent: "center",
		alignItems: "center",
		width: "100%",
		height: "100%",
	},
	loadingText: {
		fontSize: 16,
	},
	videoInfoModal: {
		padding: 20,
		backgroundColor: "rgba(0, 0, 0, 0.8)",
	},
	videoTitleModal: {
		fontSize: 20,
		fontWeight: "600",
		marginBottom: 4,
	},
	videoSubtitleModal: {
		fontSize: 14,
	},
});
