//Lan�amento e gerenciamento de eventos.

unit Udiary;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
   Vcl.Grids, Vcl.DBGrids, Vcl.XPMan, Vcl.Menus, Vcl.Buttons, Vcl.Mask, JvExControls,
   JvLabel, JvExMask, JvToolEdit, JvComponentBase, JvEnterTab, JvMaskEdit, JvExDBGrids,
   JvDBGrid, JvDBUltimGrid,  ZAbstractRODataset, ZAbstractDataset, Data.DB, ZDataset,
   Vcl.AppEvnts, DateUtils;

type
    TfrmDiary = class(TForm)

    lblSepara: TJvLabel;
    lblFechar: TJvLabel;
    lblMinimizar: TJvLabel;
    lblMaximizar: TJvLabel;
    txtEvento: TEdit;
    dtEdtData: TJvDateEdit;
    txtLocal: TEdit;
    btnLancar: TButton;
    lblTitulo: TLabel;
    medtHorario: TJvMaskEdit;
    lblLancados: TLabel;
    dbugEventos: TJvDBUltimGrid;
    ZqryEventos: TZQuery;
    dsEventos: TDataSource;
    ZqryVersao: TZQuery;
    lblVersao: TLabel;
    tIcon: TTrayIcon;
    ppmIcon: TPopupMenu;
    ppRestaurar: TMenuItem;
    ppEncerrar: TMenuItem;
    btnExcluir: TButton;
    btnLimpar: TButton;
    appEvt: TApplicationEvents;
    ZqryEventosdescricao: TWideMemoField;
    ZqryEventosdata: TDateField;
    ZqryEventoshorario: TWideStringField;
    ZqryEventoslocal: TWideStringField;
    ZqryEventosis_ativo: TBooleanField;
    edtTestaData: TEdit;
    dtEdtAtual: TJvDateEdit;

    procedure lblFecharMouseLeave(Sender: TObject);
    procedure lblFecharClick(Sender: TObject);
    procedure lblMinimizarMouseLeave(Sender: TObject);
    procedure lblMinimizarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure txtEventoExit(Sender: TObject);
    procedure txtLocalExit(Sender: TObject);
    procedure btnLancarClick(Sender: TObject);
    procedure medtHorarioMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure txtLocalEnter(Sender: TObject);
    procedure ZqryEventosAfterRefresh(DataSet: TDataSet);
    procedure medtHorarioKeyPress(Sender: TObject; var Key: Char);
    procedure dbugEventosCellClick(Column: TColumn);
    procedure dbugEventosDblClick(Sender: TObject);
    procedure dbugEventosColEnter(Sender: TObject);
    procedure lblFecharMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ppEncerrarClick(Sender: TObject);
    procedure ppRestaurarClick(Sender: TObject);
    procedure tIconDblClick(Sender: TObject);
    procedure lblMinimizarClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure dbugEventosMouseLeave(Sender: TObject);
    procedure dtEdtDataEnter(Sender: TObject);
    procedure medtHorarioEnter(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure txtEventoClick(Sender: TObject);
    procedure txtEventoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure appEvtException(Sender: TObject; E: Exception);
    procedure dtEdtDataMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnLimparClick(Sender: TObject);
    procedure dtEdtDataChange(Sender: TObject);
    procedure dtEdtDataExit(Sender: TObject);
    procedure btnLancarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

//Vari�veis globais
var
 frmDiary: TfrmDiary;

implementation
  {$R *.dfm}

Uses
 Udata, Global, Vcl.Consts;


procedure TfrmDiary.appEvtException(Sender: TObject; E: Exception);
begin
  //Trata erro de data vazia.
  if E is EConvertError then begin
   with EConvertError(E) do
   if Pos('is not a valid date', E.Message) <> 0 then
    Application.MessageBox(' Preencha uma data (v�lida).','ScheduleUp',16);
  end;
end;

procedure TfrmDiary.btnExcluirClick(Sender: TObject);
begin
  if (Application.MessageBox(' Tem certeza que deseja excluir todos os eventos?','Agende-se',36) = id_yes) then begin
    //Se houver eventos, deleta-os,
    if not (ZqryEventos.IsEmpty) then begin
     try
      ExecuteSQL(
                ' DELETE FROM rpfiorin.evento'
                );
      //Se apagar todos os eventos, conclui transa��o,
      ExecuteCommit;

       ShowMessage(' Sucesso ao excluir!');
     except
      //Se n�o, Executa ROLLBACK na excess�o, exibindo mensagem,
      ExecuteRollBack;

       ShowMessage(' Erro inesperado.');
     end;
      //Atualiza os eventos,
      ZqryEventos.Refresh;
    end
    else
     ShowMessage(' Nenhum evento encontrado.');
  end;
   //Volta o foco para o primeiro campo.
   txtEvento.SetFocus;
end;

procedure TfrmDiary.btnLancarClick(Sender: TObject);
begin
 //Verifica se todos os campos est�o preenchidos,
 if (txtEvento.Text = '') OR (txtLocal.Text = '') OR (mEdtHorario.Text = '  :   -   :  ')
 then begin
   Application.MessageBox(' Preencha todos os campos.','ScheduleUp',48);
    txtEvento.SetFocus;
   Exit;
 end;

 //Faz valida��o no campo "hor�rio",
 if (medtHorario.Text[9] > '0') then
  if (Copy(medtHorario.Text,1,2)) > (Copy(medtHorario.Text,9,2)) then begin
     Application.MessageBox(' Digite um hor�rio v�lido.','Agende-se',48);
      medtHorario.SetFocus;
     Exit;
  end;

 if (medtHorario.Text[1] = '2') AND (medtHorario.Text[2] > '3') then begin
    Application.MessageBox(' Digite uma hora v�lida.','Agende-se',48);
     medtHorario.SetFocus;
    Exit;
 end;
 if (medtHorario.Text[9] = '2') AND (medtHorario.Text[10] > '3') then begin
    Application.MessageBox(' Digite uma hora v�lida.','ScheduleUp',48);
     medtHorario.SetFocus;
    Exit;
 end;
 if (medtHorario.Text[1] > '2') OR (medtHorario.Text[9] > '2') then begin
    Application.MessageBox(' Digite uma hora v�lida.','ScheduleUp',48);
     medtHorario.SetFocus;
    Exit;
 end;
 if (medtHorario.Text[4] > '5') OR (medtHorario.Text[12] > '5') then begin
    Application.MessageBox(' Digite um minuto v�lido.','ScheduleUp',48);
     medtHorario.SetFocus;
    Exit;
 end;
 //Faz valida��o no campo data,
 if (dtEdtData.Date < dtEdtAtual.Date) then begin
    Application.MessageBox(' Selecione uma data maior ou igual a atual.','ScheduleUp',48);
     dtedtData.SetFocus;
    Exit;
 end;

   //Se estiver nos conformes, executa as instru��es SQL,
   try
   //Verifica se � edi��o,
   if (btnLancar.Caption = 'Editar') then begin
    ExecuteSQL(
               ' UPDATE rpfiorin.evento SET'+
               ' descricao ='+eas(txtEvento.Text)+','+
               ' local ='+eas(txtLocal.Text)+','+
               ' data ='+easData(dtedtData.Text)+','+
               ' horario ='+eas(medtHorario.Text)+
               ' WHERE'+
               ' descricao ='+eas(ZqryEventosDescricao.AsString)+
               ' AND local ='+eas(ZqryEventosLocal.AsString)+
               ' AND data ='+easData(ZqryEventosData.AsString)+
               ' AND horario ='+eas(ZqryEventosHorario.AsString)
              );

   end;
    //Se n�o, lan�a o evento,
    ExecuteBegin;
    ExecuteSQL(
               ' DELETE FROM rpfiorin.evento'+
               ' WHERE descricao ='+eas(txtEvento.Text)+
               ' AND data ='+easData(dtedtData.Text)+
               ' AND horario ='+eas(medtHorario.Text)+
               ' AND is_ativo =''TRUE'' '+
               ' AND local ='+eas(txtLocal.Text)+';'+

               ' INSERT INTO rpfiorin.evento(descricao, data, horario, local, is_ativo)'+
               ' VALUES('+
                          eas(txtEvento.Text)+','+
                          easData(dtedtData.Text)+','+
                          eas(medtHorario.Text)+','+
                          eas(txtLocal.Text)+',''TRUE'' '+
                      ');'
              );

    ExecuteCommit;

     //Exibe mensagem conforme situa��o e atualiza os eventos,
     if (btnLancar.Caption = 'Lan�ar') then
      ShowMessage(' Evento lan�ado com sucesso!')
     else
      ShowMessage(' Evento editado com sucesso!');

     ZqryEventos.Refresh;

      //Limpa os campos,
      dtedtData.Clear;
      medtHorario.Clear;

      //Atribui texto para informar preenchimento dos campos,
      txtEvento.Font.Style := [fsItalic];
      txtEvento.Font.Name := 'Segoe UI';
      txtEvento.Text := 'Descri��o';

      txtLocal.Font.Style := [fsItalic];
      txtLocal.Font.Name := 'Segoe UI';
      txtLocal.Text := 'Local';

       //Faz alguns ajustes e valida��es.
       dbugEventos.Enabled := True;
       btnLancar.Caption := 'Lan�ar';

       dbugEventos.Columns.Items[1].ReadOnly := True;
       dbugEventos.Columns.Items[2].ReadOnly := True;
       dbugEventos.Columns.Items[3].ReadOnly := True;
   except
    //Executa ROLLBACK na excess�o, exibindo mensagem de erro,
    ExecuteRollBack;

     ShowMessage(' Erro inesperado.');
   end;
   //Volta o foco para o primeiro campo.
   txtEvento.SetFocus;
end;

procedure TfrmDiary.btnLancarMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 //Trata bug do bot�o de espa�o no campo "On/off" do Grid.
 dm_DBconn.ZqryUtils.SQL.Text := ' SELECT * FROM rpfiorin.evento'+
                                 ' WHERE is_ativo = ''FALSE''';
 dm_DBconn.ZqryUtils.Open;

  if not dm_DBconn.ZqryUtils.IsEmpty then
   if (Application.MessageBox(' Evento pendente, deseja deletar?','ScheduleUp',36) = ID_YES) then begin
    ExecuteSQL(' DELETE FROM rpfiorin.evento'+
               ' WHERE'+
               ' descricao ='+eas(ZqryEventosDescricao.AsString)+
               ' AND local ='+eas(ZqryEventosLocal.AsString)+
               ' AND data ='+easData(ZqryEventosData.AsString)+
               ' AND horario ='+eas(ZqryEventosHorario.AsString)
               );

    //Mant�m atualizado,
    ZqryEventos.Refresh;

     //Se n�o tiver nenhum evento, faz:
     if (ZqryEventos.IsEmpty) then
      dbugEventos.Enabled := False
     else
      dbugEventos.Enabled := True;
   end
   else begin
    //Se n�o, volta ao estado padr�o,
    ExecuteSQL(' UPDATE rpfiorin.evento'+
               ' SET is_ativo = ''TRUE'' '+
               ' WHERE'+
               ' descricao ='+eas(ZqryEventosDescricao.AsString)+
               ' AND local ='+eas(ZqryEventosLocal.AsString)+
               ' AND data ='+easData(ZqryEventosData.AsString)+
               ' AND horario ='+eas(ZqryEventosHorario.AsString)
              );

    //Mant�m atualizado.
    ZqryEventos.Refresh;
   end;
end;

procedure TfrmDiary.btnLimparClick(Sender: TObject);
begin
  //Limpa os campos,
  dtedtData.Clear;
  medtHorario.Clear;

   //Atribui texto para informar preenchimento dos campos,
   txtEvento.Font.Style := [fsItalic];
   txtEvento.Font.Name := 'Segoe UI';
   txtEvento.Text := 'Descri��o';
   txtEvento.SetFocus;

   txtLocal.Font.Style := [fsItalic];
   txtLocal.Font.Name := 'Segoe UI';
   txtLocal.Text := 'Local';

    btnLancar.Caption := 'Lan�ar';
end;

procedure TfrmDiary.dbugEventosCellClick(Column: TColumn);
begin
//Clica,
mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);

 //Verifica se usu�rio quer editar o evento,
 if (dbugEventos.SelectedIndex = 0) then begin
  txtEvento.Text := ZqryEventosDescricao.AsString;
  txtEvento.Font.Name := 'Verdana';
  txtEvento.Font.Style := [];

  txtLocal.Text := ZqryEventosLocal.AsString;
  txtLocal.Font.Name := 'Verdana';
  txtLocal.Font.Style := [];

  dtedtData.Date := ZqryEventosData.AsDateTime;
  dtedtData.Font.Name := 'Verdana';

  medtHorario.Text := ZqryEventosHorario.AsString;
  medtHorario.Font.Name := 'Verdana';

   btnLancar.Caption := 'Editar';
 end
 else begin
  //Se clicar em outra c�lula qualquer, reseta os campos/bot�o.
  txtEvento.Font.Name := 'Segoe UI';
  txtEvento.Font.Style := [fsItalic];
  txtEvento.Text := 'Descri��o';

  txtLocal.Font.Name := 'Segoe UI';
  txtLocal.Font.Style := [fsItalic];
  txtLocal.Text := 'Local';

  dtedtData.Clear;
  medtHorario.Clear;

   btnLancar.Caption := 'Lan�ar';
 end;
  //Se tentar deletar o evento, exibe mensagem de confirma��o,
  if not (ZqryEventosIs_ativo.AsBoolean) then
   if (Application.MessageBox(' Deseja deletar o evento?','ScheduleUp',36) = ID_YES) then begin
    ExecuteSQL(' DELETE FROM rpfiorin.evento'+
               ' WHERE'+
               ' descricao ='+eas(ZqryEventosDescricao.AsString)+
               ' AND local ='+eas(ZqryEventosLocal.AsString)+
               ' AND data ='+easData(ZqryEventosData.AsString)+
               ' AND horario ='+eas(ZqryEventosHorario.AsString)
               );

    //Mant�m atualizado,
    ZqryEventos.Refresh;

     //Se n�o tiver nenhum evento, faz:
     if (ZqryEventos.IsEmpty) then
      dbugEventos.Enabled := False
     else
      dbugEventos.Enabled := True;
   end
   else begin
    //Se n�o, volta ao estado padr�o,
    ExecuteSQL(' UPDATE rpfiorin.evento'+
               ' SET is_ativo = ''TRUE'' '+
               ' WHERE'+
               ' descricao ='+eas(ZqryEventosDescricao.AsString)+
               ' AND local ='+eas(ZqryEventosLocal.AsString)+
               ' AND data ='+easData(ZqryEventosData.AsString)+
               ' AND horario ='+eas(ZqryEventosHorario.AsString)
              );

    //Mant�m atualizado.
    ZqryEventos.Refresh;
   end;
   txtEvento.SelectAll;
