unit NP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AppEvnts, XPLabel, Menus, ComCtrls, StdCtrls, Buttons,
  MPlayer, Mask, ImgList, XPButton, XPCheckBox, XPMenu, ShellApi, XpMan,
  IniFiles, Registry, ActiveX, ComObj, ShlObj, XPGroupBox, LbSpeedButton,
  XPPanel, Jpeg, CommDlg, ClipBrd;

  const
   AlignCenter = WM_USER + 1024;
   Tray        = Wm_User + 1;
   Cherta      = Wm_User + 2;
   AboutPro    = Wm_User + 3;

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

type
  TMainForm = class(TForm)
    fr2: TXPPanel;
    MyFace: TPaintBox;
    MyTime: TXPLabel;
    fr1: TShape;
    CurTime: TXPLabel;
    Timer1: TTimer;
    MainMenu: TMainMenu;
    FileItem: TMenuItem;
    NewWinItem: TMenuItem;
    ShortcutItem: TMenuItem;
    DeskItem: TMenuItem;
    StartMenuItem: TMenuItem;
    ProgramsItem: TMenuItem;
    StartupItem: TMenuItem;
    FavoritesItem: TMenuItem;
    PropItem: TMenuItem;
    sp1: TMenuItem;
    QuitItem: TMenuItem;
    ToolsItem: TMenuItem;
    LangItem: TMenuItem;
    RusItem: TMenuItem;
    EngItem: TMenuItem;
    sp2: TMenuItem;
    MainMenuItem: TMenuItem;
    MultipleItem: TMenuItem;
    OnTopItem: TMenuItem;
    sp4: TMenuItem;
    SavePosItem: TMenuItem;
    SaveConfigItem: TMenuItem;
    sp5: TMenuItem;
    OptionsItem: TMenuItem;
    HelpItem: TMenuItem;
    SysInfoItem: TMenuItem;
    sp9: TMenuItem;
    SendItem: TMenuItem;
    LicItem: TMenuItem;
    AboutItem: TMenuItem;
    TrayMenu: TPopupMenu;
    CloseItem: TMenuItem;
    Timer2: TTimer;
    OpenDlg: TOpenDialog;
    ImageList1: TImageList;
    ImageList2: TImageList;
    CurDate: TXPLabel;
    MinItem: TMenuItem;
    sp3: TMenuItem;
    ResItem: TMenuItem;
    MyDate: TXPLabel;
    SetTime: TMaskEdit;
    Check: TXPCheckBox;
    Choose: TXPButton;
    SetTimeDate: TXPLabel;
    PlaySound: TMediaPlayer;
    sp10: TMenuItem;
    sp7: TMenuItem;
    Logo: TImage;
    ContextItem: TMenuItem;
    IEItem: TMenuItem;
    sp8: TMenuItem;
    ColorItem: TMenuItem;
    SourceCodeItem: TMenuItem;
    sp6: TMenuItem;
    CheckSound: TXPLabel;
    ColorDlg: TColorDialog;
    ChooseItem: TMenuItem;
    CheckSoundItem: TMenuItem;
    sp11: TMenuItem;
    PropertiesItem: TMenuItem;
    sp12: TMenuItem;
    HomePageItem: TMenuItem;
    N1: TMenuItem;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure AboutItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SysInfoItemClick(Sender: TObject);
    procedure SendItemClick(Sender: TObject);
    procedure LicItemClick(Sender: TObject);
    procedure CheckClick(Sender: TObject);
    procedure QuitItemClick(Sender: TObject);
    procedure ChooseClick(Sender: TObject);
    procedure OptionsItemClick(Sender: TObject);
    procedure SetTimeChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CloseItemClick(Sender: TObject);
    procedure SavePosItemClick(Sender: TObject);
    procedure MultipleItemClick(Sender: TObject);
    procedure NewWinItemClick(Sender: TObject);
    procedure OnTopItemClick(Sender: TObject);
    procedure PropItemClick(Sender: TObject);
    procedure DeskItemClick(Sender: TObject);
    procedure StartMenuItemClick(Sender: TObject);
    procedure ProgramsItemClick(Sender: TObject);
    procedure StartupItemClick(Sender: TObject);
    procedure FavoritesItemClick(Sender: TObject);
    procedure MainMenuItemClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure MediaPlayer1Notify(Sender: TObject);
    procedure MinItemClick(Sender: TObject);
    procedure SetTimeDateClick(Sender: TObject);
    procedure SaveConfigItemClick(Sender: TObject);
    procedure SetTimeDateMouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure SetTimeDateMouseLeave(Sender: TObject);
    procedure SetTimeDateMouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint;
    var Handled: Boolean);
    procedure ResItemClick(Sender: TObject);
    procedure RusItemClick(Sender: TObject);
    procedure EngItemClick(Sender: TObject);
    procedure OpenDlgShow(Sender: TObject);
    procedure ContextItemClick(Sender: TObject);
    procedure IEItemClick(Sender: TObject);
    procedure ColorItemClick(Sender: TObject);
    procedure SourceCodeItemClick(Sender: TObject);
    procedure CheckSoundClick(Sender: TObject);
    procedure CheckSoundMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckSoundMouseLeave(Sender: TObject);
    procedure CheckSoundMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PropertiesItemClick(Sender: TObject);
    procedure HomePageItemClick(Sender: TObject);

  private

    R: Tregistry;

    Ini: TIniFile;

    LinkFile: IPersistFile;

    ShellObject: IUnknown;

    ShellLink: IShellLink;

    FileName, ShortcutPosition: string;

    WShortcutPosition: WideString;

    P: PItemIDList;

    S: string;

    C: array[0..1000] of char;

    hMutex: THandle;

    SM: HWND;

    Icon: TNotifyIconData;

    procedure DrawClock(t: TTime);

    procedure MinimizedApplication(Sender: TObject);

    procedure SystemTrayMenu(var Oleg: TMessage);
    message Tray;

    procedure MySystemMenu(var MySysMenu: TWmSysCommand);
    message Wm_SysCommand;

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

    procedure ChangeMessageBoxPosition(var Msg: TMessage);
    message AlignCenter;

    procedure MuHotKeys(var MyHotKeys: TWmHotKey);
    message Wm_HotKey;

    procedure CMMouseLeave(var msg: TMessage);
    message CM_MOUSELEAVE;

  public

  end;

var
  MainForm: TMainForm;

implementation

uses AP, LP, OP, SSP, AFP;

{$R *.dfm}

