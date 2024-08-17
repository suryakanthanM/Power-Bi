pageextension 55509 PowerBiDoughnutExt extends "Help And Chart Wrapper"
{
    caption = 'Fixed Assets Doughnut';
    layout
    {
        addlast(content)
        {
            usercontrol(Chart; "Microsoft.Dynamics.Nav.client.BusinessChart")
            {


                ApplicationArea = All;
                trigger AddInReady()
                var
                    Buffer: Record "Business Chart Buffer" temporary;
                    FA: Record "Fixed Asset";
                    i: Integer;
                    Top5FA: array[5] of Record "Fixed Asset";
                    Top5Cost: array[5] of Decimal;
                    j: Integer;

                begin
                    Buffer.Initialize();
                    Buffer.AddMeasure('Total Cost', 1, Buffer."Data Type"::Decimal, Buffer."Chart Type"::Doughnut);

                    Buffer.SetXAxis('Fixed Asset', Buffer."Data Type"::String);

                    i := 0;
                    if FA.FindSet() then
                        repeat
                            FA.CalcFields("Total Amount");
                            if i < 5 then begin
                                Top5FA[i + 1] := FA;
                                Top5Cost[i + 1] := FA."Total Amount";
                                i += 1;
                            end else begin
                                j := 1;
                                while j <= 5 do begin
                                    if FA."Total Amount" > Top5Cost[j] then begin
                                        Top5FA[j] := FA;
                                        Top5Cost[j] := FA."Total Amount";
                                        break;
                                    end;
                                    j += 1;
                                end;
                            end;
                        until FA.Next() = 0;

                    for i := 1 to 5 do begin
                        Buffer.AddColumn(Top5FA[i]."No.");
                        Buffer.SetValueByIndex(1, i - 1, Top5Cost[i]);
                    end;

                    Buffer.Update(CurrPage.Chart);
                end;
                // To click the doughnut it will navigate to respective card page.
                trigger DataPointClicked(Point: JsonObject)
                var
                    IsChartAddInReady: Boolean;
                    MeasuresTok: Label 'Measures', Locked = true;
                    XValueStringTok: Label 'XValueString', Locked = true;
                    YValuesTok: Label 'YValues', Locked = true;
                    Token: JsonToken;
                    ValueArray: JsonArray;
                    MeasureName: Text[249];
                    XValueString: Text[249];
                    YValue: Decimal;
                    xval: Record "Fixed Asset";
                begin
                    Point.Get(XValueStringTok, Token);

                    XValueString := CopyStr(Token.AsValue().AsText(), 1, 249);
                    xval.Get(XValueString);
                    Page.Run(Page::"Fixed Asset Card", xval);
                end;
            }
        }

    }
    var
        Buffer: Record "Business Chart Buffer" temporary;
        ChartManagement: Codeunit "Chart Management";
        SelectedChartDefinition: Record "Chart Definition";
        IsChartAddInReady: Boolean;

    local procedure DrillDownCust(DrillDownCustomerNo: Code[20])
    var
        FA: Record "Fixed Asset";
    begin
        FA.Get(DrillDownCustomerNo);
        Page.Run(Page::"Fixed Asset Card", FA);
    end;
}