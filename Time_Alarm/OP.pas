unit OP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPCheckBox, XPGroupBox, XPButton, ExtCtrls, LbSpeedButton, XPPanel,
  XPLabel, ComCtrls, IniFiles, Registry, jpeg, Buttons, XPEdit, ImgList,
  ToolWin, StdCtrls, rmCCTabs, rmTrackBar;
    
  const
   AlignCenter = WM_USER + 1024;

  type
   TTabSheet = class(ComCtrls.TTabSheet);

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

type
  TSetForm = class(TForm)
    OK: TXPButton;
    AlarmPage: TPageControl;
    GeneralTab: TTabSheet;
    ch1: TXPCheckBox;
    ch2: TXPCheckBox;
    ch14: TXPCheckBox;
    EventsTab: TTabSheet;
    WindowTab: TTabSheet;
    ch4: TXPCheckBox;
    ch7: TXPCheckBox;
    ch8: TXPCheckBox;
    ch13: TXPCheckBox;
    ch3: TXPCheckBox;
    ch15: TXPCheckBox;
    ch6: TXPCheckBox;
    TranparentBar: TrmTrackBar;
    tx1: TXPLabel;
    sp1: TBevel;
    sp2: TBevel;
    ch9: TXPCheckBox;
    ExitTab: TTabSheet;
    ch5: TXPCheckBox;
    ch10: TXPCheckBox;
    ch11: TXPCheckBox;
    Bevel1: TBevel;
    ch12: TXPCheckBox;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure ch6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TranparentBarChange(Sender: TObject);
    procedure ch5Click(Sender: TObject);
    procedure ch10Click(Sender: TObject);

  private

    Ini: TIniFile;

    R: TRegistry;

    FColor: TColor;

    procedure SetColor(Value: TColor);

    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); 
    message WM_ERASEBKGND;

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

    procedure ChangeMessageBoxPosition(var Msg: TMessage);
    message AlignCenter;

  public

    constructor Create(aOwner: TComponent); override;
    property Color: TColor read FColor write SetColor;

  end;

var
  SetForm: TSetForm;
  msgCaption: PChar;

implementation

uses NP, LP, AP;

{$R *.dfm}

function NTor9x: boolean;
begin
Result := GetVersion < $80000000;
end;

procedure TSetForm.FormDestroy(Sender: TObject);
begin
SetForm.OnActivate := nil;
TranparentBar.Free;
AlarmPage.Free;
ch1.Free;
ch2.Free;
ch3.Free;
ch4.Free;
ch5.Free;
ch6.Free;
ch7.Free;
ch8.Free;
ch9.Free;
ch10.Free;
ch11.Free;
ch12.Free;
ch13.Free;
ch14.Free;
ch15.Free;
tx1.Free;
OK.Free;
end;

procedure TSetForm.FormCreate(Sender: TObject);
begin
Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
try
ch1.Checked := Ini.ReadBool('Parameters', 'Minimized to tray on switch of alarm', ch1.Checked);
ch2.Checked := Ini.ReadBool('Parameters', 'Restore form tray on include of alarm', ch2.Checked);
ch3.Checked := Ini.ReadBool('Parameters', 'Minimized to tray at closing', ch3.Checked);
ch4.Checked := Ini.ReadBool('Parameters', 'Images in the menu', ch4.Checked);
ch5.Checked := Ini.ReadBool('Parameters', 'Auto save configuration', ch5.Checked);
ch6.Checked := Ini.ReadBool('Parameters', 'Use of XP menu', ch6.Checked);
ch7.Checked := Ini.ReadBool('Parameters', 'Confirmation exit', ch7.Checked);
ch8.Checked := Ini.ReadBool('Parameters', 'Run with Windows OS start up', ch8.Checked);
ch9.Checked := Ini.ReadBool('Parameters', 'Copy file to Clipboard', ch9.Checked);
ch10.Checked := Ini.ReadBool('Parameters', 'Auto save window position', ch10.Checked);
ch11.Checked := Ini.ReadBool('Parameters', 'Shutdown PC on exit', ch11.Checked);
ch12.Checked := Ini.ReadBool('Parameters', 'Confirm before shutdown PC on exit', ch12.Checked);
ch13.Checked := Ini.ReadBool('Parameters', 'Minimized on pressing Escape', ch13.Checked);
ch14.Checked := Ini.ReadBool('Parameters', 'Play sound endless', ch14.Checked);
TranparentBar.ThumbPosition := Ini.ReadInteger('Tranparent', 'Value', TranparentBar.ThumbPosition);
except
end;
end;

