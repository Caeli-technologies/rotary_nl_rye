using System.Collections.Generic;

namespace RotaryYepNL.Models;

public class ContactSection
{
    public string Id { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public List<Contact> Contacts { get; set; } = new List<Contact>();
}
