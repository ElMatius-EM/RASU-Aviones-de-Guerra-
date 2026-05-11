# Contexto del proyecto RASU — Ada 95
## AyP II | Grupo 2 | UNPSJB

Pegá este texto al inicio de tu conversación con la IA antes de hacer cualquier consulta sobre el proyecto.


# Skill: Ada 95 — Proyecto RASU

## Contexto del proyecto

Sistema de gestión de equivalencias de materiales para la flota de la Fuerza Aérea Argentina
(Región Sur). Materia: Algorítmica y Programación II — UNPSJB — Grupo 2.

**Tres TADs principales:**
- `Aviones` — lista enlazada de `RegAvion`
- `Repuestos` — lista enlazada de `RegRepuesto`, cada nodo tiene lista anidada de equivalencias
- `Equivalencias` — lista enlazada de `RegEquivalencia`, anidada dentro de Repuestos

**Archivos del proyecto:**
```
aviones.ads / aviones.adb
repuestos.ads / repuestos.adb
equivalencias.ads / equivalencias.adb
submenus.ads / submenus.adb
menu_principal.adb
reportes.ads / reportes.adb
cargar_datos_prueba.adb
```

---

## Paquetes genéricos disponibles (provistos por la cátedra, no modificar)

| Paquete        | Uso en RASU |
|----------------|-------------|
| ListaEnlazada  | ✅ Todos los TADs |
| ListaOrdenada  | ❌ No se usa |
| ColaDinamica   | ❌ No se usa |
| PilaDinamica   | ❌ No se usa |
| VectorCompleto | ❌ No se usa |
| MatrizCompleta | ❌ No se usa |
| NT_Console     | ✅ Todos los módulos |

---

## Convenciones del grupo

```ada
-- Tipos:       T mayúscula        → TAviones, TRepuestos, TEquivalencias
-- Registros:   Reg                → RegAvion, RegRepuesto, RegEquivalencia
-- Arch tipos:  TArchi             → TArchiRepuesto (solo Repuestos lo necesita)
-- Excepciones: Entidad_Condicion  → Avion_Duplicado, Repuesto_No_Encontrado
-- Archivos:    minúsculas         → aviones.dat, repuestos.dat, equivalencias.dat
```

---

## Reglas críticas de Ada 95

### Strings
La cátedra acepta Unbounded_String y String fijo. Este proyecto usa **String fijo** porque
Unbounded_String usa punteros internamente y no puede serializarse con Sequential_IO.

```ada
-- String fijo con longitud auxiliar (patrón del proyecto):
Campo    : String(1..50);
LongCampo: Natural;

-- Lectura:
Get_Line(Dato.Campo, Dato.LongCampo);

-- Impresión (sin espacios basura):
Put(Dato.Campo(1..Dato.LongCampo));

-- Comparación:
if Info(Ptr).Campo(1..Info(Ptr).LongCampo) = Buscar(1..LongBuscar) then
```

### Buffer de entrada
Cada `Get` numérico deja el Enter en el buffer. Siempre hacer `Skip_Line` después:
```ada
Get(Dato.Codigo);
Skip_Line;   -- OBLIGATORIO antes del próximo Get_Line
Get_Line(Dato.Nombre, Dato.LongNombre);
```

### subtype vs new para listas
```ada
-- CORRECTO:
subtype TAviones is TipoLista;

-- INCORRECTO (genera problemas de conversión):
type TAviones is new TipoLista;
```

### Parámetros de lista
La lista siempre entra como parámetro, nunca como variable global:
```ada
-- CORRECTO:
procedure Gestion_Aviones(L: in out TAviones);
```

### Suprimir con registros que tienen campos dinámicos (Regla 16 cátedra)
`Suprimir(L, Elem)` usa `=` internamente. Si el registro contiene una lista dinámica
(como `Equivalencias` en `RegRepuesto`), Ada no puede comparar ese campo y no compila.

**Solo aplica a Repuestos.** Aviones y Equivalencias tienen registros escalares — pueden
usar `Suprimir` directamente.

Para Repuestos, usar `SuprimirPorFrente` + lista auxiliar:
```ada
-- Baja en Repuestos:
procedure Baja(L: in out TRepuestos; Codigo: in Positive) is
   Aux  : TRepuestos;
   Elem : RegRepuesto;
   Enc  : Boolean := False;
begin
   Crear(Aux);
   while not Vacia(L) loop
      SuprimirPorFrente(L, Elem);
      if Elem.Codigo = Codigo then
         Enc := True;
      else
         InsertarPorFinal(Aux, Elem);
      end if;
   end loop;
   -- restaurar
   while not Vacia(Aux) loop
      SuprimirPorFrente(Aux, Elem);
      InsertarPorFinal(L, Elem);
   end loop;
   if not Enc then raise Repuesto_No_Encontrado; end if;
end Baja;

-- Modificar en Repuestos (mismo patrón, conservar equivalencias):
procedure Modificar(L: in out TRepuestos; Codigo: in Positive; NuevoReg: in RegRepuesto) is
   Aux   : TRepuestos;
   Elem  : RegRepuesto;
   Nuevo : RegRepuesto := NuevoReg;
   Enc   : Boolean := False;
begin
   Crear(Aux);
   while not Vacia(L) loop
      SuprimirPorFrente(L, Elem);
      if Elem.Codigo = Codigo then
         Enc := True;
         Nuevo.Equivalencias := Elem.Equivalencias;  -- conservar equivalencias
         InsertarPorFinal(Aux, Nuevo);
      else
         InsertarPorFinal(Aux, Elem);
      end if;
   end loop;
   while not Vacia(Aux) loop
      SuprimirPorFrente(Aux, Elem);
      InsertarPorFinal(L, Elem);
   end loop;
   if not Enc then raise Repuesto_No_Encontrado; end if;
end Modificar;
```

