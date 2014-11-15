unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, jpeg,math,
  Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Image1: TImage;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  img:array of array of double;

implementation

{$R *.dfm}

uses FRACPRISMUnit1, Unit3;
 var filenameimg:string;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form2.Hide;
Form1.Show;
end;

{
  The following function helps you to convert a RGB Color to Grayscale.
  It works after the american NTSC (National Televisision Standards Committee)
  system.
}


function getGreyScale(Color: TColor): TColor;
var
   R,G,B: Integer;
begin
 Color := ColorToRGB (Color);
  R := Color and $ff;
  G := (Color and $ff00) shr 8;
  B := (Color and $ff0000) shr 16;
  //  NTSC (National Televisision Standards Committee) standart;
  Color := Round(R * 0.56 + G * 0.33 + B * 0.11);
  Result := RGB(Color, Color, Color);
end;

function getGreyScalePixel(Color: TColor): double;
var
   R,G,B: Integer;
begin
 Color := ColorToRGB (Color);
  R := Color and $ff;
  G := (Color and $ff00) shr 8;
  B := (Color and $ff0000) shr 16;
  //  NTSC (National Televisision Standards Committee) standart;
 Result := Round(R * 0.56 + G * 0.33 + B * 0.11);
end;


procedure TForm2.SpeedButton1Click(Sender: TObject);
var
  bmp: TBitmap;
  jpg: TJpegImage;
  I, ButtonSelected,ButtonSelectedMTRX: Integer;
  J: Integer;
begin
   buttonSelected := VCL.Dialogs.MessageDlg('Load a new file for processing?',
   mtConfirmation,
   [mbYes,mbNo,mbCancel], 0);

if buttonSelected = mrYes    then begin
  if opendialog1.execute then
  begin
    jpg := TJpegImage.Create;
    try
      jpg.Loadfromfile(opendialog1.filename);
      filenameimg:=opendialog1.filename;
      bmp := TBitmap.Create;
      try

        bmp.Width :=jpg.Width  {* scale};
        bmp.Height:= jpg.Height {* scale};
        bmp.Canvas.StretchDraw(bmp.Canvas.Cliprect, jpg);
  Form2.Memo1.Lines.Add( Inttostr( bmp.Width)+ ' x '
  +Inttostr( bmp.Height));
  SetLength(img, bmp.Width, bmp.Height);
         jpg.Assign(bmp);

      {  jpg.SaveToFile(
          ChangeFileext(opendialog1.filename, '_thumb.JPG')
        );
       }
      // bmp.Canvas.Pixels[30,30]:=clRed;
       for I :=  0 to bmp.Width-1 do
       for J := 0 to bmp.Height-1 do
   begin
   img[i,j]:=getGreyScalePixel(bmp.Canvas.Pixels[i,j]);
   bmp.Canvas.Pixels[i,j]:=GetGreyScale(bmp.Canvas.Pixels[i,j]);
   if i div 5 =0 then Application.ProcessMessages;

    end;
     ButtonSelectedMTRX := VCL.Dialogs.MessageDlg('Do you want to use image data to calculate the fractal dimension map?',
          mtConfirmation, [mbYes,mbNo], 0);
   if  ButtonSelectedMTRX=mrYes then  begin
     Form1.LabeledEdit1.Value:=bmp.Width;
     Form1.LabeledEdit2.Value:=bmp.Height;
     Form1.CheckBox4.Checked:=true;
     end;

          jpg.Assign(bmp);
          Form3.image1.Width:=bmp.Width;
          Form3.Image1.Height:=bmp.Height;
          Form3.Width:=700;
          Form3.Height:=460;
          Form3.image1.Picture.Assign(bmp);
          image1.Picture.Assign(bmp);
          Form3.Show;



      finally
        bmp.free;

      end;
    finally
      jpg.free;
    end;
  end;

end;

if buttonSelected = mrNo    then begin

  jpg := TJpegImage.Create;
    try
      jpg.Loadfromfile(filenameimg);
      bmp := TBitmap.Create;
   (*   if jpg.Height > jpg.Width then
        scaleX := {240 /} jpg.Height
      else
        scaleX := {320 / }jpg.Width; *)

      try
        bmp.Width := Round(jpg.Width );
        bmp.Height:= Round(jpg.Height);
        bmp.Canvas.StretchDraw(bmp.Canvas.Cliprect, jpg);
  Form2.Memo1.Lines.Add( Inttostr( bmp.Width)+ ' x '
  +Inttostr( bmp.Height));
  SetLength(img, bmp.Width, bmp.Height);
       for I :=  0 to bmp.Width-1 do
       for J := 0 to bmp.Height-1 do
   begin
   img[i,j]:=getGreyScalePixel(bmp.Canvas.Pixels[i,j]);
   bmp.Canvas.Pixels[i,j]:=GetGreyScale(bmp.Canvas.Pixels[i,j]);
   if i div 5 =0 then Application.ProcessMessages;
    end;
          jpg.Assign(bmp);
          Form3.image1.Width:=bmp.Width;
          Form3.Image1.Height:=bmp.Height;
          Form3.Width:=700;
          Form3.Height:=460;
          Form3.image1.Picture.Assign(bmp);
          image1.Picture.Assign(bmp);
          Form3.ShowModal;
      finally
        bmp.free;
      end;
    finally
      jpg.free;
    end;