end;

procedure TfrmDiary.dbugEventosColEnter(Sender: TObject);
begin
   //Clica
   mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
end;

procedure TfrmDiary.dbugEventosDblClick(Sender: TObject);
begin
   //Solta
   mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
end;

procedure TfrmDiary.dbugEventosMouseLeave(Sender: TObject);
begin
 //Clica,
 mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
 //Solta.
 mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);

  //Atualiza os eventos,
  ZqryEventos.Refresh;
end;

procedure TfrmDiary.dtEdtDataChange(Sender: TObject);
begin
  //Muda o edit ao mudar a data.
  edtTestaData.Text := dtedtData.Text;
end;

procedure TfrmDiary.dtEdtDataEnter(Sender: TObject);
begin
  //Verifica e retorna t�tulo padr�o para o bot�o.
  if (txtEvento.Text = 'Descri��o') AND (txtLocal.Text = 'Local') then
   btnLancar.Caption := 'Lan�ar';
end;

procedure TfrmDiary.dtEdtDataExit(Sender: TObject);
begin
  //Valida campo data se n�o preenchido corretamente.
  if (dtedtData.Text <> '  /  /    ') then
   if (Length(Trim(edtTestaData.Text)) < 10) then begin
     Application.MessageBox(' Preencha a data inteira','ScheduleUp',16);
      dtedtData.SetFocus;
     Exit;
   end;
