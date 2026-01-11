import { StyleSheet, View, Text, ScrollView, Platform } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/hooks/use-theme";

export default function InsuranceScreen() {
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
							Insurance
						</Text>
						<Text
							style={[
								styles.headerSubtitle,
								{ color: themeColors.textSecondary },
							]}
						>
							Comprehensive insurance coverage for your exchange year
						</Text>
					</View>

					{/* Compulsory Coverage */}
					<View style={styles.section}>
						<View
							style={[
								styles.compulsoryCard,
								{
									backgroundColor: themeColors.card,
									shadowColor: themeColors.shadow,
									borderLeftColor: themeColors.primary,
								},
							]}
						>
							<View style={styles.compulsoryHeader}>
								<Ionicons
									name="alert-circle-outline"
									size={24}
									color={themeColors.primary}
								/>
								<Text
									style={[styles.compulsoryTitle, { color: themeColors.text }]}
								>
									Compulsory Coverage
								</Text>
							</View>
							<Text
								style={[styles.compulsoryText, { color: themeColors.text }]}
							>
								The insurance policy from the Netherlands is compulsory. We will
								pre-insure you, so you will be fully insured as soon as you will
								land at Amsterdam Schiphol airport up until you are leaving at
								the airport again.
							</Text>
						</View>
					</View>

					{/* Coverage Timeline */}
					<View style={styles.section}>
						<View style={styles.sectionHeader}>
							<Ionicons
								name="time-outline"
								size={24}
								color={themeColors.primary}
							/>
							<Text style={[styles.sectionTitle, { color: themeColors.text }]}>
								Coverage Timeline
							</Text>
						</View>

						<View
							style={[
								styles.timelineCard,
								{
									backgroundColor: themeColors.card,
									shadowColor: themeColors.shadow,
								},
							]}
						>
							<View style={styles.timelineItem}>
								<View
									style={[
										styles.timelineIcon,
										{ backgroundColor: themeColors.background },
									]}
								>
									<Ionicons
										name="airplane-outline"
										size={20}
										color={themeColors.info}
									/>
								</View>
								<View style={styles.timelineContent}>
									<Text
										style={[styles.timelineTitle, { color: themeColors.text }]}
									>
										Arrival at Schiphol
									</Text>
									<Text
										style={[
											styles.timelineText,
											{ color: themeColors.textSecondary },
										]}
									>
										Coverage begins immediately upon landing
									</Text>
								</View>
							</View>

							<View
								style={[
									styles.timelineLine,
									{ backgroundColor: themeColors.border },
								]}
							/>

							<View style={styles.timelineItem}>
								<View
									style={[
										styles.timelineIcon,
										{ backgroundColor: themeColors.background },
									]}
								>
									<Ionicons
										name="calendar-outline"
										size={20}
										color={themeColors.success}
									/>
								</View>
								<View style={styles.timelineContent}>
									<Text
										style={[styles.timelineTitle, { color: themeColors.text }]}
									>
										During Exchange
									</Text>
									<Text
										style={[
											styles.timelineText,
											{ color: themeColors.textSecondary },
										]}
									>
										Full coverage throughout your stay
									</Text>
								</View>
							</View>

							<View
								style={[
									styles.timelineLine,
									{ backgroundColor: themeColors.border },
								]}
							/>

							<View style={styles.timelineItem}>
								<View
									style={[
										styles.timelineIcon,
										{ backgroundColor: themeColors.background },
									]}
								>
									<Ionicons
										name="home-outline"
										size={20}
										color={themeColors.warning}
									/>
								</View>
								<View style={styles.timelineContent}>
									<Text
										style={[styles.timelineTitle, { color: themeColors.text }]}
									>
										Departure
									</Text>
									<Text
										style={[
											styles.timelineText,
											{ color: themeColors.textSecondary },
										]}
									>
										Coverage ends when you leave the airport
									</Text>
								</View>
							</View>
						</View>
					</View>

					{/* Policy Documents */}
					<View style={styles.section}>
						<View style={styles.sectionHeader}>
							<Ionicons
								name="document-text-outline"
								size={24}
								color={themeColors.primary}
							/>
							<Text style={[styles.sectionTitle, { color: themeColors.text }]}>
								Policy Documents
							</Text>
						</View>

						<View
							style={[
								styles.documentCard,
								{
									backgroundColor: themeColors.card,
									shadowColor: themeColors.shadow,
									borderLeftColor: themeColors.success,
								},
							]}
						>
							<View style={styles.documentHeader}>
								<Ionicons
									name="mail-outline"
									size={20}
									color={themeColors.success}
								/>
								<Text
									style={[styles.documentTitle, { color: themeColors.text }]}
								>
									Document Delivery
								</Text>
							</View>
							<Text style={[styles.documentText, { color: themeColors.text }]}>
								A copy of the Insurance Policy will be sent to you a few days
								before you leave your home country.
							</Text>
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

	// Compulsory Card
	compulsoryCard: {
		borderRadius: 16,
		padding: 20,
		marginBottom: 16,
		borderLeftWidth: 4,
		shadowOffset: { width: 0, height: 4 },
		shadowOpacity: 0.08,
		shadowRadius: 20,
		elevation: 4,
	},
	compulsoryHeader: {
		flexDirection: "row",
		alignItems: "center",
		marginBottom: 12,
	},
	compulsoryTitle: {
		fontSize: 18,
		fontWeight: "600",
		marginLeft: 8,
	},
	compulsoryText: {
		fontSize: 16,
		lineHeight: 24,
	},

	// Timeline Card
	timelineCard: {
		borderRadius: 16,
		padding: 20,
		marginBottom: 16,
		shadowOffset: { width: 0, height: 4 },
		shadowOpacity: 0.08,
		shadowRadius: 20,
		elevation: 4,
	},
	timelineItem: {
		flexDirection: "row",
		alignItems: "flex-start",
	},
	timelineIcon: {
		width: 40,
		height: 40,
		borderRadius: 20,
		justifyContent: "center",
		alignItems: "center",
		marginRight: 16,
	},
	timelineContent: {
		flex: 1,
		paddingBottom: 16,
	},
	timelineTitle: {
		fontSize: 16,
		fontWeight: "600",
		marginBottom: 4,
	},
	timelineText: {
		fontSize: 14,
		lineHeight: 20,
	},
	timelineLine: {
		width: 2,
		height: 20,
		marginLeft: 19,
		marginVertical: 4,
	},

	// Document Card
	documentCard: {
		borderRadius: 16,
		padding: 20,
		marginBottom: 16,
		borderLeftWidth: 4,
		shadowOffset: { width: 0, height: 4 },
		shadowOpacity: 0.08,
		shadowRadius: 20,
		elevation: 4,
	},
	documentHeader: {
		flexDirection: "row",
		alignItems: "center",
		marginBottom: 12,
	},
	documentTitle: {
		fontSize: 16,
		fontWeight: "600",
		marginLeft: 8,
	},
	documentText: {
		fontSize: 16,
		lineHeight: 24,
	},
});