end;
if buttonSelected = mrCancel    then exit;

end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
Var saveDialog : TSaveDialog;
 buttonSelected,i,j : Integer;
selectedsaveFile2 : string;
  myFile2,mysaveFile2 : TextFile;
 s1:string;
begin
if Length(img)>0 then BEGIN

       buttonSelected := VCL.Dialogs.MessageDlg('Save to new file?',mtCustom,
   [mbYes,mbCancel], 0);

if buttonSelected = mrYes    then begin
  saveDialog := TSaveDialog.Create(Form2);
   saveDialog.Title := 'Save your  data into new file';
 saveDialog.InitialDir := GetCurrentDir;
 saveDialog.Filter := 'dat file for Wolfram@Math import [x,y,z]|.dat|txt file [only z-values] |.txt';
 saveDialog.DefaultExt := 'dat';
  saveDialog.FilterIndex := 1;

  if saveDialog.Execute
  then ShowMessage('File : '+saveDialog.FileName)
  else begin ShowMessage('Data saving was cancelled'); exit; end;

  selectedsavefile2:=saveDialog.FileName;
saveDialog.Free; end;

 if buttonSelected = mrCancel then exit;

      AssignFile(mysavefile2,selectedsaveFile2); Rewrite(mysavefile2);
       FormatSettings.DecimalSeparator:='.';
   if saveDialog.FilterIndex=1 then   begin
 for I := 0 to Length(img)-1 do
   for J := 0 to Length(img[i])-1 do
     begin
    WriteLn(mysavefile2,FloatToStrf(i+1,ffFixed,4,1)+'  '+
    FloatToStrf(j+1,ffFixed,4,1)+'  '+FloatToStrf(img[i,j],ffFixed,6,4));

     end; end;
  if saveDialog.FilterIndex=2 then   begin
 for I := 0 to Length(img)-1 do
 begin  s1:='';
   for J := 0 to Length(img[i])-1 do
     begin s1:=s1+'  '+FloatToStrf(img[i,j],ffFixed,4,1);

     end;  WriteLn(mysavefile2,s1);   end;    end;

          FormatSettings.DecimalSeparator:=',';
       CloseFile(mysaveFile2);

                  END;

end;

procedure TForm2.SpeedButton3Click(Sender: TObject);
Var  bmp: TBitmap;
  jpg: TJpegImage;
  scale: Double;
  I: Integer;
  J: Integer;
begin

  if opendialog1.execute then
  begin
    jpg := TJpegImage.Create;
    try
      jpg.Loadfromfile(opendialog1.filename);
      filenameimg:=opendialog1.filename;
      if jpg.Height > jpg.Width then
        scale := {240 /} jpg.Height
      else
        scale := {320 / }jpg.Width;
      bmp := TBitmap.Create;
      try
        {Create thumbnail bitmap, keep pictures aspect ratio}
        bmp.Width := Round(jpg.Width  {* scale});
        bmp.Height:= Round(jpg.Height {* scale});
        bmp.Canvas.StretchDraw(bmp.Canvas.Cliprect, jpg);
       // jpg.Assign(bmp);
  Form2.Memo1.Lines.Add( Inttostr( bmp.Width)+ ' x '
  +Inttostr( bmp.Height));
  SetLength(img, bmp.Width, bmp.Height);
  image1.Picture.Assign(bmp);

      finally
        bmp.free;
      end;
    finally
      jpg.free;
    end;
  end;

end;

procedure TForm2.SpeedButton4Click(Sender: TObject);
var i,j,colorpx,redd,greenn:integer;
mx1,mn1: double;
bmp: TBitmap;
begin
if (Length(fracMTRX)>0) then
begin
mx1:=math.MinDouble; mn1:=math.MaxDouble;
 for I := 0 to length(fracMTRX)-1 do
   begin
   if math.MaxValue(fracMTRX[i])> mx1 then
   mx1:=math.MaxValue(fracMTRX[i]);
   if math.MinValue(fracMTRX[i])<mn1 then
   mn1:=math.MinValue(fracMTRX[i]);
   end;
 Form2.Memo1.Lines.Add('max, min= '+ FloattoStr(mx1)+ ' , '+FloattoStr(mn1));
 redd:=round(STRtoInt(Form2.LabeledEdit1.Text));
 greenn:=round(STRtoInt(Form2.LabeledEdit2.Text));
 bmp := TBitmap.Create;
 i:=0;
   bmp.Width := Round(length(fracMTRX));
   bmp.Height:= Round(length(fracMTRX[0]));
  for I := 0 to bmp.Width-1 do
  for j := 0 to  bmp.Height-1 do
     begin
     colorpx:= Round(255*((fracMTRX[i,j]-mn1)/(mx1-mn1)));
       bmp.Canvas.Pixels[i,j]:=RGB(round(colorpx/0.21),
       round((redd+colorpx)/0.72),
       round((greenn+colorpx)/0.07));
     end;
   Form2.image1.Picture.Assign(bmp);
   bmp.Free;

end else
 VCL.Dialogs.MessageDlg('Inconsistent data!',
          mtWarning, [mbOk], 0);

end;

end.
