import React, { memo } from "react";
import {
	StyleSheet,
	View,
	Text,
	ScrollView,
	Platform,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { ContentSection } from "./ContentSection";
import { ContentCard } from "./ContentCard";
import { HighlightGrid } from "./HighlightGrid";
import { TipCard } from "./TipCard";
import { TimelineCard } from "./TimelineCard";
import { VideoPlayer } from "./VideoPlayer";
import type {
	InfoPageContent,
	ContentBlock,
	Section,
	IconName,
	GridItem,
} from "../types";

interface InfoPageProps {
	/** Page content configuration */
	content: InfoPageContent;
}

/**
 * InfoPage - A generic content page renderer
 *
 * Takes InfoPageContent and renders all sections with appropriate components
 * based on block types.
 */
export const InfoPage = memo(function InfoPage({ content }: InfoPageProps) {
	const { colors } = useTheme();

	const renderBlock = (block: ContentBlock) => {
		switch (block.type) {
			case "text":
				return (
					<Text
						key={block.id}
						style={[styles.textBlock, { color: colors.textSecondary }]}
					>
						{block.content}
					</Text>
				);

			case "card":
				return (
					<ContentCard
						key={block.id}
						icon={block.icon}
						iconColor={block.iconColor}
						title={block.title}
						content={block.content}
						accentColor={block.accentColor}
					/>
				);

			case "highlight":
				return <HighlightGrid key={block.id} items={block.items} />;

			case "timeline":
				return <TimelineCard key={block.id} items={block.items} />;

			case "grid":
				return (
					<View key={block.id} style={styles.gridContainer}>
						{block.title && (
							<Text style={[styles.gridTitle, { color: colors.text }]}>
								{block.title}
							</Text>
						)}
						<View style={styles.grid}>
							{block.items.map((item: GridItem, index: number) => (
								<View
									key={`grid-item-${index}`}
									style={[
										styles.gridItem,
										{ backgroundColor: `${colors.success}10` },
									]}
								>
									{item.icon && (
										<Ionicons
											name={item.icon as IconName}
											size={16}
											color={colors.success}
										/>
									)}
									<Text
										style={[
											styles.gridItemText,
											{ color: colors.text },
											item.icon && styles.gridItemTextWithIcon,
										]}
									>
										{item.text}
									</Text>
								</View>
							))}
						</View>
					</View>
				);

			case "tips":
				return <TipCard key={block.id} items={block.items} />;

			case "video":
				return (
					<VideoPlayer
						key={block.id}
						videoUrl={block.videoUrl}
						title={block.title}
						description={block.description}
						thumbnailTime={block.thumbnailTime}
					/>
				);

			case "cta":
				// CTA blocks would be handled here
				// For now, just render as a card
				return (
					<ContentCard
						key={block.id}
						icon="mail-outline"
						iconColor="primary"
						title={block.label}
						content={block.description || ""}
						accentColor="primary"
					/>
				);

			default:
				return null;
		}
	};

	const renderSection = (section: Section) => {
		return (
			<ContentSection
				key={section.id}
				icon={section.icon}
				title={section.title}
			>
				{section.blocks.map(renderBlock)}
			</ContentSection>
		);
	};

	return (
		<SafeAreaView
			style={[styles.container, { backgroundColor: colors.background }]}
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
								{ backgroundColor: `${colors.primary}15` },
							]}
						>
							<Ionicons
								name={content.header.icon}
								size={32}
								color={colors.primary}
							/>
						</View>
						<Text style={[styles.headerTitle, { color: colors.text }]}>
							{content.header.title}
						</Text>
						{content.header.subtitle && (
							<Text
								style={[
									styles.headerSubtitle,
									{ color: colors.textSecondary },
								]}
							>
								{content.header.subtitle}
							</Text>
						)}
					</View>

					{/* Content Sections */}
					{content.sections.map(renderSection)}
				</View>
			</ScrollView>
		</SafeAreaView>
	);
});

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

	// Header
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

	// Text block
	textBlock: {
		fontSize: 16,
		lineHeight: 24,
		marginBottom: 16,
	},

	// Grid
	gridContainer: {
		marginBottom: 16,
	},
	gridTitle: {
		fontSize: 16,
		fontWeight: "500",
		textAlign: "center",
		marginBottom: 16,
	},
	grid: {
		flexDirection: "row",
		flexWrap: "wrap",
		justifyContent: "space-between",
	},
	gridItem: {
		flexDirection: "row",
		alignItems: "center",
		width: "48%",
		marginBottom: 12,
		padding: 12,
		borderRadius: 8,
	},
	gridItemText: {
		fontSize: 14,
		fontWeight: "600",
	},
	gridItemTextWithIcon: {
		marginLeft: 8,
	},
});
