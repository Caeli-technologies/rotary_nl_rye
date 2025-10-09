import { StyleSheet, View, Text, ScrollView, Platform } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/hooks/use-theme";
const shadowStyle = {
	shadowColor: "#000",
	shadowOffset: { width: 0, height: 4 },
	shadowOpacity: 0.08,
	shadowRadius: 20,
	elevation: 4,
};

export default function FamilyToFamilyComplyWithScreen() {
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
								{ backgroundColor: `${themeColors.primary}15` },
							]}
						>
							<Ionicons
								name="shield-checkmark-outline"
								size={32}
								color={themeColors.primary}
							/>
						</View>
						<Text style={[styles.headerTitle, { color: themeColors.text }]}>
							Waar moet ik aan voldoen?
						</Text>
						<Text
							style={[
								styles.headerSubtitle,
								{ color: themeColors.textSecondary },
							]}
						>
							Vereisten en richtlijnen voor Family-to-Family deelnemers
						</Text>
					</View>

					{/* Main Content */}
					<View style={styles.section}>
						<View style={styles.sectionHeader}>
							<Ionicons
								name="information-circle-outline"
								size={24}
								color={themeColors.primary}
							/>
							<Text style={[styles.sectionTitle, { color: themeColors.text }]}>
								Geschiktheid voor deelname
							</Text>
						</View>

						<View
							style={[
								styles.mainCard,
								{
									backgroundColor: themeColors.card,
									borderColor: themeColors.border,
									shadowColor: themeColors.shadow,
								},
							]}
						>
							<Text style={[styles.mainText, { color: themeColors.text }]}>
								Alle jongens en meisjes in de leeftijd van 15 t/m 19* jaar, die
								open staan voor anderen, van hen willen leren, met hen
								ervaringen willen uitwisselen, die uit hun eigen vertrouwde
								omgeving willen stappen en die anderen zonder vooroordelen
								willen ontmoeten zijn geschikt om aan dit programma deel te
								nemen.
							</Text>
						</View>
					</View>

					{/* Age Note */}
					<View
						style={[
							styles.noteCard,
							{
								backgroundColor: themeColors.card,
								borderColor: themeColors.border,
								shadowColor: themeColors.shadow,
								borderLeftColor: themeColors.primary,
							},
						]}
					>
						<View style={styles.noteTitleContainer}>
							<Ionicons
								name="calendar-outline"
								size={20}
								color={themeColors.primary}
							/>
							<Text style={[styles.noteTitle, { color: themeColors.text }]}>
								Leeftijdsvereisten
							</Text>
						</View>
						<Text
							style={[
								styles.noteDescription,
								{ color: themeColors.textSecondary },
							]}
						>
							*Deelnemers moeten tussen 15 en 19 jaar oud zijn om deel te kunnen
							nemen aan het Family-to-Family programma.
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

	// Main Card Styles
	mainCard: {
		borderRadius: Platform.OS === "ios" ? 16 : 12,
		padding: 20,
		...(Platform.OS === "ios"
			? shadowStyle
			: {
					elevation: 2,
					borderWidth: StyleSheet.hairlineWidth,
				}),
	},
	mainText: {
		fontSize: 16,
		lineHeight: 24,
	},

	// Note Card Styles
	noteCard: {
		borderRadius: Platform.OS === "ios" ? 12 : 8,
		padding: 16,
		marginBottom: 20,
		borderLeftWidth: 4,
		borderWidth: Platform.OS === "android" ? StyleSheet.hairlineWidth : 0,
		shadowOffset: { width: 0, height: 4 },
		shadowOpacity: 0.08,
		shadowRadius: 20,
		elevation: 2,
	},
	noteTitleContainer: {
		flexDirection: "row",
		alignItems: "center",
		marginBottom: 8,
	},
	noteTitle: {
		fontSize: 16,
		fontWeight: "600",
		marginLeft: 8,
	},
	noteDescription: {
		fontSize: 14,
		lineHeight: 20,
	},

	// Logo Section
	logoSection: {
		alignItems: "center",
		paddingVertical: 30,
		marginTop: 20,
	},
	logoText: {
		fontSize: 14,
	},

	// Requirement Card Styles
	requirementCard: {
		borderRadius: Platform.OS === "ios" ? 12 : 8,
		padding: 16,
		marginBottom: 12,
		flexDirection: "row",
		alignItems: "flex-start",
		...(Platform.OS === "ios"
			? shadowStyle
			: {
					elevation: 1,
					borderWidth: StyleSheet.hairlineWidth,
				}),
	},
	requirementIcon: {
		width: 40,
		height: 40,
		borderRadius: 20,
		justifyContent: "center",
		alignItems: "center",
		marginRight: 16,
	},
	requirementContent: {
		flex: 1,
	},
	requirementTitle: {
		fontSize: 16,
		fontWeight: "600",
		marginBottom: 4,
	},
	requirementDescription: {
		fontSize: 14,
		lineHeight: 20,
	},
});
