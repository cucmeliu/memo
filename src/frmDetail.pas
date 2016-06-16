unit frmDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, def;

type


  TOpenType = (newtask, modtask, viewtask);


  TDetailForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    DateTimePicker1: TDateTimePicker;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    needrefresh: boolean;
    opentype: TOpenType;
    function checkInput(): boolean;
  public
    { Public declarations }
    function isNeedRefresh(): boolean;
    procedure newTask();
    procedure viewTask(rec: TDetailRec);
    procedure modTask(rec: TDetailRec);
  end;

var
  DetailForm: TDetailForm;

implementation

{$R *.dfm}

{ TDetailForm }

procedure TDetailForm.BitBtn1Click(Sender: TObject);
begin
  close();
end;

procedure TDetailForm.BitBtn2Click(Sender: TObject);
begin
  if not checkInput then exit;
  
  if (opentype<>TOpenType(2))  then
    needrefresh := true;

  self.Close;

end;

function TDetailForm.checkInput: boolean;
begin
  result := false;
  if trim(edit1.Text) = '' then
  begin
    messagebox(self.Handle, '标题写几个字吧！',
      '提示', mb_Ok+mb_iconquestion);
    edit1.SetFocus;
  end else if memo1.Lines.Text = ''  then
  begin
    messagebox(self.Handle, '内容多少写几个字吧！',
      '提示', mb_Ok+mb_iconquestion);
    memo1.SetFocus;
  end else result := true;            
  
end;

procedure TDetailForm.FormCreate(Sender: TObject);
begin
  needrefresh := false;
  opentype := TOpenType(2);
  DateTimePicker1.DateTime := now;
end;

function TDetailForm.isNeedRefresh: boolean;
begin
  result := needrefresh;
end;

procedure TDetailForm.modTask(rec: TDetailRec);
begin
  opentype := TOpenType(1);

  self.Caption := '改';
  Edit1.Text := rec.title;
  DateTimePicker1.DateTime := rec.deadline;
  Memo1.Lines.Text := rec.content;

end;

procedure TDetailForm.newTask;
begin
  opentype := TOpenType(0);
end;

procedure TDetailForm.viewTask(rec: TDetailRec);
begin
  opentype := TOpenType(2);
  self.Caption := '显';
  Edit1.Text := rec.title;
  DateTimePicker1.DateTime := rec.deadline;
  Memo1.Lines.Text := rec.content;
  Edit1.ReadOnly := true;
  DateTimePicker1.Enabled := false;
  Memo1.ReadOnly := true;
  bitbtn1.Visible := false;
  bitbtn2.Caption := '知';
end;

end.
