with Ada.Numerics.Discrete_Random;

package body Control is

   function Generate_Position return Position is
      package Random_Integer is new Ada.Numerics.Discrete_Random (Integer);
      Gen         : Random_Integer.Generator;
      P           : Position;
      Is_Conflict : Boolean;
   begin
      Random_Integer.Reset(Gen);
      loop
         Is_Conflict := False;

         P.X := abs(Random_Integer.Random (Gen)) mod 40 + 1;
         P.Y := abs(Random_Integer.Random (Gen)) mod 20 + 1;
         for Ix in Integer range 1..Snake_Length loop
            Is_Conflict := P.X = Snake (1).X and then P.Y = Snake (1).Y;
            exit when Is_Conflict;
         end loop;

         exit when not Is_Conflict;
      end loop;
      return P;
   end Generate_Position;

   task body Game is
      Head      : Position;
      Next_Dir  : Direction := Right;
   begin
      Snake (1) := (X => 20, Y => 10);
      Apple     := Generate_Position;
      loop
         select
            accept Move_To (Dir : in Direction) do
               Next_Dir := Dir;
            end Move_To;
         or
            delay 0.5;
         end select;

         -- Move
         Head := Snake (1);
         case Next_Dir is
            when Up => Head.Y  := Head.Y - 1;
            when Down => Head.Y  := Head.Y + 1;
            when Left => Head.X := Head.X - 1;
            when Right => Head.X := Head.X + 1;
            when others => null;
         end case;
         for Ix in reverse 2..Snake_Length loop
            Snake (Ix) := Snake (Ix - 1);
         end loop;
         Snake (1) := Head;

         -- Eat
         if Head.X = Apple.X and then Head.Y = Apple.Y then
            Snake_Length         := Snake_Length + 1;
            Snake (Snake_Length) := Apple;
            Apple                := Generate_Position;
         end if;

         -- Crash
         Terminate_Indicator := Head.X = 1 or else Head.X =40 or else Head.Y = 1 or else Head.Y = 24;
         for Ix in 2..Snake_Length - 1 loop
            exit when Terminate_Indicator;
            Terminate_Indicator := Head.X = Snake (Ix).X and then Head.Y = Snake (Ix).Y;
         end loop;
         exit when Terminate_Indicator;
      end loop;
   end Game;


end Control;
