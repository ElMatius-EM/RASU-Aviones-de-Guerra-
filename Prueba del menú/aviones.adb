with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Integer_Text_Io;
use Ada.Integer_Text_Io;
with Nt_Console;
use Nt_Console;

package body Aviones is

   -- ==== AUXILIAR INTERNO: BuscarPtr ====
   procedure Buscarptr (
         Ptr    : in out Tavion;
         Codigo : in     Positive;
         Enc    :    out Boolean) is
   begin
      Enc := False;
      while not Vacia(Ptr) and then not Enc loop
         if Info(Ptr).Codigo = Codigo then
            Enc := True;
         else
            Ptr := Sig(Ptr);
         end if;
      end loop;
   end Buscarptr;


   -- ==== ALTA ====
   procedure Alta (
         L   : in out Tavion;
         Reg : in     Regavion) is
      Ptr : Tavion  := L;
      Enc : Boolean;
   begin
      Buscarptr(Ptr, Reg.Codigo, Enc);
      if Enc then
         raise Avion_Duplicado;
      end if;
      Insertarporfinal(L, Reg);
   end Alta;


   -- ==== BAJA ====
   procedure Baja (
         L      : in out Tavion;
         Codigo : in     Positive) is
      Ptr : Tavion  := L;
      Enc : Boolean;
   begin
      Buscarptr(Ptr, Codigo, Enc);
      if not Enc then
         raise Avion_No_Encontrado;
      end if;
      Suprimir(L, Info(Ptr));
   end Baja;


   -- ==== MODIFICAR ====
   procedure Modificar (
         L        : in out Tavion;
         Codigo   : in     Positive;
         Nuevoreg : in     Regavion) is
      Ptr   : Tavion   := L;
      Enc   : Boolean;
      Viejo : Regavion;
   begin
      Buscarptr(Ptr, Codigo, Enc);
      if not Enc then
         raise Avion_No_Encontrado;
      end if;
      Viejo := Info(Ptr);
      Suprimir(L, Viejo);
      Insertarporfinal(L, Nuevoreg);
   end Modificar;


   -- ==== BUSCAR ====
   function Buscar (
         L      : in     Tavion;
         Codigo : in     Positive)
     return Regavion is
      Ptr : Tavion  := L;
      Enc : Boolean;
   begin
      Buscarptr(Ptr, Codigo, Enc);
      if not Enc then
         raise Avion_No_Encontrado;
      end if;
      return Info(Ptr);
   end Buscar;


   -- ==== BUSCAR POR TIPO ====
   function Buscarportipo (
         L    : in     Tavion;
         Tipo : in     String)
     return Tavion is
      Ptr    : Tavion := L;
      Result : Tavion;
   begin
      Crear(Result);
      while not Vacia(Ptr) loop
         if Info(Ptr).Tipo(1..Info(Ptr).Longtipo) = Tipo then
            Insertarporfinal(Result, Info(Ptr));
         end if;
         Ptr := Sig(Ptr);
      end loop;
      return Result;
   end Buscarportipo;


   -- ==== LISTAR ====
   procedure Listar (
         L : in     Tavion) is
      Ptr : Tavion := L;
   begin
      if Vacia(Ptr) then
         Set_Foreground(Red);
         Put_Line("No hay aviones cargados.");
         Set_Foreground(White);
         return;
      end if;
      Set_Foreground(Yellow);
      Put_Line("=== LISTADO DE AVIONES ===");
      Set_Foreground(White);
      while not Vacia(Ptr) loop
         Put("Cod: ");
         Put(Info(Ptr).Codigo, 1);
         Put("  Tipo: ");
         Put_Line(Info(Ptr).Tipo(1..Info(Ptr).Longtipo));
         Put("Mod: ");
         Put(Info(Ptr).Modelo(1..Info(Ptr).Longmod));
         Put("  Anio: ");
         Put(Info(Ptr).Anio, 1);
         New_Line;
         Set_Foreground(Gray);
         Put_Line("--------------------------------");
         Set_Foreground(White);
         Ptr := Sig(Ptr);
      end loop;
   end Listar;


   function Flota_Vacia (
         L : in     Tavion)
     return Boolean is
   begin
      return Vacia(L);
   end Flota_Vacia;


   -- ==== GUARDAR ====
   procedure Guardar (
         L       : in     Tavion;
         Archivo : in     String) is
      Arch : Archiavion.File_Type;
      Ptr  : Tavion               := L;
   begin
      Archiavion.Create(Arch, Archiavion.Out_File, Archivo);
      while not Vacia(Ptr) loop
         Archiavion.Write(Arch, Info(Ptr));
         Ptr := Sig(Ptr);
      end loop;
      Archiavion.Close(Arch);
   end Guardar;


   -- ==== CARGAR ====
   procedure Cargar (
         L       :    out Tavion;
         Archivo : in     String) is
      Arch : Archiavion.File_Type;
      Elem : Regavion;
   begin
      Crear(L);
      Archiavion.Open(Arch, Archiavion.In_File, Archivo);
      while not Archiavion.End_Of_File(Arch) loop
         Archiavion.Read(Arch, Elem);
         Insertarporfinal(L, Elem);
      end loop;
      Archiavion.Close(Arch);
   exception
      when Archiavion.Name_Error =>
         null;
   end Cargar;

end Aviones;