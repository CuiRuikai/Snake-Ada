with Gdk.Types.Keysyms;          use Gdk.Types.Keysyms;
with Glib;                       use Glib;

package body GUI is

   procedure Draw_Rectangle (Cr : Cairo_Context; Pos : Position) is
   begin
      Cairo.Rectangle (Cr     => Cr,
                       X      => Gdouble (Pos.X * 11),
                       Y      => Gdouble (Pos.Y * 11),
                       Width  => Gdouble (10),
                       Height => Gdouble (10));
      Cairo.Fill_Preserve (Cr);
   end;

   function On_Key_Press (Ent   : access GObject_Record'Class; Event : Gdk_Event_Key) return Boolean is
   begin
      case Event.Keyval is
         when GDK_Up    => Game_Ins.Move_To (Up);
         when GDK_Down  => Game_Ins.Move_To (Down);
         when GDK_Left  => Game_Ins.Move_To (Left);
         when GDK_Right => Game_Ins.Move_To (Right);
         when others    => null;
      end case;
      return False;
   end On_Key_Press;

   function On_Draw (Self : access Gtk_Widget_Record'Class; Cr   : Cairo.Cairo_Context) return Boolean is
   begin
      --  Draw the border
      for x in Integer range 0 .. 41 loop
         Draw_Rectangle (Cr, (X=> x , Y => 0));
         Draw_Rectangle (Cr, (X=> x , Y => 25));
      end loop;
      for y in Integer range 0 .. 25 loop
         Draw_Rectangle (Cr, (X=> 0 , Y => y));
         Draw_Rectangle (Cr, (X=> 41 , Y => y));
      end loop;

      -- Draw Apple And Snake
      if (Terminate_Indicator) then
         Cairo.Set_Font_Size (Cr, Gdouble (30));
         Cairo.Move_To       (Cr, Gdouble (80), Gdouble (8 * 11));
         Cairo.Show_Text     (Cr, "GAME OVER");
         abort Game_Ins;
      else
         -- Draw Apple
         Draw_Rectangle (Cr, Apple);

         -- Draw Snake
         for Ix in Integer range 1..Snake_Length loop
            Draw_Rectangle (Cr, Snake (Ix));
         end loop;
      end if;

      return False;
   end On_Draw;

   function TriggerRedraw return Boolean is
   begin
      Draw.Queue_Draw;
      return True;
   end TriggerRedraw;

end GUI;
