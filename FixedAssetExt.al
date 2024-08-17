tableextension 55505 FAExt extends "Fixed Asset"
{
    fields
    {

        field(50006; "Total Amount"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum(FixedAssetSubTable.Cost where("Fixed Asset No." = field("No.")));
        }
    }
}



pageextension 55502 FAsubPage extends "Fixed Asset Card"
{
    layout
    {

        addlast(general)
        {
            field("Total Amount"; Rec."Total Amount")
            {
                ApplicationArea = All;
                
            }
        }
        addafter(general)
        {
            group("Asset Finance")
            {
                ShowCaption = false;
                part(Subpage; Subpage)
                {
                    Caption = 'Expenses Details';
                    SubPageLink = "Fixed Asset No." = field("No.");
                    ApplicationArea = All;
                    UpdatePropagation = Both;
                }
            }
        }
    }
}