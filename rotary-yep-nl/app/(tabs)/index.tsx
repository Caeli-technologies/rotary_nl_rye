import React, {
	useState,
	useEffect,
	useRef,
	useCallback,
	useMemo,
} from "react";
import {
	StyleSheet,
	View,
	Text,
	ScrollView,
	Pressable,
	Animated,
	Platform,
	Dimensions,
	type LayoutChangeEvent,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons, Fontisto, MaterialCommunityIcons } from "@expo/vector-icons";
import { Image } from "expo-image";
import { router } from "expo-router";
import * as Haptics from "expo-haptics";
import { useTheme } from "@/hooks/use-theme";
import type { ThemeColors } from "@/hooks/use-theme";

interface HomeCardProps {
	icon?: keyof typeof Ionicons.glyphMap;
	fontistoIcon?: keyof typeof Fontisto.glyphMap;
	materialIcon?: keyof typeof MaterialCommunityIcons.glyphMap;
	title: string;
	variant?: "default" | "single";
	useSvg?: boolean;
	svgSource?: any;
	onPress?: () => void;
}

const HomeCard = React.memo<HomeCardProps & { colors: ThemeColors }>(
	({
		icon = "settings-outline",
		fontistoIcon,
		materialIcon,
		title,
		variant = "default",
		useSvg = false,
		svgSource,
		onPress,
		colors,
	}) => {
		const isDefault = variant === "default";

		const handlePress = useCallback(() => {
			if (Platform.OS === "ios") {
				Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
			}
			onPress?.();
		}, [onPress]);

		const cardStyle = useMemo(
			() => [
				isDefault
					? { ...styles.homeCard, backgroundColor: colors.surface }
					: { ...styles.homeCardSingle, backgroundColor: colors.surface },
			],
			[isDefault, colors.surface],
		);

		const iconColor = colors.primary;
		const textColor = colors.primary;

		return (
			<View style={styles.cardWrapper}>
				<Pressable
					style={({ pressed }) => [cardStyle, pressed && styles.pressedCard]}
					onPress={handlePress}
					android_ripple={{
						color: `${colors.primaryVariant}20`,
						borderless: false,
					}}
				>
					<View style={styles.cardContent}>
						<View
							style={
								isDefault ? styles.iconContainer : styles.iconContainerSingle
							}
						>
							{useSvg && svgSource ? (
								<Image
									source={svgSource}
									style={{ width: 35, height: 35 }}
									contentFit="contain"
									tintColor={iconColor}
								/>
							) : materialIcon ? (
								<MaterialCommunityIcons
									name={materialIcon}
									size={35}
									color={iconColor}
								/>
							) : fontistoIcon ? (
								<Fontisto name={fontistoIcon} size={35} color={iconColor} />
							) : (
								<Ionicons name={icon} size={35} color={iconColor} />
							)}
						</View>
						{isDefault ? (
							<View style={styles.titleContainer}>
								<Text style={[styles.cardTitle, { color: textColor }]}>
									{title}
								</Text>
							</View>
						) : (
							<Text style={[styles.cardTitleSingle, { color: textColor }]}>
								{title}
							</Text>
						)}
					</View>
				</Pressable>
			</View>
		);
	},
);
HomeCard.displayName = "HomeCard";

const { width: screenWidth } = Dimensions.get("window");