end;

procedure TfrmDiary.dtEdtDataMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //Volta sempre o cursor para o in�cio do campo.
  Sendmessage(dtedtData.handle,WM_Keydown,37,0);
    Sendmessage(dtedtData.handle,WM_Keydown,37,0);
      Sendmessage(dtedtData.handle,WM_Keydown,37,0);
        Sendmessage(dtedtData.handle,WM_Keydown,37,0);
        Sendmessage(dtedtData.handle,WM_Keydown,37,0);
      Sendmessage(dtedtData.handle,WM_Keydown,37,0);
    Sendmessage(dtedtData.handle,WM_Keydown,37,0);
  Sendmessage(dtedtData.handle,WM_Keydown,37,0);
end;

procedure TfrmDiary.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 //Desconecta do BD ao fechar,
 dm_DBconn.Zconn_pg.Disconnect;

  PostMessage(FindWindow(nil, 'Acesso aos sistemas'), WM_CLOSE,0,0);
  WinExec('C:\Projetos\Delphi\Acessos\Win32\Release\Acesso_Sistemas.exe', 0);

  //Desaloca mem�ria e encerra.
  Action := caFree;
  frmDiary := nil;
  Application.Terminate;
end;

procedure TfrmDiary.FormHide(Sender: TObject);
begin
   //Executa instru��es ao minimizar para a �rea de notifica��es.
   if not (Application.Terminated) then begin
      tIcon.Visible := True;
      tIcon.BalloonTitle := 'Informa��o';
      tIcon.BalloonFlags := bfInfo;
      tIcon.BalloonHint := 'O ScheduleUp est� em segundo plano.';
      tIcon.ShowBalloonHint;
   end;