function MyExitWindows(RebootParam: Longword): Boolean;
var
TTokenHd: THandle;
TTokenPvg: TTokenPrivileges;
cbtpPrevious: DWORD;
rTTokenPvg: TTokenPrivileges;
pcbtpPreviousRequired: DWORD;
tpResult: Boolean;
const
SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
if Win32Platform = VER_PLATFORM_WIN32_NT then
begin
tpResult := OpenProcessToken(GetCurrentProcess(),
TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
TTokenHd);
if tpResult then
begin
tpResult := LookupPrivilegeValue(nil,
SE_SHUTDOWN_NAME,
TTokenPvg.Privileges[0].Luid);
TTokenPvg.PrivilegeCount := 1;
TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
cbtpPrevious := SizeOf(rTTokenPvg);
pcbtpPreviousRequired := 0;
if tpResult then
Windows.AdjustTokenPrivileges(TTokenHd, False,
TTokenPvg, cbtpPrevious, rTTokenPvg, pcbtpPreviousRequired);
end;
end;
Result := ExitWindowsEx(RebootParam, 0);
end;

procedure CopyFilesToClipboard(FileList: string); 
var 
DropFiles: PDropFiles;
hGlobal: THandle;
iLen: Integer;
begin
try
iLen := Length(FileList) + 2;
FileList := FileList + #0#0;
hGlobal := GlobalAlloc(GMEM_SHARE or GMEM_MOVEABLE or GMEM_ZEROINIT,
SizeOf(TDropFiles) + iLen);
if (hGlobal = 0) then raise Exception.Create('Could not allocate memory!');
begin
DropFiles := GlobalLock(hGlobal);
DropFiles^.pFiles := SizeOf(TDropFiles);
Move(FileList[1], (PChar(DropFiles) + SizeOf(TDropFiles))^, iLen);
GlobalUnlock(hGlobal);
Clipboard.SetAsHandle(CF_HDROP, hGlobal);
end;
except
end;
end;

function GetFileSizeByName(FileName: String): Integer;
var
FindData: TWin32FindData;
hFind: THandle;
begin
Result := -1;
hFind := FindFirstFile(PChar(FileName), FindData);
if hFind <> INVALID_HANDLE_VALUE then
begin
Windows.FindClose(hFind);
if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
Result := FindData.nFileSizeLow;
end;
end;

procedure MakeRounded(Control: TWinControl);
var
R: TRect;
Rgn: HRGN;
begin
with Control do
begin
R := ClientRect;
rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 20, 20);
Perform(EM_GETRECT, 0, lParam(@r));
InflateRect(r, - 5, - 5);
Perform(EM_SETRECTNP, 0, lParam(@r));
SetWindowRgn(Handle, rgn, True);
Invalidate;
end;
end;

procedure TMainForm.DrawClock(t: TTime);
var
x,y,i: integer;
h,m,s,ms: word;
step,c: double;
begin
MyFace.Canvas.Brush.Color:=$00FFFCF9;
MyFace.Canvas.Ellipse(3,3,108,108);
step:=2*pi/60;
MyFace.Canvas.Pen.Color:=clBlack;
for i:=0 to 11 do begin
MyFace.Canvas.MoveTo(55,55);
x:=55+Round(52*sin(i*step*5));
y:=55-Round(52*cos(i*step*5));
MyFace.Canvas.LineTo(x,y);
end;
MyFace.Canvas.Pen.Color:=clGray;
MyFace.Canvas.Ellipse(7,7,104,104);
DecodeTime(t,h,m,s,ms);
MyFace.Canvas.MoveTo(55,55);
x:=55+Round(49*sin(s*step));
y:=55-Round(49*cos(s*step));
MyFace.Canvas.Pen.Color:=clGray;
MyFace.Canvas.LineTo(x,y);
MyFace.Canvas.MoveTo(55,55);
c:=(m*60+s)/60;
x:=55+Round(43*sin(c*step));
y:=55-Round(43*cos(c*step));
MyFace.Canvas.Pen.Color:=clBlack;
MyFace.Canvas.LineTo(x,y);
MyFace.Canvas.MoveTo(55,55);
if h>12 then h:=h-12;
c:=(h*60+m)/60*5;
x:=55+Round(33*sin(c*step));
y:=55-Round(33*cos(c*step));
MyFace.Canvas.Pen.Width:=2;
MyFace.Canvas.LineTo(x,y);
MyFace.Canvas.Pen.Width:=1;
MyFace.Canvas.TextOut(10, 50, '21');
MyFace.Canvas.TextOut(49, 10, '00');
MyFace.Canvas.TextOut(49, 88, '18');
MyFace.Canvas.TextOut(88, 50, '15');
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
Timer1.Interval := 1000;
DrawClock(now);
MyTime.Caption := FormatDateTime('hh:mm:ss', time());
MyDate.Caption := DateToStr(Now);
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
begin
try
if MyTime.Caption = SetTime.Text then
begin
PlaySound.FileName := OpenDlg.FileName;
PlaySound.Open;
PlaySound.Play;
end;
if MyTime.Caption = SetTime.Text then
if SetForm.ch2.Checked then
begin
ShowWindow(Application.Handle, Sw_Show);
Application.Restore;
ShowWindow(Handle, Sw_Show);
Shell_NotifyIcon(Nim_Delete, @Icon);
end;
except
if not FileExists(OpenDlg.FileName) then
begin
ShowWindow(Application.Handle, Sw_Show);
Application.Restore;
ShowWindow(Handle, Sw_Show);
Shell_NotifyIcon(Nim_Delete, @Icon);
Timer2.Enabled := False;
PostMessage(Handle, WM_USER + 1024, 0, 0);
if RusItem.Checked then
Application.MessageBox('Звуковой файл не найден!',
'Hell of the Ring',
mb_IconQuestion + mb_OK);
if EngItem.Checked then
Application.MessageBox('Sound file is not found!',
'Hell of the Ring',
mb_IconQuestion + mb_OK);
end;
end;
end;

procedure TMainForm.AboutItemClick(Sender: TObject);
begin
AboutForm.Position := poMainFormCenter;
AboutForm.ShowModal;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
RegisterHotKey(Handle, 1, MOD_Control or MOD_Shift, ord('R'));
MakeRounded(fr2);
with Icon do
begin
Wnd := Handle;
SzTip := 'Hell of the Ring v 1.0';
HIcon := Application.Icon.Handle;
UCallBackMessage := Tray;
UFlags := Nif_Tip + nIf_Message or Nif_Icon;
Application.OnMinimize := MinimizedApplication;
end;
Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
try
Left := Ini.ReadInteger('Parameters', 'Left', 200);
Top := Ini.ReadInteger('Parameters', 'Top', 200);
MultipleItem.Checked := Ini.ReadBool('Parameters', 'Forbid multiple', MultipleItem.Checked);
OnTopItem.Checked := Ini.ReadBool('Parameters', 'Always on top', OnTopItem.Checked);
MainMenuItem.Checked := Ini.ReadBool('Parameters', 'Main menu', MainMenuItem.Checked);
RusItem.Checked := Ini.ReadBool('Parameters', 'Russian interface', RusItem.Checked);
EngItem.Checked := Ini.ReadBool('Parameters', 'English interface', EngItem.Checked);
ColorDlg.Color := Ini.ReadInteger('Parameters', 'Color of time and date', ColorDlg.Color);
except
end;
hMutex := CreateMutex(nil, true , 'Hell of the Ring');
if GetLastError = ERROR_ALREADY_EXISTS then
if MultipleItem.Checked then
halt;
end;

