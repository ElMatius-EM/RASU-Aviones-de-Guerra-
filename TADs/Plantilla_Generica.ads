-- PLANTILLA GENÉRICA DE TAD — SISTEMA RASU  (.ads)

with ListaEnlazada;
with Ada.Sequential_IO;

package XXXX is

   -- ==== 1. TIPOS ENUMERADOS (Solo si se necesitan) ====
   -- type TipoXXXX is (Opcion1, Opcion2, Opcion3);

   -- ==== 2. REGISTRO PRINCIPAL ====
   -- Cada campo de texto lleva su LongXXXX asociado.
   -- Ada usa strings de longitud fija: String(1..N) + Natural para la longitud real.
   -- Al imprimir se usa Campo(1..LongCampo); al comparar también.
   type RegXXXX is record
      Codigo     : Positive;         -- clave primaria (búsqueda/baja/modificar)
      Campo1     : String(1..50);    -- ajustar tamaño según el dato
      LongCampo1 : Natural;
      Campo2     : String(1..100);
      LongCampo2 : Natural;
      -- CampoNum  : Positive;       -- numérico: sin Long asociado
      -- CampoEnum : TipoXXXX;       -- enumerado: sin Long asociado
   end record;

   -- ==== 3. LISTA ====
   package Lista_XXXX is new ListaEnlazada(RegXXXX);
   use Lista_XXXX;

   subtype TXXXX is TipoLista;

   -- ==== 4. EXCEPCIONES ====
   XXXX_Duplicado     : exception;   -- se lanza en Alta si el Codigo ya existe
   XXXX_No_Encontrado : exception;   -- se lanza en Baja/Modificar/Buscar

   -- ==== 5. OPERACIONES ====
   -- La lista siempre entra como parámetro (nunca variable global).
   -- "in out" cuando la operación modifica la lista, "in" cuando solo consulta.

   procedure Alta     (L: in out TXXXX; Reg: in RegXXXX);
   procedure Baja     (L: in out TXXXX; Codigo: in Positive);
   procedure Modificar(L: in out TXXXX; Codigo: in Positive; NuevoReg: in RegXXXX);
   function  Buscar   (L: in TXXXX;     Codigo: in Positive) return RegXXXX;
   procedure Listar   (L: in TXXXX);

   -- ==== 6. PERSISTENCIA ====
   -- Sequential_IO instanciado con el registro. Como RegXXXX no tiene punteros,
   -- se serializa directo — no necesitamos un tipo TArchi separado.
   package ArchiXXXX is new Ada.Sequential_IO(RegXXXX);

   procedure Guardar(L: in TXXXX;  Archivo: in String);
   procedure Cargar (L: out TXXXX; Archivo: in String);

end XXXX;
