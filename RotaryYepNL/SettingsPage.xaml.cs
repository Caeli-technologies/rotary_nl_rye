namespace RotaryYepNL
{
    public partial class SettingsPage : ContentPage
    {
        public SettingsPage()
        {
            InitializeComponent();

            if (DeviceInfo.Platform == DevicePlatform.Android)
            {
                ShareToolbarItem.IconImageSource = (FontImageSource)Resources["ShareMaterial"];
            }
            else
            {
                ShareToolbarItem.IconImageSource = (FontImageSource)Resources["ShareCupertino"];
            }

            // Set version detail
            VersionCell.Detail = $"{AppInfo.VersionString}{(AppInfo.BuildString != null ? $" ({AppInfo.BuildString})" : "")}";
        }

        private async void OnInstagramClicked(object? sender, EventArgs e)
        {
            try
            {
                await Launcher.OpenAsync("https://www.instagram.com/rotexnederland/");
            }
            catch
            {
                await DisplayAlert("Fout", "Kan Instagram link niet openen", "OK");
            }
        }

        private async void OnStoreReviewClicked(object? sender, EventArgs e)
        {
            await DisplayAlert("Info", "Store review not implemented yet", "OK");
        }

        private async void OnContributorsClicked(object? sender, EventArgs e)
        {
            await Shell.Current.GoToAsync("NewPage");
        }

        private async void OnPrivacyClicked(object? sender, EventArgs e)
        {
            try
            {
                await Launcher.OpenAsync("https://www.rotary.nl/yep/yep-app/privacy-policy.html");
            }
            catch
            {
                await DisplayAlert("Fout", "Kan privacybeleid link niet openen", "OK");
            }
        }

        private async void OnTermsClicked(object? sender, EventArgs e)
        {
            try
            {
                await Launcher.OpenAsync("https://www.rotary.nl/yep/yep-app/terms-and-conditions.html");
            }
            catch
            {
                await DisplayAlert("Fout", "Kan algemene voorwaarden link niet openen", "OK");
            }
        }

        private async void OnShareClicked(object sender, EventArgs e)
        {
            await Share.Default.RequestAsync(new ShareTextRequest
            {
                Text = "Check out this app!",
                Title = "Share App"
            });
        }
    }
}
