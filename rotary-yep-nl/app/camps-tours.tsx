import { useState, useEffect, useCallback, useLayoutEffect } from "react";
import {
	StyleSheet,
	View,
	Text,
	FlatList,
	Pressable,
	ActivityIndicator,
	Alert,
	RefreshControl,
	Modal,
	Platform,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { router, useNavigation } from "expo-router";
import { Image } from "expo-image";
import { readString } from "react-native-csv";
import { getFlagAsset } from "../utils/flags";
import type { Colors } from "@/constants/theme";
import { useTheme } from "@/hooks/use-theme";
interface CampTourData {
	startDate: string;
	endDate: string;
	title: string;
	hostCountryCode: string;
	hostCountry: string;
	hostDistrict: string;
	ageMin: string;
	ageMax: string;
	contribution: string;
	invitation: string;
	full: string;
}

interface TravelCardProps extends CampTourData {
	themeColors: typeof Colors.light;
}

function TravelCard({
	startDate,
	endDate,
	title,
	hostCountryCode,
	hostCountry,
	hostDistrict,
	ageMin,
	ageMax,
	contribution,
	invitation,
	full,
	themeColors,
}: TravelCardProps) {
	const hostCountries = hostCountry.split("/");
	const hostCountryCodes = hostCountryCode.split("/");
	const isFull = full && full.trim() !== "";

	// Check if camp is in the past
	const isPast = () => {
		const endDateParts = endDate.split("/");
		if (endDateParts.length === 3) {
			const campEndDate = new Date(
				parseInt(endDateParts[2], 10),
				parseInt(endDateParts[1], 10) - 1, // Month is 0-indexed
				parseInt(endDateParts[0], 10),
			);
			const today = new Date();
			today.setHours(0, 0, 0, 0); // Reset time to start of day
			return campEndDate < today;
		}
		return false;
	};

	const campIsPast = isPast();

	const handlePress = () => {
		// Allow PDF viewing for all camps, including past ones
		if (invitation && invitation.trim() !== "") {
			router.push({
				pathname: "/pdf-viewer",
				params: {
					url: invitation,
					title: title,
				},
			});
		}
	};

	return (
		<Pressable
			style={({ pressed }) => [
				styles.card,
				{ backgroundColor: themeColors.card, borderColor: themeColors.border },
				isFull && styles.cardFull,
				campIsPast && [
					styles.cardPast,
					{ borderLeftColor: themeColors.textTertiary },
				],
				pressed && styles.cardPressed,
			]}
			onPress={handlePress}
			android_ripple={{
				color: "rgba(0, 122, 255, 0.2)",
				borderless: false,
			}}
		>
			<View style={styles.cardHeader}>
				<View style={styles.titleContainer}>
					<Text
						style={[styles.title, { color: themeColors.text }]}
						numberOfLines={2}
					>
						{title}
					</Text>
					<View style={styles.badgeContainer}>
						{campIsPast && (
							<View
								style={[
									styles.pastBadge,
									{ backgroundColor: themeColors.textTertiary },
								]}
							>
								<Ionicons name="time" size={12} color="#fff" />
								<Text style={[styles.pastBadgeText, { color: "#fff" }]}>
									AFGELOPEN
								</Text>
							</View>
						)}
						{isFull && (
							<View
								style={[styles.fullBadge, campIsPast && styles.badgeSpacing]}
							>
								<Ionicons name="warning" size={14} color="#fff" />
								<Text style={[styles.fullBadgeText, { color: "#fff" }]}>
									VOL
								</Text>
							</View>
						)}
					</View>
				</View>
				{invitation && invitation.trim() !== "" && (
					<View style={styles.actionIndicator}>
						<Ionicons
							name="document-text-outline"
							size={18}
							color={themeColors.textSecondary}
						/>
					</View>
				)}
			</View>

			<View style={styles.cardBody}>
				<View
					style={[
						styles.dateContainer,
						{ backgroundColor: themeColors.backgroundElevated },
						campIsPast && styles.dateContainerPast,
					]}
				>
					<Ionicons
						name="calendar-outline"
						size={16}
						color={campIsPast ? themeColors.textTertiary : themeColors.link}
					/>
					<Text
						style={[
							styles.dateText,
							{
								color: campIsPast ? themeColors.textTertiary : themeColors.text,
							},
							campIsPast && styles.dateTextPast,
						]}
					>
						{startDate} - {endDate}
					</Text>
				</View>

				<View style={styles.detailsGrid}>
					<View style={styles.detailItem}>
						<View style={styles.detailHeader}>
							<Ionicons
								name="location-outline"
								size={14}
								color={themeColors.textSecondary}
							/>
							<Text
								style={[
									styles.detailLabel,
									{ color: themeColors.textSecondary },
								]}
							>
								Land
							</Text>
						</View>
						<View style={styles.countryContainer}>
							{hostCountries.map((country, index) => {
								const countryCode = hostCountryCodes[index];
								const flagAsset = countryCode
									? getFlagAsset(countryCode.toLowerCase())
									: null;

								return (
									<View
										key={`${country.trim()}-${index}`}
										style={[
											styles.countryItem,
											{ backgroundColor: themeColors.backgroundElevated },
										]}
									>
										{flagAsset && (
											<Image
												source={flagAsset}
												style={styles.flag}
												contentFit="cover"
											/>
										)}
										{!flagAsset && countryCode && (
											<View
												style={[
													styles.flag,
													styles.flagPlaceholder,
													{ backgroundColor: themeColors.background },
												]}
											>
												<Ionicons
													name="flag-outline"
													size={10}
													color={themeColors.textTertiary}
												/>
											</View>
										)}
										<Text
											style={[styles.countryText, { color: themeColors.text }]}
										>
											{country.trim()}
										</Text>
									</View>
								);
							})}
						</View>
					</View>

					<View style={styles.detailItem}>
						<View style={styles.detailHeader}>
							<Ionicons
								name="business-outline"
								size={14}
								color={themeColors.textSecondary}
							/>
							<Text
								style={[
									styles.detailLabel,
									{ color: themeColors.textSecondary },
								]}
							>
								District
							</Text>
						</View>
						<Text style={[styles.detailValue, { color: themeColors.text }]}>
							{hostDistrict}
						</Text>
					</View>

					<View style={styles.detailRow}>
						<View style={styles.detailItem}>
							<View style={styles.detailHeader}>
								<Ionicons
									name="people-outline"
									size={14}
									color={themeColors.textSecondary}
								/>
								<Text
									style={[
										styles.detailLabel,
										{ color: themeColors.textSecondary },
									]}
								>
									Leeftijd
								</Text>
							</View>
							<Text style={[styles.detailValue, { color: themeColors.text }]}>
								{ageMin}-{ageMax} jr
							</Text>
						</View>

						<View style={styles.detailItem}>
							<View style={styles.detailHeader}>
								<Ionicons
									name="card-outline"
									size={14}
									color={themeColors.textSecondary}
								/>
								<Text
									style={[
										styles.detailLabel,
										{ color: themeColors.textSecondary },
									]}
								>
									Kosten
								</Text>
							</View>
							<Text style={[styles.detailValue, { color: themeColors.text }]}>
								{contribution}
							</Text>
						</View>
					</View>
				</View>
			</View>
		</Pressable>
	);
}

const AvailabilityContextMenu = ({
	filters,
	setFilters,
	themeColors,
}: {
	filters: { availability: string; timing: string; country: string };
	setFilters: React.Dispatch<
		React.SetStateAction<{
			availability: string;
			timing: string;
			country: string;
		}>
	>;
	themeColors: typeof Colors.light;
}) => {
	const showAvailabilityOptions = () => {
		Alert.alert(
			"Beschikbaarheid",
			"Selecteer welke kampen je wilt zien:",
			[
				{
					text: "Alle kampen",
					onPress: () =>
						setFilters((prev) => ({ ...prev, availability: "alle" })),
				},
				{
					text: "Alleen niet-volle kampen",
					onPress: () =>
						setFilters((prev) => ({ ...prev, availability: "niet-vol" })),
				},
				{
					text: "Alleen volle kampen",
					onPress: () =>
						setFilters((prev) => ({ ...prev, availability: "vol" })),
				},
				{
					text: "Annuleren",
					style: "cancel",
				},
			],
			{ cancelable: true },
		);
	};

	return (
		<View style={{ marginRight: 8 }}>
			<Pressable
				style={[
					styles.filterChip,
					{
						backgroundColor:
							filters.availability !== "alle"
								? themeColors.link
								: themeColors.card,
						borderColor: themeColors.border,
					},
					filters.availability !== "alle" && styles.filterChipActive,
				]}
				onPress={showAvailabilityOptions}
			>
				<Ionicons
					name="checkmark-circle-outline"
					size={16}
					color={
						filters.availability !== "alle"
							? themeColors.card
							: themeColors.textTertiary
					}
				/>
				<Text
					style={[
						styles.filterChipText,
						{
							color:
								filters.availability !== "alle"
									? themeColors.card
									: themeColors.text,
						},
						filters.availability !== "alle" && styles.filterChipTextActive,
					]}
				>
					{filters.availability === "alle"
						? "Beschikbaarheid"
						: filters.availability === "niet-vol"
							? "Niet vol"
							: "Vol"}
				</Text>
				<Ionicons
					name="chevron-down"
					size={14}
					color={
						filters.availability !== "alle"
							? themeColors.card
							: themeColors.textTertiary
					}
					style={styles.filterChipChevron}
				/>
			</Pressable>
		</View>
	);
};

const TimingContextMenu = ({
	filters,
	setFilters,
	themeColors,
}: {
	filters: { availability: string; timing: string; country: string };
	setFilters: React.Dispatch<
		React.SetStateAction<{
			availability: string;
			timing: string;
			country: string;
		}>
	>;
	themeColors: typeof Colors.light;
}) => {
	const showTimingOptions = () => {
		Alert.alert(
			"Tijdperiode",
			"Selecteer welke kampen je wilt zien:",
			[
				{
					text: "Alle kampen",
					onPress: () => setFilters((prev) => ({ ...prev, timing: "alle" })),
				},
				{
					text: "Alleen toekomstige kampen",
					onPress: () =>
						setFilters((prev) => ({ ...prev, timing: "toekomstig" })),
				},
				{
					text: "Alleen afgelopen kampen",
					onPress: () =>
						setFilters((prev) => ({ ...prev, timing: "afgelopen" })),
				},
				{
					text: "Annuleren",
					style: "cancel",
				},
			],
			{ cancelable: true },
		);
	};

	return (
		<View style={{ marginRight: 8 }}>
			<Pressable
				style={[
					styles.filterChip,
					{
						backgroundColor:
							filters.timing !== "alle" ? themeColors.link : themeColors.card,
						borderColor: themeColors.border,
					},
					filters.timing !== "alle" && styles.filterChipActive,
				]}
				onPress={showTimingOptions}
			>
				<Ionicons
					name="time-outline"
					size={16}
					color={
						filters.timing !== "alle"
							? themeColors.card
							: themeColors.textTertiary
					}
				/>
				<Text
					style={[
						styles.filterChipText,
						{
							color:
								filters.timing !== "alle" ? themeColors.card : themeColors.text,
						},
						filters.timing !== "alle" && styles.filterChipTextActive,
					]}
				>
					{filters.timing === "alle"
						? "Tijdperiode"
						: filters.timing === "toekomstig"
							? "Toekomstig"
							: "Afgelopen"}
				</Text>
				<Ionicons
					name="chevron-down"
					size={14}
					color={
						filters.timing !== "alle"
							? themeColors.card
							: themeColors.textTertiary
					}
					style={styles.filterChipChevron}
				/>
			</Pressable>
		</View>
	);
};

const CountryContextMenu = ({
	filters,
	themeColors,
	onPress,
}: {
	filters: { availability: string; timing: string; country: string };
	themeColors: typeof Colors.light;
	onPress: () => void;
}) => {
	return (
		<View style={{ marginRight: 8 }}>
			<Pressable
				style={[
					styles.filterChip,
					{
						backgroundColor:
							filters.country !== "" ? themeColors.link : themeColors.card,
						borderColor: themeColors.border,
					},
					filters.country !== "" && styles.filterChipActive,
				]}
				onPress={onPress}
			>
				<Ionicons
					name="location-outline"
					size={16}
					color={
						filters.country !== "" ? themeColors.card : themeColors.textTertiary
					}
				/>
				<Text
					style={[
						styles.filterChipText,
						{
							color:
								filters.country !== "" ? themeColors.card : themeColors.text,
						},
						filters.country !== "" && styles.filterChipTextActive,
					]}
				>
					{filters.country || "Land"}
				</Text>
				<Ionicons
					name="chevron-down"
					size={14}
					color={
						filters.country !== "" ? themeColors.card : themeColors.textTertiary
					}
					style={styles.filterChipChevron}
				/>
			</Pressable>
		</View>
	);
};

const CountryModal = ({
	showCountryModal,
	setShowCountryModal,
	availableCountriesWithCodes,
	filters,
	setFilters,
	themeColors,
}: {
	showCountryModal: boolean;
	setShowCountryModal: (show: boolean) => void;
	availableCountriesWithCodes: { country: string; code: string }[];
	filters: { availability: string; timing: string; country: string };
	setFilters: React.Dispatch<
		React.SetStateAction<{
			availability: string;
			timing: string;
			country: string;
		}>
	>;
	themeColors: typeof Colors.light;
}) => {
	const renderCountryItem = ({
		item,
	}: {
		item: { country: string; code: string };
	}) => (
		<Pressable
			style={({ pressed }) => [
				styles.countryModalItem,
				filters.country === item.country && [
					styles.countryModalItemSelected,
					{ backgroundColor: themeColors.backgroundElevated },
				],
				pressed && [
					styles.countryModalItemPressed,
					{ backgroundColor: themeColors.backgroundElevated },
				],
			]}
			onPress={() => {
				setFilters((prev) => ({ ...prev, country: item.country }));
				setShowCountryModal(false);
			}}
		>
			<View style={styles.countryModalItemContent}>
				{item.code &&
					(() => {
						const flagAsset = getFlagAsset(item.code.toLowerCase());
						return flagAsset ? (
							<Image
								source={flagAsset}
								style={styles.countryModalFlag}
								contentFit="cover"
							/>
						) : (
							<View
								style={[
									styles.countryModalFlag,
									styles.countryModalFlagPlaceholder,
								]}
							>
								<Ionicons
									name="flag-outline"
									size={16}
									color={themeColors.textTertiary}
								/>
							</View>
						);
					})()}
				<Text
					style={[
						styles.countryModalItemText,
						{ color: themeColors.text },
						filters.country === item.country &&
							styles.countryModalItemTextSelected,
					]}
				>
					{item.country}
				</Text>
			</View>
			{filters.country === item.country && (
				<Ionicons name="checkmark" size={20} color={themeColors.link} />
			)}
		</Pressable>
	);

	return (
		<Modal
			visible={showCountryModal}
			animationType="slide"
			presentationStyle="pageSheet"
			onRequestClose={() => setShowCountryModal(false)}
		>
			<SafeAreaView
				style={[
					styles.countryModalContainer,
					{ backgroundColor: themeColors.background },
				]}
			>
				<View
					style={[
						styles.countryModalHeader,
						{ borderBottomColor: themeColors.divider },
					]}
				>
					<Text style={[styles.countryModalTitle, { color: themeColors.text }]}>
						Selecteer Land
					</Text>
					<Pressable
						style={styles.countryModalCloseButton}
						onPress={() => setShowCountryModal(false)}
					>
						<Ionicons name="close" size={24} color={themeColors.textTertiary} />
					</Pressable>
				</View>

				<FlatList
					data={[
						{ country: "Alle landen", code: "" },
						...availableCountriesWithCodes,
					]}
					renderItem={({ item }) => {
						if (item.country === "Alle landen") {
							return (
								<Pressable
									style={({ pressed }) => [
										styles.countryModalItem,
										filters.country === "" && [
											styles.countryModalItemSelected,
											{ backgroundColor: themeColors.backgroundElevated },
										],
										pressed && [
											styles.countryModalItemPressed,
											{ backgroundColor: themeColors.backgroundElevated },
										],
									]}
									onPress={() => {
										setFilters((prev) => ({ ...prev, country: "" }));
										setShowCountryModal(false);
									}}
								>
									<View style={styles.countryModalItemContent}>
										<View
											style={[styles.countryModalFlag, styles.allCountriesIcon]}
										>
											<Ionicons
												name="globe-outline"
												size={14}
												color={themeColors.textTertiary}
											/>
										</View>
										<Text
											style={[
												styles.countryModalItemText,
												{ color: themeColors.text },
												filters.country === "" &&
													styles.countryModalItemTextSelected,
											]}
										>
											Alle landen
										</Text>
									</View>
									{filters.country === "" && (
										<Ionicons
											name="checkmark"
											size={20}
											color={themeColors.link}
										/>
									)}
								</Pressable>
							);
						}
						return renderCountryItem({ item });
					}}
					keyExtractor={(item) => item.country}
					showsVerticalScrollIndicator={true}
					contentContainerStyle={styles.countryModalList}
				/>
			</SafeAreaView>
		</Modal>
	);
};

export default function CampsToursScreen() {
	const { colors: themeColors } = useTheme();

	const [data, setData] = useState<CampTourData[]>([]);
	const [filteredData, setFilteredData] = useState<CampTourData[]>([]);
	const [loading, setLoading] = useState(true);
	const [error, setError] = useState<string | null>(null);
	const [filters, setFilters] = useState({
		availability: "alle", // 'alle', 'niet-vol', 'vol'
		timing: "alle", // 'alle', 'toekomstig', 'afgelopen'
		country: "",
	});
	const [availableCountriesWithCodes, setAvailableCountriesWithCodes] =
		useState<{ country: string; code: string }[]>([]);
	const [showCountryModal, setShowCountryModal] = useState(false);

	const fetchCsvData = useCallback(async () => {
		try {
			setLoading(true);
			setError(null);

			const response = await fetch(
				"https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/outbounds/camps-and-tours/zomerkampen.csv",
			);

			if (!response.ok) {
				throw new Error("Kan CSV-gegevens niet laden");
			}

			const csvText = await response.text();

			// Parse CSV with semicolon delimiter using react-native-csv
			const parsedData = readString(csvText, {
				delimiter: ";",
				skipEmptyLines: true,
			});

			// Skip header row and convert to objects
			const formattedData: CampTourData[] = parsedData.data
				.slice(1)
				.map((row: unknown) => {
					const rowArray = row as string[];
					return {
						startDate: rowArray[0]?.toString() || "",
						endDate: rowArray[1]?.toString() || "",
						title: rowArray[2]?.toString() || "",
						hostCountryCode: rowArray[3]?.toString() || "",
						hostCountry: rowArray[4]?.toString() || "",
						hostDistrict: rowArray[5]?.toString() || "",
						ageMin: rowArray[6]?.toString() || "",
						ageMax: rowArray[7]?.toString() || "",
						contribution: rowArray[8]?.toString() || "",
						invitation: rowArray[9]?.toString() || "",
						full: rowArray[10]?.toString() || "",
					};
				});

			// Sort data chronologically by start date
			const sortedData = formattedData.sort((a, b) => {
				const dateA = new Date(a.startDate.split("/").reverse().join("-"));
				const dateB = new Date(b.startDate.split("/").reverse().join("-"));
				return dateA.getTime() - dateB.getTime();
			});

			setData(sortedData);
			setFilteredData(sortedData);

			// Extract unique countries for filter with their codes
			const countries = new Set<string>();
			const countriesWithCodes = new Map<string, string>();

			formattedData.forEach((item) => {
				// Extract countries and their codes
				const countryList = item.hostCountry.split("/");
				const countryCodeList = item.hostCountryCode.split("/");

				countryList.forEach((country, index) => {
					const trimmedCountry = country.trim();
					const countryCode = countryCodeList[index]?.trim();

					if (trimmedCountry && countryCode) {
						countries.add(trimmedCountry);
						countriesWithCodes.set(trimmedCountry, countryCode);
					}
				});
			});

			const sortedCountries = Array.from(countries).sort();
			const countriesWithCodesArray = sortedCountries.map((country) => ({
				country,
				code: countriesWithCodes.get(country) || "",
			}));

			setAvailableCountriesWithCodes(countriesWithCodesArray);
		} catch (err) {
			console.error("Error fetching CSV data:", err);
			setError("Kan zomerkampen-gegevens niet laden. Probeer opnieuw.");
		} finally {
			setLoading(false);
		}
	}, []);

	const applyFilters = useCallback(() => {
		let filtered = [...data];

		// Apply availability filter
		if (filters.availability === "niet-vol") {
			filtered = filtered.filter(
				(item) => !item.full || item.full.trim() === "",
			);
		} else if (filters.availability === "vol") {
			filtered = filtered.filter(
				(item) => item.full && item.full.trim() !== "",
			);
		}

		// Apply timing filter
		if (filters.timing === "toekomstig") {
			filtered = filtered.filter((item) => {
				const endDateParts = item.endDate.split("/");
				if (endDateParts.length === 3) {
					const campEndDate = new Date(
						parseInt(endDateParts[2], 10),
						parseInt(endDateParts[1], 10) - 1,
						parseInt(endDateParts[0], 10),
					);
					const today = new Date();
					today.setHours(0, 0, 0, 0);
					return campEndDate >= today;
				}
				return true;
			});
		} else if (filters.timing === "afgelopen") {
			filtered = filtered.filter((item) => {
				const endDateParts = item.endDate.split("/");
				if (endDateParts.length === 3) {
					const campEndDate = new Date(
						parseInt(endDateParts[2], 10),
						parseInt(endDateParts[1], 10) - 1,
						parseInt(endDateParts[0], 10),
					);
					const today = new Date();
					today.setHours(0, 0, 0, 0);
					return campEndDate < today;
				}
				return false;
			});
		}

		// Country filter
		if (filters.country) {
			filtered = filtered.filter((item) =>
				item.hostCountry.toLowerCase().includes(filters.country.toLowerCase()),
			);
		}

		// Sort filtered results chronologically as well
		const sortedFiltered = filtered.sort((a, b) => {
			const dateA = new Date(a.startDate.split("/").reverse().join("-"));
			const dateB = new Date(b.startDate.split("/").reverse().join("-"));
			return dateA.getTime() - dateB.getTime();
		});

		setFilteredData(sortedFiltered);
	}, [filters, data]);

	const clearFilters = useCallback(() => {
		setFilters({
			availability: "alle",
			timing: "alle",
			country: "",
		});
		setFilteredData(data);
	}, [data]);

	const hasActiveFilters =
		filters.availability !== "alle" ||
		filters.timing !== "alle" ||
		filters.country !== "";

	const navigation = useNavigation();

	useLayoutEffect(() => {
		navigation.setOptions({
			headerRight: () => (
				<View style={styles.headerRightContainer}>
					{/* <View style={styles.headerStatsContainer}> */}
					{hasActiveFilters && (
						<View
							style={[
								styles.headerActiveIndicator,
								{ backgroundColor: themeColors.link },
							]}
						/>
					)}
					<Text
						style={[
							styles.headerStatsText,
							{ color: themeColors.textSecondary },
							hasActiveFilters && [
								styles.headerStatsTextActive,
								{ color: themeColors.link },
							],
						]}
					>
						{loading ? "Laden..." : `${filteredData.length}/${data.length}`}
					</Text>
					{/* </View> */}
					{hasActiveFilters && (
						<Pressable
							style={({ pressed }) => [
								styles.headerClearButton,
								pressed && styles.headerClearButtonPressed,
							]}
							onPress={clearFilters}
							hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
						>
							<Ionicons name="close-circle" size={20} color="#FF3B30" />
						</Pressable>
					)}
				</View>
			),
		});
	}, [
		navigation,
		loading,
		filteredData.length,
		data.length,
		hasActiveFilters,
		clearFilters,
		themeColors.link,
		themeColors.textSecondary,
	]);

	useEffect(() => {
		fetchCsvData();
	}, [fetchCsvData]);

	useEffect(() => {
		applyFilters();
	}, [applyFilters]);

	return (
		<SafeAreaView
			style={[styles.safeArea, { backgroundColor: themeColors.background }]}
			edges={["bottom"]}
		>
			{/* Filter Chips */}
			<View
				style={[
					styles.filterChipsContainer,
					{ borderBottomColor: themeColors.divider },
				]}
			>
				<FlatList
					data={[
						{
							id: "availability",
							component: (
								<AvailabilityContextMenu
									filters={filters}
									setFilters={setFilters}
									themeColors={themeColors}
								/>
							),
						},
						{
							id: "timing",
							component: (
								<TimingContextMenu
									filters={filters}
									setFilters={setFilters}
									themeColors={themeColors}
								/>
							),
						},
						{
							id: "country",
							component: (
								<CountryContextMenu
									filters={filters}
									themeColors={themeColors}
									onPress={() => setShowCountryModal(true)}
								/>
							),
						},
					]}
					renderItem={({ item }) => item.component}
					keyExtractor={(item) => item.id}
					horizontal
					showsHorizontalScrollIndicator={false}
					contentContainerStyle={styles.filterChipsContent}
					style={styles.filterChipsScrollView}
				/>
			</View>

			<CountryModal
				showCountryModal={showCountryModal}
				setShowCountryModal={setShowCountryModal}
				availableCountriesWithCodes={availableCountriesWithCodes}
				filters={filters}
				setFilters={setFilters}
				themeColors={themeColors}
			/>

			{/* Content */}
			<View
				style={[styles.container, { backgroundColor: themeColors.background }]}
			>
				{/* Main Content */}
				{loading ? (
					<View style={styles.centerContainer}>
						<ActivityIndicator size="large" color={themeColors.link} />
						<Text
							style={[styles.loadingText, { color: themeColors.textSecondary }]}
						>
							Zomerkampen laden...
						</Text>
					</View>
				) : error ? (
					<View style={styles.centerContainer}>
						<View style={styles.errorIcon}>
							<Ionicons name="warning-outline" size={64} color="#FF3B30" />
						</View>
						<Text style={[styles.errorTitle, { color: themeColors.text }]}>
							Oops! Er is iets misgegaan
						</Text>
						<Text
							style={[styles.errorText, { color: themeColors.textSecondary }]}
						>
							{error}
						</Text>
						<Pressable
							style={({ pressed }) => [
								styles.retryButton,
								{ backgroundColor: themeColors.link },
								pressed && styles.retryButtonPressed,
							]}
							onPress={fetchCsvData}
						>
							<Text
								style={[styles.retryButtonText, { color: themeColors.card }]}
							>
								Opnieuw Proberen
							</Text>
						</Pressable>
					</View>
				) : (
					<FlatList
						data={filteredData}
						renderItem={({ item }) => (
							<TravelCard {...item} themeColors={themeColors} />
						)}
						keyExtractor={(item, index) => `${item.title}-${index}`}
						style={styles.flatList}
						contentContainerStyle={[
							styles.listContent,
							filteredData.length === 0 && styles.emptyContent,
						]}
						showsVerticalScrollIndicator={false}
						contentInsetAdjustmentBehavior="automatic"
						refreshControl={
							<RefreshControl
								refreshing={loading}
								onRefresh={fetchCsvData}
								colors={["#007AFF"]}
								tintColor={themeColors.link}
							/>
						}
						ListEmptyComponent={() => {
							if (data.length > 0) {
								return (
									<View style={styles.emptyContainer}>
										<View style={styles.emptyIcon}>
											<Ionicons
												name="search-outline"
												size={64}
												color={themeColors.textDisabled}
											/>
										</View>
										<Text
											style={[styles.emptyTitle, { color: themeColors.text }]}
										>
											Geen Overeenkomende Kampen
										</Text>
										<Text
											style={[
												styles.emptyText,
												{ color: themeColors.textSecondary },
											]}
										>
											Pas je filters aan om meer resultaten te zien.
										</Text>
									</View>
								);
							} else {
								return (
									<View style={styles.emptyContainer}>
										<View style={styles.emptyIcon}>
											<Ionicons
												name="calendar-outline"
												size={64}
												color={themeColors.textDisabled}
											/>
										</View>
										<Text style={styles.emptyTitle}>
											Geen Kampen Beschikbaar
										</Text>
										<Text style={styles.emptyText}>
											Er zijn momenteel geen zomerkampen beschikbaar. Kijk later
											nog eens!
										</Text>
									</View>
								);
							}
						}}
						ItemSeparatorComponent={() => <View style={styles.itemSeparator} />}
					/>
				)}
			</View>
		</SafeAreaView>
	);
}

const styles = StyleSheet.create({
	safeArea: {
		flex: 1,
	},
	container: {
		flex: 1,
	},
	// Header styles
	headerRightContainer: {
		flexDirection: "row",
		alignItems: "center",
		marginRight: 8,
		marginLeft: 8,
	},
	headerStatsContainer: {
		flexDirection: "row",
		alignItems: "center",
		marginRight: 4,
	},
	headerActiveIndicator: {
		width: 6,
		height: 6,
		borderRadius: 3,
		marginRight: 6,
	},
	headerStatsText: {
		fontSize: 13,
		fontWeight: "500",
	},
	headerStatsTextActive: {
		fontWeight: "600",
	},
	headerClearButton: {
		width: 32,
		height: 32,
		borderRadius: 16,
		justifyContent: "center",
		alignItems: "center",
		marginLeft: 8,
	},
	headerClearButtonPressed: {
		transform: [{ scale: 0.95 }],
	},

	scrollView: {
		flex: 1,
	},
	scrollContent: {
		padding: 16,
		paddingBottom: 34,
	},
	card: {
		borderRadius: 12,
		marginBottom: 12,
		shadowOffset: { width: 0, height: 1 },
		shadowOpacity: 0.08,
		shadowRadius: 8,
		elevation: 2,
		overflow: "hidden",
	},
	cardFull: {
		borderLeftWidth: 4,
		borderLeftColor: "#FF3B30",
	},
	cardHeader: {
		flexDirection: "row",
		alignItems: "flex-start",
		justifyContent: "space-between",
		paddingHorizontal: 16,
		paddingTop: 16,
		paddingBottom: 8,
	},
	titleContainer: {
		flex: 1,
		marginRight: 12,
	},
	title: {
		fontSize: 16,
		fontWeight: "600",
		lineHeight: 22,
		marginBottom: 4,
	},
	fullBadge: {
		flexDirection: "row",
		alignItems: "center",
		backgroundColor: "#FF3B30",
		paddingHorizontal: 8,
		paddingVertical: 4,
		borderRadius: 12,
		alignSelf: "flex-start",
	},
	fullBadgeText: {
		fontSize: 11,
		fontWeight: "600",
		marginLeft: 4,
		letterSpacing: 0.5,
	},
	actionIndicator: {
		width: 32,
		height: 32,
		borderRadius: 16,
		justifyContent: "center",
		alignItems: "center",
	},
	cardBody: {
		paddingHorizontal: 16,
		paddingBottom: 16,
	},
	dateContainer: {
		flexDirection: "row",
		alignItems: "center",
		paddingHorizontal: 12,
		paddingVertical: 8,
		borderRadius: 8,
		marginBottom: 16,
	},
	dateText: {
		fontSize: 14,
		fontWeight: "500",
		marginLeft: 8,
	},
	detailsGrid: {
		gap: 16,
	},
	detailRow: {
		flexDirection: "row",
		gap: 16,
	},
	detailItem: {
		flex: 1,
	},
	detailHeader: {
		flexDirection: "row",
		alignItems: "center",
		marginBottom: 6,
	},
	detailLabel: {
		fontSize: 13,
		fontWeight: "500",
		marginLeft: 6,
	},
	detailValue: {
		fontSize: 15,
		fontWeight: "500",
	},
	countryContainer: {
		flexDirection: "row",
		flexWrap: "wrap",
		gap: 8,
	},
	countryItem: {
		flexDirection: "row",
		alignItems: "center",
		paddingHorizontal: 8,
		paddingVertical: 4,
		borderRadius: 6,
	},
	countryText: {
		fontSize: 14,
		fontWeight: "500",
	},
	flag: {
		width: 16,
		height: 12,
		marginRight: 6,
		borderRadius: 2,
	},
	flagPlaceholder: {
		justifyContent: "center",
		alignItems: "center",
	},
	countryModalFlagPlaceholder: {
		justifyContent: "center",
		alignItems: "center",
	},
	centerContainer: {
		flex: 1,
		justifyContent: "center",
		alignItems: "center",
		padding: 32,
	},
	loadingText: {
		fontSize: 16,
		fontWeight: "400",
		marginTop: 16,
		textAlign: "center",
	},
	errorIcon: {
		width: 80,
		height: 80,
		borderRadius: 40,
		backgroundColor: "#FFEBEE",
		justifyContent: "center",
		alignItems: "center",
		marginBottom: 24,
	},
	errorTitle: {
		fontSize: 20,
		fontWeight: "600",
		textAlign: "center",
		marginBottom: 8,
	},
	errorText: {
		fontSize: 16,
		fontWeight: "400",
		textAlign: "center",
		lineHeight: 22,
		marginBottom: 32,
		paddingHorizontal: 20,
	},
	retryButton: {
		paddingHorizontal: 32,
		paddingVertical: 14,
		borderRadius: 8,
		minWidth: 120,
	},
	retryButtonText: {
		fontSize: 16,
		fontWeight: "600",
		textAlign: "center",
	},
	emptyContainer: {
		alignItems: "center",
		paddingVertical: 60,
		paddingHorizontal: 32,
	},
	emptyIcon: {
		width: 80,
		height: 80,
		borderRadius: 40,
		justifyContent: "center",
		alignItems: "center",
		marginBottom: 24,
	},
	emptyTitle: {
		fontSize: 20,
		fontWeight: "600",
		textAlign: "center",
		marginBottom: 8,
	},
	emptyText: {
		fontSize: 16,
		fontWeight: "400",
		textAlign: "center",
		lineHeight: 22,
	},
	// Filter Chips styles
	filterChipsContainer: {
		borderBottomWidth: StyleSheet.hairlineWidth,
		paddingHorizontal: 16,
		paddingVertical: 12,
		flexDirection: "row",
		alignItems: "center",
	},
	filterChipsContent: {
		paddingLeft: 0,
		paddingRight: 16,
		alignItems: "center",
	},
	filterChipsRow: {
		flexDirection: "row",
		alignItems: "center",
		flex: 1,
	},
	filterChipsScrollView: {
		flex: 1,
	},
	filterChip: {
		flexDirection: "row",
		alignItems: "center",
		borderRadius: 8,
		paddingHorizontal: 12,
		paddingVertical: 8,
		marginRight: 8,
		borderWidth: 1,
		minHeight: 36,
	},
	filterChipActive: {},
	filterChipPressed: {
		opacity: 0.7,
		transform: Platform.OS === "ios" ? [{ scale: 0.96 }] : [],
	},
	filterChipText: {
		fontSize: 15,
		fontWeight: "500",
		marginLeft: 6,
	},
	filterChipTextActive: {},
	filterChipChevron: {
		marginLeft: 4,
	},

	// Native component pressed states
	cardPressed: {
		opacity: 0.8,
		transform: Platform.OS === "ios" ? [{ scale: 0.98 }] : [],
	},
	retryButtonPressed: {
		opacity: 0.8,
		transform: Platform.OS === "ios" ? [{ scale: 0.98 }] : [],
	},
	// FlatList styles
	flatList: {
		flex: 1,
	},
	listContent: {
		padding: 16,
		paddingBottom: 34,
	},
	emptyContent: {
		flexGrow: 1,
		justifyContent: "center",
	},
	itemSeparator: {
		height: 0, // No separator needed since cards have margin
	},
	// Past camp styles
	cardPast: {
		opacity: 0.7,
		borderLeftWidth: 4,
	},
	badgeContainer: {
		flexDirection: "column",
		alignItems: "flex-start",
		gap: 4,
	},
	pastBadge: {
		flexDirection: "row",
		alignItems: "center",
		paddingHorizontal: 8,
		paddingVertical: 3,
		borderRadius: 10,
		alignSelf: "flex-start",
	},
	pastBadgeText: {
		fontSize: 10,
		fontWeight: "600",
		marginLeft: 3,
		letterSpacing: 0.5,
	},
	badgeSpacing: {
		marginTop: 0,
	},
	dateContainerPast: {},
	dateTextPast: {},
	// Country Modal styles
	countryModalContainer: {
		flex: 1,
	},
	countryModalHeader: {
		flexDirection: "row",
		justifyContent: "space-between",
		alignItems: "center",
		paddingHorizontal: 16,
		paddingVertical: 16,
		borderBottomWidth: StyleSheet.hairlineWidth,
	},
	countryModalTitle: {
		fontSize: 18,
		fontWeight: "600",
	},
	countryModalCloseButton: {
		padding: 4,
	},
	countryModalList: {
		paddingVertical: 8,
	},
	countryModalItem: {
		flexDirection: "row",
		alignItems: "center",
		justifyContent: "space-between",
		paddingHorizontal: 16,
		paddingVertical: 12,
	},
	countryModalItemSelected: {
		backgroundColor: "#F0F8FF",
	},
	countryModalItemPressed: {},
	countryModalItemContent: {
		flexDirection: "row",
		alignItems: "center",
		flex: 1,
	},
	countryModalFlag: {
		width: 24,
		height: 18,
		marginRight: 12,
		borderRadius: 2,
	},
	allCountriesIcon: {
		justifyContent: "center",
		alignItems: "center",
	},
	countryModalItemText: {
		fontSize: 16,
		fontWeight: "400",
	},
	countryModalItemTextSelected: {
		fontWeight: "500",
	},
});
