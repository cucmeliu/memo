program myMemo;

uses
  Forms,
  frmMain in 'frmMain.pas' {MainForm},
  frmDetail in 'frmDetail.pas' {DetailForm},
  def in 'def.pas',
  unitPubMethod in '..\..\pubUse\unitPubMethod.pas',
  frmAdjust in 'frmAdjust.pas' {AdjustForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���汸��¼';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
