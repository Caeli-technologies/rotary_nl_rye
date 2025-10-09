import { StyleSheet, View, Text, ScrollView, Platform } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/hooks/use-theme";

export default function WelcomeInTheNetherlandsScreen() {
	const { colors: themeColors } = useTheme();

	const mottoValues = [
		"Be grateful",
		"Be on purpose",
		"Be of service",
		"Be here now",
		"Be first",
		"Be curious",
	];

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
				<View style={styles.content}>
					{/* Header Section */}
					<View style={styles.headerSection}>
						<View
							style={[
								styles.headerIcon,
								{
									borderColor: themeColors.primary,
									backgroundColor: `${themeColors.primary}10`,
								},
							]}
						>
							<Ionicons
								name="heart-outline"
								size={32}
								color={themeColors.primary}
							/>
						</View>
						<Text style={[styles.headerTitle, { color: themeColors.text }]}>
							Welcome to the Netherlands!
						</Text>
						<Text
							style={[
								styles.headerSubtitle,
								{ color: themeColors.textSecondary },
							]}
						>
							We are excited to have you join our Rotary Youth Exchange family
						</Text>
					</View>

					{/* Welcome Message */}
					<View style={styles.section}>
						<View style={styles.sectionHeader}>
							<Ionicons
								name="people-outline"
								size={24}
								color={themeColors.primary}
							/>
							<Text style={[styles.sectionTitle, { color: themeColors.text }]}>
								Our Community
							</Text>
						</View>

						<View
							style={[
								styles.welcomeCard,
								{
									backgroundColor: themeColors.card,
									shadowColor: themeColors.shadow,
									borderLeftColor: themeColors.primary,
								},
							]}
						>
							<View
								style={[
									styles.highlightBox,
									{ backgroundColor: `${themeColors.accent}15` },
								]}
							>
								<Ionicons
									name="globe-outline"
									size={20}
									color={themeColors.accent}
								/>
								<Text
									style={[styles.highlightText, { color: themeColors.text }]}
								>
									35-50 exchange students annually
								</Text>
							</View>
							<Text
								style={[
									styles.welcomeText,
									{ color: themeColors.textSecondary },
								]}
							>
								We are very excited about your upcoming stay with us and looking
								forward to meeting you. We hope and believe that you will enjoy
								your stay with us. We have an exciting and active Rotary
								International Youth Exchange Program with students from around
								the world.
							</Text>
							<View
								style={[
									styles.friendsBox,
									{ backgroundColor: `${themeColors.secondary}15` },
								]}
							>
								<Ionicons
									name="heart-outline"
									size={16}
									color={themeColors.secondary}
								/>
								<Text
									style={[
										styles.friendsText,
										{ color: themeColors.textSecondary },
									]}
								>
									You will make friends from all over the world, in addition to
									making many Dutch friends in your school and Rotary.
								</Text>
							</View>
						</View>
					</View>

					{/* Exchange Experience */}
					<View style={styles.section}>
						<View style={styles.sectionHeader}>
							<Ionicons
								name="star-outline"
								size={24}
								color={themeColors.primary}
							/>
							<Text style={[styles.sectionTitle, { color: themeColors.text }]}>
								Your Exchange Experience
							</Text>
						</View>

						<View
							style={[
								styles.experienceCard,
								{
									backgroundColor: themeColors.card,
									shadowColor: themeColors.shadow,
									borderLeftColor: themeColors.secondary,
								},
							]}
						>
							<View style={styles.experienceHeader}>
								<Ionicons
									name="sparkles-outline"
									size={20}
									color={themeColors.secondary}
								/>
								<Text
									style={[
										styles.experienceSubtitle,
										{ color: themeColors.text },
									]}
								>
									One of the best years of your life
								</Text>
							</View>
							<Text
								style={[
									styles.experienceText,
									{ color: themeColors.textSecondary },
								]}
							>
								A wonderful experience in a new culture, with a new language but
								also with some rules to make sure that your stay will be both
								enjoyable for you and us alike. These rules are consistent with
								the International Rotary rules.
							</Text>
						</View>
					</View>

					{/* Ambassador Role */}
					<View style={styles.section}>
						<View
							style={[
								styles.ambassadorCard,
								{
									backgroundColor: themeColors.card,
									shadowColor: themeColors.shadow,
									borderLeftColor: themeColors.primary,
								},
							]}
						>
							<View style={styles.ambassadorHeader}>
								<Ionicons
									name="ribbon-outline"
									size={24}
									color={themeColors.primary}
								/>
								<Text
									style={[styles.ambassadorTitle, { color: themeColors.text }]}
								>
									Ambassador Role
								</Text>
							</View>
							<Text
								style={[
									styles.ambassadorText,
									{ color: themeColors.textSecondary },
								]}
							>
								Please remember that under all circumstances you are an
								ambassador of Rotary and will have to behave accordingly. Also
								you will be an ambassador of your country. Both functions will
								be with you at all times and you will be regarded and judged as
								such at all times during your exchange!
							</Text>
						</View>
					</View>

					{/* Rotary Motto */}
					<View style={styles.section}>
						<View style={styles.sectionHeader}>
							<Ionicons
								name="trophy-outline"
								size={24}
								color={themeColors.primary}
							/>
							<Text style={[styles.sectionTitle, { color: themeColors.text }]}>
								Our Motto
							</Text>
						</View>

						<View
							style={[
								styles.mottoCard,
								{
									backgroundColor: themeColors.card,
									shadowColor: themeColors.shadow,
									borderLeftColor: themeColors.accent,
								},
							]}
						>
							<Text style={[styles.mottoIntro, { color: themeColors.text }]}>
								Live by these values during your exchange:
							</Text>
							<View style={styles.mottoGrid}>
								{mottoValues.map((value) => (
									<View
										style={[
											styles.mottoItem,
											{ backgroundColor: `${themeColors.success}10` },
										]}
										key={value}
									>
										<Ionicons
											name="checkmark-circle"
											size={16}
											color={themeColors.success}
										/>
										<Text
											style={[styles.mottoText, { color: themeColors.text }]}
										>
											{value}
										</Text>
									</View>
								))}
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
		borderWidth: 2,
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
		marginBottom: 16,
		shadowOffset: { width: 0, height: 4 },
		shadowOpacity: 0.08,
		shadowRadius: 20,
		elevation: 4,
	},

	// Welcome Card
	welcomeCard: {
		borderRadius: 16,
		padding: 20,
		marginBottom: 16,
		borderLeftWidth: 4,
		shadowOffset: { width: 0, height: 4 },
		shadowOpacity: 0.08,
		shadowRadius: 20,
		elevation: 4,
	},
	highlightBox: {
		flexDirection: "row",
		alignItems: "center",
		padding: 12,
		borderRadius: 8,
		marginBottom: 16,
	},
	highlightText: {
		fontSize: 14,
		fontWeight: "600",
		marginLeft: 8,
	},
	welcomeText: {
		fontSize: 16,
		lineHeight: 24,
		marginBottom: 16,
	},
	friendsBox: {
		flexDirection: "row",
		alignItems: "flex-start",
		padding: 12,
		borderRadius: 8,
	},
	friendsText: {
		fontSize: 14,
		marginLeft: 8,
		flex: 1,
		fontStyle: "italic",
	},

	// Experience Card
	experienceCard: {
		borderRadius: 16,
		padding: 20,
		marginBottom: 16,
		borderLeftWidth: 4,
		shadowOffset: { width: 0, height: 4 },
		shadowOpacity: 0.08,
		shadowRadius: 20,
		elevation: 4,
	},
	experienceHeader: {
		flexDirection: "row",
		alignItems: "center",
		marginBottom: 12,
	},
	experienceSubtitle: {
		fontSize: 16,
		fontWeight: "600",
		marginLeft: 8,
	},
	experienceText: {
		fontSize: 16,
		lineHeight: 24,
	},

	// Ambassador Card
	ambassadorCard: {
		borderRadius: 16,
		padding: 20,
		marginBottom: 16,
		borderLeftWidth: 4,
		shadowOffset: { width: 0, height: 4 },
		shadowOpacity: 0.08,
		shadowRadius: 20,
		elevation: 4,
	},
	ambassadorHeader: {
		flexDirection: "row",
		alignItems: "center",
		marginBottom: 12,
	},
	ambassadorTitle: {
		fontSize: 18,
		fontWeight: "600",
		marginLeft: 8,
	},
	ambassadorText: {
		fontSize: 16,
		lineHeight: 24,
	},

	// Motto Card
	mottoCard: {
		borderRadius: 16,
		padding: 20,
		marginBottom: 16,
		borderLeftWidth: 4,
		shadowOffset: { width: 0, height: 4 },
		shadowOpacity: 0.08,
		shadowRadius: 20,
		elevation: 4,
	},
	mottoIntro: {
		fontSize: 16,
		lineHeight: 24,
		marginBottom: 16,
		fontWeight: "500",
		textAlign: "center",
		padding: 12,
		borderRadius: 8,
	},
	mottoGrid: {
		flexDirection: "row",
		flexWrap: "wrap",
		justifyContent: "space-between",
	},
	mottoItem: {
		flexDirection: "row",
		alignItems: "center",
		width: "48%",
		marginBottom: 16,
		padding: 12,
		borderRadius: 8,
	},
	mottoText: {
		fontSize: 14,
		marginLeft: 8,
		fontWeight: "600",
	},

	infoText: {
		fontSize: 16,
		lineHeight: 24,
	},

	bulletPoint: {
		flexDirection: "row",
		marginBottom: 8,
		alignItems: "flex-start",
	},
	bullet: {
		fontSize: 16,
		fontWeight: "700",
		marginRight: 12,
		marginTop: 2,
	},
	bulletText: {
		flex: 1,
		fontSize: 16,
		lineHeight: 24,
	},
});
