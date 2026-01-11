/**
 * Inbound students program selection screen
 * Thin wrapper using contacts and theme features
 */

import { useCallback, useMemo, useState } from "react";
import {
	StyleSheet,
	View,
	Text,
	FlatList,
	Pressable,
	Platform,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons, FontAwesome5 } from "@expo/vector-icons";
import { router } from "expo-router";
import * as Haptics from "expo-haptics";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";
import { ContactModal, longTermContacts } from "@/features/contacts";

interface ProgramItem {
	title: string;
	subtitle: string;
	icon: keyof typeof FontAwesome5.glyphMap;
	route: string;
	enabled?: boolean;
}

export default function InboundScreen() {
	const { colors } = useTheme();
	const [showSandraContact, setShowSandraContact] = useState(false);

	const sandraCools = useMemo(
		() =>
			longTermContacts.find((contact) => contact.name === "Sandra Cools-Wemer"),
		[],
	);

	const handleSandraContactPress = useCallback(async () => {
		try {
			if (Platform.OS === "ios") {
				await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
			}
			setShowSandraContact(true);
		} catch {
			setShowSandraContact(true);
		}
	}, []);

	const handleProgramPress = useCallback(
		async (route: string, enabled: boolean = true) => {
			if (!enabled) return;

			try {
				if (Platform.OS === "ios") {
					await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
				}
				router.push(route as any);
			} catch {
				router.push(route as any);
			}
		},
		[],
	);

	const longTermPrograms: ProgramItem[] = useMemo(
		() => [
			{
				title: "Long Term Exchange Program",
				subtitle: "Year Exchange",
				icon: "calendar-alt",
				route: "/students/inbound/long-term",
				enabled: true,
			},
		],
		[],
	);

	const shortTermPrograms: ProgramItem[] = useMemo(
		() => [
			{
				title: "Zomerkampen",
				subtitle: "Zomerkampen & Culturele Programmas",
				icon: "campground",
				route: "/students/inbound/short-term/camps-and-tours",
				enabled: false,
			},
			{
				title: "Family to Family",
				subtitle: "Exchange between families",
				icon: "home",
				route: "/students/inbound/short-term/family-to-family",
				enabled: false,
			},
		],
		[],
	);

	const renderProgramItem = useCallback(
		({ item }: { item: ProgramItem }) => (
			<Pressable
				style={({ pressed }) => [
					styles.programItem,
					{
						backgroundColor: colors.card,
						borderColor: colors.border,
						shadowColor: colors.shadow,
					},
					pressed && { opacity: 0.7, transform: [{ scale: 0.98 }] },
					!item.enabled && styles.programItemDisabled,
				]}
				onPress={() => handleProgramPress(item.route, item.enabled)}
				disabled={!item.enabled}
			>
				<View style={styles.programContent}>
					<View
						style={[
							styles.iconContainer,
							{ backgroundColor: `${colors.primary}15` },
						]}
					>
						<FontAwesome5
							name={item.icon}
							size={22}
							color={item.enabled ? colors.primary : colors.textTertiary}
						/>
					</View>
					<View style={styles.textContainer}>
						<Text
							style={[
								styles.programTitle,
								{ color: colors.text },
								!item.enabled && { color: colors.textTertiary },
							]}
						>
							{item.title}
						</Text>
						<Text
							style={[styles.programSubtitle, { color: colors.textTertiary }]}
						>
							{item.subtitle}
						</Text>
					</View>
					<Ionicons
						name={Platform.OS === "ios" ? "chevron-forward" : "arrow-forward"}
						size={20}
						color={item.enabled ? colors.textTertiary : colors.textDisabled}
					/>
				</View>
			</Pressable>
		),
		[colors, handleProgramPress],
	);

	const IntroSection = useCallback(
		() => (
			<View style={styles.introContainer}>
				<Text style={[styles.introTitle, { color: colors.primary }]}>
					Inbounds
				</Text>
				<Text style={[styles.introText, { color: colors.textSecondary }]}>
					Wow, we&apos;re so excited that you will be our inbound exchange
					student for the coming year. For this to happen we will need some
					extra information so please watch your email inbox on a regular basis.
					Also you can find some further information in this app. If you have
					any questions that are not answered, please contact our inbound
					coordinator{" "}
					<Text
						style={[styles.linkText, { color: colors.link }]}
						onPress={handleSandraContactPress}
					>
						Sandra Cools-Wemer
					</Text>
					.
				</Text>
			</View>
		),
		[colors, handleSandraContactPress],
	);

	const SectionHeader = useCallback(
		({ title }: { title: string }) => (
			<View style={styles.sectionHeaderContainer}>
				<Text style={[styles.sectionHeaderTitle, { color: colors.primary }]}>
					{title}
				</Text>
				<View
					style={[
						styles.sectionHeaderDivider,
						{ backgroundColor: colors.border },
					]}
				/>
			</View>
		),
		[colors],
	);

	const listData = useMemo(
		() => [
			{ type: "intro" },
			{ type: "sectionHeader", title: "Long Term Exchange Program" },
			...longTermPrograms.map((item) => ({ type: "program", item })),
			{ type: "spacer" },
			{ type: "sectionHeader", title: "Short Term Exchange Program" },
			...shortTermPrograms.map((item) => ({ type: "program", item })),
		],
		[longTermPrograms, shortTermPrograms],
	);

	const renderItem = useCallback(
		({ item }: { item: any }) => {
			switch (item.type) {
				case "intro":
					return <IntroSection />;
				case "sectionHeader":
					return <SectionHeader title={item.title} />;
				case "program":
					return renderProgramItem({ item: item.item });
				case "spacer":
					return <View style={styles.spacer} />;
				default:
					return null;
			}
		},
		[IntroSection, SectionHeader, renderProgramItem],
	);

	return (
		<SafeAreaView
			style={[styles.safeArea, { backgroundColor: colors.background }]}
			edges={["bottom"]}
		>
			<FlatList
				data={listData}
				renderItem={renderItem}
				keyExtractor={(item, index) => `${item.type}-${index}`}
				showsVerticalScrollIndicator={false}
				contentInsetAdjustmentBehavior="automatic"
				contentContainerStyle={styles.listContainer}
			/>

			{sandraCools && (
				<ContactModal
					contact={sandraCools}
					visible={showSandraContact}
					onClose={() => setShowSandraContact(false)}
				/>
			)}
		</SafeAreaView>
	);
}

