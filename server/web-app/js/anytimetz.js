/*****************************************************************************
 *  FILE:  anytimetz.js - The Any+Time(TM) JavaScript Library
 *                        Basic Time Zone Support (source)
 *  VERSION: 5.x
 *
 *  Copyright 2008-2010 Andrew M. Andrews III (www.AMA3.com). Some Rights
 *  Reserved. This work is licensed under the Any+Time Software License
 *  Agreement Version 5.0 (below).
 *
 *  This file adds basic labels for major time zones to the Any+Time(TM)
 *  JavaScript Library.  Time zone support is extremely complicated, and
 *  ECMA-262 (JavaScript) provides little support.  Developers are expected
 *  to tailor this file to meet their needs, mostly by removing lines that
 *  are not required by their users, and/or by removing either abbreviated
 *  (before double-dash) or long (after double-dash) names from the strings.
 *  
 *  Note that there is no automatic detection of daylight savings time
 *  (AKA summer time), due to lack of support in JavaScript and the 
 *  time-prohibitive complexity of attempting such support in code.
 *  If you want to take a stab at it, let me know; if you want to pay me
 *  large sums of money to add it, again, let me know. :-p
 *  
 *  This file should be included AFTER anytime.js (or anytimec.js) in any
 *  HTML page that requires it.
 *
 *  Any+Time is a trademark of Andrew M. Andrews III.
 *
 *****************************************************************************
 *  Any+Time Software License Agreement
 *  Version 5.0
 *
 *  THIS DOCUMENT IS A LEGAL AGREEMENT (the "License Agreement") BETWEEN
 *  ANDREW M. ANDREWS III ("We," "Us") AND YOU OR THE ORGANIZATION ON WHOSE
 *  BEHALF YOU ARE UNDERTAKING THE LICENSE DESCRIBED BELOW ("You") IN RELATION
    TO THE ANY+TIME JAVASCRIPT LIBRARY SOFTWARE (THE "Software"), IN BOTH
 *  SOURCE AND OBJECT CODE FORM, AND/OR ALL RELATED MATERIALS. BY
 *  DOWNLOADING,INSTALLING, COPYING OR OTHERWISE USING THE SOFTWARE, YOU
 *  ACCEPT THE FOLLOWING TERMS AND CONDITIONS. IF YOU DO NOT AGREE WITH ANY
 *  OF THE TERMS OR CONDITIONS OF THIS LICENSE AGREEMENT, DO NOT PROCEED
 *  WITH THE DOWNLOADING, COPYING, INSTALLATION OR ANY OTHER USE OF THE
 *  SOFTWARE OR ANY PORTION THEREOF. THE SOFTWARE IS PROTECTED BY UNITED
 *  STATES COPYRIGHT LAWS AND INTERNATIONAL COPYRIGHT LAWS, AS WELL AS
 *  OTHER INTELLECTUAL PROPERTY LAWS AND TREATIES. THE SOFTWARE IS
 *  LICENSED, NOT SOLD.
 *
 *  THIS LICENSE AGREEMENT DESCRIBES YOUR RIGHTS WITH RESPECT TO THE
 *  SOFTWARE AND ITS COMPONENTS.
 *
 *  We grant You a non-exclusive, non-transferable license to the Software
 *  solely as set forth in section 1, and subject to the terms and
 *  conditions of this License Agreement.
 *
 *  1. OWNERSHIP, LICENSE GRANT
 *
 *  This is a license agreement and not an agreement for sale. We reserve
 *  ownership of all intellectual property rights inherent in or relating
 *  to the Software, which include, but are not limited to, all copyright,
 *  patent rights, all rights in relation to registered and unregistered
 *  trademarks (including service marks), confidential information
 *  (including trade secrets and know-how) and all rights other than those
 *  expressly granted by this Agreement. Subject to the payment of the fee
 *  and/or royalties (if any) required for a License and subject to the
 *  terms and conditions of this License Agreement, We grant to You a
 *  revocable, non-transferable and non-exclusive license (i) for You to
 *  install and use the Software on any workstations used exclusively by
 *  You and Your employees, and (ii) for You to install and use the
 *  Software in connection with unlimited domains and sub-domains on
 *  unlimited servers, solely in connection with distribution of the
 *  Software in accordance with sections 3 and 4 below. You may not
 *  sublicense this license except as explicitly set forth herein.
 *
 *  2. PERMITTED USES, SOURCE CODE, MODIFICATIONS
 *
 *  We provide You with source code so that You can create Modifications of
 *  the original Software, where Modification means: a) any addition to or
 *  deletion from the contents of a file included in the original Software
 *  or previous Modifications created by You, or b) any new file that
 *  contains any part of the original Software or previous Modifications.
 *  While You retain all rights to any original work authored by You as
 *  part of the Modifications, We continue to own all copyright and other
 *  intellectual property rights in the Software.
 *
 *  3. DISTRIBUTION
 *
 *  You may distribute the Software in any applications (including
 *  Software-as-a-Service applications), frameworks, or elements that you
 *  develop using the Software in accordance with this License Agreement,
 *  provided that such distribution does not violate the restrictions set
 *  forth in section 4 of this agreement. You must not remove, obscure or
 *  interfere with any copyright, acknowledgment, attribution, trademark,
 *  warning or disclaimer statement affixed to, incorporated in or
 *  otherwise applied in connection with the Software.
 *
 *  You are required to ensure that the Software is not reused by or with
 *  any applications other than those with which You distribute it as
 *  permitted herein. For example, if You install the Software on a
 *  customer's server, that customer is not permitted to use the Software
 *  independently of Your application, and must be informed as such. Your
 *  customer is required to pay any fees and/or royalties for their License
 *  to use this Software, and you are required to inform them of this
 *  obligation.
 *
 *  4. PROHIBITED USES
 *
 *  You may not, without Our prior written consent, redistribute the
 *  Software or Modifications other than by including the Software or a
 *  portion thereof within Your own product, which must have substantially
 *  different functionality than the Software or Modifications and must not
 *  allow any third party to use the Software or Modifications, or any
 *  portions thereof, for software development purposes. You are explicitly
 *  not allowed to redistribute the Software or Modifications as part of
 *  any product that can be described as a development toolkit or library
 *  or is intended for use by software developers and not end-users. You
 *  are not allowed to redistribute any part of the Software documentation.
 *
 *  You may not: a) use any part of the Software or Modifications or Your
 *  knowledge of the Software (or any information that You learn as a
 *  result of Your use of the Software) to create a product with the same
 *  or substantially the same functionality as the Software; b) transfer,
 *  rent, lease, or sub-license the Software or Modifications, or any
 *  portions thereof; c) change or remove the copyright notice from any of
 *  the files included in the Software or Modifications.
 *
 *  UNDER NO CIRCUMSTANCES MAY YOU USE THE SOFTWARE (INCLUDING WITHOUT
 *  LIMITATION THE SOURCE CODE THEREOF) AS THE BASIS FOR OR IN CONNECTION
 *  WITH A PRODUCT THAT CONTAINS THE SAME, OR SUBSTANTIALLY THE SAME,
 *  FUNCTIONALITY AS THE SOFTWARE.
 *
 *  5. TERMINATION
 *
 *  This License Agreement and Your right to use the Software and
 *  Modifications will terminate immediately without notice if You fail to
 *  comply with the terms and conditions of this License Agreement. Upon
 *  termination, You agree to immediately cease using and destroy the
 *  Software or Modifications, including all accompanying documents. The
 *  provisions of sections 4, 5, 6, 7, and 8 will survive any termination
 *  of this License Agreement.
 *
 *  6. DISCLAIMER OF WARRANTIES
 *
 *  TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, WE AND OUR SUPPLIERS
 *  DISCLAIM ALL WARRANTIES AND CONDITIONS, EITHER EXPRESS OR IMPLIED,
 *  INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT, WITH
 *  REGARD TO THE SOFTWARE. WE DO NOT GUARANTEE THAT THE OPERATION OF THE
 *  SOFTWARE WILL BE UNINTERRUPTED OR ERROR-FREE, AND YOU ACKNOWLEDGE THAT
 *  IT IS NOT TECHNICALLY PRACTICABLE FOR US TO DO SO.
 *
 *  7. LIMITATION OF LIABILITIES
 *
 *  TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, IN NO EVENT SHALL WE
 *  OR OUR SUPPLIERS BE LIABLE FOR ANY SPECIAL, INCIDENTAL, INDIRECT OR
 *  CONSEQUENTIAL DAMAGES WHATSOEVER (INCLUDING, WITHOUT LIMITATION,
 *  DAMAGES FOR LOSS OF BUSINESS PROFITS, BUSINESS INTERRUPTION, LOSS OF
 *  BUSINESS INFORMATION OR ANY OTHER PECUNIARY LAW) ARISING OUT OF THE USE
 *  OF OR INABILITY TO USE THE SOFTWARE, EVEN IF WE HAVE BEEN ADVISED OF
 *  THE POSSIBILITY OF SUCH DAMAGES. IN ANY CASE, OUR ENTIRE LIABILITY
 *  UNDER ANY PROVISION OF THIS LICENSE AGREEMENT SHALL BE LIMITED TO THE
 *  GREATER OF THE AMOUNT ACTUALLY PAID BY YOU FOR THE SOFTWARE OR FIVE
 *  ($5.00) DOLLARS (USD).
 *
 *  8. MISCELLANEOUS
 *
 *  The license granted herein applies only to the version of the Software
 *  downloaded or installed in connection with the terms of this Agreement.
 *  Any previous or subsequent license granted to You for use of the
 *  Software shall be governed by the terms and conditions of the agreement
 *  entered in connection with downloading or installation of that version
 *  of the Software.
 *
 *  You agree that you will comply with all applicable laws and regulations
 *  with respect to the Software, including without limitation all export
 *  and re-export control laws and regulations.
 *
 *  While redistributing the Software or Modifications thereof, You may
 *  choose to offer acceptance of support, warranty, indemnity, or other
 *  liability obligations and/or rights consistent with this Agreement.
 *  However, in accepting such obligations, You may act only on Your own
 *  behalf and on Your sole responsibility, not on our behalf. You agree to
 *  indemnify, defend, and hold Us harmless from and against any liability
 *  incurred by, or claims asserted against, Us by reason of Your accepting
 *  any such support, warranty, indemnity or additional liability.
 *
 *  You may not assign this License Agreement without Our prior written
 *  consent. This License Agreement will inure to the benefit of Our
 *  successors and assigns.
 *
 *  You acknowledge that this License Agreement is complete and is the
 *  exclusive representation of our agreement. No oral or written
 *  information given by Us or on our behalf shall create a warranty or
 *  collateral contract, or in any way increase the scope of this License
 *  Agreement in any way, and You may not rely on any such oral or written
 *  information.
 *
 *  If any provision in this License Agreement shall be determined to be
 *  invalid, such provision shall be deemed omitted; the remainder of this
 *  License Agreement shall continue in full force and effect.
 *
 *  This License Agreement may be modified only by a written instrument
 *  signed by an authorized representative of each party.
 *
 *  This Agreement is governed by the law of the Commonwealth of
 *  Pennsylvania, United States (notwithstanding conflicts of laws
 *  provisions), and all parties irrevocably submit to the jurisdiction of
 *  the courts of the Commonwealth of Pennsylvania and further agree to
 *  commence any litigation which may arise hereunder in the state or
 *  federal courts located in the judicial district of Washington County,
 *  Pennsylvania, US.
 *
 *  If the Software or any related documentation is licensed to the U.S.
 *  government or any agency thereof, it will be deemed to be "commercial
 *  computer software" or "commercial computer software documentation,"
 *  pursuant to SFAR Section 227.7202 and FAR Section 12.212. Any use of
 *  the Software or related documentation by the U.S. government will be
 *  governed solely by the terms of this License Agreement.
 ****************************************************************************/

