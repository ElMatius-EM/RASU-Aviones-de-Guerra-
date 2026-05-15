with Ada.Text_Io;
use Ada.Text_Io;
with Nt_Console;
use Nt_Console;
with Aviones;
use Aviones;
with Submenus;
use Submenus;
with Cargar_Datos_Prueba;

procedure Menu_Principal is
   Opcion_Actual : Integer   := 1;
   Tecla         : Character;
   Salir         : Boolean   := False;

   Flota : Tavion; -- TAvion, no TAviones

   procedure Dibujar_Estructura_Estatica is
   begin
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
      Put("[ RASU ] Panel de Control Central");
      Set_Foreground(Light_Green);
      Goto_Xy(50, 2);
      Put("Sistema de Flota Aerea | [Online]");
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
      Put("MENU NAVEGACION");
      Set_Foreground(White);
      Goto_Xy(31, 5);
      Put("BIENVENIDO AL SISTEMA RASU");
      Set_Foreground(Gray);
      Goto_Xy(31, 7);
      Put("Seleccione un modulo del menu lateral");
      Goto_Xy(31, 8);
      Put("para comenzar a operar.");
      Set_Foreground(Yellow);
      Goto_Xy(2, 25);
      Put("Navegacion >> ");
      Set_Foreground(Gray);
      Put("[Usar las FLECHAS ARRIBA/ABAJO y presionar ENTER]");
   end Dibujar_Estructura_Estatica;

   procedure Actualizar_Menu (
         Seleccion : Integer) is
      procedure Pintar_Opcion (
            Fila      : Natural;
            Numero    : String;
            Texto     : String;
            Index     : Integer;
            Es_Salida : Boolean) is
      begin
         Goto_Xy(4, Fila);
         if Seleccion = Index then
            Set_Foreground(Light_Green);
            Put("> [" & Numero & "] " & Texto & "    ");
         else
            if Es_Salida then
               Set_Foreground(Light_Red);
            else
               Set_Foreground(White);
            end if;
            Put("  [" & Numero & "] " & Texto & "    ");
         end if;
      end Pintar_Opcion;
   begin
      Pintar_Opcion(7,  "1", "Inicio",        1, False);
      Pintar_Opcion(9,  "2", "Flota Aviones", 2, False);
      Pintar_Opcion(11, "3", "Repuestos",     3, False);
      Pintar_Opcion(13, "4", "Equivalencias", 4, False);
      Pintar_Opcion(15, "5", "Reportes",      5, False);
      Pintar_Opcion(21, "0", "Salir",         6, True);
   end Actualizar_Menu;

begin
   Set_Cursor(False);
   Clear_Screen;

   -- Cargar datos al iniciar
   Cargar(Flota, "aviones.dat");
   if Flota_Vacia(Flota)then
      Cargar_Datos_Prueba(Flota);
      Guardar(Flota, "aviones.dat");
   end if;
   -- Agregar aquí: Cargar(Repuestos, ...) y Cargar(Equivalencias, ...) cuando estén listos

   Dibujar_Estructura_Estatica;

   loop
      Actualizar_Menu(Opcion_Actual);
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

         case Opcion_Actual is
            when 2 =>
               Set_Foreground(Light_Green);
               Goto_Xy(31, 22);
               Put(">> Accediendo a Flota Aviones...          ");
               delay 0.5;
               Gestion_Aviones(Flota);
               Clear_Screen;
               Dibujar_Estructura_Estatica;

            when 6 =>
               -- Guardar todo antes de salir
               Guardar(Flota, "aviones.dat");


               Salir := True;

            when others =>
               Set_Foreground(Yellow);
               Goto_Xy(31, 22);
               Put(">> Modulo en desarrollo...                ");
               delay 0.8;
               Goto_Xy(31, 22);
               Put("                                          ");
         end case;
      end if;

      exit when Salir;
   end loop;

   Set_Cursor(True);
   Clear_Screen;

end Menu_Principal;