-- =============================================================================
-- TAD REPUESTOS — SISTEMA RASU  (.ads)
-- En este TAD cada nodo tiene una lista anidada de Equivalencias.
-- Por eso se usan dos archivos separados.
-- =============================================================================

with ListaEnlazada;
with Ada.Sequential_IO;
with Equivalencias; use Equivalencias;

package Repuestos is

   -- ==== 1. TIPOS ====
   type TipoRepuesto is (Filtro_Aceite, Filtro_Aire, Correa, Bujia, Neumatico);
   -- Agregar según enunciado


   -- ==== 2. REGISTRO EN MEMORIA ====
   -- El campo Equivalencias es una lista dinámica (contiene punteros).
   -- Por eso no puede ir directo a Sequential_IO → ver sección 6.
   type RegRepuesto is record
      Codigo        : Positive;
      Tipo          : TipoRepuesto;
      Descripcion   : String(1..50);
      LongDesc      : Natural;
      CodigoAvion   : Positive;
      Equivalencias : TEquivalencias;   -- lista anidada en memoria
   end record;


   -- ==== 3. REGISTRO PARA ARCHIVO repuestos.dat ====
   -- Mismo registro pero SIN el campo Equivalencias.
   -- Las equivalencias se guardan por separado en equivalencias.dat
   -- usando CodigoRepuesto como clave foránea.
   type TArchiRepuesto is record
      Codigo      : Positive;
      Tipo        : TipoRepuesto;
      Descripcion : String(1..50);
      LongDesc    : Natural;
      CodigoAvion : Positive;
   end record;


   -- ==== 4. LISTA ====
   package Lista_Repuestos is new ListaEnlazada(RegRepuesto);
   use Lista_Repuestos;

   subtype TRepuestos is TipoLista;


   -- ==== 5. EXCEPCIONES ====
   Repuesto_Duplicado     : exception;
   Repuesto_No_Encontrado : exception;

   -- ==== 6. OPERACIONES ====
 procedure Alta     (L: in out TRepuestos; Reg: in RegRepuesto);
   procedure Baja     (L: in out TRepuestos; Codigo: in Positive);
   procedure Modificar(L: in out TRepuestos; Codigo: in Positive; NuevoReg: in RegRepuesto);
   function  Buscar   (L: in TRepuestos;     Codigo: in Positive) return RegRepuesto;
   procedure Listar   (L: in TRepuestos);


   -- ==== 7. PERSISTENCIA — DOS ARCHIVOS ====
   -- Guardar:
   --   1. Escribe cada TArchiRepuesto (sin equiv) en repuestos.dat
   --   2. Escribe todas las equivalencias de todos los nodos en equivalencias.dat
   --      con CodigoRepuesto como clave (lo hace el TAD Equivalencias)
   -- Cargar:
   --   1. Lee repuestos.dat → reconstruye la lista con Equivalencias vacías
   --   2. Lee equivalencias.dat → por cada registro busca su repuesto
   --      por CodigoRepuesto y lo inserta en la lista interna
   --   IMPORTANTE: siempre se carga repuestos antes que equivalencias.
   package ArchiRepuesto is new Ada.Sequential_IO(TArchiRepuesto);

   procedure Guardar(L: in TRepuestos;  ArchivoRep: in String; ArchivoEquiv: in String);
   procedure Cargar (L: out TRepuestos; ArchivoRep: in String; ArchivoEquiv: in String);

end Repuestos;