procedure TMainForm.SysInfoItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'msInfo32', nil,nil, Sw_ShowNormal);
end;

procedure TMainForm.SendItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'Mailto:GoodWinNix@mail.ru',
nil, nil, Sw_ShowNormal);
end;

procedure TMainForm.LicItemClick(Sender: TObject);
begin
LicForm.Position := poMainFormCenter;
LicForm.ShowModal;
end;

procedure TMainForm.CheckClick(Sender: TObject);
begin
try
if Check.Checked then
begin
CheckSound.tag:=0;
PlaySound.Open;
PlaySound.Stop;
Timer2.Enabled:=True;
Choose.Enabled := False;
CheckSound.Enabled := False;
CheckSoundItem.Enabled := False;
SetTime.Enabled := False;
if RusItem.Checked then
begin
CheckSound.Caption := 'Проверить звук';
CheckSoundItem.Caption := 'Проверить звук';
end;
if EngItem.Checked then
begin
CheckSound.Caption := 'Check Sound';
CheckSoundItem.Caption := 'Check Sound';
end;
CheckSound.Enabled := False;
if RusItem.Checked then
begin
Check.Caption := 'Выключить';
end;
if EngItem.Checked then
begin
Check.Caption := 'Switch off';
end;
if SetForm.ch1.Checked then
begin
Application.Minimize;
end;
end;
if not Check.Checked then
begin
Timer2.Enabled:=False;
Choose.Enabled := True;
CheckSound.Enabled := True;
CheckSoundItem.Enabled := True;
SetTime.Enabled := True;
if RusItem.Checked then
begin
Check.Caption := 'Включить';
end;
if EngItem.Checked then
begin
Check.Caption := 'Switch on';
end;
PlaySound.Open;
PlaySound.Stop;
end;
except
end;
end;

procedure TMainForm.QuitItemClick(Sender: TObject);
begin
Close;
end;

procedure TMainForm.ChooseClick(Sender: TObject);
begin
try
if OpenDlg.Execute then
begin
if SetForm.ch9.Checked then
begin
CopyFilesToClipboard(OpenDlg.FileName);
end;
PlaySound.FileName := OpenDlg.FileName;
Check.Enabled := True;
CheckSound.Enabled := True;
CheckSoundItem.Enabled := True;
PropertiesItem.Enabled := True;
SetTime.Enabled := True;
PlaySound.Stop;
CheckSound.Tag := 0;
if RusItem.Checked then
begin
CheckSound.Caption := 'Проверить звук';
CheckSoundItem.Caption := 'Проверить звук';
end;
if EngItem.Checked then
begin
CheckSound.Caption := 'Check Sound';
CheckSoundItem.Caption := 'Check Sound';
end;
SetTime.SetFocus;
end;
except
end;
end;

procedure TMainForm.OptionsItemClick(Sender: TObject);
begin
SetForm.Position := poMainFormCenter;
SetForm.ShowModal;
end;

procedure TMainForm.SetTimeChange(Sender: TObject);
begin
try
except
ShowMessage('');
end;
end;

procedure TMainForm.MinimizedApplication(Sender: TObject);
begin
ShowWindow(Application.Handle, Sw_Hide);
ShowWindow(Handle, Sw_Hide);
Shell_NotifyIcon(Nim_Add, @Icon);
end;

procedure TMainForm.SystemTrayMenu(var Oleg: TMessage);
var
Ico: TPoint;
begin
case Oleg.LParam of
Wm_LButtonDblClk:
begin
ShowWindow(Application.Handle, Sw_Show);
Application.Restore;
ShowWindow(Handle, Sw_Show);
Shell_NotifyIcon(Nim_Delete, @Icon);
end;
Wm_RButtonDown:
begin
SetForegroundWindow(Handle);
GetCursorPos(Ico);
TrayMenu.Popup(Ico.X, Ico.Y);
end;
end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
Shell_NotifyIcon(Nim_Delete, @Icon);
Sm := GetSystemMenu(Handle, True);
UnRegisterHotKey(Handle, 1);
MainForm.OnActivate := nil;
SetTimeDate.Free;
ImageList1.Free;
ImageList2.Free;
PlaySound.Free;
TrayMenu.Free;
MainMenu.Free;
SetTime.Free;
CurTime.Free;
CurDate.Free;
OpenDlg.Free;
Timer1.Free;
Timer2.Free;
Choose.Free;
MyDate.Free;
MyTime.Free;
Check.Free;
Logo.Free;
Ini.Free;
fr1.Free;
fr2.Free;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if SetForm.ch5.Checked then
begin
SaveConfigItem.Click;
end;
if SetForm.ch10.Checked then
begin
SavePosItem.Click;
end;
if SetForm.ch3.Checked then
begin
Action := caNone;
ShowWindow(MainForm.Handle, Sw_Hide);
ShowWindow(Application.Handle, Sw_Hide);
Shell_NotifyIcon(Nim_Add, @Icon);
end;
AnimateWindow(handle, 500, AW_BLEND or AW_HIDE);
if RusItem.Checked then
if SetForm.Ch11.Checked then
if SetForm.Ch12.Checked then
if Application.MessageBox('Вы уверены, что хотите выключить компьютер?',
'Предупреждение',
Mb_IconHand + Mb_YesNo) = idYes then
MyExitWindows(EWX_POWEROFF or EWX_FORCE);
if EngItem.Checked then
if SetForm.Ch11.Checked then
if SetForm.Ch12.Checked then
if Application.MessageBox('You are sure, what do you want to shutdown of your computer?',
'Confirmation',
Mb_IconHand + Mb_YesNo) = idYes then
MyExitWindows(EWX_POWEROFF or EWX_FORCE);
if not SetForm.Ch12.Checked then
if SetForm.Ch11.Checked then
MyExitWindows(EWX_POWEROFF or EWX_FORCE);
end;

