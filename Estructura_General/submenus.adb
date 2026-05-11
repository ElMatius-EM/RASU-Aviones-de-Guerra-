--=============================--
        --========= SUBMENÚS ==========--
        --=============================--  
with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Characters.Handling, NT_Console, Aviones;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Characters.Handling, NT_Console, Aviones;

package body Submenus is

   -------------------------------------------------------------------
   -- PROCEDIMIENTOS PRIVADOS DE UI (Estética unificada)
   -------------------------------------------------------------------
   
   procedure Dibujar_Marco_Modulo(Titulo : String) is
   begin
      Clear_Screen;
      -- Navbar Superior
      Set_Foreground(Light_Cyan);
      Goto_XY(2, 1); Put("+--------------------------------------------------------------------------+");
      Goto_XY(2, 2); Put("|"); Goto_XY(77, 2); Put("|");
      Goto_XY(2, 3); Put("+--------------------------------------------------------------------------+");
      
      Set_Foreground(White);
      Goto_XY(4, 2); Put("[ RASU ] Sistema Tactico de Flota");
      Set_Foreground(Light_Green);
      Goto_XY(50, 2); Put("Modulo: " & Titulo);
      
      -- Estructura Lateral y Principal
      Set_Foreground(Cyan);
      for Y in 4 .. 22 loop
         Goto_XY(2, Y); Put("|");
         Goto_XY(29, Y); Put("|"); 
         Goto_XY(77, Y); Put("|");
      end loop;
      Goto_XY(2, 23); Put("+---------------------------+");
      Goto_XY(29, 23); Put("+-----------------------------------------------+");
      
      Set_Foreground(Gray);
      Goto_XY(4, 5); Put("OPERACIONES");
      
      Set_Foreground(Yellow);
      Goto_XY(2, 25); Put("Navegacion >> ");
      Set_Foreground(Gray);
      Put("[FLECHAS para navegar | ENTER para seleccionar]");
   end Dibujar_Marco_Modulo;

   procedure Limpiar_Area_Contenido is
   begin
      Set_Foreground(White);
      for Y in 5 .. 22 loop
         Goto_XY(31, Y); Put("                                              ");
      end loop;
   end Limpiar_Area_Contenido;



   procedure Gestion_Aviones(Flota: in out TAviones) is
      Opcion_Actual : Integer := 1;
      Tecla         : Character;
      Salir         : Boolean := False;

      procedure Pintar_Menu_Lateral(Sel : Integer) is
         procedure Item(Fila: Integer; Texto: String; Idx: Integer; Es_Salir: Boolean) is
         begin
            Goto_XY(4, Fila);
            if Sel = Idx then
               Set_Foreground(Light_Green); Put("> " & Texto);
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
         
         -- Mensaje de bienvenida
         Set_Foreground(White);
         Goto_XY(31, 5); Put("GESTION DE AERONAVES");
         Set_Foreground(Gray);
         Goto_XY(31, 7); Put("Utilice el panel lateral para administrar");
         Goto_XY(31, 8); Put("los activos aereos de la region sur.");

         -- Bucle de navegación
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

         -- Ejecución de la opción
         case Opcion_Actual is
            when 1 => 
               Limpiar_Area_Contenido;
               Set_Cursor(True);
               Goto_XY(31, 5); Set_Foreground(Yellow); Put("--- FORMULARIO DE ALTA ---");
               Goto_XY(31, 7); Set_Foreground(White); Put("Simulando lectura de datos...");
               delay 1.0;
               Set_Cursor(False);

            when 5 => 
               Limpiar_Area_Contenido;
               Goto_XY(31, 5); Put("--- LISTADO DE FLOTA ---");
               Listar(Flota); 
               delay 1.5;

            when 6 => 
               Salir := True;
            when others => 
               null;
         end case;

         exit when Salir;
      end loop;
      Set_Cursor(True);
   end Gestion_Aviones;

end Submenus;