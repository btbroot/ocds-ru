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

##### Contract data
The current
[contract register technical regulation](http://zakupki.gov.ru/epz/main/public/download/downloadDocument.html?id=8176) 
should be defining all the practicalities of accessing the contracts data (and 
some other data).

Data should be available at the 
[FTP server](ftp://free:free@ftp.zakupki.gov.ru/fcs_regions/) in form of XML 
documents according to schema 
fcsExport.xsd (as suggested but not found) compressed into ZIP archives. 
Every archive file name should 
contain the data egress type and data actuality period. 

In non-contract data egress archives every XML document 
file name should contain the document type, the related object identifier, and 
the document identifier.

Data egress performed manually should also present the
time stamp of the manual operation in the archives file names.

The data egress is split by region (represented by the topmost directory).

Contract data then 
placed into directories named "contracts", "contracts/currmonth" and
"contracts/prevmonth". File modification time stamp seems to be not relevant 
to the data, but to the egress operation. Regardless, since there is no 
apparent distinctive procedure defined to modify any previously published data,
the file modification time stamps must be tracked and any differences must be 
considered as new releases.

Automatic egress ZIP archive file name format: 
"type_region_startdate_enddate_dailyrunningnumber.xml.zip",
where date format is "yyyymmddhh" and the daily running number is 3 digits.

Manual egress ZIP archive file name format:
"type_region_startdate_enddate_egressdatetime_dailyrunningnumber.xml.zip",
where egress date-time is yyyymmddhhmiss.

Presumaby, any date-time data is missing the MSK time zone.

The automatic egress happens daily at 00:15 MSK and monthly on the first 
Saturday at 06:00 MSK.

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

Full automatic data egress happens weekly on Sunday at 01:00 MSK. Incremental
automatic data egress happens daily at 01:00 MSK.

Full egress file name format:
"dictionaryname_all_egressdatetime_dailyrunningnumber.xml.zip".

Incremental egress file name format:
"dictionaryname_inc_startdate_enddate_dailyrunningnumber.xml.zip"

##### Other data
Other data including these in directories "sketchplans", "plangraphs",
"notifications", "protocols", "purchasedocs" are also of interest,
but we haven't found any regulations for them.

## Implementation
Since the official system doesn't publish the data according to OCDS,
we'll create a secondary publisher by first mirroring the data.

### mirror-update
This make target updates the local mirror of the data egressed. In order
to keep it small enough for piloting, we'll start to mirror only one region
(at the time of writing the mirror size is about 1 Gb).

After syncronizing, the mirror content gets commited to Git repository.
