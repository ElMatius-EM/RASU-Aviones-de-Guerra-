
with Ada.Text_Io;
use Ada.Text_Io;

package body Aviones is

   procedure Listar (
         L : in     Taviones) is
   begin
      Put_Line("   [INFO] Mostrando base de datos de la flota...");
      Put_Line("   1. IA-63 Pampa - Matricula: 101");
      Put_Line("   2. A-4AR Fightinghawk - Matricula: 205");
      Put_Line("   ---------------------------------------");
   end Listar;

end Aviones;