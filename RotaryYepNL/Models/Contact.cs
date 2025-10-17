namespace RotaryYepNL.Models;

public class Contact
{
    public string Id { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Bio { get; set; } = string.Empty;
    public string ImageUrl { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string PhoneNumber { get; set; } = string.Empty;
    public List<string> Functions { get; set; } = new List<string>();
    public string PrimaryFunction => Functions != null && Functions.Count > 0 ? Functions[0] : string.Empty;
    public string Club { get; set; } = string.Empty;
    public string District { get; set; } = string.Empty;
    public SocialMediaLinks SocialMedia { get; set; } = new SocialMediaLinks();
}

public class SocialMediaLinks
{
    public string Instagram { get; set; } = string.Empty;
    public string Facebook { get; set; } = string.Empty;
    public string Snapchat { get; set; } = string.Empty;
    public string Linkedin { get; set; } = string.Empty;
    public string Website { get; set; } = string.Empty;
}
