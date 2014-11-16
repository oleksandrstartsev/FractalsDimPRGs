unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,jpeg,
  Vcl.Buttons;

type
  TForm3 = class(TForm)
    Image1: TImage;
    ScrollBar1: TScrollBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    Image2: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm3.CheckBox1Click(Sender: TObject);
begin
if not Form3.CheckBox1.Checked then
begin
keyDf:=false;
  Form3.Image1.Picture.Assign(bmpz);
  Form3.Image2.Picture.Assign(plotlabelz);
     Form3.Label4.Caption:= labelmarkz[0];
     Form3.Label5.Caption:= labelmarkz[1];
     Form3.Label6.Caption:= labelmarkz[2];
     Form3.Label7.Caption:= labelmarkz[3];
     Form3.Label8.Caption:= labelmarkz[4];
end else begin
keyDf:=true;
  Form3.Image1.Picture.Assign(bmpx);
  Form3.Image2.Picture.Assign(plotlabelx);
   Form3.Label4.Caption:= labelmarkx[0];
     Form3.Label5.Caption:= labelmarkx[1];
     Form3.Label6.Caption:= labelmarkx[2];
     Form3.Label7.Caption:= labelmarkx[3];
     Form3.Label8.Caption:= labelmarkx[4];
end;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form3.Hide;

end;

procedure TForm3.ScrollBar1Change(Sender: TObject);
begin
Form3.Image1.Width:=round(Form3.Image1.Picture.Width*Form3.ScrollBar1.Position/100);
Form3.Image1.Height:=round(Form3.Image1.Picture.Height*Form3.ScrollBar1.Position/100);
if Form3.Image1.Width>700 then
 Form3.Width:=round(Form3.Image1.Picture.Width*Form3.ScrollBar1.Position/100)+100;
 if Form3.Image1.Width>460 then
Form3.Height:=round(Form3.Image1.Picture.Height*Form3.ScrollBar1.Position/100)+100;
Form3.Label1.Caption:='Scale= '+InttoStr(Form3.ScrollBar1.Position)+'%';
end;

procedure TForm3.ScrollBar2Change(Sender: TObject);
begin
 Form3.Image1.Left:=24-round(Form3.Image1.Picture.Width*Form3.ScrollBar2.Position/100);

Form3.Label2.Caption:='Left= '+InttoStr(-Form3.ScrollBar2.Position)+'px';
end;

procedure TForm3.ScrollBar3Change(Sender: TObject);
begin
   Form3.Image1.Top:=40-round(Form3.Image1.Picture.Height*Form3.ScrollBar3.Position/100);

Form3.Label3.Caption:='Top= '+InttoStr(-Form3.ScrollBar3.Position)+'px';
end;

procedure TForm3.SpeedButton1Click(Sender: TObject);
Var
 saveDialog1 : TSaveDialog;
buttonSelected:integer;
begin
   buttonSelected := VCL.Dialogs.MessageDlg('Save images as the new .bmp files?',mtCustom,
   [mbYes,mbCancel], 0);
 if buttonSelected=mrYes then  begin

 saveDialog1 := TSaveDialog.Create(Form3);
   saveDialog1.Title := 'Save your  raster image as new .bmp file';
 saveDialog1.InitialDir := GetCurrentDir;
 saveDialog1.Filter := 'bmp|.bmp';
 saveDialog1.DefaultExt := 'bmp';
  saveDialog1.FilterIndex := 1;


if savedialog1.Execute then
begin
   if FileExists(SaveDialog1.FileName) then
begin
if messagedlg('Do you want to replace it?',mtwarning, [mbyes,mbno],7) = mryes
then bmpz.savetofile(SaveDialog1.FileName);
end
else begin bmpz.savetofile(savedialog1.FileName); end;

end;

saveDialog1 := TSaveDialog.Create(Form3);
   saveDialog1.Title := 'Save your   Dfc as new .bmp file';
 saveDialog1.InitialDir := GetCurrentDir;
 saveDialog1.Filter := 'bmp|.bmp';
 saveDialog1.DefaultExt := 'bmp';
  saveDialog1.FilterIndex := 1;


if savedialog1.Execute then
begin
   if FileExists(SaveDialog1.FileName) then
begin
if messagedlg('Do you want to replace it?',mtwarning, [mbyes,mbno],7) = mryes
then bmpx.savetofile(SaveDialog1.FileName);
end
else begin bmpx.savetofile(savedialog1.FileName); end;

end;


 end;

end;

end.