end;

procedure TfrmDiary.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  //Ajusta o foco sempre.
  frmDiary.SetFocus;
end;

procedure TfrmDiary.FormShow(Sender: TObject);
begin
 //Faz alguns ajustes,
 lblMinimizarMouseLeave(Sender);
 dtEdtAtual.Date := dm_DBconn.ZqryUtils.Fields[0].AsDateTime;

  //Conecta ao banco de dados,
  dm_DBconn.Zconn_pg.Connected;
  ZqryEventos.Active := True;
  ZqryVersao.Open;

  //Deleta eventos que j� aconteceram, atualizando o Grid,
  ExecuteSQL(
             ' DELETE FROM rpfiorin.evento'+
             ' WHERE data < CURRENT_DATE'
            );
  ZqryEventos.Refresh;

  //Exibe vers�o atual do sistema e faz valida��o com o Grid.
  lblVersao.Caption := ZqryVersao.Fields[0].AsString;

   if (ZqryEventos.IsEmpty) then
     dbugEventos.Enabled := False
   else begin
     dbugEventos.Enabled := True;
     dbugEventos.Columns.Items[1].ReadOnly := True;
     dbugEventos.Columns.Items[2].ReadOnly := True;
     dbugEventos.Columns.Items[3].ReadOnly := True;
   end;
