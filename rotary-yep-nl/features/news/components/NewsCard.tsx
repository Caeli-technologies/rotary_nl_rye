/**
 * News card component for displaying news items in a list
 */

import { Pressable, View, Text, StyleSheet, Platform } from "react-native";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";
import { NetworkImage } from "@/shared/components/media/NetworkImage";
import type { NewsItem } from "../types";

interface NewsCardProps {
	item: NewsItem;
	onPress: () => void;
}

const shadowStyle = {
	shadowColor: "#000",
	shadowOffset: { width: 0, height: 2 },
	shadowOpacity: 0.06,
	shadowRadius: 8,
	elevation: 2,
};

export function NewsCard({ item, onPress }: NewsCardProps) {
	const { colors } = useTheme();

	return (
		<Pressable
			style={({ pressed }) => [
				styles.card,
				{
					backgroundColor: colors.card,
					borderColor: colors.border,
					shadowColor: colors.shadow,
				},
				pressed && styles.cardPressed,
			]}
			onPress={onPress}
		>
			{/* Image */}
			<View style={styles.imageContainer}>
				<NetworkImage
					imageUrl={item.imageUrl}
					name={item.title}
					style={styles.image}
				/>
				{item.isPdf && (
					<View style={[styles.pdfBadge, { backgroundColor: colors.error }]}>
						<Ionicons name="document-text" size={12} color="#FFFFFF" />
						<Text style={styles.pdfBadgeText}>PDF</Text>
					</View>
				)}
			</View>

			{/* Content */}
			<View style={styles.content}>
				<Text style={[styles.title, { color: colors.text }]} numberOfLines={2}>
					{item.title}
				</Text>
				<Text
					style={[styles.description, { color: colors.textSecondary }]}
					numberOfLines={3}
				>
					{item.description}
				</Text>

				{/* Footer */}
				<View style={styles.footer}>
					<View
						style={[
							styles.typeIndicator,
							{ backgroundColor: colors.primary + "15" },
						]}
					>
						<Ionicons
							name={item.isPdf ? "document-text-outline" : "reader-outline"}
							size={14}
							color={colors.primary}
						/>
						<Text style={[styles.typeText, { color: colors.primary }]}>
							{item.isPdf ? "PDF Document" : "Article"}
						</Text>
					</View>
					<Ionicons
						name="chevron-forward"
						size={20}
						color={colors.textTertiary}
					/>
				</View>
			</View>
		</Pressable>
	);
}

const styles = StyleSheet.create({
	card: {
		flexDirection: "row",
		borderRadius: spacing.radiusMd,
		marginHorizontal: spacing.md,
		marginVertical: spacing.xs,
		overflow: "hidden",
		...(Platform.OS === "ios"
			? shadowStyle
			: { elevation: 2, borderWidth: StyleSheet.hairlineWidth }),
	},
	cardPressed: {
		opacity: 0.9,
		transform: Platform.OS === "ios" ? [{ scale: 0.98 }] : [],
	},
	imageContainer: {
		width: 100,
		height: 120,
		position: "relative",
	},
	image: {
		width: "100%",
		height: "100%",
	},
	pdfBadge: {
		position: "absolute",
		top: spacing.xs,
		left: spacing.xs,
		flexDirection: "row",
		alignItems: "center",
		paddingHorizontal: spacing.xs,
		paddingVertical: 2,
		borderRadius: 4,
		gap: 2,
	},
	pdfBadgeText: {
		color: "#FFFFFF",
		fontSize: 10,
		fontWeight: "700",
	},
	content: {
		flex: 1,
		padding: spacing.sm,
		justifyContent: "space-between",
	},
	title: {
		fontSize: 16,
		fontWeight: "600",
		marginBottom: spacing.xs,
		lineHeight: 22,
	},
	description: {
		fontSize: 13,
		lineHeight: 18,
		marginBottom: spacing.xs,
	},
	footer: {
		flexDirection: "row",
		alignItems: "center",
		justifyContent: "space-between",
		marginTop: "auto",
	},
	typeIndicator: {
		flexDirection: "row",
		alignItems: "center",
		paddingHorizontal: spacing.xs,
		paddingVertical: 4,
		borderRadius: 4,
		gap: 4,
	},
	typeText: {
		fontSize: 11,
		fontWeight: "600",
	},
});
