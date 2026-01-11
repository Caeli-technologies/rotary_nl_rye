/**
 * Android Segmented Control using @expo/ui Jetpack Compose Picker
 */

import { Picker } from "@expo/ui/jetpack-compose";
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
			<Picker
				variant="segmented"
				options={values}
				selectedIndex={selectedIndex}
				onOptionSelected={handleOptionSelected}
				style={styles.picker}
			/>
		</View>
	);
}

const styles = StyleSheet.create({
	container: {
		width: "100%",
	},
	picker: {
		width: "100%",
		minHeight: 40,
	},
});
