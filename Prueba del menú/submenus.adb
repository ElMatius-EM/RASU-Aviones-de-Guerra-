--=============================--
--========= SUBMENÚS ==========--
--=============================--
with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Integer_Text_Io;
use Ada.Integer_Text_Io;
with Ada.Io_Exceptions;
with Nt_Console;
use Nt_Console;
with Aviones;
use Aviones;

package body Submenus is

   -------------------------------------------------------------------
   -- UI: marco general del módulo
   -------------------------------------------------------------------
   procedure Dibujar_Marco_Modulo (
         Titulo : in     String) is
   begin
      Clear_Screen;
      Set_Foreground(Light_Cyan);
      Goto_Xy(2, 1);
      Put("+--------------------------------------------------------------------------+");
      Goto_Xy(2, 2);
      Put("|");
      Goto_Xy(77, 2);
      Put("|");
      Goto_Xy(2, 3);
      Put("+--------------------------------------------------------------------------+");
      Set_Foreground(White);
      Goto_Xy(4, 2);
      Put("[ RASU ] Sistema Tactico de Flota");
      Set_Foreground(Light_Green);
      Goto_Xy(50, 2);
      Put("Modulo: " & Titulo);
      Set_Foreground(Cyan);
      for Y in 4 .. 22 loop
         Goto_Xy(2, Y);
         Put("|");
         Goto_Xy(29, Y);
         Put("|");
         Goto_Xy(77, Y);
         Put("|");
      end loop;
      Goto_Xy(2, 23);
      Put("+---------------------------+");
      Goto_Xy(29, 23);
      Put("+-----------------------------------------------+");
      Set_Foreground(Gray);
      Goto_Xy(4, 5);
      Put("OPERACIONES");
      Set_Foreground(Yellow);
      Goto_Xy(2, 25);
      Put("Navegacion >> ");
      Set_Foreground(Gray);
      Put("[FLECHAS para navegar | ENTER para seleccionar]");
   end Dibujar_Marco_Modulo;

   procedure Limpiar_Area_Contenido is
   begin
      Set_Foreground(White);
      for Y in 5 .. 22 loop
         Goto_Xy(31, Y);
         Put("                                              ");
      end loop;
   end Limpiar_Area_Contenido;


   function Leer_Avion return Regavion is
      Reg : Regavion;
   begin

      Goto_Xy(31, 8);
      Set_Foreground(White);
      Put("Tipo      : ");
      Set_Foreground(Cyan);
      Get_Line(Reg.Tipo, Reg.Longtipo);
      Goto_Xy(31, 9);
      Set_Foreground(White);
      Put("Modelo    : ");
      Set_Foreground(Cyan);
      Get_Line(Reg.Modelo, Reg.Longmod);
      loop
         begin
            Goto_Xy(31, 10);
            Set_Foreground(White);
            Put("Anio      :           ");
            Goto_Xy(31, 10);
            Put("Anio      : ");
            Set_Foreground(Cyan);
            Get(Reg.Anio);
            Skip_Line;
            exit;
         exception
            when Ada.Io_Exceptions.Data_Error =>
               Skip_Line;
               Goto_Xy(31, 11);
               Set_Foreground(Red);
               Put("Anio invalido. Intente de nuevo.");
               Set_Foreground(White);
         end;
      end loop;
      return Reg;
   end Leer_Avion;



   -------------------------------------------------------------------
   -- GESTION AVIONES
   -------------------------------------------------------------------
   procedure Gestion_Aviones (
         Flota : in out Tavion) is
      Opcion_Actual : Integer   := 1;
      Tecla         : Character;
      Salir         : Boolean   := False;

      procedure Pintar_Menu_Lateral (
            Sel : Integer) is
         procedure Item (
               Fila     : Integer;
               Texto    : String;
               Idx      : Integer;
               Es_Salir : Boolean) is
         begin
            Goto_Xy(4, Fila);
            if Sel = Idx then
               Set_Foreground(Light_Green);
               Put("> " & Texto);
            else
               if Es_Salir then
                  Set_Foreground(Light_Red);
               else
                  Set_Foreground(White);
               end if;
               Put("  " & Texto);
            end if;
         end Item;
      begin
         Item(7,  "Alta de Avion     ", 1, False);
         Item(9,  "Baja de Avion     ", 2, False);
         Item(11, "Modificar Avion   ", 3, False);
         Item(13, "Buscar por Codigo ", 4, False);
         Item(15, "Listar Flota      ", 5, False);
         Item(21, "Volver al Inicio  ", 6, True);
      end Pintar_Menu_Lateral;

   begin
      Set_Cursor(False);
      loop
         Dibujar_Marco_Modulo("AVIONES");
         Set_Foreground(White);
         Goto_Xy(31, 5);
         Put("GESTION DE AERONAVES");
         Set_Foreground(Gray);
         Goto_Xy(31, 7);
         Put("Utilice el panel lateral para administrar");
         Goto_Xy(31, 8);
         Put("los activos aereos de la region sur.");

         -- Navegación por flechas
         loop
            Pintar_Menu_Lateral(Opcion_Actual);
            Tecla := Get_Key;
            if Tecla = Character'Val(0) or Tecla = Character'Val(224) then
               Tecla := Get_Key;
            end if;
            if Tecla = Key_Up then
               if Opcion_Actual > 1 then
                  Opcion_Actual := Opcion_Actual - 1;
               else
                  Opcion_Actual := 6;
               end if;
            elsif Tecla = Key_Down then
               if Opcion_Actual < 6 then
                  Opcion_Actual := Opcion_Actual + 1;
               else
                  Opcion_Actual := 1;
               end if;
            elsif Tecla = Character'Val(13) or Tecla = Character'Val(10) then
               exit;
            end if;
         end loop;

         -- Ejecutar opción
         case Opcion_Actual is

            when 1 =>   -- ALTA
               Limpiar_Area_Contenido;
               Set_Cursor(True);
               Goto_Xy(31, 5);
               Set_Foreground(Yellow);
               Put("--- ALTA DE AVION ---");
               declare
                  Reg    : Regavion;
                  Codigo : Positive;
               begin
                  Goto_Xy(31, 7);
                  Set_Foreground(White);
                  Put("Codigo    : ");
                  Set_Foreground(Cyan);
                  Get(Codigo);
                  Skip_Line;
                  Reg        := Leer_Avion;
                  Reg.Codigo := Codigo;
                  Alta(Flota, Reg);
                  Goto_Xy(31, 14);
                  Set_Foreground(Green);
                  Put("Avion registrado exitosamente.");
               exception
                  when Avion_Duplicado =>
                     Goto_Xy(31, 14);
                     Set_Foreground(Red);
                     Put("ERROR: El codigo ya existe.");
               end;
               Set_Foreground(Gray);
               Goto_Xy(31, 22);
               Put("Presione ENTER para continuar...");
               Set_Cursor(False);
               Tecla := Get_Key;

            when 2 =>   -- BAJA
               Clear_Screen;
               Set_Cursor(True);
               Set_Foreground(Yellow);
               Put_Line("--- BAJA DE AVION ---");
               New_Line;
               Listar(Flota);
               New_Line;
               declare
                  Codigo : Positive;
               begin
                  Set_Foreground(White);
                  Put("Codigo a eliminar: ");
                  Set_Foreground(Cyan);
                  Get(Codigo);
                  Skip_Line;
                  Baja(Flota, Codigo);
                  Set_Foreground(Green);
                  Put_Line("Avion eliminado correctamente.");
               exception
                  when Avion_No_Encontrado =>
                     Set_Foreground(Red);
                     Put_Line("ERROR: Codigo no encontrado.");
                  when Ada.Io_Exceptions.Data_Error =>
                     Skip_Line;
                     Set_Foreground(Red);
                     Put_Line("ERROR: Codigo invalido.");
               end;
               Set_Foreground(Gray);
               Put("Presione ENTER para continuar...");
               Set_Cursor(False);
               Tecla := Get_Key;

            when 3 =>   -- MODIFICAR
               Limpiar_Area_Contenido;
               Set_Cursor(True);
               Goto_Xy(31, 5);
               Set_Foreground(Yellow);
               Put("--- MODIFICAR AVION ---");
               declare
                  Codigo   : Positive;
                  Nuevoreg : Regavion;
               begin
                  Goto_Xy(31, 7);
                  Set_Foreground(White);
                  Put("Codigo a modificar: ");
                  Set_Foreground(Cyan);
                  Get(Codigo);
                  Skip_Line;
                  Nuevoreg        := Leer_Avion;
                  Nuevoreg.Codigo := Codigo;
                  Modificar(Flota, Codigo, Nuevoreg);
                  Goto_Xy(31, 18);
                  Set_Foreground(Green);
                  Put("Avion modificado correctamente.");
               exception
                  when Avion_No_Encontrado =>
                     Goto_Xy(31, 18);
                     Set_Foreground(Red);
                     Put("ERROR: Codigo no encontrado.");
                  when Ada.Io_Exceptions.Data_Error =>
                     Skip_Line;
                     Goto_Xy(31, 18);
                     Set_Foreground(Red);
                     Put("ERROR: Codigo invalido.");
               end;
               Set_Foreground(Gray);
               Goto_Xy(31, 22);
               Put("Presione ENTER para continuar...");
               Set_Cursor(False);
               Tecla := Get_Key;


            when 4 =>   -- BUSCAR POR CODIGO
               Limpiar_Area_Contenido;
               Set_Cursor(True);
               Goto_Xy(31, 5);
               Set_Foreground(Yellow);
               Put("--- BUSCAR AVION ---");
               declare
                  Codigo : Positive;
                  Av     : Regavion;
               begin
                  Goto_Xy(31, 7);
                  Set_Foreground(White);
                  Put("Codigo: ");
                  Set_Foreground(Cyan);
                  Get(Codigo);
                  Skip_Line;
                  Av := Buscar(Flota, Codigo);
                  Goto_Xy(31, 9);
                  Set_Foreground(White);
                  Put("Tipo   : ");
                  Put(Av.Tipo(1..Av.Longtipo));
                  New_Line;
                  Goto_Xy(31, 10);
                  Put("Modelo : ");
                  Put(Av.Modelo(1..Av.Longmod));
                  New_Line;
                  Goto_Xy(31, 11);
                  Put("Anio   : ");
                  Put(Av.Anio, 1);
                  New_Line;
               exception
                  when Avion_No_Encontrado =>
                     Goto_Xy(31, 9);
                     Set_Foreground(Red);
                     Put("ERROR: Codigo no encontrado.");
                  when Ada.Io_Exceptions.Data_Error =>
                     Skip_Line;
                     Goto_Xy(31, 9);
                     Set_Foreground(Red);
                     Put("ERROR: Codigo invalido.");
               end;
               Set_Foreground(Gray);
               Goto_Xy(31, 22);
               Put("Presione ENTER para continuar...");
               Set_Cursor(False);
               Tecla := Get_Key;

            when 5 =>   -- LISTAR
               Clear_Screen;
               Set_Cursor(True);
               Listar(Flota);
               Set_Foreground(Gray);
               New_Line;
               Put("Presione ENTER para continuar...");
               Set_Cursor(False);
               Tecla := Get_Key;


            when 6 =>   -- VOLVER
               Guardar(Flota, "aviones.dat");
               Salir := True;

            when others =>
               null;
         end case;

         exit when Salir;
      end loop;
      Set_Cursor(True);
   end Gestion_Aviones;

end Submenus;