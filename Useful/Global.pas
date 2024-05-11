{
 Owner: Rafael P. Fiorin
}

//Unit de funções e procedures;

unit Global;

interface

uses
   //Declaração de uses do Windows;
   SysUtils, Forms, Windows, DB, ZDataSet, DateUtils, Dialogs, Classes;

    //Declaração de FUNCTIONS;
    function IsDebuggerPresent: Boolean; stdcall; external 'kernel32.dll';
    function RmvMascara(vStr: string): String;
    function BuscarReg(AInstrucao: string): String;
    function GetMonthNumeric(mes: string): String;
    function GetMonthCharacter(mes: Integer): String;
    function IncrementaValor(lastValue: string; addValue: integer): Integer;
    function zeroEsquerda(val: string; qtd: integer): String;
    function espacoDireita(val: string; qtd: integer): String;
    function espacoEsquerda(val: string; qtd: integer): String;
    function NumExtenso(Num : Integer): String;
    function nullifempty(val: string): String;
    function easData(Data: string): String;
    function VerificaData(const Data: String): Boolean;
    function eas(Str: string): String;
    function VerEsp(Str: string): String;
    function easNumerico(Numero: string): String;

	  //Declaração de PROCEDURES;
    procedure ExecuteSQL(AInstrucao: string);
    procedure ExecuteBegin;
    procedure ExecuteCommit;
    procedure ExecuteRollBack;
    procedure waitCursor(active: Boolean);

var
 //Declaração de variáveis globais;
 loQry : TZQuery;
 MyCursor: HCURSOR;

implementation

Uses
 Udata, Udiary;

function BuscarReg(AInstrucao: string): String;
begin
  with dm_DBconn.ZqryUtils do
  begin
    Close;
    SQL.Text := AInstrucao;
    Open;
    Result := Fields[0].AsString;
  end;
end;

procedure ExecuteBegin;
begin
  ExecuteSQL('BEGIN;');
end;

procedure ExecuteCommit;
begin
  ExecuteSQL('COMMIT;');
end;

procedure ExecuteRollBack;
begin
  ExecuteSQL('ROLLBACK;');
end;

procedure ExecuteSQL(AInstrucao: string);
begin
  loQry := TZQuery.Create(nil);
  loQry.Connection := dm_DBconn.Zconn_pg;
  with loQry do
  begin
    Close;
    SQL.Text := AInstrucao;
    ExecSQL;
  end;
  loQry.Free;
end;

function GetMonthNumeric(mes: string): String;
var
  sMes: String;
begin
  if mes = 'JANEIRO' then
    sMEs := '01'
  else if mes = 'FEVEREIRO' then
    sMEs := '02'
  else if mes = 'MARÇO' then
    sMEs := '03'
  else if mes = 'ABRIL' then
    sMEs := '04'
  else if mes = 'MAIO' then
    sMEs := '05'
  else if mes = 'JUNHO' then
    sMEs := '06'
  else if mes = 'JULHO' then
    sMEs := '07'
  else if mes = 'AGOSTO' then
    sMEs := '08'
  else if mes = 'SETEMBRO' then
    sMEs := '09'
  else if mes = 'OUTUBRO' then
    sMEs := '10'
  else if mes = 'NOVEMBRO' then
    sMEs := '11'
  else if mes = 'DEZEMBRO' then
    sMEs := '12';

  Result := sMes;
end;

function GetMonthCharacter(mes: Integer): String;
var
sMes: String;
begin
  case mes of
  1: sMes := 'JANEIRO';
  2: sMes := 'FEVEREIRO';
  3: sMes := 'MARÇO';
  4: sMes := 'ABRIL';
  5: sMes := 'MAIO';
  6: sMes := 'JUNHO';
  7: sMes := 'JULHO';
  8: sMes := 'AGOSTO';
  9: sMes := 'SETEMBRO';
  10: sMes := 'OUTUBRO';
  11: sMes := 'NOVEMBRO';
  12: sMes := 'DEZEMBRO';
  end;
  Result := sMes;
end;

function RmvMascara(vStr: string): String;
var i: Integer;
begin
 Result:= '';
 vStr := Trim(vStr);
  for i := 1 to Length(vStr) do   //Função para remover máscara.
   if vStr[i] in ['0'..'9', 'A'..'Z', 'a'..'z'] then
    result:= result + vStr[i];
