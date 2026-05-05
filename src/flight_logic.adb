package body Flight_Logic is
   protected body Flight_Data is
      procedure Update_Altitude (New_Value : Altitude) is
      begin
         Current_Altitude := New_Value;
      end Update_Altitude;
      function Get_Altitude return Altitude is
      begin
         return Current_Altitude;
      end Get_Altitude;
      function Get_Power return Power is
      begin
         return Current_Power;
      end Get_Power;
      procedure Set_Power (Setting : Power) is
      begin
         Current_Power := Setting;
      end Set_Power;

      procedure Update_SensorA (Val : Altitude) is
      begin
         RawA := Val;
      end Update_SensorA;

      procedure Update_SensorB (Val : Altitude) is
      begin
         RawB := Val;
      end Update_SensorB;

      procedure Update_SensorC (Val : Altitude) is
      begin
         RawC := Val;
      end Update_SensorC;

      procedure Update_SensorD (Val : Altitude) is
      begin
         RawD := Val;
      end Update_SensorD;

      procedure Update_SensorE (Val : Altitude) is
      begin
         RawE := Val;
      end Update_SensorE;

      function Get_SensorA return Altitude is
      begin
         return RawA;
      end Get_SensorA;

      function Get_SensorB return Altitude is
      begin
         return RawB;
      end Get_SensorB;

      function Get_SensorC return Altitude is
      begin
         return RawC;
      end Get_SensorC;

      function Get_SensorD return Altitude is
      begin
         return RawD;
      end Get_SensorD;

      function Get_SensorE return Altitude is
      begin
         return RawE;
      end Get_SensorE;

      procedure Set_Voted_Alt (Val : Altitude) is
      begin
         bestVal := Val;
      end Set_Voted_Alt;

      function Get_Voted_Alt return Altitude is
      begin
         return bestVal;
      end Get_Voted_Alt;

      procedure Set_Phase (P : Flight_Phase) is
      begin
         Current_Flight_Phase := P;
      end Set_Phase;

      function Get_Phase return Flight_Phase is
      begin
         return Current_Flight_Phase;
      end Get_Phase;

      procedure Update_Latitude (L : Latitude) is
      begin
         Current_Lat := L;
      end Update_Latitude;

      function Get_Latitude return Latitude is
      begin
         return Current_Lat;
      end Get_Latitude;

      procedure Update_Longitude (Lon : Longitude) is
      begin
         Current_Lon := Lon;
      end Update_Longitude;

      function Get_Longitude return Longitude is
      begin
         return Current_Lon;
      end Get_Longitude;

      procedure Update_Velocity (V : Velocity) is
      begin
         Current_Velocity := V;
      end Update_Velocity;

      function Get_Velocity return Velocity is
      begin
         return Current_Velocity;
      end Get_Velocity;

      procedure Set_Target (L : Latitude; Lon : Longitude) is
      begin
         Target_Lat := L;
         Target_Lon := Lon;
      end Set_Target;

      function Get_Target_Lat return Latitude is
      begin
         return Target_Lat;
      end Get_Target_Lat;

      function Get_Target_Lon return Longitude is
      begin
         return Target_Lon;
      end Get_Target_Lon;

   end Flight_Data;
end Flight_Logic;