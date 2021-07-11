public class Document : Gtk.TextView {
    public bool Saved { get; set; }
    public bool Changed { get; set; }
    public File DocumentFile { get; set; }

    public Document () {
        this.Saved = false;
        this.Changed = true;
        this.DocumentFile = null;
        base.top_margin = 10;
        base.bottom_margin = 10;
        base.left_margin = 30;
        base.right_margin = 30;
        base.wrap_mode = Gtk.WrapMode.WORD;
        base.set_buffer (null);
        base.set_size_request (800, 1200);
    }

    public Document.with_buffer (Gtk.TextBuffer buffer) {
        this.Saved = false;
        this.Changed = false;
        base.set_buffer (buffer);
    }

    public Document.from_file (File file) {
        this.DocumentFile = file;
        uint8[] contents;
        string etag_out;

        try {
            DocumentFile.load_contents (null, out contents, out etag_out);
        } catch (Error err) {
            error ("%s\n", err.message);
        }
        base.buffer.set_text ((string)contents, contents.length);
    }

    public bool UnsavedChanges () {
        return (!this.Saved && this.Changed);
    }

    public void New () {
        if (this.UnsavedChanges ()) {
            var message_dialog = new Granite.MessageDialog.with_image_from_icon_name (
                "You have unsaved changes!",
                "If you continue, you will lose all unsaved changes. Do you want to continue?",
                "dialog-warning",
                Gtk.ButtonsType.CANCEL
            );

            var continue_button = message_dialog.add_button ("Contune", Gtk.ResponseType.OK);
            continue_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);

            var response = message_dialog.run ();
            

            message_dialog.destroy ();
            switch (response) {
                case Gtk.ResponseType.OK:
                    break;
                case Gtk.ResponseType.CANCEL:
                    return;
            }
        }
        base.set_buffer (null);
        this.DocumentFile = null;
    }

    public void Load (File file) {
        if (this.UnsavedChanges ()) {
            var message_dialog = new Granite.MessageDialog.with_image_from_icon_name (
                "You have unsaved changes!",
                "If you continue, you will lose all unsaved changes. Do you want to continue?",
                "dialog-warning",
                Gtk.ButtonsType.CANCEL
            );

            var continue_button = message_dialog.add_button ("Contune", Gtk.ResponseType.OK);
            continue_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);

            var response = message_dialog.run ();
            

            message_dialog.destroy ();
            switch (response) {
                case Gtk.ResponseType.OK:
                    break;
                case Gtk.ResponseType.CANCEL:
                    return;
            }
        }
        this.DocumentFile = file;
        uint8[] file_contents;
        string etag_out;
        try {
            DocumentFile.load_contents (null, out file_contents, out etag_out);
        }
        catch (Error err) {
            error ("%s\n", err.message);
        }
        base.buffer.set_text ((string) file_contents, file_contents.length);
    }

    public void Save () {
        if (DocumentFile == null) {
            this.SaveAs ();
            return;
        }

        try {
            DocumentFile.replace_contents (base.buffer.text.data, null, false, FileCreateFlags.NONE, null);
        } catch (Error e) {
            print ("Error: %s\n", e.message);
        }
        Saved = true;
        Changed = false;
    }

    public void SaveAs () {
        // TODO
    }

    public void Print (Gtk.Window window) {
        var print_operation = new Gtk.PrintOperation ();
        print_operation.set_default_page_setup (new Gtk.PageSetup.from_file (this.DocumentFile.get_path ()));
        print_operation.run (Gtk.PrintOperationAction.PREVIEW, window);
        print (this.DocumentFile.get_path ());
    }
}