end;

function IncrementaValor(lastValue: string; addValue: integer): Integer;
var
  value: integer;
begin
  if lastValue = '' then
    value := 0
  else
    value := StrToInt(lastValue);
  Result := value + addValue;
end;

function zeroEsquerda(val: string; qtd: integer): String;
begin
   val := trim(val);
   while qtd >  length(val) do val := '0' + val;
   result := val;
end;

function espacoDireita(val: string; qtd: integer): String;
begin
   val := trim(val);
   while qtd > length(val) do val := val + ' ';
   result := val;
end;

function espacoEsquerda(val: string; qtd: integer): String;
begin
   val := trim(val);
   while qtd >  length(val) do val := ' ' + val;
   result := val;
end;

function NumExtenso(Num : Integer): String;
  var Extenso: string; Idx: Integer;
  const
    Unidades: array[1..9] of string = ('Uma', 'Duas', 'Tres', 'Quatro',
    'Cinco', 'Seis', 'Sete', 'Oito', 'Nove');
    Dez: array[1..9] of string = ('Onze', 'Doze', 'Treze', 'Quatorze',
    'Quinze', 'Dezesseis', 'Dezessete', 'Dezoito', 'Dezenove');
    Dezenas: array[1..9] of string = ('Dez', 'Vinte', 'Trinta', 'Quarenta',
    'Cinquenta', 'Sessenta', 'Setenta', 'Oitenta', 'Noventa');
    Centenas: array[1..9] of string = ('Cento', 'Duzentos', 'Trezentos',
    'Quatrocentos', 'Quinhentos', 'Seiscentos', 'Setecentos', 'Oitocentos',
    'Novecentos');
begin
  if Length(IntToStr(Num)) = 1 then  NumExtenso := Unidades[Num];
  if Length(IntToStr(Num)) = 2 then begin
    if StrToInt(Copy(IntToStr(Num), 1, 1)) = 1 then  begin
      if StrToInt(Copy(IntToStr(Num), 2, 1)) > 0 then NumExtenso := Dez[StrToInt(Copy(IntToStr(Num), 2, 1))]
          else NumExtenso := Dezenas[1];
        end
      else
        begin
          Idx := StrToInt(Copy(IntToStr(Num), 1, 1));
          Extenso := Dezenas[Idx];
          Idx := StrToInt(Copy(IntToStr(Num), 2, 1));
          if Idx > 0 then
            Begin
              Extenso := Extenso + ' e ';
              Extenso := Extenso + Unidades[Idx];
            end;
          NumExtenso := Extenso;
        end;
    end;
end;

function nullifempty(val: string): String;
begin
  if val = '' then
   Result := 'NULL'
  else
    Result := val;
end;

function easData(Data: string): String;
begin
  Result := 'NULL';
  if Data <> '  /  /    ' then
    if VerificaData(Data) then
      Result := QuotedStr(FormatDateTime('YYYY-MM-DD', StrToDate(Data)));
end;

function VerificaData(const Data: string): Boolean;
begin
  try
    StrToDate(Data);
    Result := True;
  except
    Result := False;
  end;
end;

function eas(Str: string): String;
begin
  Str := VerEsp(Str);
  if Str = '' then
    Result := 'NULL'
  else
    Result := QuotedStr(Str);
end;

function easNumerico(Numero: string): String;
begin
  if Numero = '' then
    Result := 'NULL'
  else
    Result := Numero;
end;

function VerEsp(Str: string): String;
var
  Tamanho, Posicao: Integer;
begin
  while True do
  begin
    Str := Trim(Str);
    Tamanho := Length(Str);
    Posicao := Pos(' ', Str);
    if Posicao = 0 then
    begin
      Result := Result + Str;
      Break;
    end;
    Result := Result + Copy(Str, 1, Posicao);
    Str := Trim(Copy(Str, Posicao + 1, Tamanho));
  end;
end;

procedure waitCursor(active: Boolean);
begin
  if active then
  begin
    MyCursor := LoadCursorFromFile(PChar('waiting.ani'));
    Screen.Cursors[1] := MyCursor;
    Screen.Cursor := 1;
  end
  else
    Screen.Cursor := 0;
end;

end.
