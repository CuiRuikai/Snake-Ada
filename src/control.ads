package Control is

   type Position is record
      X : Integer := 0;
      Y : Integer := 0;
   end record;

   type Direction is (Up,Down,Left,Right);

   Snake_Length : Integer := 1;

   Apple : Position;
   Snake : array (1..100) of Position;
   Terminate_Indicator : Boolean := False;

   function Generate_Position return Position;

   task type Game is
      entry Move_To (Dir : Direction);
   end Game;

end Control;
