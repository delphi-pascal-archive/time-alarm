unit AP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPGroupBox, XPButton, StdCtrls, ComCtrls, Buttons, ExtCtrls,
  XPLabel, Drawer, ShellApi;

  const
   AlignCenter = WM_USER + 1024;

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

type
  TAboutForm = class(TForm)
    fr1: TPanel;
    t1: TXPLabel;
    t2: TXPLabel;
    t13: TXPLabel;
    t14: TXPLabel;
    t3: TXPLabel;
    fr2: TPanel;
    SendEdit: TEdit;
    Drawer: TDrawer;
    t15: TXPLabel;
    OK: TXPButton;
    Logo: TImage;
    spr1: TBevel;
    spr2: TBevel;
    t4: TXPLabel;
    t8: TXPLabel;
    t10: TXPLabel;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure OKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure t15MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure t15MouseLeave(Sender: TObject);
    procedure t15MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure t15Click(Sender: TObject);
    procedure SendEditClick(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

    procedure ChangeMessageBoxPosition(var Msg: TMessage);
    message AlignCenter;

    procedure CMMouseLeave(var msg: TMessage);
    message CM_MOUSELEAVE;

  public
  
  end;

var
  AboutForm: TAboutForm;
  msgCaption: PChar;

implementation

uses LP, OP, NP;

{$R *.dfm}

procedure TAboutForm.ChangeMessageBoxPosition(var Msg: TMessage);
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
x := AboutForm.Left + ((AboutForm.Width - w) div 2);
if x < 0 then
x := 0
else if x + w > Screen.Width then x := Screen.Width - w;
y := AboutForm.Top + ((AboutForm.Height - h) div 2);
if y < 0 then y := 0
else if y + h > Screen.Height then y := Screen.Height - h;
SetWindowPos(MBHWnd, 0, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;
end;

procedure TAboutForm.WMMoving(var msg: TWMMoving);
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

procedure TAboutForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;

procedure TAboutForm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_Escape then
OK.OnClick(Self);
if Key = vk_F1 then
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if Key = vk_F1 then
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if MainForm.RusItem.Checked then
Application.MessageBox('ѕрограмма Hell of the Ring предназначена дл€ напоминани€' +
#13 + 'заданного времени.',
'Hell of the Ringing',
mb_IconAsterisk + mb_OK);
if MainForm.EngItem.Checked then
Application.MessageBox('Hell of the Ring program is intended for the remember' +
#13 + 'tasking time.',
'Hell of the Ring',
mb_IconAsterisk + mb_OK);
end;
end;
end;

procedure TAboutForm.OKClick(Sender: TObject);
begin
AboutForm.Close;
end;

procedure TAboutForm.FormShow(Sender: TObject);
var
Size: DWord;
MS: TMemoryStatus;
NameUser: array[0..255] of char;
NameComp: array[0..255] of char;
begin
Size:= 55;
if getcomputername(NameComp, Size) then
t10.Caption := NameComp else
t10.Caption := '';
Size:= 55;
if getusername(NameUser, Size) then
t8.Caption := NameUser else
t8.Caption := '';
GlobalMemoryStatus(MS);
if MainForm.EngItem.Checked then
begin
t13.Caption := 'Memory Available to Windows: ' + FormatFloat('#,###" KB"', MS.dwTotalPhys / 1024);
t14.Caption := 'Use: ' + Format('%d %%', [MS.dwMemoryLoad]);
end;
if MainForm.RusItem.Checked then
begin
t13.Caption := '‘изическа€ пам€ть: ' + FormatFloat('#,###" KB"', MS.dwTotalPhys / 1024);
t14.Caption := '»спользовано: ' + Format('%d %%', [MS.dwMemoryLoad]);
end;
SetWindowLong(AboutForm.Handle, GWL_EXSTYLE,
GetWindowLOng(AboutForm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TAboutForm.FormDestroy(Sender: TObject);
begin
AboutForm.OnActivate := nil;
SendEdit.Free;
Drawer.Free;
Logo.Free;
spr1.Free;
spr2.Free;
fr1.Free;
fr2.Free;
t1.Free;
t2.Free;
t3.Free;
t4.Free;
t8.Free;
t10.Free;
t13.Free;
t14.Free;
t15.Free;
OK.Free;
end;

procedure TAboutForm.t15MouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
t15.ForegroundColor := clRed;
end;

procedure TAboutForm.t15MouseLeave(Sender: TObject);
begin
t15.ForegroundColor := $00FF8000;
end;

procedure TAboutForm.t15MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
t15.ForegroundColor := $00FF8000;
end;

procedure TAboutForm.t15Click(Sender: TObject);
begin
ShellExecute(Handle, nil, 'Mailto:GoodWinNix@mail.ru',
nil, nil, Sw_ShowNormal);
end;

procedure TAboutForm.SendEditClick(Sender: TObject);
begin
Drawer.Open;
end;

procedure TAboutForm.LogoClick(Sender: TObject);
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if MainForm.RusItem.Checked then
Application.MessageBox('¬ы имеете право распростран€ть и использовать эту программу' +
#13 + 'в любых цел€х при условии целостности оригинального' + #13 + 'дистрибутива.',
'Hell of the Ring',
mb_IconAsterisk + mb_OK);
if MainForm.EngItem.Checked then
Application.MessageBox('You have the right to distribute and use this program in any' +
#13 + 'purposes under condition of integrity of the original' + #13 + 'distribution kit.',
'Hell of the Ring',
mb_IconAsterisk + mb_OK);
end;

procedure TAboutForm.CMMouseLeave(var msg: TMessage);
begin
t15.ForegroundColor := $00FF8000;
end;

procedure TAboutForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
OK.SetFocus;
end;

end.
