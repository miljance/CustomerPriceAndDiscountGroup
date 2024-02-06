# CustomerPriceAndDiscountGroup
Include prices/discounts for price group and discount group on customer and contact

With New Pricing experience for Business Central it became obious that the module is not (yet) user friendly.
Taking this into account the Codeunit 50000 from this repo helps with displaying prices on customer and contact.
On a customer two fields can be defined: Customer Price Group and Customer Discount Groups.
The prices can be defined to be valid only for specific Customer Price Group.
The discounts can be defined to be valid only for specific Customer Discoung Group.

When Sales Prices are called from Contact Card/List all of the prices defined for acompanying customer and price group from customer should be shown.
When Sales Prices are called from Customer Card/List all of the prices defined for selected customer and price group from customer should be shown.
When Sales Discounts are called from Customer Card/List all of the discounts defined for selected customer and discount group from customer should be shown.

The solution is event based and therefore can be easily implemeted in a customer project.