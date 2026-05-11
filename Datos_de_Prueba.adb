-- =============================================================================
-- CARGA DE DATOS DE PRUEBA — SISTEMA RASU
-- Llamar desde Menu_Principal solo si los .dat no existen (primera ejecución).
-- NOTA: Equivalencias.ads debe exportar CriarLista(L: out TEquivalencias)
--       que internamente llame a Lista_Equivalencias.Crear(L).
-- =============================================================================

with Aviones;      use Aviones;
with Repuestos;    use Repuestos;
with Equivalencias; use Equivalencias;

procedure Cargar_Datos_Prueba(LA: in out TAviones; LR: in out TRepuestos) is

   -- Helper: carga un String fijo desde un literal, rellena con espacios.
   procedure Str(S: out String; L: out Natural; V: String) is
   begin
      S := (others => ' ');
      S(1..V'Length) := V;
      L := V'Length;
   end Str;

   A   : RegAvion;
   Rep : RegRepuesto;
   Eq  : RegEquivalencia;

begin

   -- ==== AVIONES ====

   A.Codigo:=101; A.Anio:=1988; Str(A.Tipo,A.LongTipo,"Pampa");           Str(A.Modelo,A.LongMod,"IA-63");      Alta(LA,A);
   A.Codigo:=102; A.Anio:=1991; Str(A.Tipo,A.LongTipo,"Pampa");           Str(A.Modelo,A.LongMod,"IA-63 B");    Alta(LA,A);
   A.Codigo:=103; A.Anio:=1976; Str(A.Tipo,A.LongTipo,"A-4");             Str(A.Modelo,A.LongMod,"Skyhawk C");  Alta(LA,A);
   A.Codigo:=104; A.Anio:=1979; Str(A.Tipo,A.LongTipo,"A-4");             Str(A.Modelo,A.LongMod,"Skyhawk Q");  Alta(LA,A);
   A.Codigo:=105; A.Anio:=1982; Str(A.Tipo,A.LongTipo,"Super Etendard");  Str(A.Modelo,A.LongMod,"SuE Mod 1");  Alta(LA,A);
   A.Codigo:=106; A.Anio:=1986; Str(A.Tipo,A.LongTipo,"Super Etendard");  Str(A.Modelo,A.LongMod,"SuE Mod 2");  Alta(LA,A);


   -- ==== REPUESTOS + EQUIVALENCIAS ====
   -- 8 repuestos por avión, 2 equivalencias por repuesto.
   -- Códigos: repuestos 201-248 / equivalencias 301-396
   -- Tipos ciclan: Filtro_Aceite, Filtro_Aire, Correa, Bujia, Neumatico,
   --               Filtro_Aceite, Filtro_Aire, Correa


   -- ---- AVION 101 (Pampa IA-63) ----

   Rep.Codigo:=201; Rep.CodigoAvion:=101; Rep.Tipo:=Filtro_Aceite;  Str(Rep.Descripcion,Rep.LongDesc,"Filtro aceite motor");       CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=201; Eq.CodigoAvion:=101;
   Eq.Codigo:=301; Eq.Origen:=Nacional;       Eq.Precio:=2500.0; Eq.CantUsadaAnio:=6; Str(Eq.Marca,Eq.LongMarca,"AcmeParts FO-78");  Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=302; Eq.Origen:=Internacional;  Eq.Precio:=3800.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Bosch OF-220");      Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=202; Rep.CodigoAvion:=101; Rep.Tipo:=Filtro_Aire;   Str(Rep.Descripcion,Rep.LongDesc,"Filtro aire admision");        CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=202; Eq.CodigoAvion:=101;
   Eq.Codigo:=303; Eq.Origen:=Nacional;       Eq.Precio:=1800.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"RioFil AF-12");     Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=304; Eq.Origen:=Internacional;  Eq.Precio:=2900.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Mann C-2134");       Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=203; Rep.CodigoAvion:=101; Rep.Tipo:=Correa;        Str(Rep.Descripcion,Rep.LongDesc,"Correa distribucion");          CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=203; Eq.CodigoAvion:=101;
   Eq.Codigo:=305; Eq.Origen:=Nacional;       Eq.Precio:=3200.0; Eq.CantUsadaAnio:=4; Str(Eq.Marca,Eq.LongMarca,"SurTec CT-55");     Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=306; Eq.Origen:=Internacional;  Eq.Precio:=5200.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Gates T-180");       Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=204; Rep.CodigoAvion:=101; Rep.Tipo:=Bujia;         Str(Rep.Descripcion,Rep.LongDesc,"Bujia encendido");              CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=204; Eq.CodigoAvion:=101;
   Eq.Codigo:=307; Eq.Origen:=Nacional;       Eq.Precio:=2100.0; Eq.CantUsadaAnio:=8; Str(Eq.Marca,Eq.LongMarca,"PataCorp SP-4");    Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=308; Eq.Origen:=Internacional;  Eq.Precio:=3500.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"NGK BKR6E");         Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=205; Rep.CodigoAvion:=101; Rep.Tipo:=Neumatico;     Str(Rep.Descripcion,Rep.LongDesc,"Neumatico tren aterrizaje");    CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=205; Eq.CodigoAvion:=101;
   Eq.Codigo:=309; Eq.Origen:=Nacional;       Eq.Precio:=4500.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"AeroArg NA-18");    Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=310; Eq.Origen:=Internacional;  Eq.Precio:=6800.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Michelin Air X");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=206; Rep.CodigoAvion:=101; Rep.Tipo:=Filtro_Aceite; Str(Rep.Descripcion,Rep.LongDesc,"Filtro aceite hidraulico");     CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=206; Eq.CodigoAvion:=101;
   Eq.Codigo:=311; Eq.Origen:=Nacional;       Eq.Precio:=2800.0; Eq.CantUsadaAnio:=5; Str(Eq.Marca,Eq.LongMarca,"AcmeParts FH-33"); Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=312; Eq.Origen:=Internacional;  Eq.Precio:=4200.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Bosch OH-110");     Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=207; Rep.CodigoAvion:=101; Rep.Tipo:=Filtro_Aire;   Str(Rep.Descripcion,Rep.LongDesc,"Filtro aire cabina");           CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=207; Eq.CodigoAvion:=101;
   Eq.Codigo:=313; Eq.Origen:=Nacional;       Eq.Precio:=1500.0; Eq.CantUsadaAnio:=7; Str(Eq.Marca,Eq.LongMarca,"RioFil AC-08");    Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=314; Eq.Origen:=Internacional;  Eq.Precio:=2600.0; Eq.CantUsadaAnio:=4; Str(Eq.Marca,Eq.LongMarca,"Mann CF-500");     Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=208; Rep.CodigoAvion:=101; Rep.Tipo:=Correa;        Str(Rep.Descripcion,Rep.LongDesc,"Correa accesorios");            CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=208; Eq.CodigoAvion:=101;
   Eq.Codigo:=315; Eq.Origen:=Nacional;       Eq.Precio:=3600.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"SurTec CA-22");    Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=316; Eq.Origen:=Internacional;  Eq.Precio:=5500.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Gates A-90");      Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);


   -- ---- AVION 102 (Pampa IA-63 B) ----

   Rep.Codigo:=209; Rep.CodigoAvion:=102; Rep.Tipo:=Filtro_Aceite;  Str(Rep.Descripcion,Rep.LongDesc,"Filtro aceite motor");         CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=209; Eq.CodigoAvion:=102;
   Eq.Codigo:=317; Eq.Origen:=Nacional;       Eq.Precio:=2200.0; Eq.CantUsadaAnio:=5; Str(Eq.Marca,Eq.LongMarca,"AcmeParts FO-78"); Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=318; Eq.Origen:=Internacional;  Eq.Precio:=3700.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Bosch OF-220");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=210; Rep.CodigoAvion:=102; Rep.Tipo:=Filtro_Aire;   Str(Rep.Descripcion,Rep.LongDesc,"Filtro aire admision");         CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=210; Eq.CodigoAvion:=102;
   Eq.Codigo:=319; Eq.Origen:=Nacional;       Eq.Precio:=1900.0; Eq.CantUsadaAnio:=4; Str(Eq.Marca,Eq.LongMarca,"RioFil AF-12");    Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=320; Eq.Origen:=Internacional;  Eq.Precio:=3100.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Mann C-2134");     Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=211; Rep.CodigoAvion:=102; Rep.Tipo:=Correa;        Str(Rep.Descripcion,Rep.LongDesc,"Correa distribucion");          CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=211; Eq.CodigoAvion:=102;
   Eq.Codigo:=321; Eq.Origen:=Nacional;       Eq.Precio:=3400.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"SurTec CT-55");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=322; Eq.Origen:=Internacional;  Eq.Precio:=4900.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Gates T-180");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=212; Rep.CodigoAvion:=102; Rep.Tipo:=Bujia;         Str(Rep.Descripcion,Rep.LongDesc,"Bujia encendido");              CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=212; Eq.CodigoAvion:=102;
   Eq.Codigo:=323; Eq.Origen:=Nacional;       Eq.Precio:=2300.0; Eq.CantUsadaAnio:=6; Str(Eq.Marca,Eq.LongMarca,"PataCorp SP-4");  Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=324; Eq.Origen:=Internacional;  Eq.Precio:=3600.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"NGK BKR6E");      Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=213; Rep.CodigoAvion:=102; Rep.Tipo:=Neumatico;     Str(Rep.Descripcion,Rep.LongDesc,"Neumatico tren aterrizaje");    CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=213; Eq.CodigoAvion:=102;
   Eq.Codigo:=325; Eq.Origen:=Nacional;       Eq.Precio:=4700.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"AeroArg NA-18");  Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=326; Eq.Origen:=Internacional;  Eq.Precio:=6600.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Michelin Air X"); Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=214; Rep.CodigoAvion:=102; Rep.Tipo:=Filtro_Aceite; Str(Rep.Descripcion,Rep.LongDesc,"Filtro aceite hidraulico");     CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=214; Eq.CodigoAvion:=102;
   Eq.Codigo:=327; Eq.Origen:=Nacional;       Eq.Precio:=2600.0; Eq.CantUsadaAnio:=4; Str(Eq.Marca,Eq.LongMarca,"AcmeParts FH-33"); Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=328; Eq.Origen:=Internacional;  Eq.Precio:=3900.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Bosch OH-110");   Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=215; Rep.CodigoAvion:=102; Rep.Tipo:=Filtro_Aire;   Str(Rep.Descripcion,Rep.LongDesc,"Filtro aire cabina");           CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=215; Eq.CodigoAvion:=102;
   Eq.Codigo:=329; Eq.Origen:=Nacional;       Eq.Precio:=1700.0; Eq.CantUsadaAnio:=5; Str(Eq.Marca,Eq.LongMarca,"RioFil AC-08");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=330; Eq.Origen:=Internacional;  Eq.Precio:=2700.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"Mann CF-500");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=216; Rep.CodigoAvion:=102; Rep.Tipo:=Correa;        Str(Rep.Descripcion,Rep.LongDesc,"Correa accesorios");            CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=216; Eq.CodigoAvion:=102;
   Eq.Codigo:=331; Eq.Origen:=Nacional;       Eq.Precio:=3100.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"SurTec CA-22");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=332; Eq.Origen:=Internacional;  Eq.Precio:=4700.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Gates A-90");     Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);


   -- ---- AVION 103 (A-4 Skyhawk C) ----

   Rep.Codigo:=217; Rep.CodigoAvion:=103; Rep.Tipo:=Filtro_Aceite;  Str(Rep.Descripcion,Rep.LongDesc,"Filtro aceite motor");         CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=217; Eq.CodigoAvion:=103;
   Eq.Codigo:=333; Eq.Origen:=Nacional;       Eq.Precio:=2700.0; Eq.CantUsadaAnio:=7; Str(Eq.Marca,Eq.LongMarca,"AcmeParts FO-78"); Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=334; Eq.Origen:=Internacional;  Eq.Precio:=4100.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"Bosch OF-220");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=218; Rep.CodigoAvion:=103; Rep.Tipo:=Filtro_Aire;   Str(Rep.Descripcion,Rep.LongDesc,"Filtro aire admision");         CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=218; Eq.CodigoAvion:=103;
   Eq.Codigo:=335; Eq.Origen:=Nacional;       Eq.Precio:=1600.0; Eq.CantUsadaAnio:=5; Str(Eq.Marca,Eq.LongMarca,"RioFil AF-12");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=336; Eq.Origen:=Internacional;  Eq.Precio:=2800.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Mann C-2134");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=219; Rep.CodigoAvion:=103; Rep.Tipo:=Correa;        Str(Rep.Descripcion,Rep.LongDesc,"Correa distribucion");          CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=219; Eq.CodigoAvion:=103;
   Eq.Codigo:=337; Eq.Origen:=Nacional;       Eq.Precio:=3800.0; Eq.CantUsadaAnio:=4; Str(Eq.Marca,Eq.LongMarca,"SurTec CT-55");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=338; Eq.Origen:=Internacional;  Eq.Precio:=5900.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Gates T-180");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=220; Rep.CodigoAvion:=103; Rep.Tipo:=Bujia;         Str(Rep.Descripcion,Rep.LongDesc,"Bujia encendido");              CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=220; Eq.CodigoAvion:=103;
   Eq.Codigo:=339; Eq.Origen:=Nacional;       Eq.Precio:=1900.0; Eq.CantUsadaAnio:=9; Str(Eq.Marca,Eq.LongMarca,"PataCorp SP-4");  Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=340; Eq.Origen:=Internacional;  Eq.Precio:=3200.0; Eq.CantUsadaAnio:=4; Str(Eq.Marca,Eq.LongMarca,"NGK BKR6E");      Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=221; Rep.CodigoAvion:=103; Rep.Tipo:=Neumatico;     Str(Rep.Descripcion,Rep.LongDesc,"Neumatico tren aterrizaje");    CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=221; Eq.CodigoAvion:=103;
   Eq.Codigo:=341; Eq.Origen:=Nacional;       Eq.Precio:=4300.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"AeroArg NA-18");  Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=342; Eq.Origen:=Internacional;  Eq.Precio:=6600.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Michelin Air X"); Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=222; Rep.CodigoAvion:=103; Rep.Tipo:=Filtro_Aceite; Str(Rep.Descripcion,Rep.LongDesc,"Filtro aceite hidraulico");     CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=222; Eq.CodigoAvion:=103;
   Eq.Codigo:=343; Eq.Origen:=Nacional;       Eq.Precio:=3100.0; Eq.CantUsadaAnio:=6; Str(Eq.Marca,Eq.LongMarca,"AcmeParts FH-33"); Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=344; Eq.Origen:=Internacional;  Eq.Precio:=4800.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Bosch OH-110");   Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=223; Rep.CodigoAvion:=103; Rep.Tipo:=Filtro_Aire;   Str(Rep.Descripcion,Rep.LongDesc,"Filtro aire cabina");           CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=223; Eq.CodigoAvion:=103;
   Eq.Codigo:=345; Eq.Origen:=Nacional;       Eq.Precio:=1600.0; Eq.CantUsadaAnio:=4; Str(Eq.Marca,Eq.LongMarca,"RioFil AC-08");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=346; Eq.Origen:=Internacional;  Eq.Precio:=2700.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Mann CF-500");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=224; Rep.CodigoAvion:=103; Rep.Tipo:=Correa;        Str(Rep.Descripcion,Rep.LongDesc,"Correa accesorios");            CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=224; Eq.CodigoAvion:=103;
   Eq.Codigo:=347; Eq.Origen:=Nacional;       Eq.Precio:=3500.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"SurTec CA-22");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=348; Eq.Origen:=Internacional;  Eq.Precio:=5100.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Gates A-90");     Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);


   -- ---- AVION 104 (A-4 Skyhawk Q) ----

   Rep.Codigo:=225; Rep.CodigoAvion:=104; Rep.Tipo:=Filtro_Aceite;  Str(Rep.Descripcion,Rep.LongDesc,"Filtro aceite motor");         CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=225; Eq.CodigoAvion:=104;
   Eq.Codigo:=349; Eq.Origen:=Nacional;       Eq.Precio:=2400.0; Eq.CantUsadaAnio:=5; Str(Eq.Marca,Eq.LongMarca,"AcmeParts FO-78"); Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=350; Eq.Origen:=Internacional;  Eq.Precio:=3900.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Bosch OF-220");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=226; Rep.CodigoAvion:=104; Rep.Tipo:=Filtro_Aire;   Str(Rep.Descripcion,Rep.LongDesc,"Filtro aire admision");         CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=226; Eq.CodigoAvion:=104;
   Eq.Codigo:=351; Eq.Origen:=Nacional;       Eq.Precio:=2000.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"RioFil AF-12");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=352; Eq.Origen:=Internacional;  Eq.Precio:=3300.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Mann C-2134");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=227; Rep.CodigoAvion:=104; Rep.Tipo:=Correa;        Str(Rep.Descripcion,Rep.LongDesc,"Correa distribucion");          CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=227; Eq.CodigoAvion:=104;
   Eq.Codigo:=353; Eq.Origen:=Nacional;       Eq.Precio:=3300.0; Eq.CantUsadaAnio:=4; Str(Eq.Marca,Eq.LongMarca,"SurTec CT-55");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=354; Eq.Origen:=Internacional;  Eq.Precio:=4700.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Gates T-180");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=228; Rep.CodigoAvion:=104; Rep.Tipo:=Bujia;         Str(Rep.Descripcion,Rep.LongDesc,"Bujia encendido");              CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=228; Eq.CodigoAvion:=104;
   Eq.Codigo:=355; Eq.Origen:=Nacional;       Eq.Precio:=2000.0; Eq.CantUsadaAnio:=7; Str(Eq.Marca,Eq.LongMarca,"PataCorp SP-4");  Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=356; Eq.Origen:=Internacional;  Eq.Precio:=3400.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"NGK BKR6E");      Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=229; Rep.CodigoAvion:=104; Rep.Tipo:=Neumatico;     Str(Rep.Descripcion,Rep.LongDesc,"Neumatico tren aterrizaje");    CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=229; Eq.CodigoAvion:=104;
   Eq.Codigo:=357; Eq.Origen:=Nacional;       Eq.Precio:=4600.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"AeroArg NA-18");  Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=358; Eq.Origen:=Internacional;  Eq.Precio:=6400.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Michelin Air X"); Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=230; Rep.CodigoAvion:=104; Rep.Tipo:=Filtro_Aceite; Str(Rep.Descripcion,Rep.LongDesc,"Filtro aceite hidraulico");     CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=230; Eq.CodigoAvion:=104;
   Eq.Codigo:=359; Eq.Origen:=Nacional;       Eq.Precio:=2900.0; Eq.CantUsadaAnio:=4; Str(Eq.Marca,Eq.LongMarca,"AcmeParts FH-33"); Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=360; Eq.Origen:=Internacional;  Eq.Precio:=4300.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Bosch OH-110");   Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=231; Rep.CodigoAvion:=104; Rep.Tipo:=Filtro_Aire;   Str(Rep.Descripcion,Rep.LongDesc,"Filtro aire cabina");           CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=231; Eq.CodigoAvion:=104;
   Eq.Codigo:=361; Eq.Origen:=Nacional;       Eq.Precio:=1800.0; Eq.CantUsadaAnio:=5; Str(Eq.Marca,Eq.LongMarca,"RioFil AC-08");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=362; Eq.Origen:=Internacional;  Eq.Precio:=2900.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Mann CF-500");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=232; Rep.CodigoAvion:=104; Rep.Tipo:=Correa;        Str(Rep.Descripcion,Rep.LongDesc,"Correa accesorios");            CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=232; Eq.CodigoAvion:=104;
   Eq.Codigo:=363; Eq.Origen:=Nacional;       Eq.Precio:=3400.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"SurTec CA-22");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=364; Eq.Origen:=Internacional;  Eq.Precio:=5300.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Gates A-90");     Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);


   -- ---- AVION 105 (Super Etendard Mod 1) ----

   Rep.Codigo:=233; Rep.CodigoAvion:=105; Rep.Tipo:=Filtro_Aceite;  Str(Rep.Descripcion,Rep.LongDesc,"Filtro aceite motor");         CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=233; Eq.CodigoAvion:=105;
   Eq.Codigo:=365; Eq.Origen:=Nacional;       Eq.Precio:=2600.0; Eq.CantUsadaAnio:=8; Str(Eq.Marca,Eq.LongMarca,"AcmeParts FO-78"); Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=366; Eq.Origen:=Internacional;  Eq.Precio:=4000.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"Bosch OF-220");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=234; Rep.CodigoAvion:=105; Rep.Tipo:=Filtro_Aire;   Str(Rep.Descripcion,Rep.LongDesc,"Filtro aire admision");         CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=234; Eq.CodigoAvion:=105;
   Eq.Codigo:=367; Eq.Origen:=Nacional;       Eq.Precio:=1700.0; Eq.CantUsadaAnio:=6; Str(Eq.Marca,Eq.LongMarca,"RioFil AF-12");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=368; Eq.Origen:=Internacional;  Eq.Precio:=3000.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Mann C-2134");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=235; Rep.CodigoAvion:=105; Rep.Tipo:=Correa;        Str(Rep.Descripcion,Rep.LongDesc,"Correa distribucion");          CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=235; Eq.CodigoAvion:=105;
   Eq.Codigo:=369; Eq.Origen:=Nacional;       Eq.Precio:=3600.0; Eq.CantUsadaAnio:=5; Str(Eq.Marca,Eq.LongMarca,"SurTec CT-55");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=370; Eq.Origen:=Internacional;  Eq.Precio:=5600.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Gates T-180");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=236; Rep.CodigoAvion:=105; Rep.Tipo:=Bujia;         Str(Rep.Descripcion,Rep.LongDesc,"Bujia encendido");              CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=236; Eq.CodigoAvion:=105;
   Eq.Codigo:=371; Eq.Origen:=Nacional;       Eq.Precio:=2200.0; Eq.CantUsadaAnio:=10; Str(Eq.Marca,Eq.LongMarca,"PataCorp SP-4"); Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=372; Eq.Origen:=Internacional;  Eq.Precio:=3700.0; Eq.CantUsadaAnio:=4;  Str(Eq.Marca,Eq.LongMarca,"NGK BKR6E");     Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=237; Rep.CodigoAvion:=105; Rep.Tipo:=Neumatico;     Str(Rep.Descripcion,Rep.LongDesc,"Neumatico tren aterrizaje");    CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=237; Eq.CodigoAvion:=105;
   Eq.Codigo:=373; Eq.Origen:=Nacional;       Eq.Precio:=4800.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"AeroArg NA-18");  Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=374; Eq.Origen:=Internacional;  Eq.Precio:=7100.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Michelin Air X"); Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=238; Rep.CodigoAvion:=105; Rep.Tipo:=Filtro_Aceite; Str(Rep.Descripcion,Rep.LongDesc,"Filtro aceite hidraulico");     CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=238; Eq.CodigoAvion:=105;
   Eq.Codigo:=375; Eq.Origen:=Nacional;       Eq.Precio:=3000.0; Eq.CantUsadaAnio:=5; Str(Eq.Marca,Eq.LongMarca,"AcmeParts FH-33"); Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=376; Eq.Origen:=Internacional;  Eq.Precio:=4500.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Bosch OH-110");   Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=239; Rep.CodigoAvion:=105; Rep.Tipo:=Filtro_Aire;   Str(Rep.Descripcion,Rep.LongDesc,"Filtro aire cabina");           CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=239; Eq.CodigoAvion:=105;
   Eq.Codigo:=377; Eq.Origen:=Nacional;       Eq.Precio:=1900.0; Eq.CantUsadaAnio:=7; Str(Eq.Marca,Eq.LongMarca,"RioFil AC-08");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=378; Eq.Origen:=Internacional;  Eq.Precio:=3100.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"Mann CF-500");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=240; Rep.CodigoAvion:=105; Rep.Tipo:=Correa;        Str(Rep.Descripcion,Rep.LongDesc,"Correa accesorios");            CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=240; Eq.CodigoAvion:=105;
   Eq.Codigo:=379; Eq.Origen:=Nacional;       Eq.Precio:=3700.0; Eq.CantUsadaAnio:=4; Str(Eq.Marca,Eq.LongMarca,"SurTec CA-22");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=380; Eq.Origen:=Internacional;  Eq.Precio:=5800.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Gates A-90");     Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);


   -- ---- AVION 106 (Super Etendard Mod 2) ----

   Rep.Codigo:=241; Rep.CodigoAvion:=106; Rep.Tipo:=Filtro_Aceite;  Str(Rep.Descripcion,Rep.LongDesc,"Filtro aceite motor");         CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=241; Eq.CodigoAvion:=106;
   Eq.Codigo:=381; Eq.Origen:=Nacional;       Eq.Precio:=2300.0; Eq.CantUsadaAnio:=6; Str(Eq.Marca,Eq.LongMarca,"AcmeParts FO-78"); Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=382; Eq.Origen:=Internacional;  Eq.Precio:=3600.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Bosch OF-220");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=242; Rep.CodigoAvion:=106; Rep.Tipo:=Filtro_Aire;   Str(Rep.Descripcion,Rep.LongDesc,"Filtro aire admision");         CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=242; Eq.CodigoAvion:=106;
   Eq.Codigo:=383; Eq.Origen:=Nacional;       Eq.Precio:=1500.0; Eq.CantUsadaAnio:=4; Str(Eq.Marca,Eq.LongMarca,"RioFil AF-12");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=384; Eq.Origen:=Internacional;  Eq.Precio:=2600.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Mann C-2134");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=243; Rep.CodigoAvion:=106; Rep.Tipo:=Correa;        Str(Rep.Descripcion,Rep.LongDesc,"Correa distribucion");          CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=243; Eq.CodigoAvion:=106;
   Eq.Codigo:=385; Eq.Origen:=Nacional;       Eq.Precio:=3500.0; Eq.CantUsadaAnio:=5; Str(Eq.Marca,Eq.LongMarca,"SurTec CT-55");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=386; Eq.Origen:=Internacional;  Eq.Precio:=5400.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Gates T-180");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=244; Rep.CodigoAvion:=106; Rep.Tipo:=Bujia;         Str(Rep.Descripcion,Rep.LongDesc,"Bujia encendido");              CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=244; Eq.CodigoAvion:=106;
   Eq.Codigo:=387; Eq.Origen:=Nacional;       Eq.Precio:=2100.0; Eq.CantUsadaAnio:=8; Str(Eq.Marca,Eq.LongMarca,"PataCorp SP-4");  Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=388; Eq.Origen:=Internacional;  Eq.Precio:=3500.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"NGK BKR6E");      Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=245; Rep.CodigoAvion:=106; Rep.Tipo:=Neumatico;     Str(Rep.Descripcion,Rep.LongDesc,"Neumatico tren aterrizaje");    CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=245; Eq.CodigoAvion:=106;
   Eq.Codigo:=389; Eq.Origen:=Nacional;       Eq.Precio:=4400.0; Eq.CantUsadaAnio:=3; Str(Eq.Marca,Eq.LongMarca,"AeroArg NA-18");  Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=390; Eq.Origen:=Internacional;  Eq.Precio:=6500.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Michelin Air X"); Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=246; Rep.CodigoAvion:=106; Rep.Tipo:=Filtro_Aceite; Str(Rep.Descripcion,Rep.LongDesc,"Filtro aceite hidraulico");     CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=246; Eq.CodigoAvion:=106;
   Eq.Codigo:=391; Eq.Origen:=Nacional;       Eq.Precio:=2700.0; Eq.CantUsadaAnio:=5; Str(Eq.Marca,Eq.LongMarca,"AcmeParts FH-33"); Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=392; Eq.Origen:=Internacional;  Eq.Precio:=4100.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Bosch OH-110");   Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=247; Rep.CodigoAvion:=106; Rep.Tipo:=Filtro_Aire;   Str(Rep.Descripcion,Rep.LongDesc,"Filtro aire cabina");           CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=247; Eq.CodigoAvion:=106;
   Eq.Codigo:=393; Eq.Origen:=Nacional;       Eq.Precio:=1600.0; Eq.CantUsadaAnio:=6; Str(Eq.Marca,Eq.LongMarca,"RioFil AC-08");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=394; Eq.Origen:=Internacional;  Eq.Precio:=2800.0; Eq.CantUsadaAnio:=2; Str(Eq.Marca,Eq.LongMarca,"Mann CF-500");    Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

   Rep.Codigo:=248; Rep.CodigoAvion:=106; Rep.Tipo:=Correa;        Str(Rep.Descripcion,Rep.LongDesc,"Correa accesorios");            CriarLista(Rep.Equivalencias);
   Eq.CodigoRepuesto:=248; Eq.CodigoAvion:=106;
   Eq.Codigo:=395; Eq.Origen:=Nacional;       Eq.Precio:=3200.0; Eq.CantUsadaAnio:=4; Str(Eq.Marca,Eq.LongMarca,"SurTec CA-22");   Alta(Rep.Equivalencias,Eq);
   Eq.Codigo:=396; Eq.Origen:=Internacional;  Eq.Precio:=4900.0; Eq.CantUsadaAnio:=1; Str(Eq.Marca,Eq.LongMarca,"Gates A-90");     Alta(Rep.Equivalencias,Eq);
   Alta(LR,Rep);

end Cargar_Datos_Prueba;
