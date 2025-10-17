namespace RotaryYepNL;

public partial class AppShell : Shell
{
	public AppShell()
	{
		InitializeComponent();

		Routing.RegisterRoute("NewPage", typeof(NewPage));

		if (DeviceInfo.Platform == DevicePlatform.Android)
		{
			HomeTab.Icon = (FontImageSource)Resources["HomeMaterial"];
			AboutTab.Icon = (FontImageSource)Resources["AboutMaterial"];
			EmergencyTab.Icon = (FontImageSource)Resources["EmergencyMaterial"];
			ContactTab.Icon = (FontImageSource)Resources["ContactMaterial"];
			SettingsTab.Icon = (FontImageSource)Resources["SettingsMaterial"];
		}
		else
		{
			HomeTab.Icon = (FontImageSource)Resources["HomeCupertino"];
			AboutTab.Icon = (FontImageSource)Resources["AboutCupertino"];
			EmergencyTab.Icon = (FontImageSource)Resources["EmergencyCupertino"];
			ContactTab.Icon = (FontImageSource)Resources["ContactCupertino"];
			SettingsTab.Icon = (FontImageSource)Resources["SettingsCupertino"];
		}
	}
}
