-- =============================================================================
-- PLANTILLA GENÉRICA DE TAD — SISTEMA RASU  (.adb)
-- =============================================================================

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with NT_Console;          use NT_Console;

package body XXXX is

   -- ==== AUXILIAR INTERNO: BuscarPtr ====
   -- No va en el .ads porque es un detalle de implementación.
   -- Recibe una copia de la lista para recorrerla sin modificar L.
   -- Si lo encuentra, Enc=True y Ptr queda apuntando al nodo.
   procedure BuscarPtr(Ptr: in out TXXXX; Codigo: in Positive; Enc: out Boolean) is
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
   procedure Alta(L: in out TXXXX; Reg: in RegXXXX) is
      Ptr : TXXXX := L;
      Enc : Boolean;
   begin
      BuscarPtr(Ptr, Reg.Codigo, Enc);
      if Enc then
         raise XXXX_Duplicado;
      end if;
      InsertarPorFinal(L, Reg);
   end Alta;


   -- ==== BAJA ====
   procedure Baja(L: in out TXXXX; Codigo: in Positive) is
      Ptr : TXXXX := L;
      Enc : Boolean;
   begin
      BuscarPtr(Ptr, Codigo, Enc);
      if not Enc then
         raise XXXX_No_Encontrado;
      end if;
      Suprimir(L, Info(Ptr));
   end Baja;


   -- ==== MODIFICAR ====
   -- Se suprime el nodo viejo y se inserta unol nuevo al final.
   procedure Modificar(L: in out TXXXX; Codigo: in Positive; NuevoReg: in RegXXXX) is
      Ptr   : TXXXX := L;
      Enc   : Boolean;
      Viejo : RegXXXX;
   begin
      BuscarPtr(Ptr, Codigo, Enc);
      if not Enc then
         raise XXXX_No_Encontrado;
      end if;
      Viejo := Info(Ptr);
      Suprimir(L, Viejo);
      InsertarPorFinal(L, NuevoReg);
   end Modificar;

 -- ==== BUSCAR ====
   function Buscar(L: in TXXXX; Codigo: in Positive) return RegXXXX is
      Ptr : TXXXX := L;
      Enc : Boolean;
   begin
      BuscarPtr(Ptr, Codigo, Enc);
      if not Enc then
         raise XXXX_No_Encontrado;
      end if;
      return Info(Ptr);
   end Buscar;


   -- ==== LISTAR ====
   -- Campo(1..LongCampo) imprime solo los caracteres reales, sin espacios de más (osea no imprime basura)
   procedure Listar(L: in TXXXX) is
      Ptr : TXXXX := L;
   begin
      if Vacia(Ptr) then
         Set_Foreground(Red);
         Put_Line("No hay registros cargados.");
         Set_Foreground(White);
         return;
      end if;
      Set_Foreground(Yellow);
      Put_Line("========== LISTADO DE XXXX ==========");
      Set_Foreground(White);
      while not Vacia(Ptr) loop
         Put("Codigo : "); Put(Info(Ptr).Codigo, 1); New_Line;
         Put("Campo1 : "); Put(Info(Ptr).Campo1(1..Info(Ptr).LongCampo1)); New_Line;
         Put("Campo2 : "); Put(Info(Ptr).Campo2(1..Info(Ptr).LongCampo2)); New_Line;
         Put_Line("--------------------------------------");
         Ptr := Sig(Ptr);
      end loop;
   end Listar;


   -- ==== GUARDAR ====
   -- Create sobreescribe si el archivo ya existe
   procedure Guardar(L: in TXXXX; Archivo: in String) is
      Arch : ArchiXXXX.File_Type;
      Ptr  : TXXXX := L;
   begin
      ArchiXXXX.Create(Arch, ArchiXXXX.Out_File, Archivo);
      while not Vacia(Ptr) loop
         ArchiXXXX.Write(Arch, Info(Ptr));
         Ptr := Sig(Ptr);
      end loop;
      ArchiXXXX.Close(Arch);
   end Guardar;


   -- ==== CARGAR ====
   -- Name_Error silenciado: primera ejecución sin archivo → lista vacía, no es error.
   procedure Cargar(L: out TXXXX; Archivo: in String) is
      Arch : ArchiXXXX.File_Type;
      Elem : RegXXXX;
   begin
      Crear(L);
      ArchiXXXX.Open(Arch, ArchiXXXX.In_File, Archivo);
      while not ArchiXXXX.End_Of_File(Arch) loop
         ArchiXXXX.Read(Arch, Elem);
         InsertarPorFinal(L, Elem);
      end loop;
      ArchiXXXX.Close(Arch);
   exception
      when ArchiXXXX.Name_Error => null;
   end Cargar;

end XXXX;
