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

##### Auxiliary data
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

## Implementation
Since the official system doesn't publish the data according to OCDS,
we'll create a secondary publisher by first mirroring the data.

### mirror-update
This make target updates the local mirror of the data egressed. In order
to keep it small enough for piloting, we'll start to mirror only one region.

Files included in the mirror are .xml.zip.

The "prevMonth" directories are omitted (the monthly egress should be enough).

The "sketchplans" directories are omitted (no structured data at all).

The "plangraphs" directories are omitted - see below.

As 
[Consultant](https://www.consultant.ru/document/cons_doc_LAW_144624/081ebfc463be2d2e8bda2693d8cd38b2cf0434f9/)
says, the "procurement identification code" - basically the id for a 
contracting process used to link together records in the draft plans, 
schedules, tenders, contracts and other contractind documentss - will only be 
required by the law since Jan 1st 2016. As a matter of fact, no linkage is
feasible between schedule document records and the others.


### unzip-all
As the data comes in ZIP archives, all not-yet-unpacked files found in the 
mirror directory are being unzipped to the working directory (never 
overwriting anything) and stamping the success.

Any "Unstructured" files are omitted.


