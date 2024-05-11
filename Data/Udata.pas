unit Udata;

interface

uses
   System.SysUtils, System.Classes, ZAbstractConnection, ZConnection, Data.DB,
   ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
    Tdm_DBconn = class(TDataModule)

    Zconn_pg: TZConnection;
    ZqryUtils: TZQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
 dm_DBconn: Tdm_DBconn;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure Tdm_DBconn.DataModuleCreate(Sender: TObject);
begin
  ZqryUtils.SQL.Text := ' SELECT current_date';
  ZqryUtils.Open;
end;

procedure Tdm_DBconn.DataModuleDestroy(Sender: TObject);
begin
  dm_DBconn := nil;
end;

end.
