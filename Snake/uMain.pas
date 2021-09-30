{
JOGO DA SERPENTE (SNAKE GAME)
Autor ... : Nelson Carlson F.
Data .... : 08/01/2020

Exemplo de uso do canvas
}

unit uMain;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
    TfmMain = class(TForm)
        img: TImage;
        tm: TTimer;
        lbRestart: TLabel;
        Label4: TLabel;
        sb: TStatusBar;
        lbPerdeu: TLabel;
        lbPausado: TLabel;
        procedure FormCreate(Sender: TObject);
        procedure tmTimer(Sender: TObject);
        procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    fmMain: TfmMain;

implementation

{$R *.dfm}

type
    dot = record
        x, y: Integer;
    end;

var
    x, y, xIni, yIni, altura, largura: Integer;
    sizeSquare: Integer;
    direcao: Integer; //1=top, 2=bottom, 3=left, 4=right
    perdeu, mudouDirecao: Boolean;
    body: array of dot;
    alvo: dot;
    pontos, nivel, pontosNivel: Integer;
    backColor: TColor;
    limitarMudancaDeDirecao: Boolean;
    pausar: Boolean;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    estavaPausado: Boolean;
begin
    estavaPausado := pausar;
    CanClose := False;
    pausar := True;
    if MessageDlg('Tem certeza de que deseja sair?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        CanClose := True
    else
        pausar := False or estavaPausado;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
    color: TColor;
begin
    randomize();
    altura := 200;
    largura := 300;
    lbPerdeu.Visible := False;
    lbRestart.Enabled := False;
    pausar := False;
    lbPausado.Visible := False;

    backColor := RGB(160, 212, 183);
    limitarMudancaDeDirecao := false;
    mudouDirecao := false;
    perdeu := false;
    pontos := 0;
    nivel := 1;
    pontosNivel := 0;
    x := 1;
    y := 1;
    xIni := 1;
    yIni := 1;
    sizeSquare := 10;
    perdeu := false;
    direcao := 4; // right =>
    SetLength(body, 1);
    body[Low(body)].x := x;
    body[Low(body)].y := y;

    img.Canvas.Pen.Width := 1;
    img.Canvas.Pen.Color := backColor;
    img.Canvas.Brush.Color := backColor;
    img.Canvas.Rectangle(0, 0, largura + 2, altura + 2);

    img.Canvas.Pen.Color := backColor;
    img.Canvas.Brush.Color := clBlack;
    img.Canvas.Rectangle(body[High(body)].x, body[High(body)].y, body[High(body)].x + sizeSquare, body[High(body)].y + sizeSquare);

    alvo.x := 1 + (random(10) * sizeSquare);
    alvo.y := 1 + (random(10) * sizeSquare);
    color := img.Canvas.Pixels[alvo.x + (sizeSquare div 2), alvo.y + (sizeSquare div 2)];
    while color = clBlack do
    begin
        alvo.x := 1 + (random(10) * sizeSquare);
        alvo.y := 1 + (random(10) * sizeSquare);
        color := img.Canvas.Pixels[alvo.x + (sizeSquare div 2), alvo.y + (sizeSquare div 2)];
    end;

    img.Canvas.Rectangle(alvo.x, alvo.y, alvo.x + sizeSquare, alvo.y + sizeSquare);
    tm.Tag := 0;
    tm.Enabled := True;
end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if not limitarMudancaDeDirecao then
        mudouDirecao := False;
    if (Key = VK_UP) and (direcao <> 2) and (not mudouDirecao) then
    begin
        direcao := 1;
        mudouDirecao := True;
    end
    else if (Key = VK_DOWN) and (direcao <> 1) and (not mudouDirecao) then
    begin
        direcao := 2;
        mudouDirecao := True;
    end
    else if (Key = VK_LEFT) and (direcao <> 4) and (not mudouDirecao) then
    begin
        direcao := 3;
        mudouDirecao := True;
    end
    else if (Key = VK_RIGHT) and (direcao <> 3) and (not mudouDirecao) then
    begin
        direcao := 4;
        mudouDirecao := True;
    end
    else if (Key = VK_F3) and perdeu then
    begin
        FormCreate(Sender);
        sb.Panels[3].Text := '1';
        sb.Panels[1].Text := '0';
    end
    else if (Key = VK_PAUSE) and (not perdeu) then
    begin
        pausar := not pausar;
        lbPausado.Visible := pausar;
    end;
end;

procedure TfmMain.tmTimer(Sender: TObject);
var
    i: Integer;
    xAnt, yAnt: Integer;
    color: TColor;
    achouAlvo: Boolean;
begin
    if tm.Tag = 1 then
        Exit;

    try
        tm.Tag := 1;

        if perdeu then
            Exit;

        if pausar then
            Exit;

        achouAlvo := False;

        xAnt := x;
        yAnt := y;

        if direcao = 1 then // top
        begin
            y := y - sizeSquare;
        end
        else if direcao = 2 then // bottom
        begin
            y := y + sizeSquare;
        end
        else if direcao = 3 then // left
        begin
            x := x - sizeSquare;
        end
        else if direcao = 4 then // right
        begin
            x := x + sizeSquare;
        end;

        if x < 1 then
            x := x + largura;
        if x > largura then
            x := 1;
        if y < 1 then
            y := y + altura;
        if y > altura then
            y := 1;

        if ((x + (sizeSquare div 2)) > alvo.x) and ((x + (sizeSquare div 2)) < (alvo.x + sizeSquare)) and ((y + (sizeSquare div 2)) > alvo.y) and ((y + (sizeSquare div 2)) < (alvo.y + sizeSquare)) then
        begin
            achouAlvo := True;
            pontos := pontos + nivel;
            pontosNivel := pontosNivel + nivel;
            sb.Panels[1].Text := IntToStr(pontos);
            sb.Panels[5].Text := IntToStr(Length(body) + 1);

            if pontosNivel >= (10 * nivel) then
            begin
                pontosNivel := 0;
                nivel := nivel + 1;
                if tm.Interval >= 50 then
                    tm.Interval := tm.Interval - 25;
            end;
            sb.Panels[3].Text := IntToStr(nivel);
        end;

        if not achouAlvo then
        begin
            color := img.Canvas.Pixels[x + (sizeSquare div 2), y + (sizeSquare div 2)];
            if color = clBlack then
            begin
                perdeu := True;
                lbPerdeu.Visible := True;
                lbRestart.Enabled := True;
                Exit;
            end;
        end;

        if achouAlvo then
        begin
            SetLength(body, Length(body) + 1);

            body[High(body)].x := x;
            body[High(body)].y := y;

            img.Canvas.Pen.Color := backColor;
            img.Canvas.Brush.Color := clBlack;
            img.Canvas.Rectangle(body[High(body)].x, body[High(body)].y, body[High(body)].x + sizeSquare, body[High(body)].y + sizeSquare);

            alvo.x := 1 + (random(largura div sizeSquare) * sizeSquare);
            alvo.y := 1 + (random(altura div sizeSquare) * sizeSquare);
            color := img.Canvas.Pixels[alvo.x + (sizeSquare div 2), alvo.y + (sizeSquare div 2)];
            while (alvo.x > largura) or (alvo.y > altura) or (color = clBlack) do
            begin
                alvo.x := 1 + (random(largura div sizeSquare) * sizeSquare);
                alvo.y := 1 + (random(altura div sizeSquare) * sizeSquare);
                color := img.Canvas.Pixels[alvo.x + (sizeSquare div 2), alvo.y + (sizeSquare div 2)];
            end;
            img.Canvas.Rectangle(alvo.x, alvo.y, alvo.x + sizeSquare, alvo.y + sizeSquare);
        end
        else
        begin
            img.Canvas.Pen.Color := backColor;
            img.Canvas.Brush.Color := backColor;
            img.Canvas.Rectangle(body[Low(body)].x, body[Low(body)].y, body[Low(body)].x + sizeSquare, body[Low(body)].y + sizeSquare);

            for i := Low(body) to High(body) - 1 do
            begin
                body[i].x := body[i + 1].x;
                body[i].y := body[i + 1].y;
            end;

            body[High(body)].x := x;
            body[High(body)].y := y;

            img.Canvas.Pen.Color := backColor;
            img.Canvas.Brush.Color := clBlack;
            img.Canvas.Rectangle(body[High(body)].x, body[High(body)].y, body[High(body)].x + sizeSquare, body[High(body)].y + sizeSquare);

        end;

    finally
        mudouDirecao := False;
        tm.Tag := 0;
    end;

end;

end.

