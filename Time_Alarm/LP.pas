unit LP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPButton, StdCtrls, ComCtrls, ExtCtrls, jpeg;

    type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

type
  TLicForm = class(TForm)
    PrintText: TXPButton;
    OK: TXPButton;
    PrintDlg: TPrintDialog;
    Frame: TPanel;
    ReadMe: TRichEdit;
    procedure PrintTextClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;
  public
  end;

var
  LicForm: TLicForm;

implementation

uses OP;

{$R *.dfm}

procedure TLicForm.PrintTextClick(Sender: TObject);
var
FFileName: String;
begin
if PrintDlg.Execute then
ReadMe.Print(FFileName);

end;

procedure TLicForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;

procedure TLicForm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_Escape then
OK.OnClick(Self);
end;

procedure TLicForm.FormShow(Sender: TObject);
begin
SetWindowLong(LicForm.Handle, GWL_EXSTYLE,
GetWindowLOng(LicForm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TLicForm.OKClick(Sender: TObject);
begin
LicForm.Close;
end;

procedure TLicForm.WMMoving(var msg: TWMMoving);
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

procedure TLicForm.FormDestroy(Sender: TObject);
begin
LicForm.OnActivate := nil;
PrintText.Free;
PrintDlg.Free;
ReadMe.Free;
Frame.Free;
OK.Free;
end;

procedure TLicForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ReadMe.SetFocus;
end;

end.