procedure TSetForm.OKClick(Sender: TObject);
begin
R := TRegistry.Create;
R.RootKey := HKEY_LOCAL_MACHINE;
R.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', false);
if Ch8.Checked then
R.WriteString(Application.Title, ParamStr(0)) else
R.DeleteValue(Application.Title);
R.Free;
if ch4.Checked then
MainForm.MainMenu.Images := MainForm.ImageList2 else
MainForm.MainMenu.Images := MainForm.ImageList1;
if ch4.Checked then
MainForm.TrayMenu.Images := MainForm.ImageList2 else
MainForm.TrayMenu.Images := MainForm.ImageList1;
SetForm.Close;
end;

procedure TSetForm.FormShow(Sender: TObject);
begin
AlarmPage.ActivePageIndex := 0;
if NTor9x then
begin
TranparentBar.Visible := True;
tx1.Visible := True;
end else
begin
TranparentBar.Visible := False;
tx1.Visible := False;
end;

SetWindowLong(SetForm.Handle, GWL_EXSTYLE,
GetWindowLOng(SetForm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TSetForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;

procedure TSetForm.ChangeMessageBoxPosition(var Msg: TMessage);
var
MbHwnd: longword;
MbRect: TRect;
x, y, w, h: integer;
begin
MbHwnd := FindWindow(MAKEINTRESOURCE(WC_DIALOG), msgCaption);
if (MbHwnd <> 0) then
begin
GetWindowRect(MBHWnd, MBRect);
with MbRect do
begin
w := Right - Left;
h := Bottom - Top;
end;
x := SetForm.Left + ((SetForm.Width - w) div 2);
if x < 0 then
x := 0
else if x + w > Screen.Width then x := Screen.Width - w;
y := SetForm.Top + ((SetForm.Height - h) div 2);
if y < 0 then y := 0
else if y + h > Screen.Height then y := Screen.Height - h;
SetWindowPos(MBHWnd, 0, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;
end;

procedure TSetForm.WMMoving(var msg: TWMMoving);
var
r: TRect;
begin
r := Screen.WorkareaRect;
if msg.lprect^.left < r.left then
OffsetRect(msg.lprect^, r.left - msg.lprect^.left, 0);
if msg.lprect^.top < r.top then
OffsetRect(msg.lprect^, 0, r.top - msg.lprect^.top);
if msg.lprect^.right > r.right then
OffsetRect(msg.lprect^, r.right - msg.lprect^.right, 0);
if msg.lprect^.bottom > r.bottom then
OffsetRect(msg.lprect^, 0, r.bottom - msg.lprect^.bottom);
inherited;
end;

procedure TSetForm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_Escape then
OK.OnClick(Self);
end;

procedure TSetForm.ch6Click(Sender: TObject);
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if MainForm.RusItem.Checked then
Application.MessageBox('Изменения темы вступят в силу, когда Вы перезапустите' +
#13 + 'Hell of the Ringing!',
'Применение Темы',
mb_IconExclamation + mb_OK);
if MainForm.EngItem.Checked then
Application.MessageBox('Theme changes will take effect when you restart' +
#13 + 'Hell of the Ringing!',
'Apply Theme',
mb_IconExclamation + mb_OK);
end;

procedure TSetForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
OK.OnClick(Self);
OK.SetFocus;
end;

constructor TSetForm.Create(aOwner: TComponent);
begin
inherited; 
FColor := $00FFBE7D;
end;

procedure TSetForm.SetColor(Value: TColor);
begin
if FColor = Value then
begin
FColor := Value;
Invalidate;
end;
end;

procedure TSetForm.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
if FColor = clBtnFace then
inherited else
begin
Brush.Color := FColor;
Windows.FillRect(Msg.dc, ClientRect, Brush.Handle);
Msg.Result := 1;
end;
end;

procedure TSetForm.TranparentBarChange(Sender: TObject);
begin
MainForm.AlphaBlendValue := TranparentBar.ThumbPosition;
end;

procedure TSetForm.ch5Click(Sender: TObject);
begin
Ini.WriteBool('Parameters', 'Auto save configuration', ch5.Checked);
end;

procedure TSetForm.ch10Click(Sender: TObject);
begin
Ini.WriteBool('Parameters', 'Auto save window position', SetForm.ch10.Checked);
end;

end.
