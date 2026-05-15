-- =============================================================================
-- CARGA DE DATOS DE PRUEBA — SOLO AVIONES
-- Llamar desde Menu_Principal si aviones.dat no existe (primera ejecución).
-- =============================================================================

with Aviones; use Aviones;

procedure Cargar_Datos_Prueba(LA: in out TAvion) is

   procedure Str(S: out String; L: out Natural; V: in String) is
   begin
      S := (others => ' ');
      S(1..V'Length) := V;
      L := V'Length;
   end Str;

   A : RegAvion;

begin

   A.Codigo:=101; A.Anio:=1988; Str(A.Tipo,A.LongTipo,"Pampa");          Str(A.Modelo,A.LongMod,"IA-63");      Alta(LA,A);
   A.Codigo:=102; A.Anio:=1991; Str(A.Tipo,A.LongTipo,"Pampa");          Str(A.Modelo,A.LongMod,"IA-63 B");    Alta(LA,A);
   A.Codigo:=103; A.Anio:=1976; Str(A.Tipo,A.LongTipo,"A-4");            Str(A.Modelo,A.LongMod,"Skyhawk C");  Alta(LA,A);
   A.Codigo:=104; A.Anio:=1979; Str(A.Tipo,A.LongTipo,"A-4");            Str(A.Modelo,A.LongMod,"Skyhawk Q");  Alta(LA,A);
   A.Codigo:=105; A.Anio:=1982; Str(A.Tipo,A.LongTipo,"Super Etendard"); Str(A.Modelo,A.LongMod,"SuE Mod 1");  Alta(LA,A);
   A.Codigo:=106; A.Anio:=1986; Str(A.Tipo,A.LongTipo,"Super Etendard"); Str(A.Modelo,A.LongMod,"SuE Mod 2");  Alta(LA,A);

end Cargar_Datos_Prueba;