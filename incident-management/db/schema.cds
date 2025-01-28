using { cuid, managed, sap.common.CodeList } from '@sap/cds/common';
namespace sap.capire.incidents;

/**
* Incidents created by Customers.
*/

entity Incidents : cuid, managed {
customer    : Association to Customers;
title       : String @title : 'Title';
urgency     : Association to Urgency default 'M';
status      : Association to Status  default 'N';
conversation : Composition of many {
    key ID  : UUID;
    timestamp : type of managed:createdAt;
    author    : type of managed:createdBy;
    message   : String;
};
}

/**
* Customers entitled to create support Incidents.
*/

entity Customers    : managed {
key ID              : String;
firstName           : String;
lastName            : String;
name                : String = firstName || '' || lastName;
email               : EMailAddress;
phone               : PhoneNumber;
incidents           : Association to many Incidents on incidents.customer = $self;





}


type EMailAddress : String;
type PhoneNumber : String;