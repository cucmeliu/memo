object DetailForm: TDetailForm
  Left = 0
  Top = 0
  Caption = #26032
  ClientHeight = 270
  ClientWidth = 337
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    337
    270)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 30
    Height = 16
    Caption = #26631#39064
  end
  object Label2: TLabel
    Left = 16
    Top = 76
    Width = 30
    Height = 16
    Caption = #20869#23481
  end
  object Label3: TLabel
    Left = 16
    Top = 51
    Width = 30
    Height = 16
    Caption = #26399#38480
  end
  object Edit1: TEdit
    Left = 52
    Top = 13
    Width = 259
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    ExplicitWidth = 261
  end
  object DateTimePicker1: TDateTimePicker
    Left = 52
    Top = 43
    Width = 109
    Height = 24
    Date = 40170.934689305560000000
    Time = 40170.934689305560000000
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 52
    Top = 73
    Width = 259
    Height = 150
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 2
    WordWrap = False
    ExplicitWidth = 261
    ExplicitHeight = 152
  end
  object BitBtn1: TBitBtn
    Left = 156
    Top = 237
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #24323
    TabOrder = 3
    OnClick = BitBtn1Click
    ExplicitLeft = 158
    ExplicitTop = 239
  end
  object BitBtn2: TBitBtn
    Left = 237
    Top = 237
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #21462
    TabOrder = 4
    OnClick = BitBtn2Click
    ExplicitLeft = 239
    ExplicitTop = 239
  end
end
