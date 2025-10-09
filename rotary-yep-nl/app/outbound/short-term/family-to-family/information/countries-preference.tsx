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

export default function CountriesPreferenceScreen() {
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
								name="globe-outline"
								size={32}
								color={themeColors.primary}
							/>
						</View>
						<Text style={[styles.headerTitle, { color: themeColors.text }]}>
							Landenvoorkeur
						</Text>
						<Text
							style={[
								styles.headerSubtitle,
								{ color: themeColors.textSecondary },
							]}
						>
							Kies je voorkeursbestemming voor de Family-to-Family ervaring
						</Text>
					</View>

					{/* Landenkeuze uitleg */}
					<View style={styles.section}>
						<View style={styles.sectionHeader}>
							<Ionicons
								name="help-circle-outline"
								size={24}
								color={themeColors.primary}
							/>
							<Text style={[styles.sectionTitle, { color: themeColors.text }]}>
								Hoe kies je je voorkeur?
							</Text>
						</View>

						<View
							style={[
								styles.infoCard,
								{
									backgroundColor: themeColors.card,
									borderColor: themeColors.border,
									shadowColor: themeColors.shadow,
								},
							]}
						>
							<Text style={[styles.infoText, { color: themeColors.text }]}>
								Als je mee wilt doen aan het Family to Family programma geef je
								op of je voor het noordelijk of zuidelijk halfrond gaat. Bij de
								landenkeuze dien je drie landen op 2 continenten op te geven.
								Hierbij gelden de Verenigde Staten en Canada als één bestemming.
								De reden hiervoor is dat we niet alle kandidaten in de VS en
								Canada kunnen plaatsen. Daarbij komt dat als jij de juiste
								instelling hebt voor een Family to Family uitwisseling het
								uiteindelijk niet uitmaakt naar welk land je gaat.
							</Text>
						</View>
					</View>

					{/* Europa aanbeveling */}
					<View style={styles.section}>
						<View style={styles.sectionHeader}>
							<Ionicons
								name="star-outline"
								size={24}
								color={themeColors.primary}
							/>
							<Text style={[styles.sectionTitle, { color: themeColors.text }]}>
								Europa: Noordelijk of Zuidelijk
							</Text>
						</View>

						<View
							style={[
								styles.europeCard,
								{
									backgroundColor: themeColors.card,
									borderColor: themeColors.border,
									shadowColor: themeColors.shadow,
									borderLeftColor: themeColors.primary,
								},
							]}
						>
							<Text style={[styles.europeText, { color: themeColors.text }]}>
								Binnen Europa, ook al ligt dit naast de deur, vinden de mooiste
								uitwisselingen plaats en ontstaan de mooiste vriendschappen met
								het voordeel dat je deze vrienden makkelijker kunt herbezoeken.
								De reiskosten zijn veel lager.
							</Text>
						</View>
					</View>

					{/* Tips voor landenkeuze */}
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
									shadowColor: themeColors.shadow,
								},
							]}
						>
							<View
								style={[
									styles.tipIcon,
									{ backgroundColor: `${themeColors.primary}15` },
								]}
							>
								<Ionicons
									name="language-outline"
									size={20}
									color={themeColors.primary}
								/>
							</View>
							<View style={styles.tipContent}>
								<Text style={[styles.tipTitle, { color: themeColors.text }]}>
									Taal en cultuur
								</Text>
								<Text
									style={[
										styles.tipDescription,
										{ color: themeColors.textSecondary },
									]}
								>
									Overweeg landen waar je de taal spreekt of wilt leren
								</Text>
							</View>
						</View>

						<View
							style={[
								styles.tipCard,
								{
									backgroundColor: themeColors.card,
									borderColor: themeColors.border,
									shadowColor: themeColors.shadow,
								},
							]}
						>
							<View
								style={[
									styles.tipIcon,
									{ backgroundColor: `${themeColors.primary}15` },
								]}
							>
								<Ionicons
									name="globe-outline"
									size={20}
									color={themeColors.primary}
								/>
							</View>
							<View style={styles.tipContent}>
								<Text style={[styles.tipTitle, { color: themeColors.text }]}>
									Cultuur
								</Text>
								<Text
									style={[
										styles.tipDescription,
										{ color: themeColors.textSecondary },
									]}
								>
									Kies landen waarvan de cultuur en geschiedenis je echt
									interesseren.
								</Text>
							</View>
						</View>

						<View
							style={[
								styles.tipCard,
								{
									backgroundColor: themeColors.card,
									borderColor: themeColors.border,
									shadowColor: themeColors.shadow,
								},
							]}
						>
							<View
								style={[
									styles.tipIcon,
									{ backgroundColor: `${themeColors.primary}15` },
								]}
							>
								<Ionicons
									name="airplane-outline"
									size={20}
									color={themeColors.primary}
								/>
							</View>
							<View style={styles.tipContent}>
								<Text style={[styles.tipTitle, { color: themeColors.text }]}>
									Reiskosten
								</Text>
								<Text
									style={[
										styles.tipDescription,
										{ color: themeColors.textSecondary },
									]}
								>
									Houd rekening met reiskosten en afstand, vooral bij kortere
									programma&apos;s.
								</Text>
							</View>
						</View>
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
	infoText: {
		fontSize: 16,
		lineHeight: 24,
	},

	// Europe Card Styles
	europeCard: {
		borderRadius: Platform.OS === "ios" ? 16 : 12,
		padding: 20,
		borderLeftWidth: 4,
		borderWidth: Platform.OS === "android" ? StyleSheet.hairlineWidth : 0,
		shadowOffset: { width: 0, height: 2 },
		shadowOpacity: 0.1,
		shadowRadius: 4,
		elevation: 2,
	},
	europeText: {
		fontSize: 16,
		lineHeight: 24,
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

	// Tip Card Styles
	tipCard: {
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
	tipIcon: {
		width: 40,
		height: 40,
		borderRadius: 20,
		justifyContent: "center",
		alignItems: "center",
		marginRight: 16,
	},
	tipContent: {
		flex: 1,
	},
	tipTitle: {
		fontSize: 16,
		fontWeight: "600",
		marginBottom: 4,
	},
	tipDescription: {
		fontSize: 14,
		lineHeight: 20,
	},
});
