# ocds-ru
An attempt of mapping the raw data published on zakupki.gov.ru into OCDS 
publisher.

 Copyright 2015 Al Nikolov
 
 This file is part of ocds-ru suite.
 
    ocds-ru is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    ocds-ru is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with ocds-ru.  If not, see <http://www.gnu.org/licenses/>.

## Preambula
[OCDS](http://standard.open-contracting.org/) stands for Open Contracting 
Data Standard and aims for a semantic network creation of contracting 
information by disclosuring structurized data, mainly related to government or
heavily regulated companies spendings. The standard evolves starting from 2014 
and at the time of writing the version 1.0.0 is published.

In Russia the most of such spendings at their different stages of completion 
are regulated by certain laws, hereby the disclosure of any relevant data is 
mandatory via [centralized system](http://zakupki.gov.ru/). Publishing this 
data according to OCDS would be a great benefit for public interest.

## Regulation
A number of Federal Acts regulate the activities of interest, most notable are:

* [Federal Act 44](http://www.rg.ru/2013/04/12/goszakupki-dok.html);
* Federal Act 223;
* Federal Act 94 (obsoleted by the Federal Act 44).

### Federal Act 44
The Act regulates activities aimed for satisfying state and municipal needs and 
encompasses the whole cycle of:

* procurement planning for goods, works, services;
* suppliers determining;
* contract sealing;
* contract obligations fulfilling

etc.

Notably, these spendings are not being regulated:

* on services provided by international financial organizations;
* on security assurance for criminal victims, whitnesses, and also for judges etc.

Some specifics can also be different for satisfying defence needs (Federal Act 
275).

In general, any government organization or instutution, as well as any budget
institution, and in some cases companies (if budget capital invesments 
granted to them) must align the spending activities to the Act.

#### Technical regulation

The current
[technical regulation](http://zakupki.gov.ru/epz/main/public/download/downloadDocument.html?id=3228) 
should be defining all the practicalities of accessing the data egress.

## Basic data
Data should be available at the 
[FTP server](ftp://free:free@ftp.zakupki.gov.ru/fcs_regions/) in form of XML 
documents, compressed into ZIP archives. 

The data egress is split by region (represented by the topmost directory).

Data then is being 
placed into directories named according to documents type:

* "contracts" (contracts/awards and contract implementation steps),
* "protocols" (?protocols of something?),
* "purchasedocs" (documents related to tenders?),
* "notifications" (tenders),
* "plangraphs" (no mapping -- procurement schedules required by the law since Jan 1st 2016),
* "sketchplans" (no mapping -- procurement plans have no structured data).

Monthly archives go to the topmost directories. Daily archives for the current
month go to "currMonth" subdirectories.

Presumaby, any date-time data is missing the MSK time zone.

## Auxiliary data
The same regulation should be defining some auxiliary data 
egresses, such as dictionaries. the said data should be available th the
[FTP server](ftp://free:free@ftp.zakupki.gov.ru/fcs_nsi/).

Notably there should be the following data (in directories):

* budgets ("nsibudget");
* contract value amendment reasons ("nsiContractPriceChangeReason");
* contract refusal reasons ("nsiContractRefusalReason");
* single supplier contract reasons ("nsiContractSingleCustomerReason");
* contract termination reasons ("nsiContractTerminationReason");
* contract amendment reasons ("nsiContractModificationReason");
* organizations ("nsiOrganization");
* organization types ("nsiOrganizationType")

etc. To be considered as needed.

## OCDS mapping

Following the realities of Russian government procurements, these 
processes mapping appears to be feasible.

### Federal Act 44
#### Request for quotations

* /e:export/e:fcsNotificationZK[@schemeVersion=1.0] and /*/*/t:placingWay/t:code='ZK44'
* /e:export/e:fcsPurchaseDocument[@schemeVersion=1.0] and /*/*/t:docType/t:code='P'
* /e:export/e:contract[@schemeVersion=1.0] and /*/*/t:foundation/t:fcsOrder/t:placing=9
* /e:export/e:contractProcedure[@schemeVersion=1.0]

## Autors
Al Nikolov <root@toor.fi.eu.org>
Solisevankuja 1 B 7
027600
Espoo
Finland