//=============================================================================
//  AnyTime.utcLabel is an array of arrays, indexed by UTC offset IN MINUTES
//  (not hours-and-minutes).  This is used by AnyTime.Converter to display
//  time zone labels when the "%@" format specifier is used.  It is also used
//  by AnyTime.widget() to determine which time zone labels to offer as valid
//  choices when a user attempts to change the time zone.  NOTE: Positive
//  indicies are NOT signed.
//
//  Each sub-array contains a series of strings, each of which is a label
//  for a time-zone having the corresponding UTC offset.  The first string in
//  each sub-array is the default label for that UTC offset (the one used by
//  AnyTime.Converter.format() if utcFormatOffsetSubIndex is not specified and
//  setUtcFormatOffsetSubIndex() is not called.
//=============================================================================

AnyTime.utcLabel = [];
AnyTime.utcLabel[-720]=[
  'BIT'
  ];
AnyTime.utcLabel[-660]=[
  'SST'
  ];
AnyTime.utcLabel[-600]=[
  'CKT'
  ,'HAST'
  ,'TAHT'
  ];
AnyTime.utcLabel[-540]=[
  'AKST'
  ,'GIT'
  ];
AnyTime.utcLabel[-510]=[
  'MIT'
  ];
AnyTime.utcLabel[-480]=[
  'CIST'
  ,'PST'
  ];