end;

procedure TfrmDiary.lblFecharClick(Sender: TObject);
begin
  //Se tentar encerrar, exibe mensagem de confirma��o.
  if (Application.MessageBox(' Deseja encerrar?','ScheduleUp',36) = id_yes) then
   self.Close;
end;

procedure TfrmDiary.lblFecharMouseLeave(Sender: TObject);
begin
   //Altera cor da fonte.
   lblFechar.Font.Color := $00C08000;
end;

procedure TfrmDiary.lblFecharMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   //Altera cor da fonte.
   lblFechar.Font.Color := clWhite;
end;

procedure TfrmDiary.lblMinimizarClick(Sender: TObject);
begin
   //Deixa Form invis�vel.
   Hide;
end;

procedure TfrmDiary.lblMinimizarMouseLeave(Sender: TObject);
begin
   //Altera cor da fonte.
   lblMinimizar.Font.Color := $00C08000;
end;

procedure TfrmDiary.lblMinimizarMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   //Altera cor da fonte.
   lblMinimizar.Font.Color := clWhite;
end;

procedure TfrmDiary.medtHorarioEnter(Sender: TObject);
begin
  //Verifica e retorna t�tulo padr�o para o bot�o.
  if (txtEvento.Text = 'Descri��o') AND (txtLocal.Text = 'Local') then
   btnLancar.Caption := 'Lan�ar';
