object AdjustForm: TAdjustForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #35843#25972#26102#38388
  ClientHeight = 135
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 18
    Top = 24
    Width = 32
    Height = 19
    Caption = #26085#26399
  end
  object Label2: TLabel
    Left = 18
    Top = 57
    Width = 32
    Height = 19
    Caption = #19978#29677
  end
  object Label3: TLabel
    Left = 178
    Top = 57
    Width = 32
    Height = 19
    Caption = #19979#29677
  end
  object dtpDate: TDateTimePicker
    Left = 56
    Top = 16
    Width = 113
    Height = 27
    Date = 40816.912541932870000000
    Time = 40816.912541932870000000
    DateMode = dmUpDown
    TabOrder = 0
    OnChange = dtpDateChange
  end
  object dtpWorkin: TDateTimePicker
    Left = 56
    Top = 49
    Width = 113
    Height = 27
    Date = 40816.912579479170000000
    Time = 40816.912579479170000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Kind = dtkTime
    ParentFont = False
    TabOrder = 1
  end
  object dtpWorkout: TDateTimePicker
    Left = 216
    Top = 49
    Width = 113
    Height = 27
    Date = 40816.912599768520000000
    Time = 40816.912599768520000000
    Kind = dtkTime
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 167
    Top = 96
    Width = 75
    Height = 25
    Caption = #35843#25972'(&J)'
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 248
    Top = 96
    Width = 75
    Height = 25
    Caption = #20851#38381'(&C)'
    TabOrder = 4
    OnClick = BitBtn2Click
  end
end
