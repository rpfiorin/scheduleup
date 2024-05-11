{
 Sistema de gerenciamento de eventos,
 Author: Rafael P. Fiorin.
}

program Schedule_Up;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  Udata in '..\Data\Udata.pas' {dm_DBconn: TDataModule},
  Global in '..\Useful\Global.pas',
  Vcl.Consts in '..\Useful\Vcl.Consts.pas',
  Udiary in '..\Forms\Udiary.pas' {frmDiary};

{$R *.res}

begin
    //Atribui título padrão à aplicação,
    Application.Initialize;
    Application.Title := 'Agende-se';

    //Exibe ícone na barra de tarefas,
    Application.MainFormOnTaskbar := True;
    //Define skin,
    TStyleManager.TrySetStyle('Metropolis UI Dark');

    //Cria o dataModule,
    Application.CreateForm(Tdm_DBconn, dm_DBconn);

    //Cria o Form principal.
    Application.CreateForm(TfrmDiary, frmDiary);

    Application.Run;
end.
