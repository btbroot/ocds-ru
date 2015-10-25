# ocds-ru
An attempt of mapping the raw data published on zakupki.gov.ru into OCDS 
publisher.

Copyright 2015 Al Nikolov

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

We will focus on the first one, and follow up the rest as it become feasible.

### Federal Act 44
The Act regulates activities aimed for satisfying state and municipal needs and 
encompasses the whole cycle of:

* procurement planning for goods, works, services;
* suppliers determining;
* contract sealing;
* contract obligations fulfilling

etc.

Notably, these are not being regulated:

* services provided by international financial organizations;
* security assurance for criminal victims, whitnesses, and also for judges etc.

Some specifics can also be different for satisfying defence needs (Federal Act 
275).

In general, any government organization or instutution, as well as any budget
institution, and in some cases companies (if budget capital invesments 
granted to them) must align the spending activities to the Act.

#### Technical regulation

The current
[technical regulation](http://zakupki.gov.ru/epz/main/public/download/downloadDocument.html?id=3228) 
should be defining all the practicalities of accessing the egress data.

#### Basic data
Data should be available at the 
[FTP server](ftp://free:free@ftp.zakupki.gov.ru/fcs_regions/) in form of XML 
documents, compressed into ZIP archives. 
Every archive file name should 
contain the data egress type and data actuality period. 

The data egress is split by region (represented by the topmost directory).

Data then is being 
placed into directories named according to documents type:

* "contracts" (contracts?),
* "protocols" (protocols of something?),
* "purchasedocs" (purchase acts?),
* "notifications" (tenders?),
* "plangraphs" (schedules in "tenderPlan_...")
* "sketchplans" (draft plans, no structured data)

Monthly archives go to the topmost directories. Daily archives for the current
month go to "currmonth" subdirectories.

Presumaby, any date-time data is missing the MSK time zone.

##### "notifications" type
fcsNotification

##### "contracts" type
contract
: contract itself or a modification

contractCancel
: cancellation of a contract

contractProcedure
: implementation of a contract

contractProcedureCancel
: cancellation of a contract

#### Auxiliary data
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
Selected data can be mapped to OCDS (definitions).

### OCDS contract
id
: /ns2:contract/id

## Implementation
Since the official system doesn't publish the data according to OCDS,
we'll create a secondary publisher by first mirroring the data.

### mirror-update
This script maintains the local mirror of the regional data egressed one to one,
omitting non-informative directories. Notably, any disappeared source files
also get removed in the mirror, any modified files silently get changed etc.
There's no any kind of control on the data quality at this step.

The existing mirror content - the archives - then gets exploded into the work 
directory, never overwriting any existing documents for speed. This assumes that
no XML document can be silently replaced by the source with modified 
content (republishing the same content in the same document file is tolerable).


### unzip-all
As the data comes in ZIP archives, all not-yet-unpacked files found in the 
mirror directory are being unzipped to the working directory (never 
overwriting anything) and stamping the success.

Any "Unstructured" files are omitted.


