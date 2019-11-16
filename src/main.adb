with Gtk.Main;
with Glib.Main;
with Gtk.Widget;        use Gtk.Widget;
with Gtk.Window;        use Gtk.Window;
with Gtk.Drawing_Area;  use Gtk.Drawing_Area;
with GUI;               use GUI;

procedure Main is

   Win     : Gtk_Window;
   Timeout : Glib.Main.G_Source_Id;

begin

   --  Initialize GtkAda.
   Gtk.Main.Init;

   --  Create Window
   Gtk_New                   (Win);
   Win.Set_Title             ("Snake Game");
   Win.Set_Border_Width      (4);
   Win.Set_Resizable         (False);

   Gtk.Drawing_Area.Gtk_New  (GUI.Draw);
   GUI.Draw.Set_Size_Request (462, 286);
   GUI.Draw.On_Draw          (On_Draw'Access);
   Win.Add                   (GUI.Draw);

   --  Show the window
   Win.Show_All;
   Win.On_Key_Press_Event    (On_Key_Press'Access, Win);

   -- Update
   Timeout := Glib.Main.Timeout_Add (10, TriggerRedraw'Access);

   --  Start the Gtk+ main loop
   Gtk.Main.Main;

end Main;
