object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'FRAC3D PRISM'
  ClientHeight = 482
  ClientWidth = 704
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 40
    Width = 145
    Height = 401
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 0
      Top = 16
      Width = 145
      Height = 22
      Caption = 'CLARK FRAC A with sliding1'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 0
      Top = 158
      Width = 145
      Height = 22
      Caption = 'Import and transform'
      OnClick = SpeedButton2Click
    end
    object ClearButton: TSpeedButton
      Left = 64
      Top = 359
      Width = 41
      Height = 34
      Caption = 'Clear'
      OnClick = ClearButtonClick
    end
    object SpeedButton3: TSpeedButton
      Left = 0
      Top = 359
      Width = 34
      Height = 34
      Caption = '-'
      OnClick = SpeedButton3Click
    end
    object SpeedButton4: TSpeedButton
      Left = 30
      Top = 359
      Width = 36
      Height = 34
      Caption = '+'
      OnClick = SpeedButton4Click
    end
    object SpeedButton5: TSpeedButton
      Left = 0
      Top = 130
      Width = 145
      Height = 22
      Caption = 'Clark FRAC A as 1985v'
      OnClick = SpeedButton5Click
    end
    object SpeedButton6: TSpeedButton
      Left = 0
      Top = 44
      Width = 58
      Height = 22
      Caption = 'Save FM'
      OnClick = SpeedButton6Click
    end
    object SpeedButton7: TSpeedButton
      Left = 56
      Top = 44
      Width = 49
      Height = 22
      Caption = 'Show FM'
      OnClick = SpeedButton7Click
    end
    object Label1: TLabel
      Left = 24
      Top = 243
      Width = 26
      Height = 13
      Caption = 'steps'
    end
    object Label2: TLabel
      Left = 8
      Top = 186
      Width = 58
      Height = 13
      Caption = 'NUMROW'
    end
    object Label3: TLabel
      Left = 13
      Top = 205
      Width = 53
      Height = 29
      Caption = 'NUMCOL'
    end
    object CheckBox1: TCheckBox
      Left = 24
      Top = 271
      Width = 97
      Height = 17
      Caption = 'Show save data'
      TabOrder = 0
    end
    object LabeledEdit3: TLabeledEdit
      Left = 127
      Top = 286
      Width = 81
      Height = 21
      EditLabel.Width = 10
      EditLabel.Height = 13
      EditLabel.Caption = 'br'
      Enabled = False
      LabelPosition = lpLeft
      TabOrder = 1
      Text = '1'
      Visible = False
    end
    object LabeledEdit5: TLabeledEdit
      Left = 127
      Top = 213
      Width = 81
      Height = 21
      EditLabel.Width = 11
      EditLabel.Height = 13
      EditLabel.Caption = 'bc'
      Enabled = False
      LabelPosition = lpLeft
      TabOrder = 2
      Text = '1'
      Visible = False
    end
    object LabeledEdit6: TLabeledEdit
      Left = 127
      Top = 240
      Width = 81
      Height = 21
      EditLabel.Width = 11
      EditLabel.Height = 13
      EditLabel.Caption = 'ec'
      Enabled = False
      LabelPosition = lpLeft
      TabOrder = 3
      Text = '17'
      Visible = False
    end
    object Swich1: TCheckBox
      Left = 24
      Top = 298
      Width = 97
      Height = 17
      Caption = 'Swich #1'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object ShowInput: TCheckBox
      Left = 24
      Top = 321
      Width = 97
      Height = 17
      Caption = 'Show I'
      TabOrder = 5
    end
    object LabeledEdit7: TSpinEdit
      Left = 56
      Top = 240
      Width = 65
      Height = 22
      MaxValue = 21
      MinValue = 3
      TabOrder = 6
      Value = 3
    end
    object LabeledEdit4: TLabeledEdit
      Left = 127
      Top = 313
      Width = 81
      Height = 21
      EditLabel.Width = 10
      EditLabel.Height = 13
      EditLabel.Caption = 'er'
      Enabled = False
      LabelPosition = lpLeft
      TabOrder = 7
      Text = '17'
      Visible = False
    end
    object LabeledEdit1: TSpinEdit
      Left = 56
      Top = 185
      Width = 65
      Height = 22
      MaxValue = 5000
      MinValue = 7
      TabOrder = 8
      Value = 17
    end
    object LabeledEdit2: TSpinEdit
      Left = 56
      Top = 203
      Width = 65
      Height = 22
      MaxValue = 5000
      MinValue = 7
      TabOrder = 9
      Value = 17
    end
  end
  object Memo1: TMemo
    Left = 199
    Top = 40
    Width = 449
    Height = 401
    Color = clInfoText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
  end
end
