divert(-1)
changecom(/*, */)
/*
 * Copyright (c) 2000-2002 Apple Computer, Inc. All Rights Reserved.
 * 
 * The contents of this file constitute Original Code as defined in and are
 * subject to the Apple Public Source License Version 1.2 (the 'License').
 * You may not use this file except in compliance with the License. Please obtain
 * a copy of the License at http://www.apple.com/publicsource and read it before
 * using this file.
 * 
 * This Original Code and all software distributed under the License are
 * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS
 * OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES, INCLUDING WITHOUT
 * LIMITATION, ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT. Please see the License for the
 * specific language governing rights and limitations under the License.
 */

define(`startClass',
`define(`arrayIndex', 0)dnl
define(`class', $1)dnl
divert(0)dnl
// $1 password attributes
static const CSSM_DB_ATTRIBUTE_INFO $1Attributes[] =
{
divert(1)dnl
// $1 password indices
static const CSSM_DB_INDEX_INFO $1Indices[] =
{')

define(`endClass',
`divert(0)dnl
};

divert(1)dnl
`  // Unique (primary) index'
undivert(3)
`  // Secondary indices'
undivert(4)dnl
};

divert(-1)')

define(`attributeBody',
`    {
ifelse(index(`$1',`s'),-1,
`        CSSM_DB_ATTRIBUTE_NAME_AS_INTEGER,
        {(char *)$3},',
`        CSSM_DB_ATTRIBUTE_NAME_AS_STRING,
        {$4},')
        CSSM_DB_ATTRIBUTE_FORMAT_$7
    }')

define(`simpleAttribute',
`const CSSM_DB_ATTRIBUTE_INFO $2 =
attributeBody($*);
')

define(`attribute',
`ifelse(index(`$1',`U'),-1,`',
`divert(3)dnl
  {
    CSSM_DB_INDEX_UNIQUE,
    CSSM_DB_INDEX_ON_ATTRIBUTE,
attributeBody($*)
  },
')dnl
ifelse(index(`$1',`I'),-1,`',
`divert(4)dnl
  {
    CSSM_DB_INDEX_NONUNIQUE,
    CSSM_DB_INDEX_ON_ATTRIBUTE,
attributeBody($*)
  },
')dnl
divert(2)dnl
dnl const CSSM_DB_ATTRIBUTE_INFO &`k'class()$2 = class()Attributes[arrayIndex()];
`#define k'class()$2 class()Attributes[arrayIndex()];
divert(0)dnl
attributeBody($*),dnl
define(`arrayIndex', incr(arrayIndex))dnl
')

define(`attrInfo',
`{
        $1,
        sizeof($2Attributes) / sizeof(CSSM_DB_ATTRIBUTE_INFO),
        const_cast<CSSM_DB_ATTRIBUTE_INFO_PTR>($2Attributes)
    }')

define(`indexInfo',
`{
        $1,
        sizeof($2Indices) / sizeof(CSSM_DB_INDEX_INFO),
        const_cast<CSSM_DB_INDEX_INFO_PTR>($2Indices)
    }')

define(`parseInfo',
`{
        CSSM_DB_RECORDTYPE_APP_DEFINED_START,
        {
            {0,0,0,{0}},
            {0,0},
            0,
            0
        }
    }')

define(`startNewClass',
`define(`indexIndex', 0)dnl
define(`class', $1)dnl
divert(2)dnl
// $1 attributes
const CSSM_DB_SCHEMA_ATTRIBUTE_INFO $1SchemaAttributeList[] =
{
divert(3)dnl
// $1 indices
const CSSM_DB_SCHEMA_INDEX_INFO $1SchemaIndexList[] =
{')

define(`endNewClass',
`divert(2)dnl
};

const uint32 class()SchemaAttributeCount = sizeof(class()SchemaAttributeList) / sizeof(CSSM_DB_SCHEMA_ATTRIBUTE_INFO);

divert(3)dnl
`    // Unique (primary) index'
undivert(5)
`    // Secondary indices'
undivert(6)dnl
};

const uint32 class()SchemaIndexCount = sizeof(class()SchemaIndexList) / sizeof(CSSM_DB_SCHEMA_INDEX_INFO);

undivert(4)dnl
divert(0)dnl
undivert(2)dnl
undivert(3)dnl')

define(`newAttributeBody',
`{
ifelse(index(`$1',`s'),-1,
`    CSSM_DB_ATTRIBUTE_NAME_AS_INTEGER,
    {(char *)$3},',
`    CSSM_DB_ATTRIBUTE_NAME_AS_STRING,
    {$4},')
    CSSM_DB_ATTRIBUTE_FORMAT_$7
}')

define(`simpleNewAttribute',
`const CSSM_DB_ATTRIBUTE_INFO `k'class()$2 =
newAttributeBody($*);
')

define(`newAttribute',
`divert(2)dnl
    { $3, $4, { $5, $6 }, CSSM_DB_ATTRIBUTE_FORMAT_$7 },
divert(-1)
ifelse(index(`$1',`S'),-1,`',
`divert(4)dnl
simpleNewAttribute($*)
divert(-1)')dnl

ifelse(index(`$1',`U'),-1,`',
`divert(5)dnl
    { $3, 0, CSSM_DB_INDEX_UNIQUE, CSSM_DB_INDEX_ON_ATTRIBUTE },
divert(-1)')dnl
ifelse(index(`$1',`I'),-1,`',
`define(`indexIndex', incr(indexIndex))dnl
divert(6)dnl
    { $3, indexIndex(), CSSM_DB_INDEX_NONUNIQUE, CSSM_DB_INDEX_ON_ATTRIBUTE },
divert(-1)')')

/* Start of actual output */
divert(0)dnl
/*
 * Generated by m4 from Schema.m4 please do not edit this file.
 */

`#include <security_cdsa_utilities/Schema.h>'

`#include <Security/SecCertificate.h>'
`#include <Security/SecTrustPriv.h>'
`#include <Security/SecKeychainItemPriv.h>'
`#include <Security/cssmapple.h>'
`#include <security_utilities/errors.h>'

namespace Security {

namespace KeychainCore {

namespace Schema {

// Meta attributes
simpleAttribute(`  s', RelationID, 0, "RelationID", 0, NULL, UINT32)
simpleAttribute(`  s', RelationName, 1, "RelationName", 0, NULL, STRING)
simpleAttribute(`  s', AttributeID, 1, "AttributeID", 0, NULL, UINT32)
simpleAttribute(`  s', AttributeNameFormat, 2, "AttributeNameFormat", 0, NULL, UINT32)
simpleAttribute(`  s', AttributeName, 3, "AttributeName", 0, NULL, STRING)
simpleAttribute(`  s', AttributeNameID, 4, "AttributeNameID", 0, NULL, BLOB)
simpleAttribute(`  s', AttributeFormat, 5, "AttributeFormat", 0, NULL, UINT32)
simpleAttribute(`  s', IndexType, 3, "IndexType", 0, NULL, UINT32)

divert(-1)
startClass(Generic)
attribute(`  i', CreationDate, kSecCreationDateItemAttr, "CreationDate", 0, NULL, TIME_DATE)
attribute(`  i', ModDate, kSecModDateItemAttr, "ModDate", 0, NULL, TIME_DATE)
attribute(`  i', Description, kSecDescriptionItemAttr, "Description", 0, NULL, BLOB)
attribute(`  i', Comment, kSecCommentItemAttr, "Comment", 0, NULL, BLOB)
attribute(`  i', Creator, kSecCreatorItemAttr, "Creator", 0, NULL, UINT32)
attribute(`  i', Type, kSecTypeItemAttr, "Type", 0, NULL, UINT32)
attribute(`  i', ScriptCode, kSecScriptCodeItemAttr, "ScriptCode", 0, NULL, SINT32)
attribute(`  s', PrintName, kSecLabelItemAttr, "PrintName", 0, NULL, BLOB)
attribute(`  s', Alias, kSecAliasItemAttr, "Alias", 0, NULL, BLOB)
attribute(`  i', Invisible, kSecInvisibleItemAttr, "Invisible", 0, NULL, SINT32)
attribute(`  i', Negative, kSecNegativeItemAttr, "Negative", 0, NULL, SINT32)
attribute(`  i', CustomIcon, kSecCustomIconItemAttr, "CustomIcon", 0, NULL, SINT32)
attribute(`  i', Protected, kSecProtectedDataItemAttr, "Protected", 0, NULL, BLOB)
attribute(`UIi', Account, kSecAccountItemAttr, "Account", 0, NULL, BLOB)
attribute(`UIi', Service, kSecServiceItemAttr, "Service", 0, NULL, BLOB)
attribute(`  i', Generic, kSecGenericItemAttr, "Generic", 0, NULL, BLOB)
endClass()

startClass(Appleshare)
attribute(`  i', CreationDate, kSecCreationDateItemAttr, "CreationDate", 0, NULL, TIME_DATE)
attribute(`  i', ModDate, kSecModDateItemAttr, "ModDate", 0, NULL, TIME_DATE)
attribute(`  i', Description, kSecDescriptionItemAttr, "Description", 0, NULL, BLOB)
attribute(`  i', Comment, kSecCommentItemAttr, "Comment", 0, NULL, BLOB)
attribute(`  i', Creator, kSecCreatorItemAttr, "Creator", 0, NULL, UINT32)
attribute(`  i', Type, kSecTypeItemAttr, "Type", 0, NULL, UINT32)
attribute(`  i', ScriptCode, kSecScriptCodeItemAttr, "ScriptCode", 0, NULL, SINT32)
attribute(`  s', PrintName, kSecLabelItemAttr, "PrintName", 0, NULL, BLOB)
attribute(`  s', Alias, kSecAliasItemAttr, "Alias", 0, NULL, BLOB)
attribute(`  i', Invisible, kSecInvisibleItemAttr, "Invisible", 0, NULL, SINT32)
attribute(`  i', Negative, kSecNegativeItemAttr, "Negative", 0, NULL, SINT32)
attribute(`  i', CustomIcon, kSecCustomIconItemAttr, "CustomIcon", 0, NULL, SINT32)
attribute(`  i', Protected, kSecProtectedDataItemAttr, "Protected", 0, NULL, BLOB)
attribute(`UIi', Account, kSecAccountItemAttr, "Account", 0, NULL, BLOB)
attribute(`UIi', Volume, kSecVolumeItemAttr, "Volume", 0, NULL, BLOB)
attribute(`  i', Server, kSecServerItemAttr, "Server", 0, NULL, BLOB)
attribute(`  i', Protocol, kSecProtocolItemAttr, "Protocol", 0, NULL, UINT32)
attribute(`UIi', Address, kSecAddressItemAttr, "Address", 0, NULL, BLOB)
attribute(`UIi', Signature, kSecSignatureItemAttr, "Signature", 0, NULL, BLOB)
endClass()

startClass(Internet)
attribute(`  i', CreationDate, kSecCreationDateItemAttr, "CreationDate", 0, NULL, TIME_DATE)
attribute(`  i', ModDate, kSecModDateItemAttr, "ModDate", 0, NULL, TIME_DATE)
attribute(`  i', Description, kSecDescriptionItemAttr, "Description", 0, NULL, BLOB)
attribute(`  i', Comment, kSecCommentItemAttr, "Comment", 0, NULL, BLOB)
attribute(`  i', Creator, kSecCreatorItemAttr, "Creator", 0, NULL, UINT32)
attribute(`  i', Type, kSecTypeItemAttr, "Type", 0, NULL, UINT32)
attribute(`  i', ScriptCode, kSecScriptCodeItemAttr, "ScriptCode", 0, NULL, SINT32)
attribute(`  s', PrintName, kSecLabelItemAttr, "PrintName", 0, NULL, BLOB)
attribute(`  s', Alias, kSecAliasItemAttr, "Alias", 0, NULL, BLOB)
attribute(`  i', Invisible, kSecInvisibleItemAttr, "Invisible", 0, NULL, SINT32)
attribute(`  i', Negative, kSecNegativeItemAttr, "Negative", 0, NULL, SINT32)
attribute(`  i', CustomIcon, kSecCustomIconItemAttr, "CustomIcon", 0, NULL, SINT32)
attribute(`  i', Protected, kSecProtectedDataItemAttr, "Protected", 0, NULL, BLOB)
attribute(`UIi', Account, kSecAccountItemAttr, "Account", 0, NULL, BLOB)
attribute(`UIi', SecurityDomain, kSecSecurityDomainItemAttr, "SecurityDomain", 0, NULL, BLOB)
attribute(`UIi', Server, kSecServerItemAttr, "Server", 0, NULL, BLOB)
attribute(`UIi', Protocol, kSecProtocolItemAttr, "Protocol", 0, NULL, UINT32)
attribute(`UIi', AuthType, kSecAuthenticationTypeItemAttr, "AuthType", 0, NULL, BLOB)
attribute(`UIi', Port, kSecPortItemAttr, "Port", 0, NULL, UINT32)
attribute(`UIi', Path, kSecPathItemAttr, "Path", 0, NULL, BLOB)
endClass()

startNewClass(X509Certificate)
newAttribute(`UISs', CertType, kSecCertTypeItemAttr, "CertType", 0, NULL, UINT32)
newAttribute(`  Ss', CertEncoding, kSecCertEncodingItemAttr, "CertEncoding", 0, NULL, UINT32)
newAttribute(`  Ss', PrintName, kSecLabelItemAttr, "PrintName", 0, NULL, BLOB)
newAttribute(` ISs', Alias, kSecAliasItemAttr, "Alias", 0, NULL, BLOB)
newAttribute(` ISs', Subject, kSecSubjectItemAttr, "Subject", 0, NULL, BLOB)
newAttribute(`UISs', Issuer, kSecIssuerItemAttr, "Issuer", 0, NULL, BLOB)
newAttribute(`UISs', SerialNumber, kSecSerialNumberItemAttr, "SerialNumber", 0, NULL, BLOB)
newAttribute(` ISs', SubjectKeyIdentifier, kSecSubjectKeyIdentifierItemAttr, "SubjectKeyIdentifier", 0, NULL, BLOB)
newAttribute(` ISs', PublicKeyHash, kSecPublicKeyHashItemAttr, "PublicKeyHash", 0, NULL, BLOB)
endNewClass()

startNewClass(X509Crl)
newAttribute(`UISs', CrlType, kSecCrlTypeItemAttr, "CrlType", 0, NULL, UINT32)
newAttribute(`  Ss', CrlEncoding, kSecCrlEncodingItemAttr, "CrlEncoding", 0, NULL, UINT32)
newAttribute(`  Ss', PrintName, kSecLabelItemAttr, "PrintName", 0, NULL, BLOB)
newAttribute(`  Ss', Alias, kSecAliasItemAttr, "Alias", 0, NULL, BLOB)
newAttribute(`UISs', Issuer, kSecIssuerItemAttr, "Issuer", 0, NULL, BLOB)
newAttribute(`UISs', ThisUpdate, kSecThisUpdateItemAttr, "ThisUpdate", 0, NULL, BLOB)
newAttribute(`UISs', NextUpdate, kSecNextUpdateItemAttr, "NextUpdate", 0, NULL, BLOB)
newAttribute(`  Ss', URI, kSecUriItemAttr, "URI", 0, NULL, BLOB)
newAttribute(` ISs', CrlNumber, kSecCrlNumberItemAttr, "CrlNumber", 0, NULL, UINT32)
newAttribute(` ISs', DeltaCrlNumber, kSecDeltaCrlNumberItemAttr, "DeltaCrlNumber", 0, NULL, UINT32)
endNewClass()

startNewClass(UserTrust)
newAttribute(`UISs', TrustedCertificate, kSecTrustCertAttr, "TrustedCertificate", 0, NULL, BLOB)
newAttribute(`UISs', TrustedPolicy, kSecTrustPolicyAttr, "TrustedPolicy", 0, NULL, BLOB)
newAttribute(`  Ss', PrintName, kSecLabelItemAttr, "PrintName", 0, NULL, BLOB)
endNewClass()


divert(3)
static const CSSM_DB_RECORD_ATTRIBUTE_INFO Attributes[] =
{
    attrInfo(CSSM_DL_DB_RECORD_GENERIC_PASSWORD, Generic),
    attrInfo(CSSM_DL_DB_RECORD_APPLESHARE_PASSWORD, Appleshare),
    attrInfo(CSSM_DL_DB_RECORD_INTERNET_PASSWORD, Internet)
};

static const CSSM_DB_RECORD_INDEX_INFO Indices[] =
{
    indexInfo(CSSM_DL_DB_RECORD_GENERIC_PASSWORD, Generic),
    indexInfo(CSSM_DL_DB_RECORD_APPLESHARE_PASSWORD, Appleshare),
    indexInfo(CSSM_DL_DB_RECORD_INTERNET_PASSWORD, Internet)
};

static const CSSM_DB_PARSING_MODULE_INFO ParseInfos[] =
{
    parseInfo(),
    parseInfo(),
    parseInfo()
};

//
// Public stuff
//
const CSSM_DBINFO DBInfo =
{
    sizeof(Attributes) / sizeof(CSSM_DB_RECORD_ATTRIBUTE_INFO),
    const_cast<CSSM_DB_PARSING_MODULE_INFO_PTR>(ParseInfos),
    const_cast<CSSM_DB_RECORD_ATTRIBUTE_INFO_PTR>(Attributes),
    const_cast<CSSM_DB_RECORD_INDEX_INFO_PTR>(Indices),
    CSSM_TRUE,
    NULL,
    NULL
};

//
// Schema methods
//
CSSM_DB_RECORDTYPE
recordTypeFor(SecItemClass itemClass)
{
    switch (itemClass)
    {
    case kSecGenericPasswordItemClass: return CSSM_DL_DB_RECORD_GENERIC_PASSWORD;
    case kSecInternetPasswordItemClass: return CSSM_DL_DB_RECORD_INTERNET_PASSWORD;
    case kSecAppleSharePasswordItemClass: return CSSM_DL_DB_RECORD_APPLESHARE_PASSWORD;
    default: return CSSM_DB_RECORDTYPE(itemClass);
    }
}

SecItemClass
itemClassFor(CSSM_DB_RECORDTYPE recordType)
{
    switch (recordType)
    {
    case CSSM_DL_DB_RECORD_GENERIC_PASSWORD: return kSecGenericPasswordItemClass;
    case CSSM_DL_DB_RECORD_INTERNET_PASSWORD: return kSecInternetPasswordItemClass;
    case CSSM_DL_DB_RECORD_APPLESHARE_PASSWORD: return kSecAppleSharePasswordItemClass;
    default: return SecItemClass(recordType);
    }
}

const CSSM_DB_ATTRIBUTE_INFO &
attributeInfo(SecKeychainAttrType attrType)
{
    switch (attrType) 
    {
    case kSecCreationDateItemAttr: return kGenericCreationDate;
    case kSecModDateItemAttr: return kGenericModDate;
    case kSecDescriptionItemAttr: return kGenericDescription;
    case kSecCommentItemAttr: return kGenericComment;
    case kSecCreatorItemAttr: return kGenericCreator;
    case kSecTypeItemAttr: return kGenericType;
    case kSecScriptCodeItemAttr: return kGenericScriptCode;
    case kSecLabelItemAttr: return kGenericPrintName;
    case kSecAliasItemAttr: return kGenericAlias;
    case kSecInvisibleItemAttr: return kGenericInvisible;
    case kSecNegativeItemAttr: return kGenericNegative;
    case kSecCustomIconItemAttr: return kGenericCustomIcon;
    /* Unique Generic password attributes */
    case kSecAccountItemAttr: return kGenericAccount;
    case kSecServiceItemAttr: return kGenericService;
    case kSecGenericItemAttr: return kGenericGeneric;
    /* Unique Appleshare password attributes */
    case kSecVolumeItemAttr: return kAppleshareVolume;
    case kSecAddressItemAttr: return kAppleshareAddress;
    case kSecSignatureItemAttr: return kAppleshareSignature;
    /* Unique AppleShare and Internet attributes */
    case kSecServerItemAttr: return kAppleshareServer;
    case kSecProtocolItemAttr: return kAppleshareProtocol;
    /* Unique Internet password attributes */
    case kSecSecurityDomainItemAttr: return kInternetSecurityDomain;
    case kSecAuthenticationTypeItemAttr: return kInternetAuthType;
    case kSecPortItemAttr: return kInternetPort;
    case kSecPathItemAttr: return kInternetPath;
	/* Unique Certificate attributes */
	case kSecCertTypeItemAttr: return kX509CertificateCertType;
	case kSecCertEncodingItemAttr: return kX509CertificateCertEncoding;
	case kSecSubjectItemAttr: return kX509CertificateSubject;
	case kSecIssuerItemAttr: return kX509CertificateIssuer;
	case kSecSerialNumberItemAttr: return kX509CertificateSerialNumber;
	case kSecSubjectKeyIdentifierItemAttr: return kX509CertificateSubjectKeyIdentifier;
	case kSecPublicKeyHashItemAttr: return kX509CertificatePublicKeyHash;
	/* Unique UserTrust attributes */
	case kSecTrustCertAttr: return kUserTrustTrustedCertificate;
	case kSecTrustPolicyAttr: return kUserTrustTrustedPolicy;
    default: MacOSError::throwMe(errSecNoSuchAttr); // @@@ Not really but whatever.
    }
}

} // end namespace Schema

} // end namespace KeychainCore

} // end namespace Security
