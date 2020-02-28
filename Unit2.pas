unit Unit2;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Ani,
  {$IFDEF ANDROID}
    FMX.DialogService.Async,
    FMX.Helpers.Android,
    Androidapi.Jni.Os,
    Androidapi.Jni.Widget,
    Androidapi.Helpers,
    Androidapi.Jni.JavaTypes,
    Androidapi.JniBridge,
    Androidapi.Jni.GraphicsContentViewText,
    Androidapi.JNI.App,
  {$ENDIF}
  FMX.StatusBar;

type
  TForm2 = class(TForm)
    lytMain: TLayout;
    recFundo: TRectangle;
    lytMnuLateral: TLayout;
    recSideBar: TRectangle;
    lytAba: TLayout;
    recAba: TRectangle;
    lytBtn: TLayout;
    pthBtn: TPath;
    lytMenu: TLayout;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Circle1: TCircle;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Layout5: TLayout;
    Line1: TLine;
    lytPrincipal: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    lblHome: TLabel;
    lytMinhaConta: TLayout;
    Layout9: TLayout;
    Path2: TPath;
    Layout10: TLayout;
    lblMinhaConta: TLabel;
    lytLogoff: TLayout;
    Layout12: TLayout;
    Path3: TPath;
    Layout13: TLayout;
    lblLogoff: TLabel;
    lytPedidos: TLayout;
    Layout15: TLayout;
    Path4: TPath;
    Layout16: TLayout;
    lblMeusPedidos: TLabel;
    Line2: TLine;
    lytConfig: TLayout;
    Layout18: TLayout;
    Path5: TPath;
    Layout19: TLayout;
    lblConfig: TLabel;
    lytDesejos: TLayout;
    Layout21: TLayout;
    Path6: TPath;
    Layout22: TLayout;
    lblListaDesejos: TLabel;
    Path1: TPath;
    flaAnimaMenu: TFloatAnimation;
    speMenu: TSpeedButton;
    lblPagina: TLabel;
    lytFullPrincipal: TLayout;
    lytFullMinhaconta: TLayout;
    lytFullPedidos: TLayout;
    lytFullDesejos: TLayout;
    lytFullConfig: TLayout;
    lytFullLogoff: TLayout;
    flaAnimaBtnMnu: TFloatAnimation;
    phtX: TPath;
    flaAnimaX: TFloatAnimation;
    recNavBar: TRectangle;
    procedure FormCreate(Sender: TObject);
    procedure speMenuClick(Sender: TObject);
    procedure OpenScreen(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FShowingMenu : Boolean;
    FStatusBarColor : TAlphaColor;
    {$IFDEF ANDROID}
      FMyUI           : TMyUI;
      procedure TransparentNavBar;
    {$ENDIF}
    procedure ChangeStatusBarColor(AColorStatusBar: TAlphaColor);
    procedure ShowMenu;
    procedure HideMenu;
  public
    { Public declarations }
    property ShowingMenu : Boolean read FShowingMenu write FShowingMenu;
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

{ TForm2 }

procedure TForm2.ChangeStatusBarColor(AColorStatusBar: TAlphaColor);
begin
  FStatusBarColor := AColorStatusBar;
  Fill.Color      := FStatusBarColor;
  {$IFDEF Android}
    StatusBarGetBounds(FMyUI.StatusBar, FMyUI.NavBar);
    StatusBarSetColor(Fill.Color);
  {$EndIf}
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
  Fill.Color := FStatusBarColor;
  Fill.Kind  := TBrushKind.Solid;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  lytMnuLateral.Position.X := -323;
  lytMnuLateral.Position.Y := -4;
  lytMnuLateral.Height     := Self.ClientHeight + 4;
  recSideBar.Height        := 650;
  recSideBar.Position.Y    := -4;

  ChangeStatusBarColor(TAlphaColorRec.White);
  {$IFDEF ANDROID}
    TransparentNavBar;
  {$ENDIF}

  //Menu
  lytPrincipal.TagString   := 'Principal';
  lytMinhaConta.TagString  := 'Minha Conta';
  lytPedidos.TagString     := 'Meus Pedidos';
  lytDesejos.TagString     := 'Lista de Desejos';
  lytConfig.TagString      := 'Configurações';
  lytLogoff.TagString      := 'Logoff';
end;

procedure TForm2.FormResize(Sender: TObject);
var
  LVertical : Boolean;
begin
  LVertical := (Height > Width);
  if LVertical then
  begin
    //Celular na vertical
    lytMain.Margins.Left   := 0;
    {$IFDEF ANDROID}
    lytMain.Margins.Top    := FMyUI.StatusBar;
    {$ENDIF}
    lytMain.Margins.Right  := 0;
    lytMain.Margins.Bottom := 0;
    recNavBar.Align        := TAlignLayout.MostBottom;
    {$IFDEF ANDROID}
    recNavBar.Height       := FMyUI.NavBar;
    {$ENDIF}
  end
  else
  begin
    //Celular na horizonal
    //Apenas didáticas - desvio se necessário
    lytMain.Margins.Left   := 0;
    {$IFDEF ANDROID}
    lytMain.Margins.Top    := FMyUI.StatusBar;
    {$ENDIF}
    lytMain.Margins.Right  := 0;
    lytMain.Margins.Bottom := 0;
    recNavBar.Align        := TAlignLayout.MostRight;
    {$IFDEF ANDROID}
    recNavBar.Width        := FMyUI.NavBar;
    {$ENDIF}
    recNavBar.BringToFront;
  end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  FormActivate(nil);
  {$IFDEF ANDROID}
  StatusBarGetBounds(FMyUI.StatusBar, FMyUI.NavBar);
  StatusBarSetColor(Fill.Color);
  {$ENDIF}
end;

procedure TForm2.HideMenu;
begin
  ShowingMenu             := False;
  flaAnimaMenu.StartValue := 0;
  flaAnimaMenu.StopValue  := -323;
  flaAnimaMenu.Start;

  flaAnimaBtnMnu.StartValue   := 0;
  flaAnimaBtnMnu.StopValue    := 1;
  flaAnimaBtnMnu.Start;

  flaAnimaX.StartValue        := 1;
  flaAnimaX.StopValue         := 0;
  flaAnimaX.Start;
end;

procedure TForm2.ShowMenu;
begin
  ShowingMenu                 := True;
  flaAnimaMenu.StartValue     := -323;
  flaAnimaMenu.StopValue      := 0;
  flaAnimaMenu.Start;

  flaAnimaBtnMnu.StartValue   := 1;
  flaAnimaBtnMnu.StopValue    := 0;
  flaAnimaBtnMnu.Start;

  flaAnimaX.StartValue        := 0;
  flaAnimaX.StopValue         := 1;
  flaAnimaX.Start;
end;

procedure TForm2.speMenuClick(Sender: TObject);
begin
  if ShowingMenu
  then HideMenu
  else ShowMenu;
end;

{$IFDEF ANDROID}
procedure TForm2.TransparentNavBar;
var
  LActivity : JActivity;
  LWindow   : JWindow;
begin
  LActivity := TAndroidHelper.Activity;
  LWindow   := LActivity.getWindow;

  LWindow.setFlags(
    TJWindowManager_LayoutParams.JavaClass.FLAG_TRANSLUCENT_STATUS,
    TJWindowManager_LayoutParams.JavaClass.FLAG_TRANSLUCENT_STATUS
  );

  LWindow.setFlags(
    TJWindowManager_LayoutParams.JavaClass.FLAG_LAYOUT_NO_LIMITS,
    TJWindowManager_LayoutParams.JavaClass.FLAG_LAYOUT_NO_LIMITS
  );
end;

{$ENDIF}

procedure TForm2.OpenScreen(Sender: TObject);
begin
  lblPagina.Text := TLayout(TControl(Sender).Parent).TagString;
  HideMenu;
end;

end.
