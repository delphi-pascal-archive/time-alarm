unit AFP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPButton, XPCheckBox, StdCtrls, XPGroupBox;

type
  TAttrForm = class(TForm)
    fr1: TXPGroupBox;
    PathNameEd: TEdit;
    PathEd: TEdit;
    DirParh: TEdit;
    fr2: TXPGroupBox;
    ChReadOnly: TXPCheckBox;
    ChArchive: TXPCheckBox;
    ChSystem: TXPCheckBox;
    ChHidden: TXPCheckBox;
    OK: TXPButton;
    Cancel: TXPButton;
    SizeFileEd: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private

  public

  end;

var
  AttrForm: TAttrForm;

implementation

{$R *.dfm}

procedure TAttrForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Cancel.SetFocus;
end;

procedure TAttrForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;

procedure TAttrForm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_Escape then
AttrForm.Close;
end;

procedure TAttrForm.CancelClick(Sender: TObject);
begin
AttrForm.Close;
end;

procedure TAttrForm.FormShow(Sender: TObject);
begin
SetWindowLong(AttrForm.Handle, GWL_EXSTYLE,
GetWindowLOng(AttrForm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TAttrForm.FormDestroy(Sender: TObject);
begin
AttrForm.OnActivate := nil;
PathNameEd.Free;
SizeFileEd.Free;
ChArchive.Free;
ChHidden.Free;
ChSystem.Free;
DirParh.Free;
PathEd.Free;
Cancel.Free;
fr1.Free;
fr2.Free;
OK.Free;
end;

end.