procedure TMainForm.FormShow(Sender: TObject);
var
Reg: TRegistry;
begin
Timer1.Interval := 1;
MainForm.AlphaBlendValue := SetForm.TranparentBar.ThumbPosition;
Reg := TRegistry.Create;
with Reg do begin
RootKey := HKEY_CLASSES_ROOT;
if not reg.KeyExists
('\*\Shell\Time Alarm\Command\')then
ContextItem.Checked := False else
ContextItem.Checked := True;
RootKey := HKEY_LOCAL_MACHINE;
if not reg.KeyExists
('\Software\Microsoft\Internet Explorer\Extensions\{4D073934-BDFB-46BD-B8CA-8F3B36539DE1}\')then
IEItem.Checked := False else
IEItem.Checked := True;
end;
if RusItem.Checked = False then
if EngItem.Checked = False then
RusItem.Click;
if RusItem.Checked = True then
RusItem.Click;
if EngItem.Checked = True then
EngItem.Click;
r := TRegistry.Create;
r.RootKey := HKEY_LOCAL_MACHINE;
r.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', false);
if SetForm.Ch8.Checked then
r.WriteString(Application.Title, ParamStr(0)) else
r.DeleteValue(Application.Title);
if MainMenuItem.Checked then
begin
FileItem.Visible := True;
ToolsItem.Visible := True;
ShortCutItem.Visible := True;
HelpItem.Visible := True;
MainForm.ClientHeight := 200;
end else
begin
FileItem.Visible := False;
ToolsItem.Visible := False;
ShortCutItem.Visible := False;
HelpItem.Visible := False;
MainForm.ClientHeight := 200;
end;
if SetForm.ch4.Checked then
MainMenu.Images := ImageList2 else
MainMenu.Images := ImageList1;
if SetForm.ch4.Checked then
MainForm.TrayMenu.Images := ImageList2 else
MainForm.TrayMenu.Images := ImageList1;
if SetForm.ch6.Checked then
begin
RyMenu.Add(MainMenu, nil);
RyMenu.Add(TrayMenu, nil);
end;
if OnTopItem.Checked = False
then begin
SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE+SWP_NOSIZE);
end else begin
SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE+SWP_NOSIZE);
OnTopItem.Checked := true;
end;
MyTime.ForegroundColor := ColorDlg.Color;
MyDate.ForegroundColor := ColorDlg.Color;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if not SetForm.ch3.Checked then
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if RusItem.Checked then
if SetForm.Ch7.Checked then
CanClose :=
Application.MessageBox('Вы уверены, что хотите выйти из Hell of the Ring?',
'Выход',
mb_IconQuestion + mb_YesNo) = mrYes;
end;
if not SetForm.ch3.Checked then
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if EngItem.Checked then
if SetForm.Ch7.Checked then
CanClose :=
Application.MessageBox('Are you sure, what do you want to exit Hell of the Ring?',
'Exit',
mb_IconQuestion + mb_YesNo) = mrYes;
end;
end;

procedure TMainForm.CloseItemClick(Sender: TObject);
begin
if SetForm.ch5.Checked then
begin
SaveConfigItem.Click;
end;
if SetForm.ch10.Checked then
begin
SavePosItem.Click;
end;
if RusItem.Checked then
if SetForm.Ch7.Checked then
if Application.MessageBox('Вы уверены, что хотите выйти из Hell of the Ring?',
'Выход',
mb_IconQuestion + mb_YesNo) = mrYes then
Halt;
if EngItem.Checked then
if SetForm.Ch7.Checked then
if Application.MessageBox('Are you sure, what do you want to closed Hell of the Ring?',
'Exit',
mb_IconQuestion + mb_YesNo) = mrYes then
Halt;
if not SetForm.Ch7.Checked then
begin
Halt;
end;
end;

procedure TMainForm.SavePosItemClick(Sender: TObject);
begin
Ini.WriteInteger('Parameters', 'Left', Left);
Ini.WriteInteger('Parameters', 'Top', Top);
end;

procedure TMainForm.MultipleItemClick(Sender: TObject);
begin
MultipleItem.Checked := not MultipleItem.Checked;
Ini.WriteBool('Parameters', 'Forbid multiple', MultipleItem.Checked);
end;

procedure TMainForm.NewWinItemClick(Sender: TObject);
var
PC: array[0..255] of char;
S: String;
begin
{$ifdef Windows}
WinExec(StrPCopy(PC, ParamStr(0)+' '+S), Sw_Show);
{$else}
WinExec(StrPCopy(PC, ParamStr(0)+' "'+S+'"'), Sw_Show);
{$endif}
end;

procedure TMainForm.OnTopItemClick(Sender: TObject);
begin
OnTopItem.Checked := not OnTopItem.Checked;
if OnTopItem.Checked = False
then begin
SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE+SWP_NOSIZE);
end else begin
SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE+SWP_NOSIZE);
OnTopItem.Checked := true;
end;
end;

procedure ShowPropertiesDialog(FName: string);
var
SExInfo: TSHELLEXECUTEINFO;
begin
ZeroMemory(Addr(SExInfo),SizeOf(SExInfo));
SExInfo.cbSize := SizeOf(SExInfo);
SExInfo.lpFile := PChar(FName);
SExInfo.lpVerb := 'properties';
SExInfo.fMask  := SEE_MASK_INVOKEIDLIST;
ShellExecuteEx(Addr(SExInfo));
end;

procedure TMainForm.PropItemClick(Sender: TObject);
begin
ShowPropertiesDialog(ParamStr(0));
end;

