/*
* Copyright (c) 2021 - Today Tre Babcock (trebabcock.me)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Tre Babcock <tre.babcock@gmail.com>
*/

public class Application : Gtk.Application {

    public Application () {
        Object (
            application_id: "com.github.trebabcock.Writer",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var open_action = new SimpleAction ("open", null);
        add_action (open_action);
        const string[] open_keys = {"<Control>o"};
        set_accels_for_action ("app.open", open_keys);
        
        var save_action = new SimpleAction ("save", null);
        add_action (save_action);
        const string[] save_keys = {"<Control>s"};
        set_accels_for_action ("app.save", save_keys);
        
        var save_as_action = new SimpleAction ("save-as", null);
        add_action (save_as_action);
        const string[] save_as_keys = {"<Shift><Control>s"};
        set_accels_for_action ("app.save-as", save_as_keys);
        
        var new_action = new SimpleAction ("new", null);
        add_action (new_action);
        const string[] new_keys = {"<Control>n"};
        set_accels_for_action ("app.new", new_keys);
        
        var print_action = new SimpleAction ("print", null);
        add_action (print_action);
        const string[] print_keys = {"<Control>p"};
        set_accels_for_action ("app.print", print_keys);

        var button_open = new Gtk.Button.from_icon_name ("document-open", Gtk.IconSize.LARGE_TOOLBAR) {
            action_name = "app.open",
            tooltip_markup = Granite.markup_accel_tooltip (
                get_accels_for_action ("app.open"),
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
        
        var font_chooser = new Gtk.FontButton.with_font ("Open Sans Regular 12");
        
        var just_left = new Gtk.RadioToolButton.from_widget (null);
        just_left.set_icon_widget (new Gtk.Image.from_icon_name ("format-justify-left", Gtk.IconSize.LARGE_TOOLBAR));
        var just_center = new Gtk.RadioToolButton.from_widget (just_left);
        just_center.set_icon_widget (new Gtk.Image.from_icon_name ("format-justify-center", Gtk.IconSize.LARGE_TOOLBAR));
        var just_right = new Gtk.RadioToolButton.from_widget (just_center);
        just_right.set_icon_widget (new Gtk.Image.from_icon_name ("format-justify-right", Gtk.IconSize.LARGE_TOOLBAR));
        
        var print_button = new Gtk.Button.from_icon_name ("document-print", Gtk.IconSize.LARGE_TOOLBAR) {
            action_name = "app.print",
            tooltip_markup = Granite.markup_accel_tooltip (
                get_accels_for_action ("app.print"),
                "Print Document"
            )
        };
        
        var settings = new Gtk.Button.from_icon_name ("view-more", Gtk.IconSize.LARGE_TOOLBAR);

        var headerbar = new Gtk.HeaderBar () {
            show_close_button = true
        };

        var color_button = new Gtk.ColorButton ();

        var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        box.add (font_chooser);
        box.add (color_button);
        
        headerbar.pack_start (button_open);
        headerbar.pack_start (button_save);
        headerbar.pack_start (button_save_as);
        headerbar.pack_start (button_new);
        headerbar.pack_start (button_bold);
        headerbar.pack_start (button_italic);
        headerbar.pack_start (button_underline);
        headerbar.pack_start (button_strikethrough);
        headerbar.pack_end (settings);
        headerbar.pack_end (print_button);
        headerbar.pack_end (just_right);
        headerbar.pack_end (just_center);
        headerbar.pack_end (just_left);
        headerbar.set_custom_title (box);
        
        var document = new Document ();
        document.override_font (font_chooser.get_font_desc ());
        
        var document_scroll = new Gtk.ScrolledWindow (null, null);
        document_scroll.add (document);
        
        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 600,
            default_width = 800,
            title = "Writer",
            resizable = true
        };
        
        main_window.set_titlebar (headerbar);
        main_window.add (document_scroll);
        main_window.show_all ();

        font_chooser.font_set.connect (() => {
            document.override_font (font_chooser.get_font_desc ());
        });
        
        just_left.toggled.connect (() => {
            if (just_left.active) {
                document.justification = Gtk.Justification.LEFT;
                document.wrap_mode = Gtk.WrapMode.WORD;
            }
        });
        
        just_center.toggled.connect (() => {
            if (just_center.active) {
                document.justification = Gtk.Justification.CENTER;
                document.wrap_mode = Gtk.WrapMode.WORD;
            }
        });
        
        just_right.toggled.connect (() => {
            if (just_right.active) {
                document.justification = Gtk.Justification.RIGHT;
                document.wrap_mode = Gtk.WrapMode.WORD;
            }
        });
        
        open_action.activate.connect (() => {
            var file = OpenFile (main_window);
            document.Load (file);
        });
        
        save_action.activate.connect (() => {
            document.Save ();
        });
        
        save_as_action.activate.connect (() => {
            
        });
        
        new_action.activate.connect (() => {
            document.New ();
        });

        print_action.activate.connect (() => {
            document.Print (main_window);
        });
    }

    public static int main (string[] args) {
        var app = new Application ();
        return app.run (args);
    }
}