end;

procedure TfrmDiary.medtHorarioKeyPress(Sender: TObject; var Key: Char);
begin
  //Se pressionar "Enter", dispara click do bot�o "Lan�ar".
  if (Key = #13) then
   btnLancar.Click;
end;

procedure TfrmDiary.medtHorarioMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //Volta sempre o cursor para o in�cio do campo.
  Sendmessage(medtHorario.handle,WM_Keydown,37,0);
    Sendmessage(medtHorario.handle,WM_Keydown,37,0);
      Sendmessage(medtHorario.handle,WM_Keydown,37,0);
        Sendmessage(medtHorario.handle,WM_Keydown,37,0);
        Sendmessage(medtHorario.handle,WM_Keydown,37,0);
      Sendmessage(medtHorario.handle,WM_Keydown,37,0);
    Sendmessage(medtHorario.handle,WM_Keydown,37,0);
  Sendmessage(medtHorario.handle,WM_Keydown,37,0);
end;

procedure TfrmDiary.ppEncerrarClick(Sender: TObject);
begin
   //Encerra a aplica��o.
   Application.ProcessMessages;
   Application.Terminate;
end;

procedure TfrmDiary.ppRestaurarClick(Sender: TObject);
begin
  //Deixa TrayIcon invis�vel e reabre o Form.
  tIcon.Visible := False;

   frmDiary.Show;
   ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TfrmDiary.tIconDblClick(Sender: TObject);
begin
   //Dispara evento Click.
   ppRestaurar.Click;
end;

procedure TfrmDiary.txtEventoClick(Sender: TObject);
begin
  //Verifica��o para limpar o campo.
  if (txtEvento.Text = 'Descri��o') then begin
    txtEvento.Clear;
    txtEvento.Font.Name := 'Verdana';
    txtEvento.Font.Style := [];
  end;
end;

procedure TfrmDiary.txtEventoExit(Sender: TObject);
begin
  //Se estiver vazio, deixa texto padr�o, se n�o, altera estilo e fonte.
  if (txtEvento.Text = '') then begin
   txtEvento.Text := 'Descri��o';

   txtEvento.Font.Name := 'Segoe UI';
   txtEvento.Font.Style := [fsItalic];
  end;
end;

procedure TfrmDiary.txtEventoKeyPress(Sender: TObject; var Key: Char);
begin
 //Anula tecla "Esc",
 if (Key = #27) then begin
  Key := #0;
  Beep;
 end
 else
  txtEventoClick(Sender);
end;

procedure TfrmDiary.txtLocalEnter(Sender: TObject);
begin
 //Altera estilo e fonte,
 txtLocal.Font.Style := [];
 txtLocal.Font.Name := 'Verdana';

  //Verifica��o para limpar o campo.
  if (txtLocal.Text = 'Local') then
   txtLocal.Clear
  else
   txtLocal.SetFocus;
end;

procedure TfrmDiary.txtLocalExit(Sender: TObject);
begin
  //Se estiver vazio, deixa texto padr�o, se n�o, altera estilo e fonte.
  if (txtLocal.Text = '') then begin
   txtLocal.Text := 'Local';

   txtLocal.Font.Name := 'Segoe UI';
   txtLocal.Font.Style := [fsItalic];
  end;
end;

procedure TfrmDiary.ZqryEventosAfterRefresh(DataSet: TDataSet);
begin
   //Aplica as altera��es feitas.
   ZqryEventos.CommitUpdates;
end;

end.
