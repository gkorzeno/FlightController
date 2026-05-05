package Flight_Logic is
   type Altitude is digits 7 range 0.0 .. 40_000.0;
   type Power is new Float range 0.0 .. 100.0;
   type Latitude is digits 7 range -90.0 .. 90.0;
   type Longitude is digits 7 range -180.0 .. 180.0;
   type Velocity is digits 7 range 0.0 .. 700.0;
   type Direction is digits 7 range 0.0 .. 360.0;
   type Distance is digits 7 range 250.0 .. 10_000.0;
   type Flight_Phase is (Grounded, Takeoff, Climb, Cruise, Descent, Landing);

   protected Flight_Data is
      procedure Update_Altitude (New_Value : Altitude);
      procedure Set_Power (Setting : Power);
      function Get_Altitude return Altitude;
      function Get_Power return Power;

      procedure Update_SensorA (Val : Altitude);
      procedure Update_SensorB (Val : Altitude);
      procedure Update_SensorC (Val : Altitude);
      procedure Update_SensorD (Val : Altitude);
      procedure Update_SensorE (Val : Altitude);

      function Get_SensorA return Altitude;
      function Get_SensorB return Altitude;
      function Get_SensorC return Altitude;
      function Get_SensorD return Altitude;
      function Get_SensorE return Altitude;

      procedure Set_Voted_Alt (Val : Altitude);
      function Get_Voted_Alt return Altitude;

      procedure Set_Phase (P : Flight_Phase);
      function Get_Phase return Flight_Phase;
      procedure Update_Latitude (L : Latitude);
      function Get_Latitude return Latitude;
      procedure Update_Longitude (Lon : Longitude);
      function Get_Longitude return Longitude;
      procedure Update_Velocity (V : Velocity);
      function Get_Velocity return Velocity;
      function Get_Target_Lat return Latitude;
      function Get_Target_Lon return Longitude;
      procedure Set_Target (L : Latitude; Lon : Longitude);

   private
      Current_Altitude : Altitude := 0.0;
      Current_Power : Power := 0.0;
      RawA, RawB, RawC, RawD, RawE : Altitude := 0.0;
      bestVal : Altitude := 35_000.0;
      Current_Lat : Latitude := 44.8851;
      Current_Lon : Longitude := 93.2144;
      Current_Velocity : Velocity := 0.0;
      Current_Direction : Direction := 0.0;
      Current_Flight_Phase : Flight_Phase := Grounded;
      Target_Lat : Latitude := 0.0;
      Target_Lon : Longitude := 0.0;
      votedAltitude : Altitude := 0.0;

   end Flight_Data;
end Flight_Logic;