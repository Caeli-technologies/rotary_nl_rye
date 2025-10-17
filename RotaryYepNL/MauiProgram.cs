using Microsoft.Extensions.Logging;
using CommunityToolkit.Maui;
using MauiIcons.Material;
using MauiIcons.Cupertino;
using Plugin.Maui.SegmentedControl;

namespace RotaryYepNL;

public static class MauiProgram
{
	public static MauiApp CreateMauiApp()
	{
		var builder = MauiApp.CreateBuilder();
		builder
			.UseMauiApp<App>()
			.UseMauiCommunityToolkit()
			.UseSegmentedControl()
			.UseMaterialMauiIcons()
			.UseCupertinoMauiIcons()
			.ConfigureFonts(fonts =>
			{
				fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
				fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
			});

#if DEBUG
		builder.Logging.AddDebug();
#endif

		return builder.Build();
	}
}
