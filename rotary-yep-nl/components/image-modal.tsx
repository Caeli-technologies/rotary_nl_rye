import {
	Modal,
	View,
	StyleSheet,
	Pressable,
	Dimensions,
	Platform,
	Text,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { Image } from "expo-image";
import { useTheme } from "@/hooks/use-theme";
import { getInitials } from "@/utils/communications";

const { width: screenWidth } = Dimensions.get("window");

interface ImageModalProps {
	visible: boolean;
	onClose: () => void;
	source: any;
	name?: string;
}

export function ImageModal({
	visible,
	onClose,
	source,
	name,
}: ImageModalProps) {
	const { colors: themeColors } = useTheme();
	const shouldShowImage =
		source &&
		(typeof source === "string"
			? !source.includes("Profile_avatar_placeholder_large.png")
			: true);
	const initials = name ? getInitials(name) : "";

	return (
		<Modal
			visible={visible}
			animationType="none"
			onRequestClose={onClose}
			presentationStyle="fullScreen"
			statusBarTranslucent={true}
		>
			<SafeAreaView style={styles.modalContainer}>
				<Pressable onPress={onClose} style={styles.closeButton}>
					<Ionicons name="close" size={30} color="white" />
				</Pressable>
				<Pressable style={styles.modalPressable} onPress={onClose}>
					{shouldShowImage ? (
						<Image
							source={typeof source === "string" ? { uri: source } : source}
							style={styles.fullImage}
							contentFit="contain"
						/>
					) : (
						<View style={styles.placeholderContainer}>
							<View
								style={[
									styles.expandedPlaceholder,
									{ backgroundColor: `${themeColors.primary}20` },
								]}
							>
								<Text
									style={[
										styles.expandedInitials,
										{ color: themeColors.primary },
									]}
								>
									{initials}
								</Text>
							</View>
						</View>
					)}
				</Pressable>
			</SafeAreaView>
		</Modal>
	);
}

const styles = StyleSheet.create({
	modalContainer: {
		flex: 1,
		backgroundColor: "black",
	},
	modalPressable: {
		flex: 1,
	},
	closeButton: {
		position: "absolute",
		top: 50,
		right: 20,
		zIndex: 1,
	},
	fullImage: {
		flex: 1,
		width: "100%",
	},
	placeholderContainer: {
		flex: 1,
		justifyContent: "center",
		alignItems: "center",
	},
	expandedPlaceholder: {
		width: screenWidth * 0.6,
		height: screenWidth * 0.6,
		borderRadius: (screenWidth * 0.6) / 2,
		alignItems: "center",
		justifyContent: "center",
	},
	expandedInitials: {
		fontSize: screenWidth * 0.15,
		fontWeight: Platform.OS === "ios" ? "700" : "800",
		textAlign: "center",
	},
});
