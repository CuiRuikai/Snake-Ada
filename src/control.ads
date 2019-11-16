package Control is

   type Position is record
      X : Integer := 0;
      Y : Integer := 0;
   end record;

   type Direction is (Up,Down,Left,Right);

   Apple               : Position;
   Snake               : array (1..100) of Position;
   Snake_Length        : Integer                     := 1;

   Terminate_Indicator : Boolean                     := False;

   task type Game is
      entry Move_To (Dir : Direction);
   end Game;

private

   function Generate_Position return Position;

end Control;
