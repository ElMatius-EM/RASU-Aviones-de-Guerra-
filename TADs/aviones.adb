-- =============================================================================
-- PLANTILLA GENÉRICA DE TAD - SISTEMA RASU  (.adb)
-- =============================================================================

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with NT_Console;          use NT_Console;

package body aviones is

   -- ==== AUXILIAR INTERNO: BuscarPtr ====
   -- No va en el .ads porque es un detalle de implementación.
   -- Recibe una copia de la lista para recorrerla sin modificar L.
   -- Si lo encuentra, Enc=True y Ptr queda apuntando al nodo.
   procedure BuscarPtr(Ptr: in out TAvion; Codigo: in Positive; Enc: out Boolean) is
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
   procedure Alta(L: in out TAvion; Reg: in RegAvion) is
      Ptr : TAvion := L;
      Enc : Boolean;
   begin
      BuscarPtr(Ptr, Reg.Codigo, Enc);
      if Enc then
         raise Avion_Duplicado;
      end if;
      Insertar(L, Reg);
   end Alta;


   -- ==== BAJA ====
   procedure Baja(L: in out TAvion; Codigo: in Positive) is
      Ptr : TAvion := L;
      Enc : Boolean;
   begin
      BuscarPtr(Ptr, Codigo, Enc);
      if not Enc then
         raise Avion_No_Encontrado;
      end if;
      Suprimir(L, Info(Ptr));
   end Baja;


   -- ==== MODIFICAR ====
   -- Se suprime el nodo viejo y se inserta unol nuevo al final.
   procedure Modificar(L: in out TAvion; Codigo: in Positive; NuevoReg: in RegAvion) is
      Ptr   : TAvion := L;
      Enc   : Boolean;
      Viejo : RegAvion;
   begin
      BuscarPtr(Ptr, Codigo, Enc);
      if not Enc then
         raise Avion_No_Encontrado;
      end if;
      Viejo := Info(Ptr);
      Suprimir(L, Viejo);
      Insertar(L, NuevoReg);
   end Modificar;

 -- ==== BUSCAR ====
   function Buscar(L: in TAvion; Codigo: in Positive) return RegAvion is
      Ptr : TAvion := L;
      Enc : Boolean;
   begin
      BuscarPtr(Ptr, Codigo, Enc);
      if not Enc then
         raise Avion_No_Encontrado;
      end if;
      return Info(Ptr);
   end Buscar;


   function Buscarportipo(L: in Tavion; Tipo: in String)  return tavion is
  
   Ptr : Tavion := L;
   Resul:Tavion;
   
begin
   while not Vacia(Ptr) loop
      if Info(Ptr).Tipo(1..Info(Ptr).LongTipo) = Tipo then
         insertarporfinal(resul,info(ptr));
      end if;
      Ptr := Sig(Ptr);
   end loop;
   return Resul;
    
  end BuscarPorTipo;

   -- ==== LISTAR ====
   -- Campo(1..LongCampo) imprime solo los caracteres reales, sin espacios de más (osea no imprime basura)
   procedure Listar(L: in TAvion) is
      Ptr : TAvion := L;
   begin
      if Vacia(Ptr) then
         Set_Foreground(Red);
         Put_Line("No hay registros cargados.");
         Set_Foreground(White);
         return;
      end if;
      Set_Foreground(Yellow);
      Put_Line("========== LISTADO DE AVIONES==========");
      Set_Foreground(White);
      while not Vacia(Ptr) loop
         Put("Codigo : "); Put(Info(Ptr).Codigo, 1); New_Line;
         Put("Tipo : "); Put(Info(Ptr).Tipo(1..Info(Ptr).LongTipo)); New_Line;
         Put("Modelo : "); Put(Info(Ptr).Modelo(1..Info(Ptr).LongMod)); New_Line;
         Put_Line("--------------------------------------");
         Ptr := Sig(Ptr);
      end loop;
   end Listar;


   -- ==== GUARDAR ====
   -- Create sobreescribe si el archivo ya existe
   procedure Guardar(L: in TAvion; Archivo: in String) is
      Arch : archiaviones.File_Type;
      Ptr  : TAvion := L;
   begin
      archiaviones.Create(Arch, archiaviones.Out_File, Archivo);
      while not Vacia(Ptr) loop
         archiaviones.Write(Arch, Info(Ptr));
         Ptr := Sig(Ptr);
      end loop;
      archiaviones.Close(Arch);
   end Guardar;


   -- ==== CARGAR ====
   -- Name_Error silenciado: primera ejecución sin archivo ? lista vacía, no es error.
   procedure Cargar(L: out TAvion; Archivo: in String) is
      Arch : archiaviones.File_Type;
      Elem : RegAvion;
   begin
      Crear(L);
      archiaviones.Open(Arch, archiaviones.In_File, Archivo);
      while not archiaviones.End_Of_File(Arch) loop
         archiaviones.Read(Arch, Elem);
         Insertar(L, Elem);
      end loop;
      archiaviones.Close(Arch);
   exception
      when archiaviones.Name_Error => null;
   end Cargar;

end aviones;