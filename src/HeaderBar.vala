public class HeaderBar : Gtk.HeaderBar {
    public Gtk.RadioToolButton JustLeft { get; set; }
    public Gtk.RadioToolButton JustCenter { get; set; }
    public Gtk.RadioToolButton JustRight { get; set; }

    public HeaderBar () {
        base.show_close_button = true;

        var button_open = new Gtk.Button.from_icon_name ("document-open", Gtk.IconSize.LARGE_TOOLBAR) {
            action_name = "app.open",
            tooltip_markup = Granite.markup_accel_tooltip (
                Application.get_accels_for_action ("app.open"),
                "Open Document"
            )
        };
        
        var button_save = new Gtk.Button.from_icon_name ("document-save", Gtk.IconSize.LARGE_TOOLBAR) {
            action_name = "app.save",
            tooltip_markup = Granite.markup_accel_tooltip (
                get_accels_for_action ("app.save"),
                "Save Document"
            )
        };
        
        var button_save_as = new Gtk.Button.from_icon_name ("document-save-as", Gtk.IconSize.LARGE_TOOLBAR) {
            action_name = "app.save-as",
            tooltip_markup = Granite.markup_accel_tooltip (
                get_accels_for_action ("app.save-as"),
                "Save Document As"
            )
        };
        
        var button_new = new Gtk.Button.from_icon_name ("document-new", Gtk.IconSize.LARGE_TOOLBAR) {
            action_name = "app.new",
            tooltip_markup = Granite.markup_accel_tooltip (
                get_accels_for_action ("app.new"),
                "New Document"
            )
        };
        
        var button_bold = new Gtk.ToggleButton ();
        button_bold.image = new Gtk.Image.from_icon_name ("format-text-bold", Gtk.IconSize.LARGE_TOOLBAR);
        
        var button_italic = new Gtk.ToggleButton ();
        button_italic.image = new Gtk.Image.from_icon_name ("format-text-italic", Gtk.IconSize.LARGE_TOOLBAR);
        
        var button_underline = new Gtk.ToggleButton ();
        button_underline.image = new Gtk.Image.from_icon_name ("format-text-underline", Gtk.IconSize.LARGE_TOOLBAR);
        
        var button_strikethrough = new Gtk.ToggleButton ();
        button_strikethrough.image = new Gtk.Image.from_icon_name ("format-text-strikethrough", Gtk.IconSize.LARGE_TOOLBAR);
        
        var font_chooser = new Gtk.FontButton.with_font ("RobotoMono-Regular");
        
        this.JustLeft = new Gtk.RadioToolButton.from_widget (null);
        this.JustLeft.set_icon_widget (new Gtk.Image.from_icon_name ("format-justify-left", Gtk.IconSize.LARGE_TOOLBAR));
        this.JustCenter = new Gtk.RadioToolButton.from_widget (just_left);
        this.JustCenter.set_icon_widget (new Gtk.Image.from_icon_name ("format-justify-center", Gtk.IconSize.LARGE_TOOLBAR));
        this.JustRight = new Gtk.RadioToolButton.from_widget (just_center);
        this.JustRight.set_icon_widget (new Gtk.Image.from_icon_name ("format-justify-right", Gtk.IconSize.LARGE_TOOLBAR));
        
        var print_button = new Gtk.Button.from_icon_name ("document-print", Gtk.IconSize.LARGE_TOOLBAR) {
            action_name = "app.print",
            tooltip_markup = Granite.markup_accel_tooltip (
                get_accels_for_action ("app.print"),
                "Print Document"
            )
        };
        
        var settings = new Gtk.Button.from_icon_name ("view-more", Gtk.IconSize.LARGE_TOOLBAR);
        
        base.pack_start (button_open);
        base.pack_start (button_save);
        base.pack_start (button_save_as);
        base.pack_start (button_new);
        base.pack_start (button_bold);
        base.pack_start (button_italic);
        base.pack_start (button_underline);
        base.pack_start (button_strikethrough);
        base.pack_end (settings);
        base.pack_end (print_button);
        base.pack_end (this.JustRight);
        base.pack_end (this.JustCenter);
        base.pack_end (this.JustLeft);
        base.set_custom_title (font_chooser);

        
    }
}