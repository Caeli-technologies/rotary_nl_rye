import { useState, useEffect, useCallback } from "react";
import {
	StyleSheet,
	View,
	Text,
	FlatList,
	Pressable,
	ActivityIndicator,
	Alert,
	Platform,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { Image } from "expo-image";
import { router } from "expo-router";
import type { Colors } from "@/constants/theme";
import { useTheme } from "@/hooks/use-theme";
interface NewsItem {
	id: number;
	images: string;
	pdf: string | null;
	title: string;
	description: string;
	isPdf: string;
	text?: {
		heading?: string;
		body?: {
			paragraph?: string[];
			videoUrl?: string;
			imageUrl?: string;
		}[];
	}[];
}

interface NewsData {
	news: NewsItem[];
}

function NewsCard({
	item,
	onPress,
	themeColors,
}: {
	item: NewsItem;
	onPress: () => void;
	themeColors: typeof Colors.light;
}) {
	return (
		<Pressable
			style={({ pressed }) => [
				styles.newsCard,
				{ backgroundColor: themeColors.card, shadowColor: themeColors.shadow },
				pressed && styles.newsCardPressed,
			]}
			onPress={onPress}
			android_ripple={{
				color: `${themeColors.primary}20`,
				borderless: false,
			}}
		>
			<View style={styles.cardContent}>
				<View style={styles.imageContainer}>
					<Image
						source={{ uri: item.images }}
						style={styles.newsImage}
						contentFit="cover"
						placeholder="https://via.placeholder.com/300x200/E0E0E0/999999?text=Loading"
					/>
				</View>
				<View style={styles.textContainer}>
					{item.isPdf === "yes" && (
						<View style={styles.pdfBadge}>
							<Ionicons name="document-text" size={16} color="#fff" />
							<Text style={styles.pdfText}>PDF</Text>
						</View>
					)}
					<Text
						style={[styles.newsTitle, { color: themeColors.text }]}
						numberOfLines={2}
					>
						{item.title}
					</Text>
					{item.description && (
						<Text
							style={[
								styles.newsDescription,
								{ color: themeColors.textSecondary },
							]}
							numberOfLines={3}
						>
							{item.description}
						</Text>
					)}
				</View>
			</View>
		</Pressable>
	);
}

export default function NewsScreen() {
	const { colors: themeColors } = useTheme();

	const [newsData, setNewsData] = useState<NewsItem[]>([]);
	const [loading, setLoading] = useState(true);
	const [refreshing, setRefreshing] = useState(false);
	const [error, setError] = useState<string | null>(null);

	const fetchNews = useCallback(async (isRefresh = false) => {
		try {
			if (!isRefresh) setLoading(true);
			setError(null);

			// Add timestamp to prevent caching
			const timestamp = Date.now();
			const url = `https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/news/news.json?t=${timestamp}`;

			const response = await fetch(url, {
				method: "GET",
				headers: {
					"Cache-Control": "no-cache, no-store, must-revalidate",
					Pragma: "no-cache",
					Expires: "0",
				},
			});

			if (!response.ok) {
				throw new Error(`Failed to load news: ${response.status}`);
			}

			const data: NewsData = await response.json();
			setNewsData(data.news || []);
		} catch (err) {
			console.error("Error fetching news:", err);
			setError(err instanceof Error ? err.message : "Failed to load news");
		} finally {
			setLoading(false);
			if (isRefresh) setRefreshing(false);
		}
	}, []);

	useEffect(() => {
		fetchNews();
	}, [fetchNews]);

	const handleRefresh = () => {
		setRefreshing(true);
		fetchNews(true);
	};

	const handleNewsItemPress = (item: NewsItem) => {
		if (item.isPdf === "yes" && item.pdf) {
			router.push({
				pathname: "/pdf-viewer" as any,
				params: { url: item.pdf, title: item.title },
			});
		} else if (item.text?.length) {
			router.push({
				pathname: "/news/[id]" as any,
				params: {
					id: item.id.toString(),
					title: item.title,
					content: JSON.stringify(item),
				},
			});
		} else {
			Alert.alert(
				"Notice",
				"This news item has no additional content available.",
			);
		}
	};

	const renderNewsItem = ({ item }: { item: NewsItem }) => (
		<NewsCard
			item={item}
			onPress={() => handleNewsItemPress(item)}
			themeColors={themeColors}
		/>
	);

	const renderEmptyComponent = () => {
		if (loading) {
			return (
				<View style={styles.centered}>
					<ActivityIndicator size="large" color={themeColors.link} />
					<Text
						style={[styles.loadingText, { color: themeColors.textSecondary }]}
					>
						Loading news...
					</Text>
				</View>
			);
		}

		if (error) {
			return (
				<View style={styles.centered}>
					<Ionicons name="alert-circle" size={64} color={themeColors.error} />
					<Text style={[styles.errorText, { color: themeColors.error }]}>
						Failed to load news
					</Text>
					<Text
						style={[styles.errorSubtext, { color: themeColors.textSecondary }]}
					>
						{error}
					</Text>
					<Pressable
						style={[
							styles.retryButton,
							{ backgroundColor: themeColors.primary },
						]}
						onPress={() => fetchNews()}
					>
						<Text style={[styles.retryText, { color: themeColors.onPrimary }]}>
							Try Again
						</Text>
					</Pressable>
				</View>
			);
		}

		return (
			<View style={styles.centered}>
				<Ionicons
					name="newspaper-outline"
					size={64}
					color={themeColors.textTertiary}
				/>
				<Text style={[styles.emptyText, { color: themeColors.textSecondary }]}>
					No news available
				</Text>
			</View>
		);
	};

	return (
		<SafeAreaView
			style={[styles.safeArea, { backgroundColor: themeColors.background }]}
			edges={[]}
		>
			<FlatList
				data={newsData}
				renderItem={renderNewsItem}
				keyExtractor={(item) => item.id.toString()}
				contentContainerStyle={
					newsData.length > 0 ? styles.listContent : styles.emptyContainer
				}
				showsVerticalScrollIndicator={false}
				refreshing={refreshing}
				onRefresh={handleRefresh}
				ListEmptyComponent={renderEmptyComponent}
			/>
		</SafeAreaView>
	);
}

const styles = StyleSheet.create({
	safeArea: {
		flex: 1,
	},
	listContent: {
		paddingHorizontal: 16,
		paddingTop: 16,
		paddingBottom: 34,
		flexGrow: 1,
	},
	emptyContainer: {
		flex: 1,
		padding: 16,
	},
	newsCard: {
		borderRadius: 16,
		marginBottom: 16,
		shadowOffset: { width: 0, height: 2 },
		shadowOpacity: 0.1,
		shadowRadius: 8,
		elevation: 4,
		overflow: "hidden",
	},
	newsCardPressed: {
		opacity: 0.8,
		transform: Platform.OS === "ios" ? [{ scale: 0.98 }] : [],
	},
	cardContent: {
		flexDirection: "row",
	},
	imageContainer: {
		width: 140,
		height: 120,
		position: "relative",
	},
	newsImage: {
		width: "100%",
		height: "100%",
	},
	pdfBadge: {
		position: "absolute",
		top: 12,
		right: 12,
		backgroundColor: "rgba(31, 78, 121, 0.95)",
		flexDirection: "row",
		alignItems: "center",
		paddingHorizontal: 8,
		paddingVertical: 4,
		borderRadius: 12,
	},
	pdfText: {
		color: "#fff",
		fontSize: 12,
		fontWeight: "600",
		marginLeft: 4,
	},
	textContainer: {
		flex: 1,
		padding: 16,
		paddingTop: 20,
		justifyContent: "center",
		position: "relative",
	},
	newsTitle: {
		fontSize: 18,
		fontWeight: "700",
		marginBottom: 8,
		lineHeight: 24,
	},
	newsDescription: {
		fontSize: 15,
		fontWeight: "400",
		lineHeight: 22,
	},
	centered: {
		flex: 1,
		justifyContent: "center",
		alignItems: "center",
		padding: 40,
	},
	loadingText: {
		marginTop: 16,
		fontSize: 17,
		fontWeight: "500",
	},
	errorText: {
		marginTop: 16,
		fontSize: 20,
		fontWeight: "600",
		textAlign: "center",
	},
	errorSubtext: {
		marginTop: 8,
		fontSize: 15,
		textAlign: "center",
	},
	retryButton: {
		marginTop: 24,
		paddingHorizontal: 32,
		paddingVertical: 14,
		borderRadius: 12,
	},
	retryText: {
		fontSize: 16,
		fontWeight: "600",
	},
	emptyText: {
		marginTop: 16,
		fontSize: 17,
		fontWeight: "500",
		textAlign: "center",
	},
});
