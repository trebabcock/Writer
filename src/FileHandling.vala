public File OpenFile (Gtk.Window window) {
    FileIOStream iostream;
    File file;
	try {
        file = File.new_tmp ("tpl-XXXXXX.txt", out iostream);
    } catch (Error err) {
        error ("%s\n", err.message);
    }
    var dialog = new Gtk.FileChooserNative ("Open Document",
                                            window,
                                            Gtk.FileChooserAction.OPEN,
                                            "Open",
                                            "Cancel");
    var res = dialog.run();
    switch (res) { 
        case Gtk.ResponseType.ACCEPT:
            file = dialog.get_file();
            break;
        case Gtk.ResponseType.CANCEL:
            file = null;
            break;
    }

    return file;
}