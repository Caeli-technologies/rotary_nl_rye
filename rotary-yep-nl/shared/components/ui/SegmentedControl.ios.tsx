/**
 * iOS Segmented Control using @expo/ui SwiftUI Picker
 */

import { Host, Picker } from "@expo/ui/swift-ui";
import { StyleSheet, View, type ViewStyle } from "react-native";

interface SegmentedControlProps {
	values: string[];
	selectedIndex: number;
	onChange: (index: number) => void;
	style?: ViewStyle;
}

export function SegmentedControl({
	values,
	selectedIndex,
	onChange,
	style,
}: SegmentedControlProps) {
	const handleOptionSelected = (event: {
		nativeEvent: { index: number; label: string };
	}) => {
		onChange(event.nativeEvent.index);
	};

	return (
		<View style={[styles.container, style]}>
			<Host style={styles.host}>
				<Picker
					variant="segmented"
					options={values}
					selectedIndex={selectedIndex}
					onOptionSelected={handleOptionSelected}
				/>
			</Host>
		</View>
	);
}

const styles = StyleSheet.create({
	container: {
		width: "100%",
	},
	host: {
		width: "100%",
		minHeight: 32,
	},
});
