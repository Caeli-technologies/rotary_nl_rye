namespace RotaryYepNL;

public partial class NewPage : ContentPage
{
    public NewPage()
    {
        InitializeComponent();
    }

    private void OnToggleButtonClicked(object sender, EventArgs e)
    {
        ToggleButton.Text = ToggleButton.Text == "Toggle" ? "Toggled" : "Toggle";
    }
}