export default function HomeScreen() {
	const { colors } = useTheme();

	const carouselImages = useMemo(
		() => [
			require("@/assets/home/carousel/outbound-25-26-group.jpeg"),
			require("@/assets/home/carousel/inbounds-with-flags.jpeg"),
			require("@/assets/home/carousel/inbound-andre-schiphol.jpeg"),
		],
		[],
	);

	const [currentImageIndex, setCurrentImageIndex] = useState(0);
	const [containerWidth, setContainerWidth] = useState(screenWidth - 32); // Default to screen width minus padding
	const slideAnim = useRef(new Animated.Value(0)).current;
	const intervalRef = useRef<ReturnType<typeof setInterval> | null>(null);

	const animateToIndex = useCallback(
		(index: number, duration: number = 500) => {
			Animated.timing(slideAnim, {
				toValue: -index * containerWidth,
				duration,
				useNativeDriver: true,
			}).start();
		},
		[containerWidth, slideAnim],
	);

	const resetToFirstSlide = useCallback(() => {
		slideAnim.setValue(0);
		setCurrentImageIndex(0);
	}, [slideAnim]);

	const handleLayoutChange = useCallback(
		(event: LayoutChangeEvent) => {
			const { width } = event.nativeEvent.layout;
			if (width !== containerWidth) {
				setContainerWidth(width);
			}
		},
		[containerWidth],
	);

	useEffect(() => {
		if (carouselImages.length > 1 && containerWidth > 0) {
			intervalRef.current = setInterval(() => {
				setCurrentImageIndex((prevIndex) => {
					const nextIndex = prevIndex + 1;

					// If we're at the duplicate slide (last position), reset without animation
					if (nextIndex >= carouselImages.length) {
						// Animate to the duplicate first image
						animateToIndex(carouselImages.length, 500);
						// After animation, instantly reset to the real first image
						setTimeout(() => {
							resetToFirstSlide();
						}, 500);
						return carouselImages.length; // Temporary state for the duplicate
					}

					return nextIndex;
				});
			}, 3000);
		}

		return () => {
			if (intervalRef.current) {
				clearInterval(intervalRef.current);
				intervalRef.current = null;
			}
		};
	}, [
		carouselImages.length,
		containerWidth,
		animateToIndex,
		resetToFirstSlide,
	]);

	useEffect(() => {
		if (containerWidth > 0 && currentImageIndex < carouselImages.length) {
			animateToIndex(currentImageIndex);
		}
	}, [
		currentImageIndex,
		containerWidth,
		animateToIndex,
		carouselImages.length,
	]);

	return (
		<SafeAreaView
			style={[styles.container, { backgroundColor: colors.background }]}
			edges={["top"]}
		>
			<ScrollView
				style={styles.scrollView}
				showsVerticalScrollIndicator={false}
				contentInsetAdjustmentBehavior="automatic"
			>
				{/* Logo Section */}
				<View style={styles.logoContainer}>
					<Image
						source={require("@/assets/home/rotary_rye_nl_logo_home.svg")}
						style={styles.logo}
						contentFit="contain"
					/>
				</View>

				<View style={styles.carouselContainer} onLayout={handleLayoutChange}>
					{carouselImages.length === 1 ? (
						<Image
							source={carouselImages[0]}
							style={styles.carouselImage}
							contentFit="cover"
						/>
					) : (
						<>
							<Animated.View
								style={[
									styles.slideContainer,
									{
										width: (carouselImages.length + 1) * containerWidth,
										transform: [{ translateX: slideAnim }],
									},
								]}
							>
								{carouselImages.map((image, index) => (
									<View
										key={`slide-${index}-${image}`}
										style={[styles.slideItem, { width: containerWidth }]}
									>
										<Image
											source={image}
											style={styles.carouselImage}
											contentFit="cover"
										/>
									</View>
								))}
								{/* Duplicate first image for seamless infinite loop */}
								<View
									key="duplicate"
									style={[styles.slideItem, { width: containerWidth }]}
								>
									<Image
										source={carouselImages[0]}
										style={styles.carouselImage}
										contentFit="cover"
									/>
								</View>
							</Animated.View>

							{carouselImages.length > 1 && (
								<View style={styles.dotIndicators}>
									{carouselImages.map((image, index) => (
										<View
											key={`dot-${image}`}
											style={[
												styles.dot,
												(index === currentImageIndex ||
													(currentImageIndex === carouselImages.length &&
														index === 0)) &&
													styles.activeDot,
											]}
										/>
									))}
								</View>
							)}
						</>
					)}
				</View>

				<View style={styles.gridContainer}>
					<View style={styles.gridRow}>
						<HomeCard
							icon="list-outline"
							title="Programma"
							colors={colors}
							onPress={() => router.push("/programs")}
						/>
						<HomeCard
							icon="newspaper-outline"
							title="News"
							colors={colors}
							onPress={() => router.push("/news")}
						/>
						<HomeCard
							icon="calendar-outline"
							title="Calendar"
							colors={colors}
							onPress={() => router.push("/calendar")}
						/>
					</View>

					<View style={styles.gridRow}>
						<HomeCard
							materialIcon="airplane-takeoff"
							title="Op Exchange"
							colors={colors}
							onPress={() => router.push("/outbound")}
						/>
						<HomeCard
							materialIcon="airplane-landing"
							title="To NL"
							colors={colors}
							onPress={() => router.push("/inbound")}
						/>
						<HomeCard
							icon="refresh-outline"
							title="Rebound"
							colors={colors}
							onPress={() => router.push("/rebound")}
						/>
					</View>

					<View style={styles.gridRowSingle}>
						<HomeCard
							fontistoIcon="tent"
							title="Zomerkampen Lijst"
							variant="single"
							colors={colors}
							onPress={() => router.push("/camps-tours")}
						/>
						<HomeCard
							title="voor Rotary Clubs"
							variant="single"
							useSvg={true}
							colors={colors}
							svgSource={require("@/assets/logo/rotary-logo-icon.svg")}
							onPress={() => router.push("/rotary-clubs")}
						/>
					</View>
				</View>
			</ScrollView>
		</SafeAreaView>
	);
}

