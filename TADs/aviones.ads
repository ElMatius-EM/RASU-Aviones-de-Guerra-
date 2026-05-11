-- PLANTILLA GENÉRICA DE TAD — SISTEMA RASU  (.ads)

with ListaEnlazada;
with Ada.Sequential_IO;

package aviones is

   -- ==== 1. TIPOS ENUMERADOS (Solo si se necesitan) ====
   -- type TipoXXXX is (Opcion1, Opcion2, Opcion3);

   -- ==== 2. REGISTRO PRINCIPAL ====
 
   type RegAvion is record
      Codigo     : Positive;         -- clave primaria (búsqueda/baja/modificar)
      Tipo     : String(1..20);    -- ajustar tamaño según el dato
      LongTipo : Positive;
      Modelo     : String(1..20);
      LongMod: positive;
      Anio : Positive;
   
   end record;

   -- ==== 3. LISTA ====
   package Lista_Avion is new ListaEnlazada(RegAvion);
   use Lista_Avion;

   subtype TAvion is TipoLista;

   -- ==== 4. EXCEPCIONES ====
   Avion_Duplicado     : exception;   -- se lanza en Alta si el Codigo ya existe
   Avion_No_Encontrado : exception;   -- se lanza en Baja/Modificar/Buscar

   -- ==== 5. OPERACIONES ====
   
   procedure Alta     (L: in out TAvion; Reg: in RegAvion);
   procedure Baja     (L: in out TAvion; Codigo: in Positive);
   procedure Modificar(L: in out TAvion; Codigo: in Positive; NuevoReg: in RegAvion);
   function  Buscar   (L: in Tavion;     Codigo: in Positive) return Regavion;
   function BuscarPorTipo (L: in TAvion; Tipo: in String) return regavion;
   procedure Listar   (L: in TAvion);

   -- ==== 6. PERSISTENCIA ====
   
   package aviones is new Ada.Sequential_IO(RegAvion);

   procedure Guardar(L: in TAvion;  Archivo: in String);
   procedure Cargar (L: out TAvion; Archivo: in String);

end aviones;