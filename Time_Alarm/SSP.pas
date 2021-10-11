unit SSP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, XPLabel, Registry, jpeg;

type
  TScreenForm = class(TForm)
    Logo: TImage;
    tx10: TXPLabel;
    tx9: TXPLabel;
    tx1: TXPLabel;
    tx3: TXPLabel;
    tx5: TXPLabel;
    tx6: TXPLabel;
    tx2: TXPLabel;
    tx4: TXPLabel;
    tx8: TXPLabel;
    tx7: TXPLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    r: TRegistry;
    MS: TMemoryStatus;
    
  public

  end;

var
  ScreenForm: TScreenForm;

implementation

{$R *.dfm}

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

procedure TScreenForm.FormCreate(Sender: TObject);
begin
r:=TRegistry.Create;
r.RootKey:=HKEY_LOCAL_MACHINE;
r.OpenKey('\Software\Microsoft\Windows NT\CurrentVersion', True);
tx10.Caption := r.ReadString('ProductName');
GlobalMemoryStatus(MS);
tx9.Caption := 'Memory Available to Windows: ' + FormatFloat('#,###" KB"', MS.dwTotalPhys / 1024);
end;

procedure TScreenForm.FormDestroy(Sender: TObject);
begin
ScreenForm.OnActivate := nil;
Logo.Free;
tx1.Free;
tx2.Free;
tx3.Free;
tx4.Free;
tx5.Free;
tx6.Free;
tx7.Free;
tx8.Free;
tx9.Free;
end;

procedure TScreenForm.FormShow(Sender: TObject);
begin
MakeRounded(ScreenForm);
end;

end.
