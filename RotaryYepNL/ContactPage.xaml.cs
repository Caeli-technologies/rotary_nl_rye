using System.Collections.ObjectModel;
using System.ComponentModel;
using Plugin.Maui.SegmentedControl;
using RotaryYepNL.Models;
using ListSelectionChangedEventArgs = Microsoft.Maui.Controls.SelectionChangedEventArgs;

namespace RotaryYepNL;

public partial class ContactPage : ContentPage
{
    private readonly ObservableCollection<ContactSection> _sections = new();
    private ObservableCollection<RotaryYepNL.Models.Contact> _visibleContacts = new();
    private int _selectedIndex;

    public int SelectedIndex
    {
        get => _selectedIndex;
        set
        {
            if (_selectedIndex != value)
            {
                _selectedIndex = value;
                OnPropertyChanged(nameof(SelectedIndex));
                ApplyFilter(value);
            }
        }
    }

    public ContactPage()
    {
        InitializeComponent();
        BindingContext = this;

        LoadData();
    }

    private void LoadData()
    {
        var loaded = RotaryYepNL.Data.ContactsData.GetSections() ?? Enumerable.Empty<ContactSection>();
        foreach (var section in loaded)
            _sections.Add(section);

        // Build segmented control options dynamically
        Segmented.Children.Clear();
        foreach (var s in _sections)
        {
            Segmented.Children.Add(new SegmentedControlOption
            {
                Text = s.Title
            });
        }

        if (_sections.Count > 0)
        {
            SelectedIndex = 0; // This will trigger ApplyFilter via the setter
        }
        else
        {
            UpdateEmptyState();
        }
    }

    private void ApplyFilter(int index)
    {
        _visibleContacts = new ObservableCollection<RotaryYepNL.Models.Contact>();

        if (index < 0 || index >= _sections.Count)
        {
            ContactsCollection.ItemsSource = _visibleContacts;
            UpdateEmptyState();
            return;
        }

        var contacts = _sections[index].Contacts;
        if (contacts != null)
        {
            foreach (var c in contacts)
                _visibleContacts.Add(c);
        }

        ContactsCollection.ItemsSource = _visibleContacts;
        UpdateEmptyState();
    }

    private void UpdateEmptyState()
    {
        var hasItems = _visibleContacts.Count > 0;
        ContactsCollection.IsVisible = hasItems;
        EmptyState.IsVisible = !hasItems;
    }

    private async void ContactsCollection_SelectionChanged(object? sender, ListSelectionChangedEventArgs e)
    {
        var selected = e.CurrentSelection?.FirstOrDefault();
        if (selected is null)
            return;

        var detail = new ContactDetailPage(selected);
        await Navigation.PushAsync(detail);

        if (sender is CollectionView cv)
            cv.SelectedItem = null;
    }
}
