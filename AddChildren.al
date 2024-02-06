codeunit 50000 AddChildren
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Price Source List", 'OnBeforeAddChildren', '', false, false)]
    local procedure AddChildren(var Sender: Codeunit "Price Source List"; PriceSource: Record "Price Source"; var TempChildPriceSource: Record "Price Source" temporary)
    var
        ContactBusinessRelation: Record "Contact Business Relation";
    begin
        case PriceSource."Source Type" of
            "Price Source Type"::Customer:
                AddPriceAndDiscountGroupChildren(PriceSource."Source No.", Sender, TempChildPriceSource);
            "Price Source Type"::Contact:
                begin
                    ContactBusinessRelation.SetLoadFields("No.");
                    ContactBusinessRelation.SetRange("Contact No.", PriceSource."Source No.");
                    ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                    if ContactBusinessRelation.FindSet() then
                        repeat
                            AddPriceAndDiscountGroupChildren(ContactBusinessRelation."No.", Sender, TempChildPriceSource);
                        until ContactBusinessRelation.Next() = 0;
                end;
        end;
    end;

    local procedure AddPriceAndDiscountGroupChildren(CustomerNo: Code[20]; var Sender: Codeunit "Price Source List"; var TempChildPriceSource: Record "Price Source" temporary)
    var
        Customer: Record Customer;
        CustomerPriceGroup: Record "Customer Price Group";
        CustomerDiscountGroup: Record "Customer Discount Group";
    begin
        if CustomerNo = '' then
            exit;

        Customer.SetLoadFields("No.", "Customer Price Group", "Customer Disc. Group");
        if Customer.Get(CustomerNo) then begin
            Customer.ToPriceSource(TempChildPriceSource);
            Sender.Add(TempChildPriceSource);
            CustomerPriceGroup.SetLoadFields(Code);
            if CustomerPriceGroup.Get(Customer."Customer Price Group") then begin
                CustomerPriceGroup.ToPriceSource(TempChildPriceSource);
                Sender.Add(TempChildPriceSource);
            end;
            CustomerDiscountGroup.SetLoadFields(Code);
            if CustomerDiscountGroup.Get(Customer."Customer Disc. Group") then begin
                CustomerDiscountGroup.ToPriceSource(TempChildPriceSource);
                Sender.Add(TempChildPriceSource);
            end;
        end;

    end;
}