const shadowStyle = Platform.select({
	ios: {
		shadowColor: "#000",
		shadowOffset: { width: 0, height: 4 },
		shadowOpacity: 0.08,
		shadowRadius: 20,
	},
	android: {
		elevation: 4,
	},
	default: {},
});

const styles = StyleSheet.create({
	container: {
		flex: 1,
	},
	scrollView: {
		flex: 1,
	},
	logoContainer: {
		alignItems: "center",
		marginBottom: 30,
		paddingVertical: 20,
		paddingHorizontal: 16,
	},
	logo: {
		width: "100%",
		height: 80,
	},
	carouselContainer: {
		height: 200,
		marginHorizontal: 16,
		marginBottom: 16,
		borderRadius: 12,
		overflow: "hidden",
		position: "relative",
		...shadowStyle,
	},
	pressedCard: {
		transform: [{ scale: 0.98 }],
		opacity: 0.8,
	},
	slideContainer: {
		flexDirection: "row",
		height: "100%",
	},
	slideItem: {
		height: "100%",
	},
	carouselImage: {
		width: "100%",
		height: "100%",
	},
	dotIndicators: {
		position: "absolute",
		bottom: 12,
		left: 0,
		right: 0,
		flexDirection: "row",
		justifyContent: "center",
		alignItems: "center",
	},
	dot: {
		width: 8,
		height: 8,
		borderRadius: 4,
		backgroundColor: "rgba(255, 255, 255, 0.5)",
		marginHorizontal: 4,
	},
	activeDot: {
		backgroundColor: "rgba(255, 255, 255, 0.9)",
		width: 10,
		height: 10,
		borderRadius: 5,
	},
	gridContainer: {
		paddingHorizontal: 16,
		paddingBottom: Platform.OS === "android" ? 80 : 30,
	},
	gridRow: {
		flexDirection: "row",
		marginBottom: 16,
	},
	gridRowSingle: {
		flexDirection: "row",
		marginBottom: 30,
	},
	cardWrapper: {
		flex: 1,
		paddingHorizontal: 5,
	},
	homeCard: {
		height: 120,
		borderRadius: 10,
		...shadowStyle,
	},
	homeCardSingle: {
		height: 80,
		borderRadius: 10,
		...shadowStyle,
	},
	cardContent: {
		flex: 1,
		justifyContent: "center",
		alignItems: "center",
		padding: 16,
	},
	iconContainer: {
		marginBottom: 16,
	},
	iconContainerSingle: {
		marginBottom: 10,
	},
	titleContainer: {
		width: 80,
		alignItems: "center",
	},
	cardTitle: {
		fontSize: 14,
		fontWeight: "400",
		textAlign: "center",
		maxWidth: 80,
	},
	cardTitleSingle: {
		fontSize: 14,
		fontWeight: "400",
		textAlign: "center",
	},
});