AnyTime.utcLabel[-420]=[
  'MST'
  ,'PDT'
  ];
AnyTime.utcLabel[-360]=[
  'CST'
  ,'EAST'
  ,'GALT'
  ,'MDT'
  ];
AnyTime.utcLabel[-300]=[
  'CDT'
  ,'COT'
  ,'ECT'
  ,'EST'
  ];
AnyTime.utcLabel[-240]=[
  'AST'
  ,'BOT'
  ,'CLT'
  ,'COST'
  ,'ECT'
  ,'EDT'
  ,'FKST'
  ,'GYT'
  ];
AnyTime.utcLabel[-210]=[
  'VET'
  ];
AnyTime.utcLabel[-180]=[
  'ART'
  ,'BRT'
  ,'CLST'
  ,'GFT'
  ,'UYT'
  ];
AnyTime.utcLabel[-150]=[
  'NT'
  ];
AnyTime.utcLabel[-120]=[
  'GST'
  ,'UYST'
  ];
AnyTime.utcLabel[-90]=[
  'NDT'
  ];
AnyTime.utcLabel[-60]=[
  'AZOST'
  ,'CVT'
  ];
AnyTime.utcLabel[0]=[
  'GMT'
  ,'WET'
  ];
AnyTime.utcLabel[60]=[
  'BST'
  ,'CET'
  ];
