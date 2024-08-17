table 55501 FixedAssetSubTable
{
    DataClassification = ToBeClassified;
    Caption = 'Fixed Asset SubTable';

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            //  AutoIncrement=true;
        }
        field(2; "Vehicle Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Fixed Asset No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; Period; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; Model; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(24; "Project Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","O&M","Project";
        }
        field(25; "Client No."; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            trigger OnValidate()
            var
                CustL: Record Customer;
            begin
                if CustL.Get("Client No.") then begin
                    Rec."Client Name" := CustL.Name;
                end;

            end;
        }

        field(26; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Cost; Decimal)
        {

             DataClassification = ToBeClassified;
            

        }
        field(28; "Total Cost"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum(FixedAssetSubTable.Cost);


        }
        field(29; "Payment Type"; option)
        {
            OptionMembers = " ","Cash","NEFT",UPI,RTGS;
        }
        field(30; "Account Holder Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Account No/Mobile No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "IFSC Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(33; Category; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; Name; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Client Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            trigger OnValidate()
            var
                GLAcc: Record "G/L Account";
            begin
                if GLAcc.Get("No.") then begin
                    Rec.Category := GLAcc.Name;
                end;

            end;
        }
        field(37; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }



    }
    keys
    {
        key(Key1; "Fixed Asset No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var a : PAge "Data Migration Wizard";
}

page 55501 Subpage
{
    ApplicationArea = All;
    Caption = 'Finance Details';
    PageType = ListPart;
    SourceTable = FixedAssetSubTable;
    AutoSplitKey = true;
    DeleteAllowed = true;
    InsertAllowed = true;
    LinksAllowed = true;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    Visible = false;

                }
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Project Type"; Rec."Project Type")
                {
                    ToolTip = 'Specifies the value of the Project Type field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Specifies the value of the Client field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field.', Comment = '%';
                    ApplicationArea = All;
                }

                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                    ApplicationArea = All;
                }
                field(Cost; Rec.Cost)
                {
                    ToolTip = 'Specifies the value of the Cost field.', Comment = '%';
                    ApplicationArea = All;
                }

                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Account Holder Name"; Rec."Account Holder Name")
                {
                    ToolTip = 'Specifies the value of the Account Holder Name field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Acc.No/Mob.No"; Rec."Account No/Mobile No")
                {
                    ToolTip = 'Specifies the value of the Account No/Mobile No field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("IFSC Code"; Rec."IFSC Code")
                {
                    ToolTip = 'Specifies the value of the IFSC Code field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ToolTip = 'Specifies the value of the Approved Amount field.', Comment = '%';
                    ApplicationArea = All;
                }
            }
        }
    }
}
