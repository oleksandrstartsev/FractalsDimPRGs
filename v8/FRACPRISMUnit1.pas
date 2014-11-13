unit FRACPRISMUnit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,math,
  Vcl.ExtCtrls, Vcl.Samples.Spin, Vcl.Grids, Vcl.Outline, Vcl.Samples.DirOutln;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ClearButton: TSpeedButton;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    Swich1: TCheckBox;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ShowInput: TCheckBox;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    LabeledEdit7: TSpinEdit;
    Label1: TLabel;
    LabeledEdit1: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    LabeledEdit2: TSpinEdit;
    LabeledEdit4: TLabeledEdit;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    CheckBox2: TCheckBox;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Panel2: TPanel;
    LabeledEdit8: TLabeledEdit;
    CheckBox3: TCheckBox;
    RadioButton7: TRadioButton;
    RadioGroup2: TRadioGroup;
    RadioButton8: TRadioButton;
    RadioButton11: TRadioButton;
    RadioButton10: TRadioButton;
    RadioButton9: TRadioButton;
    Label4: TLabel;
    procedure ClearButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
MAXROW:integer=1025;  {*Upper size limits of array for DEM }
MAXCOL:integer=1025;  {plus two. Change numbers to suit   }
NUMROW:integer;
NUMCOL:integer;
area,resolution: array of double;
dimension: double;
breakpoint1:boolean;
zmin,zmax: double;
rowmax, colmax, steps, begin_row, end_row,begin_col, end_col, timex:integer;
  selectedFile,selectedsaveFile : string;
  myFile,mysaveFile : TextFile;
  Sarray: array of string;
  Iarray,matrix, fracMTRX: array of array of double;
  precision_total,precision_frac:integer;

  (*FOXVIEWER variables +'1'*)
  selectedFile1,selectedsaveFile1 : string;
  myFile1,mysaveFile1 : TextFile;
  Sarray1: array of string;
  Iarray1: array of array of double;  //end file variables;
  window_size, num_divisors:integer;
   divisors: array of integer;
implementation

{$R *.dfm}

procedure findPRECISION(firstWord:string);
Var i,j,k: integer;
begin
    if Length(trim(firstWord))>0 then
    begin
     firstWord:=trim(firstWord);  k:=length(firstWord);
     for I :=1 to length(firstWord) do
       begin
       if ord(firstWord[I])=44 then firstWord[I]:='.';
        if ord(firstWord[I])=46 then begin k:=I; continue; end;
       end;
       if length(firstWord)> precision_total then
     precision_total:=length(firstWord);
       if length(firstWord)-k> precision_frac then
     precision_frac:=length(firstWord)-k;
    end else begin
      ShowMessage('Smth is wrong with input data:: precision or dot');

     (* precision_total:=5;precision_frac:=2; *)
      exit;
    end;
end;           

 (*~FOXVIEWER procedures*)
  procedure readExportedTxtThermogramFile();
Var first: string;
i,j,k: integer;
begin
selectedFile1:='';
    FormatSettings.DecimalSeparator:='.';
    if VCL.Dialogs.PromptForFileName(selectedFile1,
                       'import TXT file with Temperature matrix|*.txt',
                       '',
                       'Select your data file',
                       GetCurrentDir,
                       False)
  then
        begin


         end;

   if length(selectedFile1)<=3 then begin
    ShowMessage('Warning: you have not selected any files');
          FormatSettings.DecimalSeparator:=','; exit;
        end else   Form1.Memo1.Lines.Add('Selected file1= '+selectedFile1);

  AssignFile(myFile1, selectedFile1);
  Reset(myFile1);         //skip a few lines with unnecessary data;
  first:='';     k:=0;
     ReadLn(myfile1,first);
        ReadLn(myfile1,first);
           ReadLn(myfile1,first);
              ReadLn(myfile1,first);
                 ReadLn(myfile1,first);
                    ReadLn(myfile1,first);

  SetLength(Sarray1,320);  //only for the special thermographic width 320px;
  while not Eof(myFile1) do
  begin   inc(k);
    ReadLn(myfile1,first);
       Sarray1[k]:=first;
  //  Form1.Memo1.Lines.Add(first);
  // Form1.Memo1.Lines.Add(InttoStr(k));
  // if (k=320) then    Form1.Memo1.Lines.Add(Sarray[k]);


  end;
  if eof(myFile1) then
   Form1.Memo1.Lines.Add('Reading has been already completed!');

  CloseFile(myFile1);
   FormatSettings.DecimalSeparator:=',';
end;



procedure parseExportedTxtThermogramFile();
Var i,j,p,k: integer;

s,s1,s2: string;
begin
if length(Sarray1)=0 then  exit else
begin  precision_total:=-1000;precision_frac:=-1000;
      SetLength(Iarray1,length(Sarray1),240);
     for j := 0 to Length(Iarray1)-1 do
       for k := 0 to Length(Iarray1[j])-1 do
      Iarray1[j,k]:=0;

    for I := 1 to length(Sarray1) do BEGIN

    Application.ProcessMessages();
    if Form1.CheckBox1.Checked then

    Form1.Memo1.Lines.Add('string= '+Sarray1[i]);
              s1:=''; p:=0;    s2:='';
    for j := Length(InttoStr(i))+1 to length(Sarray1[i]) do
    if (ord(Sarray1[i][j])>=44)and(ord(Sarray1[i][j])<=57) then
    begin
   s1:=s1+Sarray1[i][j]; end
    else begin s:=s+' ';
    if Length(s1)>1 then begin
    findPRECISION(s1);
     Iarray1[i-1,p]:=StrToFloat(s1);inc(p);
     s1:='';
     s2:=s2+' '+FloattoStrf( Iarray1[i-1,p-1],ffFixed,precision_total,precision_frac);
   // Form1.Memo1.Lines.Add('Iarray='+InttoStr(p-1)+' = '+FloattoStr( Iarray[i-1,p-1]));
       end;
     end;
 // Form1.Memo1.Lines.Add('s='+s);
 if Form1.CheckBox1.Checked then
   Form1.Memo1.Lines.Add('Iarray1='+InttoStr(i)+' ='+s2);


                          END;
    Form1.Memo1.Lines.Add('Parsing has been already completed!');
end;


end;



procedure saveExportedTxtThermogramFile();
Var saveDialog : TSaveDialog;
 buttonSelected,i,j : Integer;
 s1:string;
begin
  if Length(Iarray1)<>0 then begin

       buttonSelected := VCL.Dialogs.MessageDlg('Save to new file?',mtCustom,
   [mbYes,mbCancel], 0);

if buttonSelected = mrYes    then begin
  saveDialog := TSaveDialog.Create(Form1);
   saveDialog.Title := 'Save your  data into new file';
 saveDialog.InitialDir := GetCurrentDir;
 saveDialog.Filter := 'Dat file for Wolfram@Math import [x,y,T]|.dat|Txt file [for frac analysis: only T-matrix] |.txt';
 saveDialog.DefaultExt := 'dat';
  saveDialog.FilterIndex := 1;

  if saveDialog.Execute
  then ShowMessage('File : '+saveDialog.FileName)
  else begin ShowMessage('Data saving was cancelled'); exit; end;

  selectedsavefile1:=saveDialog.FileName;