AnyTime.utcLabel[60]=[
  'WAT'
  ,'WEST'
  ];
AnyTime.utcLabel[120]=[
  'CAT'
  ,'CEST'
  ,'EET'
  ,'IST'
  ,'SAST'
  ];
AnyTime.utcLabel[180]=[
  'AST'
  ,'AST'
  ,'EAT'
  ,'EEST'
  ,'MSK'
  ];
AnyTime.utcLabel[210]=[
  'IRST'
  ];
AnyTime.utcLabel[240]=[
  'AMT'
  ,'AST'
  ,'AZT'
  ,'GET'
  ,'MUT'
  ,'RET'
  ,'SAMT'
  ,'SCT'
  ];
AnyTime.utcLabel[270]=[
  'AFT'
  ];
AnyTime.utcLabel[300]=[
  'AMST'
  ,'HMT'
  ,'PKT'
  ,'YEKT'
  ];
AnyTime.utcLabel[330]=[
  'IST'
  ,'SLT'
  ];
AnyTime.utcLabel[345]=[
  'NPT'
  ];
AnyTime.utcLabel[360]=[
  'BIOT'
  ,'BST'
  ,'BTT'
  ,'OMST'
  ];
AnyTime.utcLabel[390]=[
  'CCT'
  ,'MST'
  ];
AnyTime.utcLabel[420]=[
  'CXT'
  ,'KRAT'
  ,'THA'
  ];
AnyTime.utcLabel[480]=[
  'ACT'
  ,'AWST'
  ,'BDT'
  ,'CST'
  ,'HKT'
  ,'IRKT'
  ,'MST'
  ,'PST'
  ,'SST'
  ];
AnyTime.utcLabel[540]=[
  'JST'
  ,'KST'
  ,'YAKT'
  ];
AnyTime.utcLabel[570]=[
  'ACST'
  ];
AnyTime.utcLabel[600]=[
  'AEST'
  ,'ChST'
  ,'VLAT'
  ];
AnyTime.utcLabel[630]=[
  'LHST'
  ];
AnyTime.utcLabel[660]=[
  'MAGT'
  ,'SBT'
  ];
AnyTime.utcLabel[690]=[
  'NFT'
  ];
AnyTime.utcLabel[720]=[
  'FJT'
  ,'GILT'
  ,'PETT'
  ];
AnyTime.utcLabel[765]=[
  'CHAST'
  ];
AnyTime.utcLabel[780]=[
  'PHOT'
  ];
AnyTime.utcLabel[840]=[
  'LINT'
  ];

//
//END OF FILE
//