const styles = StyleSheet.create({
	safeArea: {
		flex: 1,
	},
	listContainer: {
		padding: spacing.md,
		paddingBottom: spacing.xl,
	},
	introContainer: {
		marginBottom: spacing.xl,
	},
	introTitle: {
		fontSize: 24,
		fontWeight: "600",
		marginBottom: spacing.md,
	},
	introText: {
		fontSize: 15,
		lineHeight: 22,
	},
	linkText: {
		textDecorationLine: "underline",
	},
	sectionHeaderContainer: {
		marginBottom: spacing.md,
		marginTop: spacing.sm,
	},
	sectionHeaderTitle: {
		fontSize: 18,
		fontWeight: "600",
		marginBottom: spacing.sm,
	},
	sectionHeaderDivider: {
		height: 2,
		borderRadius: 1,
	},
	programItem: {
		borderRadius: 12,
		marginBottom: spacing.sm,
		overflow: "hidden",
		shadowOffset: { width: 0, height: 1 },
		shadowOpacity: 0.08,
		shadowRadius: 8,
		elevation: 2,
	},
	programItemDisabled: {
		opacity: 0.6,
	},
	programContent: {
		flexDirection: "row",
		alignItems: "center",
		padding: spacing.md,
		minHeight: 72,
	},
	iconContainer: {
		width: 44,
		height: 44,
		borderRadius: 22,
		justifyContent: "center",
		alignItems: "center",
		marginRight: spacing.md,
	},
	textContainer: {
		flex: 1,
		marginRight: spacing.sm,
	},
	programTitle: {
		fontSize: 16,
		fontWeight: "600",
		marginBottom: 4,
	},
	programSubtitle: {
		fontSize: 13,
	},
	spacer: {
		height: spacing.sm,
	},
});