saveDialog.Free; end;

 if buttonSelected = mrCancel then exit;

      AssignFile(mysavefile1,selectedsaveFile1); Rewrite(mysavefile1);
       FormatSettings.DecimalSeparator:='.';
       if SaveDialog.FilterIndex=1 then begin

 for I := 0 to Length(Iarray1)-1 do
   for J := 0 to Length(Iarray1[i])-1 do
     begin
    WriteLn(mysavefile1,FloatToStrf(i+1,ffFixed,6,3)+'  '+
    FloatToStrf(j+1,ffFixed,6,3)+'  '+FloatToStrf(Iarray1[i,j],ffFixed,precision_total,precision_frac));

     end;     end;
      if SaveDialog.FilterIndex=2 then begin
 for I := 0 to Length(Iarray1)-1 do
 begin  s1:='';
   for J := 0 to Length(Iarray1[i])-1 do
     begin s1:=s1+'  '+FloatToStrf(Iarray1[i,j],ffFixed,precision_total,precision_frac);


     end;  WriteLn(mysavefile1,s1);   end; end;


          FormatSettings.DecimalSeparator:=',';
       CloseFile(mysaveFile1);

  end;
end;


(*~FRAC3D procedures *)

procedure parse();
Var i,j,p,k: integer;
s,s1,s2: string;
begin
if length(Sarray)=0 then  exit else
begin
precision_total:=-1000;precision_frac:=-1000;
      SetLength(Iarray,NUMROW,NUMCOL);
     for j := 0 to Length(Iarray)-1 do
       for k := 0 to Length(Iarray[j])-1 do
      Iarray[j,k]:=0;

    for I :=0 to length(Sarray)-1 do BEGIN

    Application.ProcessMessages();
     Sarray[i]:='  '+Sarray[i]+'  ';
   { Form1.Memo1.Lines.Add('Sarray['+InttoStr(i)+']= '+Sarray[i]);   }

          s1:=''; p:=0;    s2:='';
    for j := Length(InttoStr(i))+1 to length(Sarray[i]) do
    if (ord(Sarray[i][j])>=44)and(ord(Sarray[i][j])<=57)and(ord(Sarray[i][j])<>47) then
    begin
   s1:=s1+Sarray[i][j]; end
    else begin
    if Length(s1)>1 then begin Iarray[i,p]:=StrToFloat(s1);
     findPRECISION(s1);
     s2:=s2+' '+FloattoStr( Iarray[i,p]);  inc(p);  s1:='';
   // Form1.Memo1.Lines.Add('Iarray='+InttoStr(p-1)+' = '+FloattoStr( Iarray[i-1,p-1]));
       end;   s1:='';
     end;
 // Form1.Memo1.Lines.Add('s='+s);
{    Form1.Memo1.Lines.Add('Iarray='+InttoStr(i)+' ='+s2); }


                          END;
    Form1.Memo1.Lines.Add('Parsing has been completed already!');
end;   

end;

procedure readdem();
Var first: string;
i,j,k: integer;
Begin
if tryStrtoInt(Form1.LabeledEdit1.Text,NUMROW)and(NUMROW>0) then  begin
NUMROW:= StrtoInt(Form1.LabeledEdit1.Text); Form1.LabeledEdit1.Color:=clWhite;
 end else begin
  breakpoint1:=false;
  Form1.LabeledEdit1.Color:=clRed;
  exit;
end;
if tryStrtoInt(Form1.LabeledEdit2.Text,NUMCOL)and(NUMCOL>0) then begin
NUMCOL:= StrtoInt(Form1.LabeledEdit2.Text);Form1.LabeledEdit2.Color:=clWhite;
 end else begin
  breakpoint1:=false;   Form1.LabeledEdit2.Color:=clRed;
  exit;
end;        


    FormatSettings.DecimalSeparator:='.';
    if VCL.Dialogs.PromptForFileName(selectedFile,
                       'TXT files|*.txt',
                       '',
                       'Select your data file',
                       GetCurrentDir,
                       False)
  then
        begin
         end;

   if length(selectedFile)<=3 then begin
    ShowMessage('Warning: you have not selected any files');
          FormatSettings.DecimalSeparator:=',';
          breakpoint1:=false;
           exit;
        end else   Form1.Memo1.Lines.Add('Selected file= '+selectedFile);

  AssignFile(myFile, selectedFile);
  Reset(myFile);
  first:='';     k:=0;
   {}

  SetLength(Sarray,NUMROW);
  while not Eof(myFile) do
  begin
    ReadLn(myfile,first);
    Sarray[k]:= trim(StringReplace(first, '  ', ' ',
                          [rfReplaceAll, rfIgnoreCase]));
   if Form1.ShowInput.Checked then Form1.Memo1.Lines.Add(Floattostrf(k,ffFixed,4,0)+' :: '+Sarray[k]);
 inc(k);
   end;
  if eof(myFile) then
   Form1.Memo1.Lines.Add('Reading has been completed already!');

  CloseFile(myFile);
   FormatSettings.DecimalSeparator:='.';

  parse();
   SetLength(matrix,NUMROW,NUMCOL);      (*initialize matrix array*)
   matrix:=Iarray;
   SetLength(Iarray,0,0);

   for i := 0 to Length(matrix)-1 do
       for j := 0 to Length(matrix[i])-1 do
       begin
   if((i=0)and(j=0))then begin
		 zmin:=matrix[i,j];
		 zmax:=matrix[i,j];
	 end;
	 if(matrix[i,j]<zmin) then zmin:=matrix[i,j];
	 if(matrix[i,j]>zmax) then zmax:=matrix[i,j];
       end;
{  first:='';
 for i := 0 to Length(matrix)-1 do
       for j := 0 to Length(matrix[i])-1 do
       begin
         first:= first+' '+FloattoStrf(matrix[i][j],ffFixed,precision_total,precision_frac);
         if j=(Length(matrix[i])-1) then
         begin
         Form1.Memo1.Lines.Add(InttoStr(i)+' ::'+ Sarray[i]);
        Form1.Memo1.Lines.Add(InttoStr(i)+' ::'+ first);
         first:='';
              end;
       end;   }
      SetLength(Sarray,0);
      Form1.Memo1.Lines.Add('');
    Form1.Memo1.Lines.Add('Minimum elevation :'+FloattoStrf(zmin,ffFixed,precision_total,precision_frac));
    Form1.Memo1.Lines.Add('Maximum elevation :'+FloattoStrf(zmax,ffFixed,precision_total,precision_frac));
    Form1.Memo1.Lines.Add(' ** Data input complete ** ');
    breakpoint1:=true;

End;


(*==================================================*)
(*   function center: calculate area for for biLog plot*)
(*==================================================*)
procedure    center();
Var i,j: integer;
    n:integer;
    size, slop:integer;
Begin   n:=1;

(*Select short side of array*)
rowmax:=numrow; colmax:=numcol;
    if rowmax>colmax then size:=colmax else size:=rowmax;
	 steps:=1;
(*Find power of two which is less than short side *)
     repeat begin
   inc(steps);
   n:=n*2;
		end
     until (n>=size);
     n:=round(n/2);
     dec(steps);
(*Calculate begin and end rows & cols for processing *)
	slop:= round((rowmax-n)/2);
    begin_row:=slop+1;
    end_row:=n+slop+1;
    slop:=round((colmax-n)/2);
    begin_col:=slop+1;
	end_col:=n+slop+1;
   Form1.Memo1.Lines.Add('Processing rows '+InttoStr(begin_row)+' to '+Inttostr(end_row));
   Form1.Memo1.Lines.Add('and columns '+Inttostr(begin_col)+' to '+Inttostr(end_col));
 breakpoint1:=true;

end;

function fourTriangles(row1,col1,step1:integer):double;
 Var
    diag1:double;
     a1,b1,c1,d1,e1,w1,x1,y1,z1,o1,p1,q1,r1,sa1,sb1,sc1,sd1,
           aa1 :double;
begin
  diag1:=step1*sqrt(2.0)/2.0;
      a1:=matrix[row1][col1];
      b1:=matrix[row1][col1+step1];
	    c1:=matrix[row1+step1][col1+step1];
      d1:=matrix[row1+step1][col1];

