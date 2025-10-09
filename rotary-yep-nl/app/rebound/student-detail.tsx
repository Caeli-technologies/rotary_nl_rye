import { useMemo, useLayoutEffect, useState } from "react";
import {
	StyleSheet,
	View,
	Text,
	ScrollView,
	Pressable,
	Platform,
	Animated,
	Modal,
	Dimensions,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import * as Haptics from "expo-haptics";
import { Ionicons } from "@expo/vector-icons";
import { Image } from "expo-image";
import { useVideoPlayer, VideoView } from "expo-video";
import { useEvent } from "expo";
import { useLocalSearchParams, useNavigation } from "expo-router";
import { NetworkImage } from "../../components/network-image";

import type { StudentsData } from "../../types/student";
import studentsData from "../../assets/students/list.json";
import { getFlagAsset } from "../../utils/flags";
import type { Colors } from "@/constants/theme";
import { useTheme } from "@/hooks/use-theme";
const data = studentsData as StudentsData;

const shadowStyle = {
	shadowColor: "#000",
	shadowOffset: { width: 0, height: 4 },
	shadowOpacity: 0.08,
	shadowRadius: 20,
	elevation: 4,
};

interface ActionButtonProps {
	icon: keyof typeof Ionicons.glyphMap;
	title: string;
	subtitle?: string;
	onPress: () => void;
	disabled?: boolean;
	themeColors: typeof Colors.light;
}

function ActionButton({
	icon,
	title,
	subtitle,
	onPress,
	disabled = false,
	themeColors,
}: ActionButtonProps) {
	const [scaleAnim] = useState(new Animated.Value(1));

	const handlePressIn = () => {
		if (!disabled && Platform.OS === "ios") {
			Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
		}
		Animated.spring(scaleAnim, {
			toValue: 0.98,
			useNativeDriver: true,
		}).start();
	};

	const handlePressOut = () => {
		Animated.spring(scaleAnim, {
			toValue: 1,
			useNativeDriver: true,
		}).start();
	};

	return (
		<Animated.View style={{ transform: [{ scale: scaleAnim }] }}>
			<Pressable
				style={({ pressed }) => [
					styles.actionButton,
					{
						backgroundColor: themeColors.card,
						borderColor: themeColors.border,
					},
					disabled && styles.actionButtonDisabled,
					!disabled &&
						pressed && [
							styles.actionButtonPressed,
							{ backgroundColor: themeColors.backgroundElevated },
						],
				]}
				onPress={disabled ? undefined : onPress}
				onPressIn={handlePressIn}
				onPressOut={handlePressOut}
				disabled={disabled}
			>
				<View style={styles.actionButtonContent}>
					<View
						style={[
							styles.actionIconContainer,
							{ backgroundColor: themeColors.primary },
							disabled && [
								styles.actionIconDisabled,
								{ backgroundColor: themeColors.backgroundElevated },
							],
						]}
					>
						<Ionicons
							name={icon}
							size={24}
							color={disabled ? themeColors.textTertiary : themeColors.card}
						/>
					</View>
					<View style={styles.actionTextContainer}>
						<Text
							style={[
								styles.actionTitle,
								{ color: themeColors.text },
								disabled && [
									styles.actionTitleDisabled,
									{ color: themeColors.textTertiary },
								],
							]}
							numberOfLines={1}
						>
							{title}
						</Text>
						{subtitle && (
							<Text
								style={[
									styles.actionSubtitle,
									{ color: themeColors.textSecondary },
									disabled && [
										styles.actionSubtitleDisabled,
										{ color: themeColors.textTertiary },
									],
								]}
								numberOfLines={2}
							>
								{subtitle}
							</Text>
						)}
					</View>
					{!disabled && (
						<Ionicons
							name={
								Platform.OS === "ios"
									? "chevron-forward"
									: "chevron-forward-outline"
							}
							size={Platform.OS === "ios" ? 20 : 24}
							color={themeColors.textTertiary}
						/>
					)}
				</View>
			</Pressable>
		</Animated.View>
	);
}

export default function StudentDetailScreen() {
	const { colors: themeColors } = useTheme();

	const navigation = useNavigation();
	const params = useLocalSearchParams<{
		year: string;
		country: string;
		studentName: string;
	}>();

	const student = useMemo(() => {
		if (!params.year || !params.studentName) return null;

		const studentsForYear = data.list[params.year] || [];
		return studentsForYear.find((s) => s.name === params.studentName) || null;
	}, [params.year, params.studentName]);

	const fromFlagAsset = student ? getFlagAsset(student.fromFlag) : null;
	const toFlagAsset = student ? getFlagAsset(student.toFlag) : null;

	const [isVideoModalVisible, setIsVideoModalVisible] = useState(false);

	const player = useVideoPlayer(student?.videoUrl || null, (player) => {
		if (player) {
			player.loop = false;
			player.muted = false;
		}
	});

	const { status } = useEvent(player, "statusChange", {
		status: player.status,
	});

	const handleVideoPress = async () => {
		if (student?.videoUrl) {
			if (Platform.OS === "ios") {
				await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
			}
			setIsVideoModalVisible(true);
			player.play();
		}
	};

	const handleCloseVideo = () => {
		player.pause();
		setIsVideoModalVisible(false);
	};

	// Configure navigation header with student name and share button
	useLayoutEffect(() => {
		if (student) {
			navigation.setOptions({
				title: student.name,
				headerTitle: () => (
					<View
						style={{
							alignItems: Platform.OS === "ios" ? "center" : "flex-start",
						}}
					>
						<Text
							style={{
								fontSize: Platform.OS === "ios" ? 18 : 20,
								fontWeight: "600",
								color: themeColors.text,
							}}
							numberOfLines={1}
						>
							{student.name}
						</Text>
						<Text
							style={{
								fontSize: 13,
								fontWeight: "400",
								marginTop: 2,
								color: themeColors.textSecondary,
							}}
						>
							{params.year} Exchange
						</Text>
					</View>
				),
			});
		}
	}, [navigation, student, params.year, themeColors]);

	if (!student) {
		return (
			<SafeAreaView
				style={[styles.container, { backgroundColor: themeColors.background }]}
				edges={["bottom"]}
			>
				<View style={styles.errorContainer}>
					<Ionicons
						name="person-outline"
						size={64}
						color={themeColors.primary}
					/>
					<Text style={[styles.errorTitle, { color: themeColors.text }]}>
						Student Not Found
					</Text>
					<Text
						style={[styles.errorMessage, { color: themeColors.textSecondary }]}
					>
						The student information could not be loaded. Please try again.
					</Text>
				</View>
			</SafeAreaView>
		);
	}

	return (
		<SafeAreaView
			style={[styles.container, { backgroundColor: themeColors.background }]}
			edges={["bottom"]}
		>
			<ScrollView
				style={[styles.scrollView, { backgroundColor: themeColors.background }]}
				showsVerticalScrollIndicator={false}
				contentInsetAdjustmentBehavior="automatic"
			>
				{/* Hero Section */}
				<View style={styles.heroSection}>
					<View style={styles.imageContainer}>
						<NetworkImage
							imageUrl={student.imageUrl}
							name={student.name}
							size={120}
							expandable={true}
							showInitials={true}
						/>
					</View>

					<Text style={[styles.studentName, { color: themeColors.text }]}>
						{student.name}
					</Text>
					<Text
						style={[
							styles.studentDescription,
							{ color: themeColors.textSecondary },
						]}
					>
						{student.description}
					</Text>
				</View>

				{/* Exchange Info Card */}
				<View
					style={[
						styles.exchangeCard,
						{
							backgroundColor: themeColors.card,
							borderColor: themeColors.border,
						},
					]}
				>
					<View style={styles.exchangeHeader}>
						<Ionicons
							name="airplane-outline"
							size={24}
							color={themeColors.primary}
						/>
						<Text style={[styles.exchangeTitle, { color: themeColors.text }]}>
							Exchange Details
						</Text>
					</View>

					<View style={styles.exchangeRoute}>
						<View style={styles.exchangeCountry}>
							<View style={styles.exchangeCountryHeader}>
								{fromFlagAsset ? (
									<Image
										source={fromFlagAsset}
										style={styles.exchangeFlag}
										contentFit="contain"
									/>
								) : (
									<View
										style={[
											styles.exchangeFlag,
											styles.flagPlaceholder,
											{ backgroundColor: themeColors.backgroundElevated },
										]}
									>
										<Text
											style={[
												styles.flagText,
												{ color: themeColors.textTertiary },
											]}
										>
											{student.fromFlag.toUpperCase()}
										</Text>
									</View>
								)}
								<Text
									style={[
										styles.exchangeLabel,
										{ color: themeColors.textTertiary },
									]}
								>
									From
								</Text>
							</View>
							<Text
								style={[
									styles.exchangeCountryName,
									{ color: themeColors.text },
								]}
							>
								{student.from}
							</Text>
						</View>

						<View style={styles.exchangeArrow}>
							<Ionicons
								name="arrow-forward"
								size={24}
								color={themeColors.primary}
							/>
						</View>

						<View style={styles.exchangeCountry}>
							<View style={styles.exchangeCountryHeader}>
								{toFlagAsset ? (
									<Image
										source={toFlagAsset}
										style={styles.exchangeFlag}
										contentFit="contain"
									/>
								) : (
									<View
										style={[
											styles.exchangeFlag,
											styles.flagPlaceholder,
											{ backgroundColor: themeColors.backgroundElevated },
										]}
									>
										<Text
											style={[
												styles.flagText,
												{ color: themeColors.textTertiary },
											]}
										>
											{student.toFlag.toUpperCase()}
										</Text>
									</View>
								)}
								<Text
									style={[
										styles.exchangeLabel,
										{ color: themeColors.textTertiary },
									]}
								>
									To
								</Text>
							</View>
							<Text
								style={[
									styles.exchangeCountryName,
									{ color: themeColors.text },
								]}
							>
								{student.to}
							</Text>
						</View>
					</View>

					<View
						style={[styles.yearBadge, { backgroundColor: themeColors.primary }]}
					>
						<Text style={[styles.yearText, { color: themeColors.card }]}>
							{params.year}
						</Text>
					</View>
				</View>

				{/* Bio Section */}
				{student.bio && student.bio.trim() !== "" && (
					<View
						style={[
							styles.bioCard,
							{
								backgroundColor: themeColors.card,
								borderColor: themeColors.border,
							},
						]}
					>
						<View style={styles.bioHeader}>
							<Ionicons
								name="document-text-outline"
								size={24}
								color={themeColors.primary}
							/>
							<Text style={[styles.bioTitle, { color: themeColors.text }]}>
								Biography
							</Text>
						</View>
						<Text
							style={[styles.bioText, { color: themeColors.textSecondary }]}
						>
							{student.bio}
						</Text>
					</View>
				)}

				{/* Actions */}
				<View style={styles.actionsSection}>
					<Text style={[styles.sectionTitle, { color: themeColors.text }]}>
						Actions
					</Text>

					<ActionButton
						icon="play-circle-outline"
						title="Watch Video"
						subtitle={
							student.videoUrl
								? "View exchange experience"
								: "Video not available"
						}
						onPress={handleVideoPress}
						disabled={!student.videoUrl}
						themeColors={themeColors}
					/>
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
					style={styles.videoModalContainer}
					edges={["top", "left", "right"]}
				>
					<View style={styles.videoModalHeader}>
						<Pressable
							style={styles.closeButton}
							onPress={handleCloseVideo}
							hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
						>
							<Ionicons name="close" size={28} color={themeColors.card} />
						</Pressable>
					</View>

					<View style={styles.videoContainer}>
						{status === "loading" && (
							<View style={styles.loadingContainer}>
								<Text style={[styles.loadingText, { color: "#FFFFFF" }]}>
									Loading video...
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

					{student && (
						<View style={styles.videoInfo}>
							<Text style={[styles.videoTitle, { color: "#FFFFFF" }]}>
								{student.name}&apos;s Exchange Story
							</Text>
							<Text
								style={[
									styles.videoSubtitle,
									{ color: "rgba(255, 255, 255, 0.7)" },
								]}
							>
								{student.from} → {student.to} • {params.year}
							</Text>
						</View>
					)}
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
	heroSection: {
		alignItems: "center",
		paddingHorizontal: 24, // Extra padding to prevent clipping
		paddingTop: Platform.OS === "ios" ? 32 : 24,
		paddingBottom: 32,
		backgroundColor: "transparent",
		overflow: "visible",
	},
	imageContainer: {
		width: 140,
		height: 140,
		justifyContent: "center",
		alignItems: "center",
		marginBottom: 16,
		overflow: "visible",
	},

	studentName: {
		fontSize: Platform.OS === "ios" ? 28 : 24,
		fontWeight: Platform.OS === "ios" ? "700" : "500",
		textAlign: "center",
		marginBottom: 8,
		marginTop: 16,
	},
	studentDescription: {
		fontSize: 16,
		textAlign: "center",
		lineHeight: 22,
	},
	exchangeCard: {
		borderRadius: Platform.OS === "ios" ? 16 : 12,
		margin: Platform.OS === "ios" ? 16 : 12,
		padding: 20,
		...(Platform.OS === "ios"
			? {
					...shadowStyle,
					shadowOpacity: 0.12,
					shadowRadius: 24,
				}
			: {
					elevation: 3,
					borderWidth: StyleSheet.hairlineWidth,
				}),
	},
	exchangeHeader: {
		flexDirection: "row",
		alignItems: "center",
		marginBottom: 20,
	},
	exchangeTitle: {
		fontSize: 18,
		fontWeight: "600",
		marginLeft: 12,
	},
	exchangeRoute: {
		flexDirection: "row",
		alignItems: "center",
		justifyContent: "space-between",
		marginBottom: 20,
	},
	exchangeCountry: {
		flex: 1,
		alignItems: "center",
	},
	exchangeCountryHeader: {
		alignItems: "center",
		marginBottom: 8,
	},
	exchangeFlag: {
		width: 40,
		height: 27,
		marginBottom: 8,
	},
	exchangeLabel: {
		fontSize: 12,
		fontWeight: "500",
		textTransform: "uppercase",
		letterSpacing: 0.5,
	},
	exchangeCountryName: {
		fontSize: 16,
		fontWeight: "600",
		textAlign: "center",
	},
	exchangeArrow: {
		marginHorizontal: 20,
	},
	yearBadge: {
		paddingHorizontal: 16,
		paddingVertical: 8,
		borderRadius: 20,
		alignSelf: "center",
	},
	yearText: {
		fontSize: 14,
		fontWeight: "600",
	},
	bioCard: {
		borderRadius: Platform.OS === "ios" ? 16 : 8,
		margin: Platform.OS === "ios" ? 16 : 12,
		padding: 20,
		...(Platform.OS === "ios"
			? shadowStyle
			: {
					elevation: 2,
					borderWidth: StyleSheet.hairlineWidth,
				}),
	},
	bioHeader: {
		flexDirection: "row",
		alignItems: "center",
		marginBottom: 16,
	},
	bioTitle: {
		fontSize: 18,
		fontWeight: "600",
		marginLeft: 12,
	},
	bioText: {
		fontSize: 16,
		lineHeight: 24,
	},
	actionsSection: {
		paddingHorizontal: Platform.OS === "ios" ? 16 : 12,
		paddingBottom: 32,
	},
	sectionTitle: {
		fontSize: Platform.OS === "ios" ? 20 : 18,
		fontWeight: Platform.OS === "ios" ? "600" : "500",
		marginBottom: 16,
	},
	actionButton: {
		borderRadius: Platform.OS === "ios" ? 16 : 12,
		marginBottom: 16,
		overflow: "hidden",
		...(Platform.OS === "ios"
			? {
					...shadowStyle,
					shadowOpacity: 0.08,
					shadowRadius: 16,
				}
			: {
					elevation: 2,
					borderWidth: StyleSheet.hairlineWidth,
				}),
	},
	actionButtonDisabled: {
		opacity: 0.6,
	},
	actionButtonPressed: {},
	actionButtonContent: {
		flexDirection: "row",
		alignItems: "center",
		padding: 16,
		minHeight: Platform.OS === "ios" ? 60 : 64,
	},
	actionIconContainer: {
		width: Platform.OS === "ios" ? 48 : 52,
		height: Platform.OS === "ios" ? 48 : 52,
		borderRadius: Platform.OS === "ios" ? 24 : 26,
		justifyContent: "center",
		alignItems: "center",
		marginRight: 16,
		...(Platform.OS === "ios" && {
			shadowOffset: { width: 0, height: 2 },
			shadowOpacity: 0.1,
			shadowRadius: 4,
		}),
	},
	actionIconDisabled: {},
	actionTextContainer: {
		flex: 1,
	},
	actionTitle: {
		fontSize: Platform.OS === "ios" ? 16 : 16,
		fontWeight: Platform.OS === "ios" ? "600" : "500",
		marginBottom: 2,
	},
	actionTitleDisabled: {},
	actionSubtitle: {
		fontSize: 14,
		fontWeight: "400",
	},
	actionSubtitleDisabled: {},
	flagPlaceholder: {
		justifyContent: "center",
		alignItems: "center",
	},
	flagText: {
		fontSize: 10,
		fontWeight: "600",
	},
	errorContainer: {
		flex: 1,
		justifyContent: "center",
		alignItems: "center",
		paddingHorizontal: 32,
	},
	errorTitle: {
		fontSize: 24,
		fontWeight: "600",
		marginTop: 16,
		marginBottom: 8,
	},
	errorMessage: {
		fontSize: 16,
		textAlign: "center",
		lineHeight: 22,
	},
	// Video Modal Styles
	videoModalContainer: {
		flex: 1,
		backgroundColor: "#000000",
	},
	videoModalHeader: {
		flexDirection: "row",
		justifyContent: "flex-end",
		alignItems: "center",
		paddingHorizontal: 20,
		paddingVertical: 15,
		backgroundColor: "rgba(0, 0, 0, 0.8)",
		minHeight: 60,
	},
	closeButton: {
		padding: 10,
		borderRadius: 20,
		backgroundColor: "rgba(255, 255, 255, 0.2)",
	},
	videoContainer: {
		flex: 1,
		justifyContent: "center",
		alignItems: "center",
	},
	loadingContainer: {
		position: "absolute",
		top: 0,
		left: 0,
		right: 0,
		bottom: 0,
		justifyContent: "center",
		alignItems: "center",
		backgroundColor: "rgba(0, 0, 0, 0.7)",
		zIndex: 1,
	},
	loadingText: {
		fontSize: 16,
		fontWeight: "500",
	},
	video: {
		width: "100%",
		aspectRatio: 16 / 9,
		backgroundColor: "#000000",
		maxHeight: Dimensions.get("window").height * 0.6,
	},
	videoInfo: {
		padding: 20,
		backgroundColor: "rgba(0, 0, 0, 0.8)",
	},
	videoTitle: {
		fontSize: 20,
		fontWeight: "600",
		textAlign: "center",
		marginBottom: 8,
	},
	videoSubtitle: {
		fontSize: 16,
		color: "rgba(255, 255, 255, 0.7)",
		textAlign: "center",
	},
});
