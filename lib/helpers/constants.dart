const String supabaseUrl = 'https://supabase.cbluna-dev.com';
const String anonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJhbm9uIiwKICAgICJpc3MiOiAic3VwYWJhc2UiLAogICAgImlhdCI6IDE2NTc2OTU2MDAsCiAgICAiZXhwIjogMTgxNTQ2MjAwMAp9.8h6s6K2rRn20SOc7robvygAWNhZsSWD4xFRdIZMyYVI';
const redirectUrl =
    'https://supabase.cbluna-dev.com/arux-change-pass/#/change-password/token';
const String queryPartidasPush =
    "SELECT partidas_sap.id_partidas_pk,proveedores.sociedad ,partidas_sap.referencia,partidas_sap.importe_ml,partidas_sap.ml,partidas_sap.importe ,partidas_sap.dias_pago,partidas_sap.descuento_porc_pp,partidas_sap.descuento_cant_pp,partidas_sap.pronto_pago,esquemas.id_esquema_pk FROM proveedores INNER JOIN partidas_sap ON id_proveedor_pk = id_proveedor_fk INNER JOIN esquemas ON id_esquema_fk = id_esquema_pk WHERE id_esquema_pk = 1 ";
const String queryPartidasPull =
    "SELECT partidas_sap.id_partidas_pk,proveedores.sociedad ,partidas_sap.referencia,partidas_sap.importe_ml,partidas_sap.ml,partidas_sap.importe ,partidas_sap.dias_pago,partidas_sap.descuento_porc_pp,partidas_sap.descuento_cant_pp,partidas_sap.pronto_pago,esquemas.id_esquema_pk FROM proveedores INNER JOIN partidas_sap ON id_proveedor_pk = id_proveedor_fk INNER JOIN esquemas ON id_esquema_fk = id_esquema_pk WHERE id_esquema_pk = 2 OR id_esquema_pk = 3 ";
const String queryPartidas =
    "SELECT partidas_sap.id_partidas_pk,proveedores.sociedad ,partidas_sap.no_doc_partida,partidas_sap.importe_ml,partidas_sap.ml,partidas_sap.importe ,partidas_sap.dias_pago,partidas_sap.descuento_porc_pp,partidas_sap.descuento_cant_pp,partidas_sap.pronto_pago,esquemas.id_esquema_pk FROM proveedores INNER JOIN partidas_sap ON id_proveedor_pk = id_proveedor_fk INNER JOIN esquemas ON id_esquema_fk = id_esquema_pk WHERE ";
const String partidasProveedores = "";
const String queryRegistroFacturas = "";
const String querySeguimientoFacturas = "";
