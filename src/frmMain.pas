unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, RzLstBox, RzChkLst, RzListVw, RzButton,
  RzPanel, ExtCtrls, RzStatus, def, ActnList, Menus,StrUtils, unitPubMethod,
  Registry, ShlObj, Activex, SkinCaption, WinSkinData, IniFiles, DateUtils;

type
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ListView1: TListView;
    ListView2: TListView;
    RzToolbar1: TRzToolbar;
    RzToolButton1: TRzToolButton;
    RzToolButton2: TRzToolButton;
    RzToolButton3: TRzToolButton;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    ActionDone: TAction;
    ActionAbout: TAction;
    ActionNewTask: TAction;
    RzToolButton4: TRzToolButton;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    PopupMenu2: TPopupMenu;
    ActionDel: TAction;
    N4: TMenuItem;
    TrayIcon1: TTrayIcon;
    PopupMenu3: TPopupMenu;
    ActionShowHide: TAction;
    ActionExit: TAction;
    N5: TMenuItem;
    N6: TMenuItem;
    RzSpacer1: TRzSpacer;
    RzToolButton5: TRzToolButton;
    ActionShowTodoDetail: TAction;
    ActionShowDoneDetail: TAction;
    TabSheet3: TTabSheet;
    RzStatusBar1: TRzStatusBar;
    RzGlyphStatus1: TRzGlyphStatus;
    RzClockStatus1: TRzClockStatus;
    rzMaq: TRzMarqueeStatus;
    SkinData1: TSkinData;
    SkinCaption1: TSkinCaption;
    ActionEdit: TAction;
    RzToolButton6: TRzToolButton;
    RzSpacer2: TRzSpacer;
    N8: TMenuItem;
    actView: TAction;
    N7: TMenuItem;
    N9: TMenuItem;
    tsWorktime: TTabSheet;
    mcTime: TMonthCalendar;
    BitBtn1: TBitBtn;
    lvTime: TListView;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ActionWorkOut: TAction;
    N10: TMenuItem;
    GroupBox1: TGroupBox;
    cbstayontop: TCheckBox;
    cbAutoStart: TCheckBox;
    bbtShortCut: TBitBtn;
    gbWorktimeSet: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    dtpBreakStart: TDateTimePicker;
    dtpBreakEnd: TDateTimePicker;
    dtpSupperStart: TDateTimePicker;
    dtpSupperEnd: TDateTimePicker;
    LabelWeektime: TStaticText;
    LabelMonthtime: TStaticText;
    ActionWorkIn: TAction;
    N11: TMenuItem;
    N12: TMenuItem;
    ts5: TTabSheet;
    LogMemo: TMemo;
    BitBtn2: TBitBtn;
    cbShowWorktime: TCheckBox;
    cbQueryOnExit: TCheckBox;
    ppmAdjustTime: TPopupMenu;
    ActionAdjustTime: TAction;
    N13: TMenuItem;
    BitBtn4: TBitBtn;
    procedure actViewExecute(Sender: TObject);
    procedure cbstayontopClick(Sender: TObject);
    procedure ActionEditExecute(Sender: TObject);
    procedure bbtShortCutClick(Sender: TObject);
    procedure cbAutoStartClick(Sender: TObject);
    procedure ListView2InfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: string);
    procedure ListView1InfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: string);
    procedure ActionExitExecute(Sender: TObject);
    procedure ActionShowHideExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ActionAboutExecute(Sender: TObject);
    procedure ActionDelExecute(Sender: TObject);
    procedure ActionDoneExecute(Sender: TObject);
    procedure ActionNewTaskExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionWorkOutExecute(Sender: TObject);
    procedure mcTimeClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ActionWorkInExecute(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure tsWorktimeShow(Sender: TObject);
    procedure cbShowWorktimeClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbQueryOnExitClick(Sender: TObject);
    procedure ActionAdjustTimeExecute(Sender: TObject);
  private
    { Private declarations }
    
    todoList, doneList: TStringList;
    FAppPath: String;

    FLunchBreakStart,
    FLunchBreakEnd,
    FSupperStart,
    FSupperEnd: Ttime;

    function strToRec(str: String):TDetailRec;
    procedure loadTodoList();
    procedure loadDoneList();
    procedure saveTodoList();
    procedure saveDoneList();
    procedure refreshTodoCount();

    procedure regAutoStart(chk: boolean);
    procedure regTop(chk: boolean);
    procedure regWorktime(chk: boolean);
    procedure regQueryOnExit(chk: boolean);

    procedure updateUI();

    function getContent(lines: TStrings; sp:char='*'): string;
    function getLines(content: string; sp:char='*'): string;//TStrings;


    procedure writeTodayWorkIn();
    procedure writeTodayWorkOut();

    procedure getWeektime(someday: TDatetime);
    procedure getMonthtime(someday: TDatetime);

    function calcWorkTime(workIn, workOut: Ttime): double;

    procedure loadSettings();
    procedure saveSettings();

    procedure logit(msg: string);


  public
    { Public declarations }
  end;

  //procedure MyAboutWin(AHandle: THandle; appName, appVersion: PChar); stdcall; external 'myCommDialogs.dll';

var
  MainForm: TMainForm;

const
  APP_REG: string = 'SOFTWARE\cucme\deskmemo';

implementation

uses frmDetail, frmAdjust;

{$R *.dfm}

procedure TMainForm.ActionAboutExecute(Sender: TObject);
begin
//  MyAboutWin(application.Handle ,
//    PChar(AppName), PChar(AppVersion));
  MyAboutWinExEx(application.Handle , pchar(PrjName),
    PChar(AppName), PChar(AppVersion), pchar(CopyRight), pchar(Author));
   //  MyAboutWinEx(application.Handle, pchar(appname),
end;

procedure TMainForm.ActionAdjustTimeExecute(Sender: TObject);
var
  frm : TAdjustForm;
//  day: Tdate;
begin
//    if lvTime.SelCount=0 then
//        day := now
//    else
//        day := strToDate(lvTime.Selected.SubItems[0]);


    frm := TAdjustForm.Create(nil);
    frm.setDate(mcTime.Date);    
    frm.ShowModal;
    frm.Free;
end;

procedure TMainForm.ActionDelExecute(Sender: TObject);
var
  idx: integer;
begin
  if listview2.SelCount <1 then exit;

  if (MessageBox(self.Handle, '确定要删除吗？','确认',
        mb_yesno+mb_iconquestion)<>mryes) then  exit;

  idx := ListView2.Selected.Index;
  doneList.Delete(idx);
  //ListView2.DeleteSelected;

  saveDoneList();
  loadDoneList();
end;

procedure TMainForm.ActionDoneExecute(Sender: TObject);
var
  idx: integer;
begin
//
  //showmessage( inttostr( ListView1.Selected.Index) );
  if listview1.SelCount <1 then exit;

  if (MessageBox(self.Handle, '确定这项备忘已完成吗？','确认',
        mb_yesno+mb_iconquestion)<>mryes) then  exit;


  idx := ListView1.Selected.Index;
  //showMessage(inttostr(idx));
  doneList.Insert(0, todoList[idx]);
  
  todoList.Delete(idx);
  ListView1.Items[idx].Delete;// .DeleteSelected;
  refreshTodoCount;
  saveTodoList();
  saveDoneList();

  loadDoneList();

end;

procedure TMainForm.ActionEditExecute(Sender: TObject);
var
  frm: TDetailForm;
  rec: TDetailRec;
  item: TListItem;
begin
  if listview1.SelCount <1 then exit;
  item := ListView1.Selected;
  rec := strtorec(todoList[item.Index]);
  
   frm := TDetailForm.Create(nil);
   frm.modTask(rec);
   frm.ShowModal();
   if frm.isNeedRefresh() then
   begin
     rec.title := frm.Edit1.Text;
     rec.content := getContent(frm.Memo1.Lines, BREAK_CHAR);
     rec.deadline := frm.DateTimePicker1.DateTime;
     todoList[item.Index] := (rec.title+'|'+rec.content+'|'+datetostr(rec.deadline));
     saveTodoList();
     loadTodoList();
   end;
   frm.Free;
end;

procedure TMainForm.ActionExitExecute(Sender: TObject);
begin
  close;

end;

procedure TMainForm.ActionNewTaskExecute(Sender: TObject);
var
  frm: TDetailForm;
  rec: TDetailRec;
begin
   frm := TDetailForm.Create(nil);
   frm.newTask();
   frm.ShowModal();
   if frm.isNeedRefresh() then
   begin
     rec.title := frm.Edit1.Text;
     rec.content := getContent(frm.Memo1.Lines, BREAK_CHAR);
     rec.deadline := frm.DateTimePicker1.DateTime;
     todoList.Insert(0, rec.title+'|'+rec.content+'|'+datetostr(rec.deadline));
     saveTodoList();
     loadTodoList();
   end;
   frm.Free;
end;

procedure TMainForm.ActionShowHideExecute(Sender: TObject);
begin 
  if self.Visible then
  begin
    self.Hide;
    TrayIcon1.ShowBalloonHint;
  end
  else self.Show;
  
end;

procedure TMainForm.ActionWorkInExecute(Sender: TObject);
begin
   writeTodayWorkIn;
end;

procedure TMainForm.ActionWorkOutExecute(Sender: TObject);
begin
    writeTodayWorkOut;
end;

procedure TMainForm.actViewExecute(Sender: TObject);
var
  frm: TDetailForm;
  rec: TDetailRec;
  item: TListItem;
begin
  if listview2.SelCount <1 then exit;
  item := ListView2.Selected;
  rec := strtorec(doneList[item.Index]);
  
   frm := TDetailForm.Create(nil);
   frm.viewTask(rec);
   frm.ShowModal();

   frm.Free;

end;

procedure TMainForm.bbtShortCutClick(Sender: TObject);
begin
  CreateDesktopLink(ParamStr(0), ' ', '桌面备忘录.lnk', Application.Title);
end;

procedure TMainForm.BitBtn2Click(Sender: TObject);
begin
      FLunchBreakStart := dtpBreakStart.Time;
      FLunchBreakEnd   := dtpBreakEnd.Time;
      FSupperStart     := dtpSupperStart.Time;
      FSupperEnd       := dtpSupperEnd.Time;

      saveSettings();
    

end;

function TMainForm.calcWorkTime(workIn, workOut: Ttime): double;
var
    morning, afternoon, night: integer;
    tmpWorkIn, tmpWorkOut: TTime;
begin

    morning     := 0;
    afternoon   := 0;
    night       := 0;

    if workIn=workOut then
    begin
        result  := 0;
        exit;
    end;

    logit(datetimetostr(workIn));
    logit(datetimetostr(workOut));

    // 算上午的工时
    if (workIn <= FLunchBreakStart) then
    begin
        tmpWorkIn   := workIn;
        tmpWorkOut  := workOut;
        if (workOut > FLunchBreakStart) then
            tmpWorkOut := FLunchBreakStart;

        morning := SecondsBetween(tmpWorkIn, tmpWorkOut);

    end;

    // 算下午的工时
    if (workIn <= FSupperStart) then
    begin          
        tmpWorkIn   := workIn;
        tmpWorkOut  := workOut;
        // 午休时间不算
        if workIn <= FLunchBreakEnd then
            tmpWorkIn := FLunchBreakEnd;

        if workOut <= FLunchBreakEnd then
            tmpWorkOut := FLunchBreakEnd
        else if workOut > FSupperStart then
            tmpWorkOut := FSupperStart;

        afternoon := SecondsBetween(tmpWorkIn, tmpWorkOut);
    end;

    // 算晚上的工时
    if (workOut > FSupperEnd) then
    begin
        tmpWorkIn   := workIn;
        tmpWorkOut  := workOut;
        if (workIn < FSupperEnd) then
            tmpWorkIn := FSupperEnd;
        night := SecondsBetween(tmpWorkIn, tmpWorkOut);
    end;

    
     (*



    // 早上打卡上班
    if (workIn <= FLunchBreakStart) then
    begin
        logit('早上打卡上班');
        // 早上就离岗
        if (workOut <= FLunchBreakStart) then
        begin
                morning     := SecondsBetween(workIn, workOut);
                logit('早上就离岗');
        end
            else if (workOut > FLunchBreakStart)
                and (workOut <= FLunchBreakEnd) then
            begin
                morning     := SecondsBetween(workIn, FLunchBreakStart);
                logit('中午离岗');
            end
            else if (workOut > FLunchBreakEnd)
                and (workOut <= FSupperStart) then
            begin
                morning     := SecondsBetween(workIn, FLunchBreakStart);
                afternoon   := SecondsBetween(FLunchBreakEnd, workOut);
                logit('下午离岗');
            end else if (workOut > FSupperStart)
                    and (workOut <= FSupperEnd) then
            begin
                morning     := SecondsBetween(workIn, FLunchBreakStart);
                afternoon   := SecondsBetween(FLunchBreakEnd, FSupperStart);
                logit('晚餐时离岗');
            end
            else if (workOut > FSupperEnd) then
            begin
                morning     := SecondsBetween(workIn, FLunchBreakStart);
                afternoon   := SecondsBetween(FLunchBreakEnd, FSupperStart);
                night       := SecondsBetween(FSupperEnd, workOut);
                logit('晚上加班');
            end;
    end else

    // 下午才来
    if (workIn <= FSupperStart) then
    begin
        logit('上午下班后才来');
        if workIn <= FLunchBreakEnd then
            workIn := FLunchBreakEnd;

        if workOut <= FLunchBreakEnd then
            workOut := FLunchBreakEnd;
        
        

        if (workIn <= FLunchBreakEnd) then
        begin
            logit('午休到岗');
            if (workOut <= FLunchBreakEnd) then
            begin
                afternoon   := 0
                logit('午休离岗');
            end
            // 下午走的
            else
            begin
                afternoon   := SecondsBetween(FLunchBreakEnd, workOut);
                logit('下午离岗');
            end;
        end
        else
        // 午休后来的
        if (workOut > FLunchBreakEnd)
            and (workOut <= FSupperStart) then
            begin
                afternoon   := SecondsBetween(workIn, workOut);
                logit('下午就走了');
            end
        else if (workOut > FSupperStart)
            and (workOut <= FSupperEnd) then
            begin
                afternoon   := SecondsBetween(workIn, FSupperStart);
                logit('晚餐时间走的');
            end
            else if (workOut > FSupperEnd) then
            begin
                afternoon   := SecondsBetween(FLunchBreakEnd, FSupperStart);
                night       := SecondsBetween(FSupperEnd, workOut);
                logit('晚上加班');
            end;
    end

    // 晚上来的
    else if (workIn > FSupperStart) then
    begin
        logit('下午下班后才来');
        if workOut >= FSupperEnd then
                night       := SecondsBetween(FSupperEnd, workOut);

    end;                *)
    logit('早上' + floattostr(morning / 60));
    logit('下午' + floattostr(afternoon / 60));
    logit('晚上' + floattostr(night / 60));
    logit('总计' + floattostr((morning + afternoon + night) / 60) + '分钟');
    result := (morning + afternoon + night) / 3600;

end;

procedure TMainForm.cbAutoStartClick(Sender: TObject);
begin
  regAutoStart(cbAutoStart.Checked);
end;

procedure TMainForm.cbQueryOnExitClick(Sender: TObject);
begin
  regQueryOnExit(cbQueryOnExit.Checked);
end;

procedure TMainForm.cbShowWorktimeClick(Sender: TObject);
begin
    regWorktime(cbShowWorktime.Checked);
    updateUI();  
    
end;

procedure TMainForm.cbstayontopClick(Sender: TObject);
begin
  regTop(cbstayontop.Checked);
  if cbstayontop.Checked then
    self.FormStyle := fsStayOnTop
  else self.FormStyle := fsNormal;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  writeTodayWorkOut;

  todoList.Free;
  //todolist.Destroy;
  donelist.Free;
  //doneList.Destroy;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    writeTodayWorkOut;
    if cbQueryOnExit.Checked then     
        if MessageBox(self.Handle, '确定要退出程序吗？',
            '确认', mb_yesno+mb_iconquestion) <> mryes then
            CanClose:=false;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FAppPath := ExtractFileDir(Application.ExeName);

  writeTodayWorkIn;
  writeTodayWorkOut;

  todoList := TStringList.create();
  doneList := TStringList.create();

  loadTodoList;
  loadDoneList;

  loadSettings;
  
end;

procedure TMainForm.FormDblClick(Sender: TObject);
begin
    ts5.TabVisible := not ts5.TabVisible;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
    writeTodayWorkOut;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
    PageControl1.ActivePageIndex := 0;
    ts5.TabVisible  := false;
    mcTime.Date     := today();  

end;

function TMainForm.getContent(lines: TStrings; sp:char='*'): string;
var
  i: integer;
begin
  result := '';
  for I := 0 to Lines.Count - 1 do
       begin
         result := result+trim(Lines[i])+sp;
       end;
  result := copy(result, 0, length(result)-1);
end;

function TMainForm.getLines(content: string; sp:char='*'): string; //TStrings;
//var
//  p: integer;
begin
  //result := TStringList.Create;
  //result := '';
//  p:=pos(sp, content);
  result :=StringReplace(content, sp, #13, [rfReplaceAll,   rfIgnoreCase]);

  (*
  while (p<>-1) do
  begin
    //result.Add(copy(content,0, p-1));
    StringReplace(
    content := copy(content, p+1, length(content)-p+1);
    p:=pos(content, sp);
  end;
      *)
end;

procedure TMainForm.getMonthtime(someday: TDatetime);
var
    i: integer;
    aIni: TIniFile;
    daytime: double;
    monthtime: double;
    oneday: TDatetime;
    inTime, outTime: String;
begin
    // daytime := 0;
    monthtime := 0;
    oneday := someday - DayOfTheMonth(someday);

    aIni := TIniFile.Create(FAppPath + '\worktime.data');

    for I := 1 to DaysInMonth(someday) do
    begin
        inTime  := aIni.ReadString('WORKIN', datetostr(oneday), '0:0:1');
        outTime := aIni.ReadString('WORKOUT', datetostr(oneday), '0:0:1');

        daytime     := calcWorkTime(strtotime(inTime), strtotime(outTime));
        monthtime   := monthtime + daytime;

        oneday := oneday + 1;
    end;
    LabelMonthtime.Caption :=  floattostr(round(monthtime * 100) / 100);
    aIni.Free;
end;


procedure TMainForm.getWeektime(someday: TDatetime);
var   
  i: byte;
  aIni: TIniFile;
  oneday: TDatetime;
  dayofwk: byte;
  inTime, outTime: String;
  aItem: TListItem;
  weektime: double;
  daytime: double;

  function DayOfWeekInChineseNum(d: byte): string;
  begin
       case d of
          1: result := '一';
          2: result := '二';
          3: result := '三';
          4: result := '四';
          5: result := '五';
          6: result := '六';
          7: result := '日';
          else ;
       end;
  end;
begin
   // daytime     := 0;
    weektime    := 0;
    dayofwk     := DayOfTheWeek(someday);
    
    lvtime.Clear;

    aIni := TIniFile.Create(FAppPath + '\worktime.data');

    for I := 1 to 7 do
    begin
        oneday      := someday + i - dayofwk;
        inTime      := aIni.ReadString('WORKIN', formatdatetime('yyyy-MM-dd', oneday), '0:0:0');
        outTime     := aIni.ReadString('WORKOUT', formatdatetime('yyyy-MM-dd', oneday), '0:0:0');
        daytime     := calcWorkTime(strtotime(inTime), strtotime(outTime));
        weektime    := weektime + daytime;
        daytime     := round(daytime * 100) / 100;

        aItem       := lvTime.Items.Add;
        aItem.Caption := DayOfWeekInChineseNum(i);

        aItem.SubItems.Add(Datetostr(oneday)); 
        aItem.SubItems.Add(inTime);
        aItem.SubItems.Add(outTime);
         
        aItem.SubItems.Add(floattostr(daytime));

    end;

    LabelWeektime.Caption   := floattostr(round(weektime * 100) / 100);
    aIni.Free;

end;

procedure TMainForm.ListView1InfoTip(Sender: TObject; Item: TListItem;
  var InfoTip: string);
var
  rec: TDetailRec;
begin
  rec := strtorec(todoList[item.Index]);
  infotip := '标题：' + rec.title + #10#13
           + '期限：' + datetostr(rec.deadline) + #10#13
           + '内容：' + rec.content;
end;

procedure TMainForm.ListView2InfoTip(Sender: TObject; Item: TListItem;
  var InfoTip: string);
var
  rec: TDetailRec;
begin
  rec := strtorec(doneList[item.Index]);
  infotip := '标题：' + rec.title + #10#13
           + '期限：' + datetostr(rec.deadline) + #10#13
           + '内容：' + rec.content;
end;

procedure TMainForm.loadDoneList;
var
  i: integer;
  lit: TListItem;
  rec: TDetailRec;
begin
  doneList.Clear;
  doneList.LoadFromFile(ExtractFileDir(Application.ExeName)+'\doneTask.lst');

  ListView2.Clear;
  
  for i := 0 to doneList.Count - 1 do
  begin
    rec := strToRec(doneList[i]);
    lit := ListView2.Items.Add();
    lit.Caption := 'v';
    lit.SubItems.Add(rec.title);
    lit.SubItems.Add(datetostr(rec.deadline));
    //lit.SubItems.Add(rec.content);
  end;

end;

procedure TMainForm.loadSettings;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create();
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  try
    reg.OpenKey(APP_REG, true);
    cbAutoStart.Checked := reg.ReadBool('autostart');
    cbstayontop.Checked := reg.ReadBool('stayontop');
    cbShowWorktime.Checked := reg.ReadBool('showworktime');
    cbQueryOnExit.Checked := reg.ReadBool('queryonexit');

    FLunchBreakStart    := TimeOf(reg.ReadTime('LunchBreakStart'));
    FLunchBreakEnd      := TimeOf(reg.ReadTime('LunchBreakEnd'));
    FSupperStart        := TimeOf(reg.ReadTime('SupperStart'));
    FSupperEnd          := TimeOf(reg.ReadTime('SupperEnd'));

  except
    //reg.WriteBool('autostart', false);
      cbAutoStart.Checked := false;
      cbstayontop.Checked := false;
      cbShowWorktime.Checked := true;
      cbQueryOnExit.Checked := true;

      FLunchBreakStart := TimeOf(StrToTime('12:30:00'));
      FLunchBreakEnd   := TimeOf(StrToTime('14:00:00'));
      FSupperStart     := TimeOf(StrToTime('17:30:00'));
      FSupperEnd       := TimeOf(StrToTime('18:00:00'));
    
  end;
  reg.CloseKey;

    dtpBreakStart.Time  := FLunchBreakStart;
    dtpBreakEnd.Time    := FLunchBreakEnd;
    dtpSupperStart.Time := FSupperStart;
    dtpSupperEnd.Time   := FSupperEnd;

    updateUI();

    logit('LunchBreakStart - ' + datetimetostr(FLunchBreakStart));
    logit('LunchBreakEnd - ' + datetimetostr(FLunchBreakEnd));
    logit('SupperStart - ' + datetimetostr(FSupperStart));
    logit('SupperEnd - ' + datetimetostr(FSupperEnd));

end;

procedure TMainForm.loadTodoList;
var
  i: integer;
  lit: TListItem;
  rec: TDetailRec;
begin
  todoList.Clear;
  todoList.LoadFromFile(ExtractFileDir(Application.ExeName)+'\todoTask.lst');

  ListView1.Clear;
  
  for i := 0 to todoList.Count - 1 do
  begin
    rec := strToRec(todoList[i]);
    lit := ListView1.Items.Add();
    lit.Caption := 'x';
    lit.SubItems.Add(rec.title);
    lit.SubItems.Add(datetostr(rec.deadline));
    //lit.SubItems.Add(rec.content);
  end;
  refreshTodoCount();

end;

procedure TMainForm.logit(msg: string);
begin
    if ts5.TabVisible then
        LogMemo.Lines.Add(msg);
end;

procedure TMainForm.mcTimeClick(Sender: TObject);
begin
    writeTodayWorkOut;
    getWeektime(mcTime.Date);
    getMonthtime(mcTime.Date);
end;

procedure TMainForm.refreshTodoCount;
begin   
  if todoList.Count = 0 then
  begin
    rzMaq.Font.Color := clGreen;
    rzMaq.Caption := '暂无备忘！';
  end else begin
    rzMaq.Font.Color := clred;
    rzMaq.Caption := '共有 '+inttostr(todoList.Count)+' 条备忘！';
  end;
end;

procedure TMainForm.regAutoStart(chk: boolean);
var
  reg: TRegistry;
begin 
  reg := TRegistry.Create();
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',true);
  if chk then
  begin
    reg.WriteString('deskMemo','"'+Application.ExeName+'"');
  end else begin
    reg.DeleteValue('deskMemo');//.DeleteKey('deskMemo');
  end;
  reg.CloseKey;
  reg.OpenKey(APP_REG, true);
  reg.WriteBool('autostart', chk);
  reg.CloseKey;

end;

procedure TMainForm.regQueryOnExit(chk: boolean);
var
  reg: TRegistry;
begin 
  reg := TRegistry.Create();
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  reg.OpenKey(APP_REG, true);
  reg.WriteBool('queryonexit', chk);
  reg.CloseKey;

end;

procedure TMainForm.regTop(chk: boolean);
var
  reg: TRegistry;
begin 
  reg := TRegistry.Create();
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  reg.OpenKey(APP_REG, true);
  reg.WriteBool('stayontop', chk);
  reg.CloseKey;
end;

procedure TMainForm.regWorktime(chk: boolean);
var
  reg: TRegistry;
begin 
  reg := TRegistry.Create();
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  reg.OpenKey(APP_REG, true);
  reg.WriteBool('showworktime', chk);
  reg.CloseKey;
end;

procedure TMainForm.saveDoneList;
begin
  doneList.SaveToFile(ExtractFileDir(Application.ExeName)+'\doneTask.lst');
end;

procedure TMainForm.saveSettings;
var
  reg: TRegistry;
begin 
  reg := TRegistry.Create();
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  reg.OpenKey(APP_REG, true);

  reg.WriteTime('LunchBreakStart', FLunchBreakStart);
  reg.WriteTime('LunchBreakEnd', FLunchBreakEnd);
  reg.WriteTime('SupperStart', FSupperStart);
  reg.WriteTime('SupperEnd', FSupperEnd);

  reg.CloseKey;

end;

procedure TMainForm.saveTodoList;
begin
  todoList.SaveToFile(ExtractFileDir(Application.ExeName)+'\todoTask.lst');
end;

function TMainForm.strToRec(str: String): TDetailRec;
var
  p: integer;
  //tmpstr: string;
begin
  p := pos('|', str);
  result.title := copy(str, 0, p-1); //LeftStr(str, p-1);
  str := copy(str, p+1, length(str)-p+1); //rightstr(str, length(str)-p);
  p := pos('|', str);
  result.content := getLines(copy(str, 0, p-1), BREAK_CHAR); //leftStr(str, p-1);
  result.deadline := strtodate(copy(str, p+1, length(str)-p+1));  //rightstr(str,length(str)-p));

end;

procedure TMainForm.tsWorktimeShow(Sender: TObject);
begin
    writeTodayWorkOut;
    getWeektime(now);
    getMonthtime(now);
end;

procedure TMainForm.updateUI;
var
  chk : boolean;
begin
    chk := cbShowWorktime.Checked;
    gbWorktimeSet.Visible := chk;
    tsWorktime.TabVisible := chk;
    
end;

procedure TMainForm.writeTodayWorkIn;
var
  aIni: TIniFile;
  today: TDatetime;
begin
        aIni := TIniFile.Create(FAppPath + '\worktime.data');

        today := aIni.ReadDateTime('WORKIN', datetostr(now), strtodatetime('2000-1-1 0:0:0'));
        //infoMsg(datetimetostr(today));
        if today=strtodatetime('2000-1-1 0:0:0') then
        begin
            today := now;
            aIni.WriteString('WORKIN', formatdatetime('yyyy-MM-dd', now), formatdatetime('H:mm:ss', today));
        end;

        //dtpWorkIn.DateTime := today;
        
        aIni.Free;
end;

procedure TMainForm.writeTodayWorkOut;
var
  aIni: TIniFile;
begin
        aIni := TIniFile.Create(FAppPath + '\worktime.data');
        aIni.WriteString('WORKOUT',
            formatdatetime('yyyy-MM-dd', now),
            formatdatetime('H:mm:ss', now));
        
        aIni.Free;
end;





end.
