with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Flight_Logic; use Flight_Logic;
with Ada.Float_Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Streams. Stream_IO;

procedure Flight_Controller is

   type Sensor_Array is array (1 .. 5) of Float;

   procedure Sort (A : in out Sensor_Array) is
      Temp : Float;
   begin
      for I in A'Range loop
         for J in A'First .. A'Last - 1 loop
            if A (J) > A (J + 1) then
               Temp := A (J);
               A (J) := A (J + 1);
               A (J + 1) := Temp;
            end if;
         end loop;
      end loop;
   end Sort;

   task SensorA;

   task body SensorA is
      G : Generator;
      trueAltitudeA : Float := 35_000.0;
      Actual : Float;
   begin
      Reset (G);
      loop
         Actual := Float (Flight_Data.Get_Altitude);
         trueAltitudeA := Actual + (Random (G) * 20.0) - 10.0;
         if trueAltitudeA < 0.0 then
            trueAltitudeA := 0.0;
         end if;
         Flight_Data.Update_SensorA (Altitude (trueAltitudeA));
         delay 0.1;
      end loop;
   end SensorA;

   task SensorB;

   task body SensorB is
      G : Generator;
      trueAltitudeB : Float := 35_000.0;
      Actual : Float;
   begin
      Reset (G);
      loop
         Actual := Float (Flight_Data.Get_Altitude);
         trueAltitudeB := Actual + (Random (G) * 20.0) - 10.0;
         if trueAltitudeB < 0.0 then
            trueAltitudeB := 0.0;
         end if;
         Flight_Data.Update_SensorB (Altitude (trueAltitudeB));
         delay 0.1;
      end loop;
   end SensorB;

   task SensorC;

   task body SensorC is
      G : Generator;
      trueAltitudeC : Float := 35_000.0;
      Actual : Float;
   begin
      Reset (G);
      loop
         Actual := Float (Flight_Data.Get_Altitude);
         trueAltitudeC := Actual + (Random (G) * 20.0) - 10.0;
         if trueAltitudeC < 0.0 then
            trueAltitudeC := 0.0;
         end if;
         Flight_Data.Update_SensorC (Altitude (trueAltitudeC));
         delay 0.1;
      end loop;
   end SensorC;

   task SensorD;

   task body SensorD is
      G : Generator;
      trueAltitudeD : Float := 35_000.0;
      Actual : Float;
   begin
      Reset (G);
      loop
         Actual := Float (Flight_Data.Get_Altitude);
         trueAltitudeD := Actual + (Random (G) * 20.0) - 10.0;
         if trueAltitudeD < 0.0 then
            trueAltitudeD := 0.0;
         end if;
         Flight_Data.Update_SensorD (Altitude (trueAltitudeD));
         delay 0.1;
      end loop;
   end SensorD;

   task SensorE;

   task body SensorE is
      G : Generator;
      trueAltitudeE : Float := 35_000.0;
      Actual : Float;
   begin
      Reset (G);
      loop
         Actual := Float (Flight_Data.Get_Altitude);
         trueAltitudeE := Actual + ((Random (G) * 20.0) - 10.0) + 3.0;
         if trueAltitudeE < 0.0 then
            trueAltitudeE := 0.0;
         end if;
         Flight_Data.Update_SensorE (Altitude (trueAltitudeE));
         delay 0.1;
      end loop;
   end SensorE;

   task GeneratePath;

   task body GeneratePath is
      G : Generator;
      Start_Latitude : Latitude;
      Start_Longitude : Longitude;
      Destination_Latitude : Latitude;
      Destination_Longitude : Longitude;
      D : Float;
      Dist : Float;
      Rad : Float;
   begin
      Reset (G);

      Start_Latitude := Flight_Data.Get_Latitude;
      Start_Longitude := Flight_Data.Get_Longitude;

      D := Random (G) * 360.0;
      Dist := Random (G) * 9750.0 + 250.0;

      Rad  := D * (3.14159265 / 180.0);

      Destination_Latitude := Start_Latitude +
         Latitude (Dist * Cos (Rad) * 0.01);
      Destination_Longitude := Start_Longitude +
         Longitude (Dist * Sin (Rad) * 0.01);

      Flight_Data.Set_Target (Destination_Latitude, Destination_Longitude);
   end GeneratePath;

   task changeAltitude;

   task body changeAltitude is
      G : Generator;
      currentAltitude : Float := 0.0;
      altitudeChange : Float;
      Current_P : Power;
      Power_Effect : Float;
      Current_V : Float;
   begin
      Reset (G);
      loop
         currentAltitude := Float (Flight_Data.Get_Altitude);
         Current_P := Flight_Data.Get_Power;
         Power_Effect := (Float (Current_P) - 70.0) * 0.3;

         altitudeChange := (Random (G) * 2.0) - 1.0;
         currentAltitude := currentAltitude + altitudeChange + Power_Effect;
         if currentAltitude < 0.0 then
            currentAltitude := 0.0;
         end if;
         if currentAltitude > 40_000.0 then
            currentAltitude := 40_000.0;
         end if;

         Flight_Data.Update_Altitude (Altitude (currentAltitude));
         Put ("Current Altitude: ");
         Ada.Float_Text_IO.Put (
            Item => Float (Flight_Data.Get_Altitude),
            Fore => 5,
            Aft => 2,
            Exp => 0
         );
         New_Line;
         Current_V := Float (Flight_Data.Get_Velocity);
         if Current_P > 80.0 then
            Current_V := Current_V + 2.0;
         elsif Current_P < 30.0 then
            Current_V := Current_V - 2.0;
         end if;

         if Current_V > 700.0 then
            Current_V := 700.0;
         end if;
         if Current_V < 0.0 then
            Current_V := 0.0;
         end if;

         Flight_Data.Update_Velocity (Velocity (Current_V));

         Put ("Phase:    ");
         Put_Line (Flight_Phase'Image (Flight_Data.Get_Phase));
         Put ("Altitude: ");
         Ada.Float_Text_IO.Put (Float (Flight_Data.Get_Altitude),
            Fore => 7, Aft => 2, Exp => 0);
         Put_Line (" ft");
         Put ("Voted:    ");
         Ada.Float_Text_IO.Put (Float (Flight_Data.Get_Voted_Alt),
            Fore => 7, Aft => 2, Exp => 0);
         Put_Line (" ft");
         Put ("Velocity: ");
         Ada.Float_Text_IO.Put (Float (Flight_Data.Get_Velocity),
            Fore => 5, Aft => 2, Exp => 0);
         Put_Line (" kts");
         Put ("Power:    ");
         Ada.Float_Text_IO.Put (Float (Flight_Data.Get_Power),
            Fore => 5, Aft => 2, Exp => 0);
         Put_Line (" %");
         Put ("Lat: ");
         Ada.Float_Text_IO.Put (Float (Flight_Data.Get_Latitude),
            Fore => 5, Aft => 4, Exp => 0);
         Put ("  Lon: ");
         Ada.Float_Text_IO.Put (Float (Flight_Data.Get_Longitude),
            Fore => 6, Aft => 4, Exp => 0);
         New_Line;
         Put_Line ("------------------");

         delay 0.1;
      end loop;
   end changeAltitude;

   task autoPilot;

   task body autoPilot is
      Current_Latitude : Latitude;
      Current_Longitude : Longitude;
      Delta_Longitude : Float;
      Delta_Latitude : Float;
      DistanceLeft : Float;
      Current_Alt : Altitude;
      cruiseAltitude : constant Altitude := 35_000.0;
      Current_Velocity : Velocity;
      Target_Lat  : Latitude;
      Target_Lon : Longitude;

   begin
      delay 0.5;
      Target_Lat := Flight_Data.Get_Target_Lat;
      Target_Lon := Flight_Data.Get_Target_Lon;
      loop
         Current_Longitude := Flight_Data.Get_Longitude;
         Current_Latitude := Flight_Data.Get_Latitude;
         Current_Velocity := Flight_Data.Get_Velocity;
         Delta_Latitude := Float (Target_Lat - Current_Latitude);
         Delta_Longitude := Float (Target_Lon - Current_Longitude);
         DistanceLeft := Sqrt (Delta_Latitude ** 2 + Delta_Longitude ** 2);
         Current_Alt := Flight_Data.Get_Voted_Alt;

         case Flight_Data.Get_Phase is
            when Grounded =>
               Flight_Data.Set_Power (0.0);

            when Takeoff =>
               Flight_Data.Set_Power (100.0);
               if Current_Velocity > 150.0 then
                  Flight_Data.Set_Phase (Climb);
               end if;

            when Cruise =>
               if Current_Alt < (cruiseAltitude - 500.0) then
                  Flight_Data.Set_Power (100.0);
               elsif Current_Alt < (cruiseAltitude - 150.0) then
                  Flight_Data.Set_Power (100.0);
               elsif Current_Alt < (cruiseAltitude - 30.0) then
                  Flight_Data.Set_Power (85.0);
               elsif Current_Alt > (cruiseAltitude + 500.0) then
                  Flight_Data.Set_Power (20.0);
               elsif Current_Alt > (cruiseAltitude + 150.0) then
                  Flight_Data.Set_Power (40.0);
               elsif Current_Alt > (cruiseAltitude + 30.0) then
                  Flight_Data.Set_Power (55.0);
               else
                  Flight_Data.Set_Power (70.0);
               end if;

               if DistanceLeft < 1.66 then
                  Flight_Data.Set_Phase (Descent);
               end if;

            when Climb =>
               if Current_Alt < cruiseAltitude - 1_000.0 then
                  Flight_Data.Set_Power (100.0);
               elsif Current_Alt < cruiseAltitude - 200.0 then
                  Flight_Data.Set_Power (85.0);
               else
                  Flight_Data.Set_Power (70.0);
                  Flight_Data.Set_Phase (Cruise);
               end if;

            when Descent =>
               Flight_Data.Set_Power (20.0);
               if Current_Alt < 50.0 then
                  Flight_Data.Set_Phase (Landing);
               end if;

            when Landing =>
               Flight_Data.Set_Power (0.0);
         end case;
         delay 0.1;
      end loop;
   end autoPilot;

   task Voter;

   task body Voter is
      A, B, C, D, E : Altitude;
      MaxDiff : constant Float := 25.0;
      sensorArray : Sensor_Array;
      votedAltitude : Float := 0.0;
   begin
      delay 0.5;
      loop
         A := Flight_Data.Get_SensorA;
         B := Flight_Data.Get_SensorB;
         C := Flight_Data.Get_SensorC;
         D := Flight_Data.Get_SensorD;
         E := Flight_Data.Get_SensorE;

         sensorArray (1) := Float (A);
         sensorArray (2) := Float (B);
         sensorArray (3) := Float (C);
         sensorArray (4) := Float (D);
         sensorArray (5) := Float (E);

         Sort (sensorArray);

         if (sensorArray (2) - sensorArray (1) > MaxDiff) and then
            (sensorArray (3) - sensorArray (2) < MaxDiff)
         then
            votedAltitude := (sensorArray (2) + sensorArray (3) +
                              sensorArray (4) + sensorArray (5)) / 4.0;

         elsif (sensorArray (5) - sensorArray (4) > MaxDiff) and then
               (sensorArray (4) - sensorArray (3) < MaxDiff)
         then
            votedAltitude := (sensorArray (1) + sensorArray (2) +
                              sensorArray (3) + sensorArray (4)) / 4.0;

         else
            votedAltitude := sensorArray (3);
         end if;

         Flight_Data.Set_Voted_Alt (Altitude (votedAltitude));
         delay 0.1;
      end loop;
   end Voter;

   task ChangeCoordinates;

   task body ChangeCoordinates is
      Ticks_Per_Hour : constant Float := 36000.0;
      Lat_Scale      : constant Float := 1.0 / 60.0;

      V, Dir, Dist : Float;
      New_Lat : Latitude;
      New_Lon : Longitude;
      Current_Lat : Latitude;
      Current_Lon : Longitude;
      Target_Lat  : Latitude;
      Target_Lon  : Longitude;

      Delta_Lat : Float;
      Delta_Lon : Float;
   begin
      delay 0.5;
      loop
         Current_Lat := Flight_Data.Get_Latitude;
         Current_Lon := Flight_Data.Get_Longitude;
         Target_Lat  := Flight_Data.Get_Target_Lat;
         Target_Lon  := Flight_Data.Get_Target_Lon;
         Delta_Lat   := Float (Target_Lat - Current_Lat);
         Delta_Lon   := Float (Target_Lon - Current_Lon);

         V := Float (Flight_Data.Get_Velocity);

         Dir := Arctan (Delta_Lon, Delta_Lat);

         Dist := V / Ticks_Per_Hour;

         New_Lat := Current_Lat +
            Latitude (Dist * Cos (Dir) * Lat_Scale);

         New_Lon := Current_Lon +
            Longitude (Dist * Sin (Dir) * Lat_Scale);

         Flight_Data.Update_Latitude (New_Lat);
         Flight_Data.Update_Longitude (New_Lon);
         delay 0.1;

         exit when Flight_Data.Get_Phase = Landing;
      end loop;
   end ChangeCoordinates;

   task BlackBox;

   task body BlackBox is
      File : File_Type;
      Interval : constant Duration := 1.0;
      Elapsed  : Float := 0.0;
   begin
      Create (File, Out_File, "data.csv");
      Put_Line (File, "Timestamp,Phase,Altitude,Voted_Alt,Velocity,Lat,Lon,Power");
      Close (File);

      loop
         Open (File, Append_File, "data.csv");
         Ada.Float_Text_IO.Put (File, Elapsed, 0, 1, 0);
         Put (File, ",");
         Put (File, Flight_Phase'Image(Flight_Data.Get_Phase));
         Put (File, ",");
         Ada.Float_Text_IO.Put (File, Float(Flight_Data.Get_Altitude), 0, 1, 0);
         Put (File, ",");
         Ada.Float_Text_IO.Put (File, Float(Flight_Data.Get_Altitude), 0, 2, 0);
         Put (File, ",");
         Ada.Float_Text_IO.Put (File, Float(Flight_Data.Get_Voted_Alt), 0, 2, 0);
         Put (File, ",");
         Ada.Float_Text_IO.Put (File, Float(Flight_Data.Get_Velocity), 0, 2, 0);
         Put (File, ",");
         Ada.Float_Text_IO.Put (File, Float(Flight_Data.Get_Latitude), 0, 5, 0);
         Put (File, ",");
         Ada.Float_Text_IO.Put (File, Float(Flight_Data.Get_Longitude), 0, 5, 0);
         Put (File, ",");
         Ada.Float_Text_IO.Put (File, Float(Flight_Data.Get_Power), 0, 1, 0);

         New_Line (File);
         Close (File);

         Elapsed := Elapsed + Float(Interval);
         delay Interval;

         exit when Flight_Data.Get_Phase = Landing and Flight_Data.Get_Altitude < 1.0;
      end loop;
      Put_Line("Black Box: Recording stopped. File saved.");
   end BlackBox;

   task BinaryBlackBox;
   task body BinaryBlackBox is
      type Flight_Record is record
         Elapsed  : Float;
         Altitude : Float;
         Voted    : Float;
         Velocity : Float;
         Lat      : Float;
         Lon      : Float;
         Power    : Float;
         Phase    : Flight_Phase;
      end record;

      Binary_File : Ada.Streams.Stream_IO.File_Type;
      S           : Ada.Streams.Stream_IO.Stream_Access;
      Interval    : constant Duration := 1.0;
      Elapsed     : Float := 0.0;
      Rec         : Flight_Record;
   begin
      Ada.Streams.Stream_IO.Create
         (Binary_File, Ada.Streams.Stream_IO.Out_File, "data.dat");
      S := Ada.Streams.Stream_IO.Stream (Binary_File);

      loop
         Rec := (
            Elapsed  => Elapsed,
            Altitude => Float (Flight_Data.Get_Altitude),
            Voted    => Float (Flight_Data.Get_Voted_Alt),
            Velocity => Float (Flight_Data.Get_Velocity),
            Lat      => Float (Flight_Data.Get_Latitude),
            Lon      => Float (Flight_Data.Get_Longitude),
            Power    => Float (Flight_Data.Get_Power),
            Phase    => Flight_Data.Get_Phase
         );

         Flight_Record'Write (S, Rec);

         Elapsed := Elapsed + Float (Interval);
         delay Interval;

         exit when Flight_Data.Get_Phase = Landing
            and then Flight_Data.Get_Altitude < 1.0;
      end loop;

      Ada.Streams.Stream_IO.Close (Binary_File);
      Put_Line ("BinaryBlackBox: Recording stopped. File saved.");
   end BinaryBlackBox;

begin
   Flight_Data.Set_Phase (Takeoff);
end Flight_Controller;