### Orden de declaración (Regla 1 cátedra)
Instanciar el paquete interno ANTES de usarlo en un record:
```ada
-- CORRECTO — en repuestos.ads:
with Equivalencias; use Equivalencias;  -- TEquivalencias ya existe
-- luego:
type RegRepuesto is record
   ...
   Equivalencias : TEquivalencias;  -- OK, ya declarado
end record;
```

### Construir completamente antes de insertar (Regla 15 cátedra)
`Insertar` guarda una copia del registro en ese momento. Cargar la lista interna
después de insertar no afecta el nodo ya insertado.
```ada
-- CORRECTO:
Crear(Rep.Equivalencias);
Alta(Rep.Equivalencias, Eq1);
Alta(Rep.Equivalencias, Eq2);
InsertarPorFinal(L, Rep);   -- insertar al final, ya completo

-- INCORRECTO:
InsertarPorFinal(L, Rep);   -- copia con lista vacía
Alta(Rep.Equivalencias, Eq1); -- modifica variable local, no el nodo
```

---

## Patrón TAD estándar — Aviones y Equivalencias (.adb)
(registros escalares: pueden usar Suprimir directamente)

```ada
package body XXXX is

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

   procedure Alta(L: in out TXXXX; Reg: in RegXXXX) is
      Ptr : TXXXX := L;
      Enc : Boolean;
   begin
      BuscarPtr(Ptr, Reg.Codigo, Enc);
      if Enc then raise XXXX_Duplicado; end if;
      InsertarPorFinal(L, Reg);
   end Alta;

   procedure Baja(L: in out TXXXX; Codigo: in Positive) is
      Ptr : TXXXX := L;
      Enc : Boolean;
   begin
      BuscarPtr(Ptr, Codigo, Enc);
      if not Enc then raise XXXX_No_Encontrado; end if;
      Suprimir(L, Info(Ptr));   -- OK: registro sin campos dinámicos
   end Baja;

   procedure Modificar(L: in out TXXXX; Codigo: in Positive; NuevoReg: in RegXXXX) is
      Ptr   : TXXXX := L;
      Enc   : Boolean;
      Viejo : RegXXXX;
   begin
      BuscarPtr(Ptr, Codigo, Enc);
      if not Enc then raise XXXX_No_Encontrado; end if;
      Viejo := Info(Ptr);
      Suprimir(L, Viejo);
      InsertarPorFinal(L, NuevoReg);
   end Modificar;

   function Buscar(L: in TXXXX; Codigo: in Positive) return RegXXXX is
      Ptr : TXXXX := L;
      Enc : Boolean;
   begin
      BuscarPtr(Ptr, Codigo, Enc);
      if not Enc then raise XXXX_No_Encontrado; end if;
      return Info(Ptr);
   end Buscar;

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
```

---

## Caso especial: Repuestos (lista anidada + Regla 16)

Sequential_IO no serializa punteros → dos archivos.
Suprimir no compila con RegRepuesto → SuprimirPorFrente + lista auxiliar.

```
repuestos.dat     → campos escalares (sin Equivalencias)
equivalencias.dat → equivalencias con CodigoRepuesto como clave foránea
```

```ada
type TArchiRepuesto is record
   Codigo      : Positive;
   Tipo        : TipoRepuesto;
   Descripcion : String(1..50);
   LongDesc    : Natural;
   CodigoAvion : Positive;
   -- sin Equivalencias
end record;
```

**Orden de carga obligatorio:** primero `repuestos.dat`, después `equivalencias.dat`.

---

## Patrón submenú

```ada
procedure Gestion_XXXX(L: in out TXXXX) is
   Rta : Character;   -- Character, no Integer
begin
   loop
      -- mostrar menú...
      Get(Rta); Skip_Line;
      case Rta is
         when '1' =>
            declare
               Reg : RegXXXX;
            begin
               Reg := LeerXXXX(L);
               Alta(L, Reg);
            exception
               when XXXX_Duplicado => Put_Line("ERROR: codigo duplicado.");
            end;
         when '5' =>
            Guardar(L, "xxxx.dat");  -- guardar al salir
            exit;
         when others => Put_Line("Opcion invalida.");
      end case;
   end loop;
end Gestion_XXXX;
```

---

## Colores NT_Console

```ada
Set_Foreground(White)  -- bordes y etiquetas
Set_Foreground(Gray)   -- opciones de menú
Set_Foreground(Cyan)   -- datos ingresados por el usuario
Set_Foreground(Green)  -- éxito (alta OK, guardado)
Set_Foreground(Red)    -- errores (duplicado, no encontrado)
Set_Foreground(Yellow) -- títulos de sección
```

---

## Errores frecuentes a evitar

| Error | Causa | Solución |
|-------|-------|----------|
| Lectura vacía después de Get numérico | Enter queda en buffer | Skip_Line después de cada Get |
| Impresión con espacios basura | Imprimir String completo | Usar Campo(1..LongCampo) |
| No compila en Baja/Modificar de Repuestos | Suprimir requiere = sobre campos dinámicos | SuprimirPorFrente + lista auxiliar |
| Equivalencias perdidas al cargar | Cargar equiv antes que repuestos | Respetar orden de carga |
| Equivalencias perdidas al insertar | Insertar antes de cargar lista interna | Construir completo, luego insertar |
| Problemas de conversión de tipos | `type X is new TipoLista` | Usar `subtype X is TipoLista` |
| Variable global de lista | Patrón del TAD Mecanicos | Siempre pasar lista como parámetro |
| Serializar lista dinámica directo | Lista contiene punteros | Usar TArchi sin el campo dinámico |
