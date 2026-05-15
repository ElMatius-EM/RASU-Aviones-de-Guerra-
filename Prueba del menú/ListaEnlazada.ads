-- Lista Enlazada --
generic 
   type Tipoelem is private;
   
   package ListaEnlazada is
   type Tipolista is private;
      
   procedure Crear (Lista: out Tipolista);
   procedure Limpiar (Lista: in out Tipolista);
   
   function Vacia (Lista: Tipolista) return Boolean;
   function Info (Lista: in TipoLista) return TipoElem;
   function Sig (Lista: in Tipolista) return Tipolista;
   function Esta (Lista: Tipolista; Elemento: Tipoelem) return Boolean;
   
   procedure Insertar (Lista: in out Tipolista; Elemento: in Tipoelem);
   procedure InsertarPorFinal (Lista: in out TipoLista; Elemento: in TipoElem);

   procedure Suprimir (Lista: in out Tipolista; Elemento: in Tipoelem);
   procedure SuprimirPorFrente (Lista: in out Tipolista; Elemento: out Tipoelem);
   
   Listavacia: exception;
   
   private 
   type TipoNodo;
   type Tipolista is access Tiponodo;
   
   type TipoNodo is record
      Info: TipoElem;
      Sig: TipoLista;
   end record;
   
end ListaEnlazada;