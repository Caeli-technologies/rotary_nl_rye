import {
	StyleSheet,
	View,
	Text,
	ScrollView,
	Platform,
	Pressable,
	Linking,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import * as Haptics from "expo-haptics";
import { useTheme } from "@/hooks/use-theme";
const shadowStyle = {
	shadowColor: "#000",
	shadowOffset: { width: 0, height: 4 },
	shadowOpacity: 0.08,
	shadowRadius: 20,
	elevation: 4,
};

export default function FamilyToFamilyHowToSignUpScreen() {
	const { colors: themeColors } = useTheme();

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
								name="document-text-outline"
								size={32}
								color={themeColors.primary}
							/>
						</View>
						<Text style={[styles.headerTitle, { color: themeColors.text }]}>
							Hoe schrijf ik mezelf in
						</Text>
						<Text
							style={[
								styles.headerSubtitle,
								{ color: themeColors.textSecondary },
							]}
						>
							Stappen om je aan te melden voor het Family-to-Family programma
						</Text>
					</View>

					{/* Email instructies */}
					<View style={styles.section}>
						<View style={styles.sectionHeader}>
							<Ionicons
								name="mail-outline"
								size={24}
								color={themeColors.primary}
							/>
							<Text style={[styles.sectionTitle, { color: themeColors.text }]}>
								Aanmelding
							</Text>
						</View>

						<View
							style={[
								styles.instructionCard,
								{
									backgroundColor: themeColors.card,
									borderColor: themeColors.border,
								},
							]}
						>
							<Text
								style={[styles.instructionText, { color: themeColors.text }]}
							>
								Je stuurt een gezellig email bericht naar:
							</Text>
							<Text style={[styles.emailText, { color: themeColors.primary }]}>
								interesse@rotaryyep.nl
							</Text>
							<Text
								style={[styles.instructionText, { color: themeColors.text }]}
							>
								Dan krijg je van ons een bevestiging dat we je mail hebben
								ontvangen.
							</Text>
						</View>
					</View>

					{/* Email Button */}
					<View style={styles.buttonSection}>
						<Pressable
							style={({ pressed }) => [
								styles.emailButton,
								{
									backgroundColor: themeColors.primary,
									shadowColor: themeColors.shadow,
								},
								pressed && { opacity: 0.7, transform: [{ scale: 0.98 }] },
							]}
							onPress={async () => {
								try {
									await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
									await Linking.openURL(
										"mailto:interesse@rotaryyep.nl?subject=Interesse%20in%20Family-to-Family%20programma",
									);
								} catch (error) {
									console.error("Error opening email:", error);
								}
							}}
							accessibilityRole="button"
							accessibilityLabel="Verstuur Email"
							accessibilityHint="Opent je email app met een voorgeschreven bericht"
							android_ripple={{
								color: "rgba(255,255,255,0.2)",
								borderless: false,
							}}
						>
							<Ionicons
								name="mail"
								size={24}
								color={themeColors.card}
								style={styles.buttonIcon}
							/>
							<Text
								style={[styles.emailButtonText, { color: themeColors.card }]}
							>
								Verstuur Email
							</Text>
						</Pressable>
						<Text
							style={[
								styles.buttonDescription,
								{ color: themeColors.textSecondary },
							]}
						>
							Klik om direct een email te sturen naar interesse@rotaryyep.nl
						</Text>
					</View>
				</View>
			</ScrollView>
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
		marginBottom: 24,
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

	// Instruction Card Styles
	instructionCard: {
		borderRadius: Platform.OS === "ios" ? 16 : 12,
		padding: 20,
		...(Platform.OS === "ios"
			? shadowStyle
			: {
					elevation: 2,
					borderWidth: StyleSheet.hairlineWidth,
				}),
	},
	instructionText: {
		fontSize: 16,
		lineHeight: 24,
		marginBottom: 12,
	},
	emailText: {
		fontSize: 18,
		fontWeight: "600",
		textAlign: "center",
		paddingVertical: 12,
		marginBottom: 12,
	},

	// Button Section Styles
	buttonSection: {
		alignItems: "center",
		paddingVertical: 24,
		marginBottom: 20,
	},
	emailButton: {
		flexDirection: "row",
		alignItems: "center",
		paddingVertical: 16,
		paddingHorizontal: 32,
		borderRadius: 25,
		marginBottom: 12,
		shadowOffset: { width: 0, height: 2 },
		shadowOpacity: 0.1,
		shadowRadius: 4,
		elevation: 4,
	},
	buttonIcon: {
		marginRight: 8,
	},
	emailButtonText: {
		fontSize: 16,
		fontWeight: "600",
	},
	buttonDescription: {
		fontSize: 14,
		textAlign: "center",
		lineHeight: 20,
		paddingHorizontal: 20,
	},

	// Update Section
	updateSection: {
		alignItems: "center",
		paddingVertical: 30,
		marginTop: 20,
	},
	updateText: {
		fontSize: 14,
	},
});
