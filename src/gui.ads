with Glib.Object;         use Glib.Object;
with Gdk.Event;           use Gdk.Event;
with Gtk.Widget;          use Gtk.Widget;
with Gtk.Drawing_Area;    use Gtk.Drawing_Area;
with Cairo;               use Cairo;
with Control;             use Control;

package GUI is

   procedure Draw_Rectangle (Cr : Cairo_Context; Pos : Position);

   function On_Key_Press   (Ent  : access GObject_Record'Class   ; Event : Gdk_Event_Key)       return Boolean;
   function On_Draw        (Self : access Gtk_Widget_Record'Class; Cr    : Cairo.Cairo_Context) return Boolean;
   function TriggerRedraw                                                                       return Boolean;

   Draw     : Gtk_Drawing_Area;
   Game_Ins : Game;

end GUI;
