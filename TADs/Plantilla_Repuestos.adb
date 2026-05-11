-- =============================================================================
-- TAD REPUESTOS — SISTEMA RASU  (.adb)
-- =============================================================================

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with NT_Console;          use NT_Console;
with Equivalencias;       use Equivalencias;

package body Repuestos is

   -- ==== AUXILIAR INTERNO: BuscarPtr ====
   procedure BuscarPtr(Ptr: in out TRepuestos; Codigo: in Positive; Enc: out Boolean) is
   begin
      Enc := False;
      while not Vacia(Ptr) and then not Enc loop
         if Info(Ptr).Codigo = Codigo then
            Enc := True;
         else
            Ptr := Sig(Ptr);
         end if;
      end loop;
   end BuscarPtr;


   -- ==== ALTA ====
   procedure Alta(L: in out TRepuestos; Reg: in RegRepuesto) is
      Ptr : TRepuestos := L;
      Enc : Boolean;
   begin
      BuscarPtr(Ptr, Reg.Codigo, Enc);
      if Enc then raise Repuesto_Duplicado; end if;
      InsertarPorFinal(L, Reg);
   end Alta;


   -- ==== BAJA ====
   -- Elimina el repuesto y todas sus equivalencias (están dentro del nodo).
   procedure Baja(L: in out TRepuestos; Codigo: in Positive) is
      Ptr : TRepuestos := L;
      Enc : Boolean;
   begin
      BuscarPtr(Ptr, Codigo, Enc);
      if not Enc then raise Repuesto_No_Encontrado; end if;
      Suprimir(L, Info(Ptr));
   end Baja;


   -- ==== MODIFICAR ====
   -- Solo modifica los campos del repuesto, no toca la lista de equivalencias.
   procedure Modificar(L: in out TRepuestos; Codigo: in Positive; NuevoReg: in RegRepuesto) is
      Ptr   : TRepuestos := L;
      Enc   : Boolean;
      Viejo : RegRepuesto;
      Nuevo : RegRepuesto := NuevoReg;
   begin
      BuscarPtr(Ptr, Codigo, Enc);
 if not Enc then raise Repuesto_No_Encontrado; end if;
      Viejo := Info(Ptr);
      Nuevo.Equivalencias := Viejo.Equivalencias;   -- conservar equivalencias
      Suprimir(L, Viejo);
      InsertarPorFinal(L, Nuevo);
   end Modificar;


   -- ==== BUSCAR ====
   function Buscar(L: in TRepuestos; Codigo: in Positive) return RegRepuesto is
      Ptr : TRepuestos := L;
      Enc : Boolean;
   begin
      BuscarPtr(Ptr, Codigo, Enc);
      if not Enc then raise Repuesto_No_Encontrado; end if;
      return Info(Ptr);
   end Buscar;


   -- ==== LISTAR ====
   procedure Listar(L: in TRepuestos) is
      Ptr : TRepuestos := L;
   begin
      if Vacia(Ptr) then
         Set_Foreground(Red);
         Put_Line("No hay repuestos cargados.");
         Set_Foreground(White);
         return;
      end if;
      Set_Foreground(Yellow);
      Put_Line("========== LISTADO DE REPUESTOS ==========");
      Set_Foreground(White);
      while not Vacia(Ptr) loop
         Put("Codigo      : "); Put(Info(Ptr).Codigo, 1); New_Line;
         Put("Tipo        : "); Put_Line(TipoRepuesto'Image(Info(Ptr).Tipo));
         Put("Descripcion : "); Put(Info(Ptr).Descripcion(1..Info(Ptr).LongDesc)); New_Line;
         Put("Cod. Avion  : "); Put(Info(Ptr).CodigoAvion, 1); New_Line;
         Put_Line("------------------------------------------");
         Ptr := Sig(Ptr);
      end loop;
   end Listar;


   -- ==== GUARDAR ====
   -- Pasada 1: escribe cada repuesto (sin equiv) en repuestos.dat
   -- Pasada 2: por cada nodo llama a GuardarEquivalencias del TAD Equivalencias,
   --           que escribe en equivalencias.dat con CodigoRepuesto como clave foránea.
   procedure Guardar(L: in TRepuestos; ArchivoRep: in String; ArchivoEquiv: in String) is
      ArchRep  : ArchiRepuesto.File_Type;
      Ptr      : TRepuestos := L;
      Primera  : Boolean := True;
      RegArchi : TArchiRepuesto;
   begin
      -- Pasada 1: repuestos.dat
      ArchiRepuesto.Create(ArchRep, ArchiRepuesto.Out_File, ArchivoRep);
      while not Vacia(Ptr) loop
         RegArchi.Codigo      := Info(Ptr).Codigo;
         RegArchi.Tipo        := Info(Ptr).Tipo;
         RegArchi.Descripcion := Info(Ptr).Descripcion;
RegArchi.LongDesc    := Info(Ptr).LongDesc;
         RegArchi.CodigoAvion := Info(Ptr).CodigoAvion;
         ArchiRepuesto.Write(ArchRep, RegArchi);
         Ptr := Sig(Ptr);
      end loop;
      ArchiRepuesto.Close(ArchRep);

      -- Pasada 2: equivalencias.dat
      -- Primera=True indica que hay que crear el archivo; False que hay que hacer append.
      Ptr := L;
      while not Vacia(Ptr) loop
         GuardarEquivalencias(Info(Ptr).Equivalencias,
                              Info(Ptr).Codigo,
                              ArchivoEquiv,
                              Primera);
         Primera := False;
         Ptr := Sig(Ptr);
      end loop;
   end Guardar;


   -- ==== CARGAR ====
   -- Pasada 1: lee repuestos.dat → reconstruye L con listas de equiv vacías
   -- Pasada 2: lee equivalencias.dat → inserta cada equiv en su repuesto
   procedure Cargar(L: out TRepuestos; ArchivoRep: in String; ArchivoEquiv: in String) is
      ArchRep   : ArchiRepuesto.File_Type;
      ElemRep   : TArchiRepuesto;
      RegMem    : RegRepuesto;

      ArchEquiv : ArchiEquivalencia.File_Type;   -- declarado en TAD Equivalencias
      ElemEquiv : TArchiEquivalencia;
      PtrRep    : TRepuestos;
      Enc       : Boolean;
      Nodo      : RegRepuesto;
   begin
      -- Pasada 1: cargar repuestos
      Crear(L);
      ArchiRepuesto.Open(ArchRep, ArchiRepuesto.In_File, ArchivoRep);
      while not ArchiRepuesto.End_Of_File(ArchRep) loop
         ArchiRepuesto.Read(ArchRep, ElemRep);
         RegMem.Codigo      := ElemRep.Codigo;
         RegMem.Tipo        := ElemRep.Tipo;
         RegMem.Descripcion := ElemRep.Descripcion;
         RegMem.LongDesc    := ElemRep.LongDesc;
         RegMem.CodigoAvion := ElemRep.CodigoAvion;
         Crear(RegMem.Equivalencias);   -- lista interna vacía; se llena en pasada 2
         InsertarPorFinal(L, RegMem);
      end loop;
      ArchiRepuesto.Close(ArchRep);

      -- Pasada 2: cargar equivalencias y conectarlas a su repuesto
      ArchiEquivalencia.Open(ArchEquiv, ArchiEquivalencia.In_File, ArchivoEquiv);
      while not ArchiEquivalencia.End_Of_File(ArchEquiv) loop
         ArchiEquivalencia.Read(ArchEquiv, ElemEquiv);
         PtrRep := L;
         BuscarPtr(PtrRep, ElemEquiv.CodigoRepuesto, Enc);
         if Enc then
            Nodo := Info(PtrRep);
            InsertarEquiv(Nodo.Equivalencias, De_ArchiEquiv(ElemEquiv));
Suprimir(L, Info(PtrRep));
            InsertarPorFinal(L, Nodo);
         end if;
      end loop;
      ArchiEquivalencia.Close(ArchEquiv);

   exception
      when ArchiRepuesto.Name_Error    => null;
      when ArchiEquivalencia.Name_Error => null;
   end Cargar;

end Repuestos;

