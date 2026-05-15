
with Ada.Unchecked_Deallocation; 
package body ListaEnlazada is 
   
   procedure Free is 
   new Ada.Unchecked_Deallocation(TipoNodo, Tipolista);
   
   procedure Crear (Lista: out Tipolista) is
   begin
      Lista:= null;
   end Crear;

   procedure Limpiar (Lista: in out TipoLista) is
   Temp: TipoLista:= Lista;
   begin
      while Lista /= null
      loop
         Temp:= Lista;
         Lista:= Lista.Sig;
         Free (Temp);
      end loop;
   end Limpiar;

   function Vacia (Lista: in TipoLista) return Boolean is
   begin 
      return Lista = null;
   end Vacia;

   function Info (Lista: in TipoLista) return TipoElem is
   begin
      if Lista /= null then
         return Lista.Info;
      else
         raise ListaVacia; 
      end if;
   end Info;

   function Sig (Lista: in TipoLista) return TipoLista is
   begin
      if Lista = null then
         return null;
      else
         return Lista.Sig;
      end if;
   end Sig;

   function Esta (Lista: TipoLista; Elemento: TipoElem) return Boolean is
   Ptr: TipoLista:= Lista;
   begin -- recursivo
      if Vacia(Lista) then 
         return false;
      else 
         if Ptr /= null and then Ptr.Info = Elemento then 
            return true;
         else 
            return Esta (Lista.Sig, elemento);
         end if;
      end if;
   end Esta;

   procedure Insertar (lista: in out TipoLista; Elemento: in TipoElem) is
   NuevoNodo: TipoLista:= new TipoNodo'(Elemento, null);
   begin 
      if Vacia (Lista) then
         Lista:= NuevoNodo;
      else NuevoNodo.Sig := Lista;
         Lista:= NuevoNodo; 
      end if;
   end Insertar;

   procedure InsertarPorFinal (Lista: in out TipoLista; Elemento: in TipoElem) is
   nodo: TipoLista:= new TipoNodo'(Elemento, null);
   ptr: TipoLista:= lista;
   begin
      if Ptr = null then 
         Lista:= Nodo; 
         else
         while ptr.Sig /= null loop
            ptr:= ptr.Sig;
         end loop;
         ptr.Sig:= nodo;
      end if;
   end Insertarporfinal;

   procedure Suprimir (Lista: in out TipoLista; Elemento: in TipoElem) is
   actual: TipoLista:= Lista;
   ant: TipoLista:= null;
   begin
      if Vacia(Lista) then raise ListaVacia;
         else while Actual /= null and then 
            Actual.Info /= Elemento 
            loop
               ant:= actual;
               actual:= actual.Sig;
            end loop;
      
         if ant = null then Lista:= Lista.Sig;
            else ant.Sig:= actual.Sig; 
         end if;
         Free (actual);
      end if;
   end Suprimir;

   procedure SuprimirPorFrente (Lista: in out TipoLista; Elemento: out TipoElem) is
   ptr: TipoLista:= Lista;
   begin
      if not Vacia (Lista) then
         Elemento:= Lista.Info;
         Lista:= Lista.Sig;
         Free (ptr);
         else raise ListaVacia;
      end if;
   end SuprimirPorFrente;
  
end ListaEnlazada;