(* e1 is the center point of four pixel values*)
      e1:=0.25*(a1+b1+c1+d1);
(*w1,x1,y1,z1 are external sides of the square   *)
	    w1:=sqrt((a1-b1)*(a1-b1)+step1*step1);
      x1:=sqrt((b1-c1)*(b1-c1)+step1*step1);
      y1:=sqrt((c1-d1)*(c1-d1)+step1*step1);
      z1:=sqrt((a1-d1)*(a1-d1)+step1*step1);
(* o1,p1,q1,r1 are internal sides of triangles   *)
	    o1:=sqrt((a1-e1)*(a1-e1)+diag1*diag1);
      p1:=sqrt((b1-e1)*(b1-e1)+diag1*diag1);
      q1:=sqrt((c1-e1)*(c1-e1)+diag1*diag1);
      r1:=sqrt((d1-e1)*(d1-e1)+diag1*diag1);
(* Compute values from Heron's formula       *)
	    sa1:=0.5*(w1+p1+o1);
      sb1:=0.5*(x1+p1+q1);
      sc1:=0.5*(y1+q1+r1);
      sd1:=0.5*(z1+o1+r1);
(* Solve areas from Heron's formula       *)
	    aa1:=sqrt(abs(sa1*(sa1-w1)*(sa1-p1)*(sa1-o1)));
      aa1:=aa1+sqrt(abs(sb1*(sb1-x1)*(sb1-p1)*(sb1-q1)));
      aa1:=aa1+sqrt(abs(sc1*(sc1-y1)*(sc1-q1)*(sc1-r1)));
      aa1:=aa1+sqrt(abs(sd1*(sd1-z1)*(sd1-o1)*(sd1-r1)));
   fourTriangles:=aa1;

end;

function epxArea(identity,row1,col1,step1:integer):double;
 Var
    diag1:double;
     a1,b1,c1,d1,e1,w1,x1,y1,z1,o1,p1,q1,r1,sa1,sb1,sc1,sd1,
           aa1 :double;
  j,v1,v2,v3,v4: integer;
     g1,f1,h1,ab1,bc1,cd1,de1,ef1,fg1,ghs1,ha1,
     oa1,ob1,oc1,od1,oe1,ofs1,og1,oh1,
     ta1,hb1,bd1,df1,fh1,
     mean1,mean2,mean3,mean4,
     windowsize1 :double;
     tp1: array of double;

begin
if identity=1 then begin

  diag1:=step1*sqrt(2.0)/2.0;
//Eight triangles for @Sun method;
 (*declare four corner edge points*)
      a1:=matrix[row1][col1];
      c1:=matrix[row1][col1+step1];
	    e1:=matrix[row1+step1][col1+step1];
      g1:=matrix[row1+step1][col1];
 (*declare four middle edge points*)
      b1:=matrix[row1][col1+round(step1/2)];
      d1:=matrix[row1+round(step1/2)][col1+step1];
	    f1:=matrix[row1+step1][col1+round(step1/2)];
      h1:=matrix[row1+round(step1/2)][col1];
(* o1 is the center point of our local window (step1+1).x.(step1+1) *)
      o1:=matrix[row1+round(step1/2)][col1+round(step1/2)];
(*ab1..ha1 are external sides of the square   *)
	    ab1:=sqrt((a1-b1)*(a1-b1)+0.25*step1*step1);
      bc1:=sqrt((b1-c1)*(b1-c1)+0.25*step1*step1);
      cd1:=sqrt((c1-d1)*(c1-d1)+0.25*step1*step1);
      de1:=sqrt((d1-e1)*(d1-e1)+0.25*step1*step1);
      ef1:=sqrt((e1-f1)*(e1-f1)+0.25*step1*step1);
      fg1:=sqrt((f1-g1)*(f1-g1)+0.25*step1*step1);
      ghs1:=sqrt((g1-h1)*(g1-h1)+0.25*step1*step1);
      ha1:=sqrt((h1-a1)*(h1-a1)+0.25*step1*step1);
(* oa1..oh1 are internal sides of triangles   *)
	    oa1:=sqrt((o1-a1)*(o1-a1)+diag1*diag1);
      oc1:=sqrt((o1-c1)*(o1-c1)+diag1*diag1);
      oe1:=sqrt((o1-e1)*(o1-e1)+diag1*diag1);
      og1:=sqrt((o1-g1)*(o1-g1)+diag1*diag1);

      ob1:=sqrt((o1-b1)*(o1-b1)+step1*step1*0.25);
      od1:=sqrt((o1-d1)*(o1-d1)+step1*step1*0.25);
      ofs1:=sqrt((o1-f1)*(o1-f1)+step1*step1*0.25);
      oh1:=sqrt((o1-h1)*(o1-h1)+step1*step1*0.25);

      (* Compute values from Heron's formula       *)
SetLength(tp1,8);  //semiperimeter;
	    tp1[0]:=0.5*(ab1+oa1+ob1);
      tp1[1]:=0.5*(bc1+ob1+oc1);
      tp1[2]:=0.5*(cd1+oc1+od1);
      tp1[3]:=0.5*(de1+od1+oe1);
      tp1[4]:=0.5*(ef1+oe1+ofs1);
      tp1[5]:=0.5*(fg1+ofs1+og1);
      tp1[6]:=0.5*(ghs1+og1+oh1);
      tp1[7]:=0.5*(ha1+oh1+oa1);
(* Obtain areas from Heron's formula       *)
ta1:=0;
     ta1:=sqrt(abs(tp1[0]*(tp1[0]-ab1)*(tp1[0]-oa1)*(tp1[0]-ob1)));
      ta1:=ta1+sqrt(abs(tp1[1]*(tp1[1]-bc1)*(tp1[1]-ob1)*(tp1[1]-oc1)));
       ta1:=ta1+sqrt(abs(tp1[2]*(tp1[2]-cd1)*(tp1[2]-oc1)*(tp1[2]-od1)));
        ta1:=ta1+sqrt(abs(tp1[3]*(tp1[3]-de1)*(tp1[3]-od1)*(tp1[3]-oe1)));
         ta1:=ta1+sqrt(abs(tp1[4]*(tp1[4]-ef1)*(tp1[4]-oe1)*(tp1[4]-ofs1)));
          ta1:=ta1+sqrt(abs(tp1[5]*(tp1[5]-fg1)*(tp1[5]-ofs1)*(tp1[5]-og1)));
           ta1:=ta1+sqrt(abs(tp1[6]*(tp1[6]-ghs1)*(tp1[6]-og1)*(tp1[6]-oh1)));
            ta1:=ta1+sqrt(abs(tp1[7]*(tp1[7]-ha1)*(tp1[7]-oh1)*(tp1[7]-oa1)));

  end;

  if (identity=2) or (identity=3)  then  begin
  (*declare four corner edge points*)
      a1:=matrix[row1][col1];
      c1:=matrix[row1][col1+step1];
	    e1:=matrix[row1+step1][col1+step1];
      g1:=matrix[row1+step1][col1];
 (* o1 is the center point of four pixel values*)
      o1:=matrix[row1+round(step1*0.5)][col1+round(step1*0.5)];
 (*declare four middle edge points*)

 if identity=3 then begin
     mean1:=0;mean2:=0; mean3:=0; mean4:=0;
     for j := 0 to step1 do
           begin
             mean1:=mean1+abs(matrix[row1][col1+j] -o1);
             mean2:=mean2+abs(matrix[row1+j][col1+step1]-o1);
             mean3:=mean3+abs(matrix[row1+step1][col1+j]-o1);
             mean4:=mean4+abs(matrix[row1+j][col1]-o1);
           end;
           mean1:=mean1/(step1+1);
           mean2:=mean2/(step1+1);
           mean3:=mean3/(step1+1);
           mean4:=mean4/(step1+1);
 end;


      v1:=0; v2:=0;v3:=0;v4:=0;
  for j :=0 to step1 do //Find a corner element of a square with max deviation
  //from the central element's value
     begin
    if identity = 2 then begin

      if Abs(matrix[row1][col1+v1]-o1)<abs(matrix[row1][col1+j] -o1) then
      v1:=j;
      if abs(matrix[row1+v2][col1+step1]-o1)<abs(matrix[row1+j][col1+step1]-o1) then
      v2:=j;
      if abs(matrix[row1+step1][col1+v3]-o1)<abs(matrix[row1+step1][col1+j]-o1) then
      v3:=j;
      if abs(matrix[row1+v4][col1]-o1)<abs(matrix[row1+j][col1]-o1) then
      v4:=j;
    end;
   if identity = 3 then begin
      if abs(Abs(matrix[row1][col1+v1]-o1)-mean1)>abs(abs(matrix[row1][col1+j] -o1)-mean1) then
      v1:=j;
      if abs(abs(matrix[row1+v2][col1+step1]-o1)-mean2)>abs(abs(matrix[row1+j][col1+step1]-o1)-mean2) then
      v2:=j;
      if abs(abs(matrix[row1+step1][col1+v3]-o1)-mean3)>abs(abs(matrix[row1+step1][col1+j]-o1)-mean3) then
      v3:=j;
      if abs(abs(matrix[row1+v4][col1]-o1)-mean4)>abs(abs(matrix[row1+j][col1]-o1)-mean4) then
      v4:=j;
   end;


       end;

      b1:=matrix[row1][col1+v1];
      d1:=matrix[row1+v2][col1+step1];
	    f1:=matrix[row1+step1][col1+v3];
      h1:=matrix[row1+v4][col1];

(*ab1..ha1 are external sides of the square   *)
	    ab1:=sqrt((a1-b1)*(a1-b1)+v1*v1);
      bc1:=sqrt((b1-c1)*(b1-c1)+(step1-v1)*(step1-v1));
      cd1:=sqrt((c1-d1)*(c1-d1)+v2*v2);
      de1:=sqrt((d1-e1)*(d1-e1)+(step1-v2)*(step1-v2));
      ef1:=sqrt((e1-f1)*(e1-f1)+(step1-v3)*(step1-v3));
      fg1:=sqrt((f1-g1)*(f1-g1)+v3*v3);
      ghs1:=sqrt((g1-h1)*(g1-h1)+(step1-v4)*(step1-v4));
      ha1:=sqrt((h1-a1)*(h1-a1)+v4*v4);
(* oa..oh are internal sides of triangles   *)
	    hb1:=sqrt((h1-b1)*(h1-b1)+v4*v4+v1*v1);
      bd1:=sqrt((b1-d1)*(b1-d1)+(step1-v1)*(step1-v1)+v2*v2);
      df1:=sqrt((d1-f1)*(d1-f1)+(step1-v2)*(step1-v2)+(step1-v3)*(step1-v3));
      fh1:=sqrt((f1-h1)*(f1-h1)+v3*v3+(step1-v4)*(step1-v4));

      ob1:=sqrt((o1-b1)*(o1-b1)+Power(v1-0.5*step1,2)+
          +Power(round(step1*0.5),2));
      od1:=sqrt((o1-d1)*(o1-d1)+Power(v2-0.5*step1,2)+
          +Power(round(0.5*step1),2));
      ofs1:=sqrt((o1-f1)*(o1-f1)+Power(v3-0.5*step1,2)+
          +Power(round(0.5*step1),2));
      oh1:=sqrt((o1-h1)*(o1-h1)+Power(v4-0.5*step1,2)+
          +Power(round(0.5*step1),2));

(* Compute values from Heron's formula       *)
SetLength(tp1,8);  //semiperimeter;
	    tp1[0]:=0.5*(ha1+ab1+hb1);
      tp1[1]:=0.5*(hb1+ob1+oh1);
      tp1[2]:=0.5*(bd1+ob1+od1);
      tp1[3]:=0.5*(bd1+bc1+cd1);
      tp1[4]:=0.5*(od1+df1+ofs1);
      tp1[5]:=0.5*(df1+de1+ef1);
      tp1[6]:=0.5*(ofs1+fh1+oh1);
      tp1[7]:=0.5*(fh1+fg1+ghs1);

(* Obtain areas from Heron's formula       *)
ta1:=0;
     ta1:=sqrt(abs(tp1[0]*(tp1[0]-ha1)*(tp1[0]-ab1)*(tp1[0]-hb1)));
      ta1:=ta1+sqrt(abs(tp1[1]*(tp1[1]-hb1)*(tp1[1]-ob1)*(tp1[1]-oh1)));
       ta1:=ta1+sqrt(abs(tp1[2]*(tp1[2]-bd1)*(tp1[2]-ob1)*(tp1[2]-od1)));
        ta1:=ta1+sqrt(abs(tp1[3]*(tp1[3]-bd1)*(tp1[3]-bc1)*(tp1[3]-cd1)));
         ta1:=ta1+sqrt(abs(tp1[4]*(tp1[4]-od1)*(tp1[4]-df1)*(tp1[4]-ofs1)));
          ta1:=ta1+sqrt(abs(tp1[5]*(tp1[5]-df1)*(tp1[5]-de1)*(tp1[5]-ef1)));
           ta1:=ta1+sqrt(abs(tp1[6]*(tp1[6]-ofs1)*(tp1[6]-fh1)*(tp1[6]-oh1)));
            ta1:=ta1+sqrt(abs(tp1[7]*(tp1[7]-fh1)*(tp1[7]-fg1)*(tp1[7]-ghs1)));

  end;


epxArea:=ta1;

end;

procedure fractal();   //Clarke Method 18-08-1985
Var	 row, col, step: integer;
    surface_area :double;
 Begin step:= 1;
       SetLength(area,100);
       SetLength(resolution,100);
(*Repeat for area sequence 1,4,16,64,256 etc. *)
   for timex:=1 to steps do begin
   surface_area:=0.0;
  (*Process whole array at this size *)
    row:=begin_row-1;
   while (row<end_row-1) do
    begin
    col:=begin_col-1;
       while(col<end_col-1) do begin
(* Calculate area and add it to total surface area  *)
	  surface_area:= surface_area+fourTriangles(row,col,step);
       col:=col+step;
        end;
       row:=row+step;
    end;
(*Save area and resolution, increment step size*)
	 area[timex]:= surface_area;
   if Form1.RadioButton1.Checked then
	 resolution[timex]:=step*step;  //Classic Clarke method 1985y; (underestimating);
    if Form1.RadioButton2.Checked then
	 resolution[timex]:=step; //Qiu, Lam et al. method; modernized to define a higher FracDim;

     step:=step*2;
     end;
   breakpoint1:=true;
ENd;


(*==================================================*)
(*      Eight-Pixel Method by @Sun, November, 2004   *)
(*==================================================*)
procedure fractalEPx();
Var	 row, col, step,j,
identifier: integer;
      surface_area :double;

 Begin step:= 1;
       SetLength(area,100);
       SetLength(resolution,100);

   for timex:=1 to steps do begin
   surface_area:=0.0;

  (*Process whole array at this size *)
      row:=begin_row-1;
   while (row<end_row-1) do begin

      col:=begin_col-1;

   while(col<end_col-1) do begin

         if step=1 then  beGin

(*Calculate area and add it to total surface area  *)
	    surface_area:= surface_area+fourTriangles(row,col,step);
                            eNd else  begin
   (*try different Triangle Prism Methods by @Sun, 2004: max-difference method,
   mean-difference method, eight-pixel method*)

   if Form1.RadioButton3.Checked then //open a section for 8-px method;

                            beGin
    identifier:=1;
	  surface_area:= surface_area+epxArea(identifier,row,col,step);
                            eNd;

if Form1.RadioButton4.Checked then //open a section for Max-diff method;
                            beGin
    identifier:=2;

(* Add to total surface area                 *)
	  surface_area:= surface_area+epxArea(identifier,row,col,step);
                            eNd;


if Form1.RadioButton5.Checked then //open a section for Mean-diff method;
                            beGin
    identifier:=3;
	  surface_area:= surface_area+epxArea(identifier,row,col,step);
                            eNd;
                            end;
    col:=col+step;
             end;
    row:=row+step;
   end;

(*Save area and resolution, increment step size*)
    	 area[timex]:= surface_area;
       if Form1.CheckBox2.Checked then
	     resolution[timex]:=step*step else
       resolution[timex]:=step;
       step:=step*2;
       end;
   breakpoint1:=true;
ENd;

(*==================================================*)
(*             arithmetic-step method               *)
(*==================================================*)
procedure fractalASM();   //ASM
Var	 row, col, step,identifier: integer;
     surface_area, gamma :double;
 Begin step:= 1;
       SetLength(area,steps);
       SetLength(resolution,steps);

if Form1.RadioButton8.Checked then identifier:=0;
if Form1.RadioButton9.Checked then identifier:=1;
if Form1.RadioButton10.Checked then identifier:=2;
if Form1.RadioButton11.Checked then identifier:=3;
   for timex:=1 to steps-1 do begin
   surface_area:=0.0;

  (*Process whole array at this size *)
    row:=begin_row;
   while (row+step<=end_row) do begin

   col:=begin_col;
   while(col+step<=end_col) do begin

   (* Add to total surface area                 *)

   if (identifier=0)or(step=1) then
	  surface_area:= surface_area+fourTriangles(row,col,step);
   if (identifier<>0)and(step>1) then
	  surface_area:= surface_area+epxArea(identifier,row,col,step);

        col:=col+step;
      end;

        row:=row+step;

   end;
(*       Coverage ratio normalization          *)
  if Form1.CheckBox3.Checked then begin
gamma:=window_size mod step;
if gamma>0 then begin
gamma:=Power((window_size-gamma)/window_size,-2);

end else gamma:=1;  end else gamma:=1;
(*Save area and resolution, increment step size*)

   area[timex]:= gamma*surface_area;
	 if Form1.CheckBox2.Checked then //Qiu, Lam et al. modification;
	     resolution[timex]:=step*step else
       resolution[timex]:=step;

   step:=step+1;
     end;
   breakpoint1:=true;
ENd;

 (*==================================================*)
(*             divisor-step method               *)
(*==================================================*)
procedure fractalDSM();   //DSM
Var	 row, col, step,identifier: integer;
     surface_area,gamma :double;

 Begin
 if Form1.RadioButton8.Checked then identifier:=0;
if Form1.RadioButton9.Checked then identifier:=1;
if Form1.RadioButton10.Checked then identifier:=2;
if Form1.RadioButton11.Checked then identifier:=3;
 step:= divisors[0];

        steps:=num_divisors+1;
       SetLength(area,steps);
       SetLength(resolution,steps);

   for timex:=1 to steps-1 do begin
   surface_area:=0.0;
     (*Set length of sides of triangles *)
  (*Process whole array at this size *)
    row:=begin_row;
   while (row+step<=end_row) do begin

   col:=begin_col;
   while(col+step<=end_col) do begin

   (* Add to total surface area                 *)
  if (identifier=0)or(step=1) then
	  surface_area:= surface_area+fourTriangles(row,col,step);
   if (identifier<>0)and(step>1) then
	  surface_area:= surface_area+epxArea(identifier,row,col,step);
        col:=col+step;
      end;

        row:=row+step;

   end;
(*       Coverage ratio normalization          *)
  if Form1.CheckBox3.Checked then begin
gamma:=window_size mod step;
if gamma>0 then begin
gamma:=Power((window_size-gamma)/window_size,-2);

end else gamma:=1;  end else gamma:=1;
(*Save area and resolution, increment step size*)

   area[timex]:= gamma*surface_area;
	 if Form1.CheckBox2.Checked then //Qiu, Lam et al. modification;
	     resolution[timex]:=step*step else
       resolution[timex]:=step;

   step:=divisors[timex];
     end;
   breakpoint1:=true;
ENd;

(*==================================================*)
(*    Function Linefit: Least Squares Log/Log fit   *)
(*==================================================*)
procedure linefit ();
Var
 resavg,areaavg, cross, sumres, sumarea, beta, r: double;
 n:integer;

Begin
   resavg:=0.0; areaavg:=0.0; cross:=0.0; sumres:=0.0;
		  sumarea:=0.0; dimension:=0.0; beta:=0.0; r:=0.0;
//       Form1.Memo1.Lines.Add('');
//   Form1.Memo1.Lines.Add(' Step Resolution Area ');
(*Do log transform and compute means*)
   for n:=1 to steps do begin
//  Form1.Memo1.Lines.Add(InttoStr(n)+'  '+
//   FloattoStr(resolution[n])+'  '+FloattoStr( area[n]));
   resolution[n]:=Ln(resolution[n]);
   area[n]:=Ln(area[n]);
   resavg:=resavg+resolution[n];
   areaavg:=areaavg+area[n];
          end;
	if(steps<3) then begin
    Form1.Memo1.Lines.Add(' Too few calculated data points regression ');
	exit();				  end;
    resavg:=resavg/steps;
	areaavg:=areaavg/steps;
(*Compute sums of squares      *)
    for n:=1 to steps do begin
    cross:= cross+((resolution[n]-resavg)*(area[n]-areaavg));
    sumres:=sumres+((resolution[n]-resavg)*(resolution[n]-resavg));
   	sumarea:=sumarea+((area[n]-areaavg)*(area[n]-areaavg));
     end;
(*Compute correlation coefficient and fractal dimension *)
 r:=cross/sqrt(sumres*sumarea);
  beta:=r*sqrt(sumarea)/sqrt(sumres);
  dimension:=2.0-beta;
   breakpoint1:=true;

  (*testing block*)
 (* Form1.Memo1.Lines.Add('');
   Form1.Memo1.Lines.Add(' >> ** Fractional Dimension= '+FloattoStr(dimension));
   Form1.Memo1.Lines.Add(' >>  r-squared= '+FloattoStr(r*r));
   Form1.Memo1.Lines.Add(' >> ** with '+FloattoStr(steps)+' observations');
    Form1.Memo1.Lines.Add('');
   Form1.Memo1.Lines.Add(' ln(resolution)');
 for n:=1 to steps do begin
  Form1.Memo1.Lines.Add('      #'+Inttostr(n)+'  '+FloattoStr(resolution[n]));
                        end;
    Form1.Memo1.Lines.Add('');
  Form1.Memo1.Lines.Add('ln(area)');
   for n:=1 to steps do begin
    Form1.Memo1.Lines.Add('     #'+Inttostr(n)+'  '+FloattoStr( area[n]));
                         end;
   *)
	End;

procedure linefitAr();
Var
 resavg,areaavg, cross, sumres, sumarea, beta, r: double;
 n:integer;

Begin
   resavg:=0.0; areaavg:=0.0; cross:=0.0; sumres:=0.0;
		  sumarea:=0.0; dimension:=0.0; beta:=0.0; r:=0.0;

(*Do log transform and compute means*)
  for n:=1 to length(area)-1 do begin

   resolution[n]:=Ln(resolution[n]);
   area[n]:=Ln(area[n]);
   resavg:=resavg+resolution[n];
   areaavg:=areaavg+area[n];
          end;
	if(steps<3) then begin
    Form1.Memo1.Lines.Add(' Too few calculated data points regression ');
	exit();				  end;
    resavg:=resavg/(length(area)-1);
	areaavg:=areaavg/(length(area)-1);
(*Compute sums of squares      *)
    for n:=1 to length(area)-1 do begin
    cross:= cross+((resolution[n]-resavg)*(area[n]-areaavg));
    sumres:=sumres+((resolution[n]-resavg)*(resolution[n]-resavg));
   	sumarea:=sumarea+((area[n]-areaavg)*(area[n]-areaavg));
     end;
(*Compute correlation coefficient and fractal dimension *)
 r:=cross/sqrt(sumres*sumarea);
  beta:=r*sqrt(sumarea)/sqrt(sumres);
  dimension:=2.0-beta;
   breakpoint1:=true;

    (*testing block*)
(* Form1.Memo1.Lines.Add('');
   Form1.Memo1.Lines.Add('[ >> ** Fractional Dimension= '+FloattoStr(dimension));
  Form1.Memo1.Lines.Add(' >>  r-squared= '+FloattoStr(r*r));
   Form1.Memo1.Lines.Add(' >> ** with '+FloattoStr(steps)+' observations');
    Form1.Memo1.Lines.Add('');
   Form1.Memo1.Lines.Add(' ln(resolution)');
 for n:=1 to length(area)-1 do begin
  Form1.Memo1.Lines.Add('      #'+Inttostr(n)+'  '+FloattoStr(resolution[n]));
                        end;
    Form1.Memo1.Lines.Add('');
  Form1.Memo1.Lines.Add('ln(area)');
   for n:=1 to length(area)-1 do begin
    Form1.Memo1.Lines.Add('     #'+Inttostr(n)+'  '+FloattoStr( area[n]));
                         end;
     Form1.Memo1.Lines.Add(']');
     *)
	End;

procedure TForm1.ClearButtonClick(Sender: TObject);
begin
Form1.Memo1.Lines.Clear;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
 Form1.Memo1.Width:=round(Form1.Width*0.73);
Form1.Memo1.Height:=round(Form1.Height*0.85);
 Form1.Memo1.Left:=round(Form1.Height*0.31);
 Form1.SpeedButton1.Width:=round(Form1.Height*0.25);
 Form1.SpeedButton2.Width:=round(Form1.Height*0.25);
 Form1.SpeedButton5.Width:=round(Form1.Height*0.25);
 Form1.ClearButton.Width:=round(Form1.Height*0.1);
  Form1.Panel1.Width:=round(Form1.Height*0.27);
 Form1.Memo1.Font.Size:=round(15*Form1.Width/Screen.Width);
  Form1.LabeledEdit1.Width:=round(Form1.Height*0.08);
  Form1.LabeledEdit2.Width:=round(Form1.Height*0.08);
  Form1.LabeledEdit7.Width:=round(Form1.Height*0.08);
end;



procedure TForm1.RadioButton1Click(Sender: TObject);
begin
fORM1.Panel2.Visible:=false;
Form1.LabeledEdit7.Visible:=true;
Form1.RadioGroup2.Visible:=false;
Form1.RadioButton8.Visible:=false;
Form1.RadioButton9.Visible:=false;
Form1.RadioButton10.Visible:=false;
Form1.RadioButton11.Visible:=false;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
fORM1.Panel2.Visible:=false;
Form1.LabeledEdit7.Visible:=true;
Form1.RadioGroup2.Visible:=false;
Form1.RadioButton8.Visible:=false;
Form1.RadioButton9.Visible:=false;
Form1.RadioButton10.Visible:=false;
Form1.RadioButton11.Visible:=false;
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin
fORM1.Panel2.Visible:=false;
Form1.LabeledEdit7.Visible:=true;
Form1.RadioGroup2.Visible:=false;
Form1.RadioButton8.Visible:=false;
Form1.RadioButton9.Visible:=false;
Form1.RadioButton10.Visible:=false;
Form1.RadioButton11.Visible:=false;
end;

procedure TForm1.RadioButton6Click(Sender: TObject);
begin
fORM1.Panel2.Visible:=true;
Form1.LabeledEdit7.Visible:=false;
Form1.RadioGroup2.Visible:=true;
Form1.RadioButton8.Visible:=true;
Form1.RadioButton9.Visible:=true;
Form1.RadioButton10.Visible:=true;
Form1.RadioButton11.Visible:=true;
end;

procedure MethodDescription();
Begin
  if form1.RadioButton1.Checked then begin
  form1.Memo1.Lines.Add('') ;
  form1.Memo1.Lines.Add('Method::    Clarke"s 1986y., with step-squared slope') ;
  end;
  if form1.RadioButton2.Checked then begin
  form1.Memo1.Lines.Add('') ;
  form1.Memo1.Lines.Add('Method::  Qiu and Lam modification of Clarke"s 1986y., with step-linear slope') ;
  end;
  if form1.RadioButton3.Checked then begin
  form1.Memo1.Lines.Add('') ;
  if form1.CheckBox2.Checked then
  form1.Memo1.Lines.Add('Method::  Eight-Pixel, with step-squared slope')
  else  form1.Memo1.Lines.Add('Method::  Eight-Pixel, with step-linear slope') ;
  end;

  if form1.RadioButton4.Checked then begin
  form1.Memo1.Lines.Add('') ;
  if form1.CheckBox2.Checked then
  form1.Memo1.Lines.Add('Method::  Max-difference, with step-squared slope')
  else  form1.Memo1.Lines.Add('Method::  Max-difference, with step-linear slope') ;
  end;

  if form1.RadioButton5.Checked then begin
  form1.Memo1.Lines.Add('') ;
  if form1.CheckBox2.Checked then
  form1.Memo1.Lines.Add('Method::  Mean-difference, with step-squared slope')
  else  form1.Memo1.Lines.Add('Method::  Mean-difference, with step-linear slope') ;
  end;
  if form1.RadioButton6.Checked then begin
  form1.Memo1.Lines.Add('') ;
  if form1.CheckBox2.Checked then
  form1.Memo1.Lines.Add('Method::  Arithmetic-step, with step-squared slope')
  else  form1.Memo1.Lines.Add('Method:: Arithmetic-step, with step-linear slope') ;
  end;

   if form1.RadioButton7.Checked then begin
  form1.Memo1.Lines.Add('') ;
  if form1.CheckBox2.Checked then
  form1.Memo1.Lines.Add('Method::  Divisor-step, with step-squared slope')
  else  form1.Memo1.Lines.Add('Method:: Divisor-step, with step-linear slope') ;
  end;

End;

procedure calculateFracDim();
VAr i,j: integer;
dimrowfracMTRX,dimcolfracMTRX: integer;
sliding,boxside:integer;
   frequencyX : Int64;
  startTimeX : Int64;
  endTimeX   : Int64;
  deltaX     : Extended;
Begin
 (*breakpoint1:=false;
readdem();
if breakpoint1 then begin
center();
fractal();
linefit(); end;   *)

(*===========================================*)
(*           test for different matrx szes   *)
(*+++++++++++++++++++++++++++++++++++++++++++*)




if (not Form1.RadioButton6.Checked)and
(not Form1.RadioButton7.Checked)  then  begin


 breakpoint1:=false;
 QueryPerformanceFrequency(frequencyX);
 QueryPerformanceCounter(startTimeX);
 readdem();
if breakpoint1 then begin
// Form1.Memo1.Lines.Add('bp#1:: passed');
//center();
if Form1.Swich1.Checked then begin
              //   Form1.Memo1.Lines.Add('swch#1:: in');
  (*begin_row:=StrToInt(Form1.LabeledEdit3.Text);
  end_row:=StrtoInt(Form1.LabeledEdit4.Text);
  begin_col:=StrtoInt(Form1.LabeledEdit5.Text);
  end_row:=StrToInt(Form1.LabeledEdit6.Text);*)

  steps:=StrToInt(Form1.LabeledEdit7.Text);

 // Form1.Memo1.Lines.Add('steps:: '+InttoStr(steps));
  (*Define steps:: 1,2,4 -> 1,4,8 frac kernel size*)
  boxside:=1;
   for I := 2 to steps do
     boxside:= boxside*2;
      Form1.Memo1.Lines.Add('boxside:: '+InttoStr(boxside));

     if (NUMROW<boxside) and  (NUMCOL<boxside) then
     begin
       Form1.Memo1.Lines.Add('Not enough elements. Procedure [frac dim] EXIT is activated');
    exit;
     end;

  dimrowfracMTRX:=1+(NUMROW-boxside)-1;
  dimcolfracMTRX:=1+(NUMCOL-boxside)-1;  (*Define size of frac map matrix:: fracMTRX*)
     SetLength(fracMTRX,dimrowfracMTRX,dimcolfracMTRX);
     Form1.Memo1.Lines.Add('  fracMTRX allocated '+Inttostr(dimrowfracMTRX)+ ' , '+InttoStr( dimcolfracMTRX));
     (**)
       for I :=0 to Length(fracMTRX)-1 do
      for j :=0 to Length(fracMTRX[I])-1 do
      fracMTRX[I,j]:=0;


       Form1.Memo1.Lines.Add('');
       MethodDescription();
       Form1.Memo1.Lines.Add('  ** MTRX frac map is calculating...');


      for I :=0 to Length(fracMTRX)-1 do begin
        begin_row:=I+1;
        end_row:= begin_row+boxside;  (*I+boxside*)
           if end_row>NUMROW then begin
             Form1.Memo1.Lines.Add('bp#2:: end_row>NUMROW');
             exit;
           end;

      for j :=0 to Length(fracMTRX[I])-1 do
    BEGIN
        begin_col:=j+1;
        end_col:= begin_col+boxside; (*j+boxside*)
           if end_col>NUMCOL then begin
             Form1.Memo1.Lines.Add('bp#3:: end_col>NUMCOL');
             exit;
     end;

if Form1.RadioButton1.Checked or Form1.RadioButton2.Checked then
        fractal();
if Form1.RadioButton3.Checked or Form1.RadioButton4.Checked or
   Form1.RadioButton5.Checked or Form1.RadioButton6.Checked then
        fractalEPx();

        linefit();
        SetLength(area,0); SetLength(resolution,0);
        fracMTRX[I][j]:=dimension;

    END;
                                        end;
      (*time perfomance*)
 QueryPerformanceCounter(endTimeX);
  deltaX := (endTimeX - startTimeX) / frequencyX;
Form1.Memo1.Lines.Add(FloatToStr(deltaX*1000)+' ms');
Form1.Memo1.Lines.Add('');
Form1.Memo1.Lines.Add('Press button "Show FM" to see fractal dimension matrix');
Form1.Memo1.Lines.Add('');
Form1.Memo1.Lines.Add('You can save FRACTAL MAP into file. Press button "SAVE FM"');
end; (*SWICH 1 end*)

end;

end else
begiN
   if Form1.RadioButton6.Checked  then  begin
 breakpoint1:=false;
 QueryPerformanceFrequency(frequencyX);
 QueryPerformanceCounter(startTimeX);
 readdem();
if breakpoint1 then begin
// Form1.Memo1.Lines.Add('bp#1:: passed');
//center();
if Form1.Swich1.Checked then begin


   if trystrtoint(Form1.LabeledEdit8.Text, steps) then
   steps:=strtoint(Form1.LabeledEdit8.Text) else begin
   Form1.Memo1.Lines.Add('Failed:: window size must be integer');
   exit;
   end;

  boxside:=steps;
  window_size:=steps-1;
      Form1.Memo1.Lines.Add('steps:: 1..+1.. '+InttoStr(steps));

     if (NUMROW<boxside) and  (NUMCOL<boxside) then
     begin
     Form1.Memo1.Lines.Add('Not enough elements. Procedure [frac dim] EXIT is activated');
     SetLength(fracMTRX,0,0);
     exit;
     end;

  dimrowfracMTRX:=(NUMROW-window_size);
  dimcolfracMTRX:=(NUMCOL-window_size);  (*Define size of frac map matrix:: fracMTRX*)
     SetLength(fracMTRX,dimrowfracMTRX,dimcolfracMTRX);
     Form1.Memo1.Lines.Add('  fracMTRX allocated '+Inttostr(dimrowfracMTRX)+
      ' , '+InttoStr( dimcolfracMTRX));
     (**)
       for I :=0 to Length(fracMTRX)-1 do
      for j :=0 to Length(fracMTRX[I])-1 do
      fracMTRX[I,j]:=0;


       Form1.Memo1.Lines.Add('');
       MethodDescription();
       Form1.Memo1.Lines.Add('  ** MTRX frac map is calculating...');


      for I :=0 to Length(fracMTRX)-1 do begin
        begin_row:=I;
        end_row:= begin_row+window_size;
           if end_row>=NUMROW then begin
             Form1.Memo1.Lines.Add('bp#2:: end_row>NUMROW');
             exit;
           end;

      for j :=0 to Length(fracMTRX[I])-1 do
    BEGIN
        begin_col:=j;
        end_col:= begin_col+window_size;
           if end_col>=NUMCOL then begin
             Form1.Memo1.Lines.Add('bp#3:: end_col>NUMCOL');
             exit;
           end;

     fractalASM();
     linefitAr();
       SetLength(area,0); SetLength(resolution,0);
        fracMTRX[I][j]:=dimension;

    END;
                                        end;
      (*time perfomance*)
 QueryPerformanceCounter(endTimeX);
  deltaX := (endTimeX - startTimeX) / frequencyX;
Form1.Memo1.Lines.Add(FloatToStr(deltaX*1000)+' ms');
Form1.Memo1.Lines.Add('');
Form1.Memo1.Lines.Add('Press button "Show FM" to see fractal dimension matrix');
Form1.Memo1.Lines.Add('');
Form1.Memo1.Lines.Add('You can save FRACTAL MAP into file. Press button "SAVE FM"');
end; (*SWICH 1 end*)

end;
   end;

(*   the Divisor-step Method, Ju & Lam, 2009  *)
  if Form1.RadioButton7.Checked then begin

    breakpoint1:=false;
 QueryPerformanceFrequency(frequencyX);
 QueryPerformanceCounter(startTimeX);
 readdem();
if breakpoint1 then begin
// Form1.Memo1.Lines.Add('bp#1:: passed');
//center();
if Form1.Swich1.Checked then begin


   if trystrtoint(Form1.LabeledEdit8.Text, steps) then
   steps:=strtoint(Form1.LabeledEdit8.Text) else begin
   Form1.Memo1.Lines.Add('Failed:: window size must be integer');
   exit;
   end;

  boxside:=steps; //(*W*)
  window_size:=steps-1; (*W-1*)

  SetLength(divisors,0);num_divisors:=0;
   Form1.Memo1.Lines.Add('divisors of Window-1='+Floattostr(window_size)+ '  ::');
  if window_size>=2 then

  for i := 1 to window_size-1 do
    begin
     if window_size mod i =0 then
     begin

      SetLength(divisors,Length(divisors)+1);
      divisors[Length(divisors)-1]:=i;
      Form1.Memo1.Lines.Add('divisor = '+FloattoStr(divisors[Length(divisors)-1]));
     end;
    end else begin Form1.Memo1.Lines.Add('Small window. Enter larger!'); exit; end;
    num_divisors:=length(divisors);

     if (NUMROW<boxside) and  (NUMCOL<boxside) then
     begin
     Form1.Memo1.Lines.Add('Not enough elements. Procedure [frac dim] EXIT is activated');
     SetLength(fracMTRX,0,0);
     exit;
     end;

  dimrowfracMTRX:=(NUMROW-window_size);
  dimcolfracMTRX:=(NUMCOL-window_size);  (*Define size of frac map matrix:: fracMTRX*)
     SetLength(fracMTRX,dimrowfracMTRX,dimcolfracMTRX);
     Form1.Memo1.Lines.Add('  fracMTRX allocated '+Inttostr(dimrowfracMTRX)+
      ' , '+InttoStr( dimcolfracMTRX));
     (**)
       for I :=0 to Length(fracMTRX)-1 do
      for j :=0 to Length(fracMTRX[I])-1 do
      fracMTRX[I,j]:=0;


       Form1.Memo1.Lines.Add('');
       MethodDescription();
       Form1.Memo1.Lines.Add('  ** MTRX frac map is calculating...');


      for I :=0 to Length(fracMTRX)-1 do begin
        begin_row:=I;
        end_row:= begin_row+window_size;
           if end_row>=NUMROW then begin
             Form1.Memo1.Lines.Add('bp#2:: end_row>NUMROW');
             exit;
           end;

      for j :=0 to Length(fracMTRX[I])-1 do
    BEGIN
        begin_col:=j;
        end_col:= begin_col+window_size;
           if end_col>=NUMCOL then begin
             Form1.Memo1.Lines.Add('bp#3:: end_col>NUMCOL');
             exit;
           end;

     fractalDSM();
     linefitAr();
       SetLength(area,0); SetLength(resolution,0);
        fracMTRX[I][j]:=dimension;

    END;
                                        end;
      (*time perfomance*)
 QueryPerformanceCounter(endTimeX);
  deltaX := (endTimeX - startTimeX) / frequencyX;
Form1.Memo1.Lines.Add(FloatToStr(deltaX*1000)+' ms');
Form1.Memo1.Lines.Add('');
Form1.Memo1.Lines.Add('Press button "Show FM" to see fractal dimension matrix');
Form1.Memo1.Lines.Add('');
Form1.Memo1.Lines.Add('You can save FRACTAL MAP into file. Press button "SAVE FM"');
end; (*SWICH 1 end*)

end;
  end;


enD;


end;


procedure calculateFracDim1();   //test;
VAr i,j: integer;
Begin
 (*breakpoint1:=false;
readdem();
if breakpoint1 then begin
center();
fractal();
linefit(); end; *)

(*===========================================*)
(*           test for different matrx szes   *)
(*+++++++++++++++++++++++++++++++++++++++++++*)
 readdem();
 //center();
  breakpoint1:=true;
  begin_row:=StrToInt(Form1.LabeledEdit3.Text);
  end_row:=StrtoInt(Form1.LabeledEdit4.Text);
  begin_col:=StrtoInt(Form1.LabeledEdit5.Text);
  end_row:=StrToInt(Form1.LabeledEdit6.Text);
  steps:=StrToInt(Form1.LabeledEdit7.Text);

 fractal();
linefit();

end;


procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 Form1.Memo1.Lines.Add('');
 Form1.Memo1.Lines.Add('(*========================================*)');

   calculateFracDim();
end;


procedure TForm1.SpeedButton2Click(Sender: TObject);
Var sr1: string;

begin
(*
FormatSettings.DecimalSeparator:='.';
 sr1:= '12.101';
findPRECISION(sr1);
Form1.Memo1.Lines.Add('precision_total= '+InttoStr(precision_total));
 Form1.Memo1.Lines.Add('precision_frac= '+InttoStr(precision_frac));
 Form1.Memo1.Lines.Add('12='+FloattoStrf(StrToFloat(sr1),ffFixed,precision_total,precision_frac));
 FormatSettings.DecimalSeparator:=',';
 FormatSettings. DecimalSeparator:='.';
 sr1:= '120.10112';
findPRECISION(sr1);
Form1.Memo1.Lines.Add('precision_total= '+InttoStr(precision_total));
 Form1.Memo1.Lines.Add('precision_frac= '+InttoStr(precision_frac));
 Form1.Memo1.Lines.Add('12='+FloattoStrf(StrToFloat(sr1),ffFixed,precision_total,precision_frac));
 FormatSettings.DecimalSeparator:=',';     *)
  Form1.Memo1.Lines.Add('');
 Form1.Memo1.Lines.Add('(*========================================*)');
 
 precision_total:=-1000;precision_frac:=-1000;
 readExportedTxtThermogramFile();
 parseExportedTxtThermogramFile();
 saveExportedTxtThermogramFile();

 end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
if Form1.Memo1.Font.Size-1>0 then

Form1.Memo1.Font.Size:=Form1.Memo1.Font.Size-1;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
if Form1.Memo1.Font.Size+1<32 then

Form1.Memo1.Font.Size:=Form1.Memo1.Font.Size+1;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
Form1.Memo1.Lines.Add('');
 Form1.Memo1.Lines.Add('(*========================================*)');
 
  breakpoint1:=false;
readdem();
if breakpoint1 then begin
center();
fractal();
linefit();
Form1.Memo1.Lines.Add('fract dim='+FloattoStrf(dimension, ffFixed,5,3)+' steps='+Inttostr(steps));
end;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
Var saveDialog : TSaveDialog;
 buttonSelected,i,j : Integer;
selectedsaveFile2 : string;
  myFile2,mysaveFile2 : TextFile;
 s1:string;
begin
if Length(fracMTRX)>0 then BEGIN

       buttonSelected := VCL.Dialogs.MessageDlg('Save to new file?',mtCustom,
   [mbYes,mbCancel], 0);

if buttonSelected = mrYes    then begin
  saveDialog := TSaveDialog.Create(Form1);
   saveDialog.Title := 'Save your  data into new file';
 saveDialog.InitialDir := GetCurrentDir;
 saveDialog.Filter := 'Dat file for Wolfram@Math import [x,y,Df]|.dat|Txt file [only Df-matrix] |.txt';
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
 for I := 0 to Length(fracMTRX)-1 do
   for J := 0 to Length(fracMTRX[i])-1 do
     begin
    WriteLn(mysavefile2,FloatToStrf(i+1,ffFixed,4,1)+'  '+
    FloatToStrf(j+1,ffFixed,4,1)+'  '+FloatToStrf(fracMTRX[i,j],ffFixed,6,4));

     end; end;
  if saveDialog.FilterIndex=2 then   begin
 for I := 0 to Length(fracMTRX)-1 do
 begin  s1:='';
   for J := 0 to Length(fracMTRX[i])-1 do
     begin s1:=s1+'  '+FloatToStrf(fracMTRX[i,j],ffFixed,6,4);

     end;  WriteLn(mysavefile2,s1);   end;    end;

          FormatSettings.DecimalSeparator:=',';
       CloseFile(mysaveFile2);

                  END;

end;


procedure TForm1.SpeedButton7Click(Sender: TObject);
Var i,j:integer;
st1:string;
begin
     for i := 0 to length(fracMTRX)-1 do   begin
      st1:='';
        for j := 0 to Length(fracMTRX[i])-1 do
        begin
 st1:=st1+' '+FloattoStrf(fracMTRX[i,j],ffFixed,5,3);
        end;
  Form1.Memo1.Lines.Add(st1);
             end;
end;

end.