procedure TMainForm.DeskItemClick(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_DESKTOP,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
s:= 'Hell of the Ring';
if RusItem.Checked then
begin
if not InputQuery('Hell of the Ring',
'Вы хотите разместить ярлык на Рабочем Столе?', s)
then s := 'Hell of the Ring' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
if EngItem.Checked then
begin
if not InputQuery('Hell of the Ring',
'Do you want a shortcut to your Desktop?', s)
then s := 'Hell of the Ring' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TMainForm.StartMenuItemClick(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_STARTMENU,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
s:= 'Hell of the Ring';
if RusItem.Checked then
begin
if not InputQuery('Hell of the Ring',
'Вы хотите разместить ярлык в Главном Меню?', s)
then s := 'Hell of the Ring' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
if EngItem.Checked then
begin
if not InputQuery('Hell of the Ring',
'Do you want a shortcut to your Start Menu?', s)
then s := 'Hell of the Ring' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TMainForm.ProgramsItemClick(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_PROGRAMS,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
s:= 'Hell of the Ring';
if RusItem.Checked then
begin
if not InputQuery('Hell of the Ring',
'Вы хотите разместить ярлык в Меню Программы?', s)
then s := 'Hell of the Ring' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
if EngItem.Checked then
begin
if not InputQuery('Hell of the Ring',
'Do you want a shortcut to your Programs Menu?', s)
then s := 'Hell of the Ring' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TMainForm.StartupItemClick(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_STARTUP,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
s:= 'Hell of the Ring';
if RusItem.Checked then
begin
if not InputQuery('Hell of the Ring',
'Вы хотите разместить ярлык в папке Автозагрузки?', s)
then s := 'Hell of the Ring' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
if EngItem.Checked then
begin
if not InputQuery('Hell of the Ring',
'Do you want a shortcut to your Startup folder?', s)
then s := 'Hell of the Ring' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TMainForm.FavoritesItemClick(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_FAVORITES,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
s:= 'Hell of the Ring';
if RusItem.Checked then
begin
if not InputQuery('Hell of the Ring',
'Вы хотите разместить ярлык в Избранном?', s)
then s := 'Hell of the Ring' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
if EngItem.Checked then
begin
if not InputQuery('Hell of the Ring',
'Do you want a shortcut to your Favorites?', s)
then s := 'Hell of the Ring' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TMainForm.MainMenuItemClick(Sender: TObject);
begin
MainMenuItem.Checked := not MainMenuItem.Checked;
if MainMenuItem.Checked then
begin
FileItem.Visible := True;
ToolsItem.Visible := True;
ShortCutItem.Visible := True;
HelpItem.Visible := True;
MainForm.ClientHeight := 200;
end else
begin
FileItem.Visible := False;
ToolsItem.Visible := False;
ShortCutItem.Visible := False;
HelpItem.Visible := False;
MainForm.ClientHeight := 200;
end;
end;

procedure TMainForm.ChangeMessageBoxPosition(var Msg: TMessage);
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
x := MainForm.Left + ((MainForm.Width - w) div 2);
if x < 0 then
x := 0
else if x + w > Screen.Width then x := Screen.Width - w;
y := MainForm.Top + ((MainForm.Height - h) div 2);
if y < 0 then y := 0
else if y + h > Screen.Height then y := Screen.Height - h;
SetWindowPos(MBHWnd, 0, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;
end;

procedure TMainForm.WMMoving(var msg: TWMMoving);
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

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if SetForm.ch13.Checked then
begin
if Key = vk_Escape then
Application.Minimize;
end;
end;

procedure TMainForm.MediaPlayer1Notify(Sender: TObject);
begin
if SetForm.ch14.Checked then
begin
with PlaySound do
if NotifyValue = nvSuccessful then
begin
Notify := True;
Play;
end;
end;
end;

procedure TMainForm.MinItemClick(Sender: TObject);
begin
Application.Minimize;
end;

procedure TMainForm.SetTimeDateClick(Sender: TObject);
begin
WinExec('Control.exe timedate.cpl', Sw_Restore);
end;

procedure TMainForm.SaveConfigItemClick(Sender: TObject);
begin
Ini.WriteBool('Parameters', 'Minimized to tray on switch of alarm', SetForm.ch1.Checked);
Ini.WriteBool('Parameters', 'Restore form tray on include of alarm', SetForm.ch2.Checked);
Ini.WriteBool('Parameters', 'Minimized to tray at closing', SetForm.ch3.Checked);
Ini.WriteBool('Parameters', 'Images in the menu', SetForm.ch4.Checked);
Ini.WriteBool('Parameters', 'Auto save configuration', SetForm.ch5.Checked);
Ini.WriteBool('Parameters', 'Use of XP menu', SetForm.ch6.Checked);
Ini.WriteBool('Parameters', 'Confirmation exit', SetForm.ch7.Checked);
Ini.WriteBool('Parameters', 'Run with Windows OS start up', SetForm.ch8.Checked);
Ini.WriteBool('Parameters', 'Copy file to Clipboard', SetForm.ch9.Checked);
Ini.WriteBool('Parameters', 'Auto save window position', SetForm.ch10.Checked);
Ini.WriteBool('Parameters', 'Shutdown PC on exit', SetForm.ch11.Checked);
Ini.WriteBool('Parameters', 'Confirm before shutdown PC on exit', SetForm.ch12.Checked);
Ini.WriteBool('Parameters', 'Minimized on pressing Escape', SetForm.ch13.Checked);
Ini.WriteBool('Parameters', 'Play sound endless', SetForm.ch14.Checked);
Ini.WriteBool('Parameters', 'Always on top', OnTopItem.Checked);
Ini.WriteBool('Parameters', 'Main menu', MainMenuItem.Checked);
Ini.WriteBool('Parameters', 'Russian interface', RusItem.Checked);
Ini.WriteBool('Parameters', 'English interface', EngItem.Checked);
Ini.WriteInteger('Parameters', 'Color of time and date', ColorDlg.Color);
Ini.WriteInteger('Tranparent', 'Value', SetForm.TranparentBar.ThumbPosition);
end;

procedure TMainForm.SetTimeDateMouseMove(Sender: TObject;
Shift: TShiftState; X, Y: Integer);
begin
SetTimeDate.ForegroundColor := clRed;
end;

procedure TMainForm.SetTimeDateMouseLeave(Sender: TObject);
begin
SetTimeDate.ForegroundColor := $00FF8000;
end;

procedure TMainForm.SetTimeDateMouseUp(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
SetTimeDate.ForegroundColor := $00FF8000;
end;

procedure TMainForm.FormContextPopup(Sender: TObject; MousePos: TPoint;
var Handled: Boolean);
begin
if SetForm.ch15.Checked then
begin
Application.Minimize;
end;
end;

procedure TMainForm.ResItemClick(Sender: TObject);
begin
ShowWindow(Application.Handle, Sw_Show);
Application.Restore;
ShowWindow(Handle, Sw_Show);
Shell_NotifyIcon(Nim_Delete, @Icon);
end;

procedure TMainForm.RusItemClick(Sender: TObject);
begin
Sm := GetSystemMenu(Handle, True);
Sm := GetSystemMenu(Handle, False);
InsertMenu(SM, Word(-1), Mf_Separator, Cherta, '');
InsertMenu(SM, Word(-2), Mf_ByPosition, AboutPro, 'О программе...');
if CheckSound.Tag = 0 then
CheckSound.Caption := 'Проверить звук';
if CheckSound.Tag = 1 then
CheckSound.Caption := 'Приостановить';
RusItem.Checked := True;
EngItem.Checked := False;
OpenDlg.Title := 'Выбрать музыкальный файл';
Choose.Caption := 'Загрузить...';
Check.Caption := 'Включить';
CurTime.Caption := 'Текущее время';
CurDate.Caption := 'Текущая дата';
SetTimeDate.Caption := 'Изменение параметров даты и времени';
FileItem.Caption := 'Файл';
NewWinItem.Caption := 'Новое окно';
ChooseItem.Caption := 'Загрузить файл...';
if CheckSound.Tag = 0 then
CheckSoundItem.Caption := 'Проверить звук';
if CheckSound.Tag = 1 then
CheckSoundItem.Caption := 'Приостановить';
PropertiesItem.Caption := 'Изменить атрибуты...';
QuitItem.Caption := 'Выход';
ToolsItem.Caption := 'Инструменты';
LangItem.Caption := 'Интерфейс';
RusItem.Caption := 'Русский';
EngItem.Caption := 'Английский';
MainMenuItem.Caption := 'Главное меню';
MultipleItem.Caption := 'Запуск одной копии';
OnTopItem.Caption := 'Всегда впереди';
MinItem.Caption := 'Свернуть';
SaveConfigItem.Caption := 'Сохранить конфигурацию';
SavePosItem.Caption := 'Сохранить позицию';
ColorItem.Caption := 'Цвет даты и времени';
OptionsItem.Caption := 'Параметры...';
ShortcutItem.Caption := 'Ярлык';
DeskItem.Caption := 'На Рабочем столе';
StartMenuItem.Caption := 'В Меню Пуск';
ProgramsItem.Caption := 'В Меню Программы';
StartupItem.Caption := 'В Автозагрузку';
FavoritesItem.Caption := 'В Избранное';
ContextItem.Caption := 'В контекстное меню';
IEItem.Caption := 'В Internet Explorer';
PropItem.Caption := 'Свойства...';
HelpItem.Caption := 'Помощь';
SysInfoItem.Caption := 'Сведения о системе...';
LicItem.Caption := 'Лицензия';
SendItem.Caption := 'Обратная связь';
SourceCodeItem.Caption := 'Исходный код...';
AboutItem.Caption := 'О программе...';
HomePageItem.Caption := 'Домашняя страница...';
ResItem.Caption := 'Открыть';
CloseItem.Caption := 'Выход';
if Check.Checked then
begin
Check.Caption := 'Выключить';
end;
if not Check.Checked then
begin
Check.Caption := 'Включить';
end;
SetForm.Caption := 'Параметры';
SetForm.GeneralTab.Caption := 'Общие';
SetForm.EventsTab.Caption := 'События';
SetForm.WindowTab.Caption := 'Окно';
SetForm.ExitTab.Caption := 'При выходе';
SetForm.ch1.Caption := 'Сворачивать окно при активизации будильника';
SetForm.ch2.Caption := 'Восстанавливать окно при активации будильника';
SetForm.ch3.Caption := 'Сворачивать в лоток при закрытии';
SetForm.ch4.Caption := 'Убрать рисунки из меню';
SetForm.ch5.Caption := 'Автоматически сохранять конфигурацию';
SetForm.ch6.Caption := 'Использовать XP меню';
SetForm.ch7.Caption := 'Подтверждать выход';
SetForm.ch8.Caption := 'Запускать вместе с Windows OS';
SetForm.ch9.Caption := 'Копировать открытый файл в буфер обмена';
SetForm.ch10.Caption := 'Автоматически сохранять позицию окна';
SetForm.ch11.Caption := 'Отключить компьютер';
SetForm.ch12.Caption := 'Подтверждение перед выключением компьютера';
SetForm.ch13.Caption := 'Сворачивать при нажатии Escape';
SetForm.ch14.Caption := 'Играть звуковой файл бесконечно';
SetForm.ch15.Caption := 'Сворачивать при правом щелчке мыши';
SetForm.tx1.Caption := 'Прозрачность';
LicForm.Caption := 'Лицензионное соглашение';
LicForm.PrintText.Caption := 'Печать';
LicForm.OK.Caption := 'Закрыть';
AboutForm.Caption := 'О программе "Hell of the Ring"';
AboutForm.t2.Caption := 'Copyright © 2009 Домани Олег (aka ?КТО_Я?)';
AboutForm.t3.Caption := 'Пермская область, г. Чайковский';
AboutForm.t4.Caption := 'Обладателем лицензии на этот продукт является:';
AboutForm.SendEdit.Text := 'Написать письмо автору';
AboutForm.OK.Caption := 'Закрыть';
ScreenForm.Caption := '';
ScreenForm.tx1.Caption := 'Hell of the Ring v 1.0';
ScreenForm.tx2.Caption := 'E-mail: viacoding@mail.ru';
ScreenForm.tx3.Caption := 'Copyright © 2009';
ScreenForm.tx4.Caption := 'Домани Олег (aka ?КТО_Я?)';
ScreenForm.tx5.Caption := 'Пермская область, г. Чайковский';
ScreenForm.tx6.Caption := 'Home page: http://viacoding.mylivepage.ru/';
ScreenForm.tx7.Caption := 'ICQ: 415660036';
ScreenForm.tx8.Caption := 'E-mail: GoodWinNix@mail.ru';
AttrForm.Caption := 'Атрибуты';
AttrForm.fr1.Caption := 'Текущий файл';
AttrForm.fr2.Caption := 'Атрибуты';
AttrForm.ChReadOnly.Caption := 'Только чтение';
AttrForm.ChSystem.Caption := 'Системный';
AttrForm.ChArchive.Caption := 'Архивный';
AttrForm.ChHidden.Caption := 'Скрытый';
AttrForm.OK.Caption := 'OK';
AttrForm.Cancel.Caption := 'Отмена';
end;

procedure TMainForm.EngItemClick(Sender: TObject);
begin
Sm := GetSystemMenu(Handle, True);
Sm := GetSystemMenu(Handle, False);
InsertMenu(SM, Word(-1), Mf_Separator, Cherta, '');
InsertMenu(SM, Word(-2), Mf_ByPosition, AboutPro, 'About...');
if CheckSound.Tag = 0 then
CheckSound.Caption := 'Check Sound';
if CheckSound.Tag = 1 then
CheckSound.Caption := 'Stop';
EngItem.Checked := True;
RusItem.Checked := False;
OpenDlg.Title := 'Choose of Musical File';
Choose.Caption := 'Choose file...';
Check.Caption := 'Switch on';
CurTime.Caption := 'Current Time';
CurDate.Caption := 'Current Date';
SetTimeDate.Caption := 'Change Settings of Time and Date';
FileItem.Caption := 'Time Alarm';
NewWinItem.Caption := 'New Window';
ChooseItem.Caption := 'Choose file...';
if CheckSound.Tag = 0 then
CheckSoundItem.Caption := 'Check Sound';
if CheckSound.Tag = 1 then
CheckSoundItem.Caption := 'Stop';
PropertiesItem.Caption := 'Change attributes...';
QuitItem.Caption := 'Quit';
ToolsItem.Caption := 'Tools';
LangItem.Caption := 'Language';
RusItem.Caption := 'Russian';
EngItem.Caption := 'English';
MainMenuItem.Caption := 'Main Menu';
MultipleItem.Caption := 'Forbid Multiple';
OnTopItem.Caption := 'Always on Top';
MinItem.Caption := 'Minimize';
SaveConfigItem.Caption := 'Save Settings';
SavePosItem.Caption := 'Save Position';
ColorItem.Caption := 'Color of Time and Date';
OptionsItem.Caption := 'Preferences...';
ShortcutItem.Caption := 'Shortcut';
DeskItem.Caption := 'Desktop';
StartMenuItem.Caption := 'Start Menu';
ProgramsItem.Caption := 'Programs Menu';
StartupItem.Caption := 'Startup Folder';
FavoritesItem.Caption := 'Favorites';
ContextItem.Caption := 'Into Context Menu';
IEItem.Caption := 'Into Internet Explorer';
PropItem.Caption := 'Properties...';
HelpItem.Caption := 'Help';
SysInfoItem.Caption := 'System Information...';
LicItem.Caption := 'License';
SendItem.Caption := 'Send Feedback';
SourceCodeItem.Caption := 'Source Code...';
AboutItem.Caption := 'About...';
HomePageItem.Caption := 'Home Page...';
ResItem.Caption := 'Open';
CloseItem.Caption := 'Quit';
if Check.Checked then
begin
Check.Caption := 'Switch off';
end;
if not Check.Checked then
begin
Check.Caption := 'Switch on';
end;
SetForm.Caption := 'Preferences';
SetForm.GeneralTab.Caption := 'General';
SetForm.EventsTab.Caption := 'Events';
SetForm.WindowTab.Caption := 'Window';
SetForm.ExitTab.Caption := 'On Close';
SetForm.ch1.Caption := 'Minimize window on Activization';
SetForm.ch2.Caption := 'Restore window on Activated';
SetForm.ch3.Caption := 'Minimize to Tray at closing';
SetForm.ch4.Caption := 'Invisible Images in the Menu';
SetForm.ch5.Caption := 'Auto saving configuration';
SetForm.ch6.Caption := 'Use of XP Menu';
SetForm.ch7.Caption := 'Confirmation Exit';
SetForm.ch8.Caption := 'Run with Windows OS Startup';
SetForm.ch9.Caption := 'Copy sound file to Clipboard';
SetForm.ch10.Caption := 'Auto saving window position';
SetForm.ch11.Caption := 'Shutdown PC on application Halt';
SetForm.ch12.Caption := 'Confirmation on before shutdown PC';
SetForm.ch13.Caption := 'Minimized on pressing Escape';
SetForm.ch14.Caption := 'Endless of play sound';
SetForm.ch15.Caption := 'Minimize on Mouse Right click';
SetForm.tx1.Caption := 'Transparency';
LicForm.Caption := 'License Agreement';
LicForm.PrintText.Caption := 'Print';
LicForm.OK.Caption := 'Close';
AboutForm.Caption := 'About "Hell of the Ring"';
AboutForm.t2.Caption := 'Copyright @2009 Domani Oleg (aka ?КТО_Я?)';
AboutForm.t3.Caption := 'Perm Region, Chaykovskiy City';
AboutForm.t4.Caption := 'Possessor of license on this product is given:';
AboutForm.SendEdit.Text := 'Write the letter to the author';
AboutForm.OK.Caption := 'Close';
ScreenForm.Caption := '';
ScreenForm.tx1.Caption := 'Hell of the Ring v 1.0';
ScreenForm.tx2.Caption := 'E-mail: viacoding@mail.ru';
ScreenForm.tx3.Caption := 'Copyright © 2009';
ScreenForm.tx4.Caption := 'Domani Oleg (aka ?КТО_Я?)';
ScreenForm.tx5.Caption := 'Perm Region, Chaykovskiy City';
ScreenForm.tx6.Caption := 'E-mail: GoodWinNix@mail.ru';
ScreenForm.tx7.Caption := 'ICQ: 415660036';
ScreenForm.tx8.Caption := 'E-mail: GoodWinNix@mail.ru';
AttrForm.Caption := 'Attributes';
AttrForm.fr1.Caption := 'Current file';
AttrForm.fr2.Caption := 'Attributes';
AttrForm.ChReadOnly.Caption := 'Read Only';
AttrForm.ChSystem.Caption := 'System';
AttrForm.ChArchive.Caption := 'Archive';
AttrForm.ChHidden.Caption := 'Hidden';
AttrForm.OK.Caption := 'OK';
AttrForm.Cancel.Caption := 'Cancel';
end;

procedure TMainForm.OpenDlgShow(Sender: TObject);
const
LB_FILETYPES_ID = 1089;
LB_FILENAME_ID = 1090;
LB_DRIVES_ID = 1091;
Str1 = 'Выбрать';
Str2 = 'Отмена';
Str3 = 'Тип:';
Str4 = 'Имя:';
Str5 = 'Alarm - clock';
Str6 = 'Choose';
Str7 = 'Cancel';
Str8 = 'Type:';
Str9 = 'Name:';
var
hOpenDialog: HWND;
begin
hOpenDialog := GetParent(OpenDlg.Handle);
if RusItem.Checked then
SendMessage(hOpenDialog, CDM_SETCONTROLTEXT, idOk, Longint(PChar(Str1))) else
SendMessage(hOpenDialog, CDM_SETCONTROLTEXT, idOk, Longint(PChar(Str6)));
if RusItem.Checked then
SendMessage(hOpenDialog, CDM_SETCONTROLTEXT, idCancel, Longint(PChar(Str2))) else
SendMessage(hOpenDialog, CDM_SETCONTROLTEXT, idCancel, Longint(PChar(Str7)));
if RusItem.Checked then
SendMessage(hOpenDialog, CDM_SETCONTROLTEXT, LB_FILETYPES_ID, Longint(PChar(Str3))) else
SendMessage(hOpenDialog, CDM_SETCONTROLTEXT, LB_FILETYPES_ID, Longint(PChar(Str8)));
if RusItem.Checked then
SendMessage(hOpenDialog, CDM_SETCONTROLTEXT, LB_FILENAME_ID, Longint(PChar(Str4))) else
SendMessage(hOpenDialog, CDM_SETCONTROLTEXT, LB_FILENAME_ID, Longint(PChar(Str9)));
SendMessage(hOpenDialog, CDM_SETCONTROLTEXT, LB_DRIVES_ID, Longint(PChar(Str5)));
end;

procedure TMainForm.ContextItemClick(Sender: TObject);
var
Reg: TRegistry;
begin
ContextItem.Checked := not ContextItem.Checked;
if ContextItem.Checked then
begin
Reg:= TRegistry.Create;
Reg.RootKey := HKEY_CLASSES_ROOT;
Reg.OpenKey('*\Shell\Time Alarm',true);
Reg.WriteString('','MyPro');
Reg.WriteString('', Application.Title);
Reg.CloseKey;
Reg.OpenKey('*\Shell\Time Alarm\command',true);
Reg.WriteString('','command');
Reg.WriteString('',paramstr(1) + application.ExeName);
Reg.CloseKey;
Reg.Free;
end else
if not ContextItem.Checked then
begin
Reg:= TRegistry.Create;
Reg.RootKey := HKEY_CLASSES_ROOT;
Reg.DeleteKey('*\Shell\Time Alarm');
Reg.CloseKey;
Reg.Free;
end;
end;

procedure TMainForm.IEItemClick(Sender: TObject);
const
TagID = '\{4D073934-BDFB-46BD-B8CA-8F3B36539DE1}\';
var
Reg: TRegistry;
ProgramPath: string;
RegKeyPath: string;
begin
IEItem.Checked := not IEItem.Checked;
ProgramPath := Application.ExeName;
Reg := TRegistry.Create;
try
with Reg do begin
RootKey := HKEY_LOCAL_MACHINE;
RegKeyPath := 'Software\Microsoft\Internet Explorer\Extensions';
OpenKey(RegKeyPath + TagID, True);
WriteString('ButtonText', 'Hell of the Ring');
WriteString('MenuText', 'Hell of the Ring');
WriteString('MenuStatusBar', 'Hell of the Ring');
WriteString('ClSid', '{1FBA04EE-3024-11d2-8F1F-0000F87ABD16}');
WriteString('Default Visible', 'Yes');
WriteString('Exec', ProgramPath);
WriteString('HotIcon', ',3');
WriteString('Icon', ',4');
end
finally
if not IEItem.Checked then
Reg.DeleteKey
('\Software\Microsoft\Internet Explorer\Extensions\{4D073934-BDFB-46BD-B8CA-8F3B36539DE1}\');
Reg.CloseKey;
Reg.Free;
end;
end;

procedure TMainForm.ColorItemClick(Sender: TObject);
begin
ColorDlg.Color := MyDate.ForegroundColor;
if ColorDlg.Execute then
begin
MyTime.ForegroundColor := ColorDlg.Color;
MyDate.ForegroundColor := ColorDlg.Color;
end;
end;

procedure TMainForm.MuHotKeys(var MyHotKeys: TWmHotKey);
begin
if MyHotKeys.HotKey = 1 then
begin
ShowWindow(Application.Handle, Sw_Show);
Application.Restore;
ShowWindow(Handle, Sw_Show);
Shell_NotifyIcon(Nim_Delete, @Icon);
end;
inherited;
end;

procedure TMainForm.SourceCodeItemClick(Sender: TObject);
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if EngItem.Checked then
begin
if Application.MessageBox(
'Copyright @2008 Domani Oleh (aka ?КТО_Я?)' + #13 +
'=====================================' + #13 + #13 + '' +
'If you want to give of Source Code of Hell of the Ring' + #13
+ '(archives with components library by wish user) and'
+ #13 + 'also all next new version then send e-mail to the author.' + #13 +
'' +  #13 + '=====================================' +  #13 +
'' +  #13 +
'Send mail now?',
'Hell of the Ring',
mb_IconAsterisk + mb_YesNo) = idYes then
begin
ShellExecute(Handle, 'open',
'mailto:GoodWinNix@mail.ru?Subject=Hell of the Ring Project' +
'&Body=Hello, please send me the source code program. Thanks!',
'', '', SW_SHOW);
end;
end;
if RusItem.Checked then
begin
if Application.MessageBox(
'Copyright @2008 Домани Олег (aka ?КТО_Я?)' + #13 +
'======================================' + #13 + #13 + '' +
'Если Вы хотите получить исходный код проекта (архив ' + #13
+ 'с компонентами по желанию пользователя), а также'
+ #13 + 'все последующие новые версии программы, то' + #13 +
'отправьте электронное письмо автору.' + #13 +
'' +  #13 + '======================================' +  #13 +
'' +  #13 +
'Отправить письмо сейчас?',
'Hell of the Ring',
mb_IconAsterisk + mb_YesNo) = idYes then
begin
ShellExecute(Handle, 'open',
'mailto:GoodWinNix@mail.ru?Subject=Hell of the Ring Project' +
'&Body=Hello, please send me the source code program. Thanks!',
'', '', SW_SHOW);
end;
end;
end;

procedure TMainForm.CMMouseLeave(var msg: TMessage);
begin
SetTimeDate.ForegroundColor := $00FF8000;
CheckSound.ForegroundColor := $00FF8000;
end;

procedure TMainForm.CheckSoundClick(Sender: TObject);
begin
try
case CheckSound.tag of
0: begin
CheckSound.tag:=1;
PlaySound.Open;
PlaySound.Play;
if RusItem.Checked then
begin
CheckSound.Caption := 'Приостановить';
CheckSoundItem.Caption := 'Приостановить';
end;
if EngItem.Checked then
begin
CheckSound.Caption := 'Stop';
CheckSoundItem.Caption := 'Stop';
end;
end;
1: begin
PlaySound.Stop;
CheckSound.tag:=0;
if RusItem.Checked then
begin
CheckSound.Caption := 'Проверить звук';
CheckSoundItem.Caption := 'Проверить звук';
end;
if EngItem.Checked then
begin
CheckSound.Caption := 'Check Sound';
CheckSoundItem.Caption := 'Check Sound';
end;
end;
end;
except
end;
end;

procedure TMainForm.CheckSoundMouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
CheckSound.ForegroundColor := $00FF8000;
end;

procedure TMainForm.CheckSoundMouseLeave(Sender: TObject);
begin
CheckSound.ForegroundColor := $00FF8000;
end;

procedure TMainForm.CheckSoundMouseMove(Sender: TObject; Shift: TShiftState;
X, Y: Integer);
begin
CheckSound.ForegroundColor := clRed;
end;

procedure TMainForm.PropertiesItemClick(Sender: TObject);
var
Attributes, NewAttributes: Word;
begin
AttrForm.Position := poMainFormCenter;
if EngItem.Checked then
begin
AttrForm.Caption := 'Attributes ' + ' - ' + ExtractFileName(OpenDlg.FileName);
AttrForm.SizeFileEd.Text := 'Size: ' + (IntToStr(GetFileSizeByName(OpenDlg.FileName)) + ' bites')
end;
if RusItem.Checked then
begin
AttrForm.Caption := 'Атрибуты ' + ' - ' + ExtractFileName(OpenDlg.FileName);
AttrForm.SizeFileEd.Text := 'Размер: ' + (IntToStr(GetFileSizeByName(OpenDlg.FileName)) + ' байт')
end;
with AttrForm do
begin
PathNameEd.Text := OpenDlg.FileName;
PathEd.Text := ExtractFileName(OpenDlg.FileName);
DirParh.Text := ExtractFilePath(OpenDlg.FileName);
Attributes := FileGetAttr(PathNameEd.Text);
ChReadOnly.Checked := (Attributes and faReadOnly) = faReadOnly;
ChArchive.Checked := (Attributes and faArchive) = faArchive;
ChSystem.Checked := (Attributes and faSysFile) = faSysFile;
ChHidden.Checked := (Attributes and faHidden) = faHidden;
if ShowModal <> mrCancel then
begin
NewAttributes := Attributes;
if ChReadOnly.Checked then NewAttributes := NewAttributes or faReadOnly
else NewAttributes := NewAttributes and not faReadOnly;
if ChArchive.Checked then NewAttributes := NewAttributes or faArchive
else NewAttributes := NewAttributes and not faArchive;
if ChSystem.Checked then NewAttributes := NewAttributes or faSysFile
else NewAttributes := NewAttributes and not faSysFile;
if ChHidden.Checked then NewAttributes := NewAttributes or faHidden
else NewAttributes := NewAttributes and not faHidden;
if NewAttributes <> Attributes then
FileSetAttr(PathNameEd.Text, NewAttributes);
end;
end;
end;

procedure TMainForm.MySystemMenu(var MySysMenu: TWmSysCommand);
begin
if MySysMenu.CmdType = AboutPro then
begin
AboutForm.Position := poMainFormCenter;
AboutForm.ShowModal;
end;
inherited;
end;

procedure TMainForm.HomePageItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'http://www.viacoding.mylivepage.ru/', nil,nil, Sw_ShowNormal);
end;

initialization
ScreenForm := TScreenForm.Create(nil);
ShowCursor(False);
ScreenForm.Show;
Application.ProcessMessages;
sleep(2000);
ScreenForm.Close;
ShowCursor(True);

end.

