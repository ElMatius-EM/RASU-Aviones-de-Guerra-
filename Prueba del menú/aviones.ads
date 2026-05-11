package Aviones is
   type TAviones is private;
   procedure Listar(L: TAviones);
private
   type TAviones is new Integer; -- Solo para que compile
end Aviones;