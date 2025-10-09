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

export default function HowToSignUpScreen() {
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
							Stappen om jezelf in te schrijven voor de lange termijn
							uitwisseling
						</Text>
					</View>

					{/* Email Instructions */}
					<View style={styles.section}>
						<View
							style={[
								styles.infoCard,
								{
									backgroundColor: themeColors.card,
									borderColor: themeColors.border,
								},
							]}
						>
							<Text style={[styles.infoText, { color: themeColors.text }]}>
								Je stuurt een gezellig email bericht naar:{" "}
								<Text
									style={[styles.emailText, { color: themeColors.primary }]}
								>
									interesse@rotaryyep.nl.
								</Text>{" "}
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
									opacity: pressed ? 0.8 : 1,
								},
							]}
							onPress={() => {
								Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
								Linking.openURL(
									"mailto:interesse@rotaryyep.nl?subject=Interesse%20in%20lange%20termijn%20uitwisseling",
								);
							}}
							accessibilityRole="button"
							accessibilityLabel="Verstuur een Email"
							accessibilityHint="Opent je email app voor het versturen van een email"
							android_ripple={{
								color: "rgba(255,255,255,0.2)",
								borderless: false,
							}}
						>
							<Ionicons
								name="mail-outline"
								size={24}
								color={themeColors.card}
							/>
							<Text
								style={[styles.emailButtonText, { color: themeColors.card }]}
							>
								Verstuur een Email
							</Text>
						</Pressable>
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
		padding: 16,
		paddingBottom: 34,
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
		marginBottom: 24,
	},
	sectionHeader: {
		flexDirection: "row",
		alignItems: "center",
		marginBottom: 16,
	},
	sectionTitle: {
		fontSize: 18,
		fontWeight: "600",
		marginLeft: 12,
	},

	// Info Card
	infoCard: {
		borderRadius: 16,
		padding: 20,
		marginBottom: 24,
		...shadowStyle,
	},
	infoText: {
		fontSize: 16,
		lineHeight: 24,
	},
	emailText: {
		textDecorationLine: "underline",
	},

	// Button Section
	buttonSection: {
		alignItems: "center",
		marginBottom: 32,
	},
	emailButton: {
		borderRadius: Platform.OS === "ios" ? 25 : 8,
		paddingVertical: Platform.OS === "ios" ? 16 : 14,
		paddingHorizontal: 32,
		flexDirection: "row",
		alignItems: "center",
		minWidth: 200,
		justifyContent: "center",
		...(Platform.OS === "ios"
			? {
					shadowColor: "#000",
					shadowOffset: { width: 0, height: 2 },
					shadowOpacity: 0.1,
					shadowRadius: 4,
				}
			: {
					elevation: 3,
				}),
	},
	emailButtonText: {
		fontSize: 16,
		fontWeight: "600",
		marginLeft: 8,
	},
});
