with Listaenlazada;
with Ada.Sequential_Io;

package Aviones is

   -- ==== 2. REGISTRO PRINCIPAL ====
   type Regavion is
      record
         Codigo   : Positive;
         Tipo     : String (1 .. 20);
         Longtipo : Natural;
         Modelo   : String (1 .. 20);
         Longmod  : Natural;
         Anio     : Positive;
      end record;

   -- ==== 3. LISTA ====
   package Lista_Avion is new Listaenlazada(Regavion);
   use Lista_Avion;

   subtype Tavion is Tipolista;

   -- ==== 4. EXCEPCIONES ====
   Avion_Duplicado     : exception;
   Avion_No_Encontrado : exception;

   -- ==== 5. OPERACIONES ====
   procedure Alta (
         L   : in out Tavion;
         Reg : in     Regavion);
   procedure Baja (
         L      : in out Tavion;
         Codigo : in     Positive);
   procedure Modificar (
         L        : in out Tavion;
         Codigo   : in     Positive;
         Nuevoreg : in     Regavion);
   procedure Listar (
         L : in     Tavion);

   function Buscar (
         L      : in     Tavion;
         Codigo : in     Positive)
     return Regavion;

   function Buscarportipo (
         L    : in     Tavion;
         Tipo : in     String)
     return Tavion;

   function Flota_Vacia (
         L : in     Tavion)
     return Boolean;

   -- ==== 6. PERSISTENCIA ====
   package Archiavion is new Ada.Sequential_Io(Regavion);
   -- nombre distinto al paquete

   procedure Guardar (
         L       : in     Tavion;
         Archivo : in     String);
   procedure Cargar (
         L       :    out Tavion;
         Archivo : in     String);

end Aviones;