using Microsoft.Maui.Controls;
using RotaryYepNL.Models;
using Microsoft.Maui.ApplicationModel;

namespace RotaryYepNL;

public partial class ContactDetailPage : ContentPage
{
    private RotaryYepNL.Models.Contact _contact = new RotaryYepNL.Models.Contact();

    public ContactDetailPage(object contactObj)
    {
        InitializeComponent();

        // Map dynamic/object to local Contact model
        try
        {
            dynamic d = contactObj;
            _contact.Id = d.Id ?? string.Empty;
            _contact.Name = d.Name ?? string.Empty;
            _contact.Bio = d.Bio ?? string.Empty;
            _contact.ImageUrl = d.ImageUrl ?? string.Empty;
            _contact.Email = d.Email ?? string.Empty;
            _contact.PhoneNumber = d.PhoneNumber ?? string.Empty;
            _contact.Club = d.Club ?? string.Empty;
            _contact.District = d.District ?? string.Empty;
            _contact.Functions = d.Functions != null ? new List<string>(d.Functions) : new List<string>();
            if (d.SocialMedia != null)
            {
                _contact.SocialMedia = new RotaryYepNL.Models.SocialMediaLinks
                {
                    Instagram = d.SocialMedia.instagram ?? string.Empty,
                    Facebook = d.SocialMedia.facebook ?? string.Empty,
                    Snapchat = d.SocialMedia.snapchat ?? string.Empty,
                    Linkedin = d.SocialMedia.linkedin ?? string.Empty,
                    Website = d.SocialMedia.website ?? string.Empty,
                };
            }
        }
        catch
        {
            // If mapping fails, ignore and leave defaults
        }

        BindData();

        CloseButton.Clicked += async (_, __) => await Navigation.PopModalAsync();
        CallButton.Clicked += (_, __) => { if (!string.IsNullOrWhiteSpace(_contact?.PhoneNumber)) PhoneDialer.Open(_contact.PhoneNumber); };
        EmailButton.Clicked += async (_, __) => { if (!string.IsNullOrWhiteSpace(_contact?.Email)) await Email.Default.ComposeAsync(new Microsoft.Maui.ApplicationModel.Communication.EmailMessage { To = new List<string> { _contact.Email } }); };
        WebsiteButton.Clicked += async (_, __) => { if (!string.IsNullOrWhiteSpace(_contact?.SocialMedia?.Website)) await Launcher.OpenAsync(_contact.SocialMedia.Website); };
    }

    private void BindData()
    {
        NameLabel.Text = _contact.Name;
        FunctionLabel.Text = _contact.PrimaryFunction;
        ProfileImage.Source = string.IsNullOrWhiteSpace(_contact.ImageUrl) ? "" : _contact.ImageUrl;
        BioLabel.Text = _contact.Bio ?? string.Empty;
        EmailLabel.Text = string.IsNullOrWhiteSpace(_contact.Email) ? "" : _contact.Email;
        PhoneLabel.Text = string.IsNullOrWhiteSpace(_contact.PhoneNumber) ? "" : _contact.PhoneNumber;
        ClubLabel.Text = string.IsNullOrWhiteSpace(_contact.Club) ? "" : _contact.Club;
        DistrictLabel.Text = string.IsNullOrWhiteSpace(_contact.District) ? "" : _contact.District;

        CallButton.IsVisible = !string.IsNullOrWhiteSpace(_contact.PhoneNumber);
        EmailButton.IsVisible = !string.IsNullOrWhiteSpace(_contact.Email);
        WebsiteButton.IsVisible = !string.IsNullOrWhiteSpace(_contact.SocialMedia?.Website);
    }
}
