object dm_DBconn: Tdm_DBconn
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object Zconn_pg: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Connected = True
    HostName = 'localhost'
    Port = 5432
    Database = 'fiorin'
    User = 'u_agendese'
    Password = '@g&nd&$&'
    Protocol = 'postgresql'
    LibraryLocation = 'C:\Program Files (x86)\PostgreSQL\9.5\bin\libpq.dll'
    Left = 24
    Top = 96
  end
  object ZqryUtils: TZQuery
    Connection = Zconn_pg
    SQL.Strings = (
      '')
    Params = <>
    Left = 96
    Top = 56
  end
end
