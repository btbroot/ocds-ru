<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright 2015 Al Nikolov -->

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
	xmlns:t="http://zakupki.gov.ru/oos/types/1"
	xmlns:e="http://zakupki.gov.ru/oos/export/1"
>

	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="/e:export/e:fcsNotificationZK[@schemeVersion=1.0] and /*/*/t:placingWay/t:code='ZK44'">
				<xsl:variable name='procuringEntity'>
					<!-- Optional -->
					<identifier>
						<!-- Optional -->
						<scheme>x-СПЗ</scheme>
						<id><xsl:value-of select="/*/*/t:purchaseResponsible/t:responsibleOrg/t:regNum"/></id>
						<legalName><xsl:value-of select="/*/*/t:purchaseResponsible/t:responsibleOrg/t:fullName"/></legalName>
						<!-- <uri> -->
					</identifier>
					<additionalIdentifiers>
						<!-- Optional -->
						<scheme>x-ИНН</scheme>
						<id><xsl:value-of select="/*/*/t:purchaseResponsible/t:responsibleOrg/t:INN"/></id>
						<!-- <legalName> -->
						<!-- <uri> -->
					</additionalIdentifiers>
					<additionalIdentifiers>
						<!-- Optional -->
						<scheme>x-КПП</scheme>
						<id><xsl:value-of select="/*/*/t:purchaseResponsible/t:responsibleOrg/t:KPP"/></id>
						<!-- <legalName> -->
						<!-- <uri> -->
					</additionalIdentifiers>
					<name><xsl:value-of select="/*/*/t:purchaseResponsible/t:responsibleOrg/t:fullName"/></name>
					<address>
						<xsl:variable name="address" select="str:split(/*/*/t:purchaseResponsible/t:responsibleOrg/t:factAddress, ', ')"/>
						<!-- Optional -->
						<streetAddress>
							<xsl:for-each select="$address">
								<xsl:if test="position() > 4">
									<xsl:value-of select="concat(., ' ')"/>
								</xsl:if>
							</xsl:for-each>
						</streetAddress>
						<locality><xsl:value-of select="$address[4]"/></locality>
						<region><xsl:value-of select="$address[3]"/></region>
						<postalCode><xsl:value-of select="$address[2]"/></postalCode>
						<countryName><xsl:value-of select="$address[1]"/></countryName>
					</address>
					<contactPoint>
						<!-- Optional -->
						<name>
							<xsl:value-of select="concat(
								'Адрес: ', /*/*/t:purchaseResponsible/t:responsibleInfo/t:orgFactAddress, ' // ',
								'Почтовый адрес: ', /*/*/t:purchaseResponsible/t:responsibleInfo/t:orgPostAddress, ' // ',
								'Лицо: ', /*/*/t:purchaseResponsible/t:responsibleInfo/t:contactPerson/t:lastName, ' ',
								/*/*/t:purchaseResponsible/t:responsibleInfo/t:contactPerson/t:firstName, ' ',
								/*/*/t:purchaseResponsible/t:responsibleInfo/t:contactPerson/t:middleName
							)"/>
						</name>
						<email><xsl:value-of select="/*/*/t:purchaseResponsible/t:responsibleInfo/t:contactEMail"/></email>
						<telephone><xsl:value-of select="/*/*/t:purchaseResponsible/t:responsibleInfo/t:contactPhone"/></telephone>
						<faxNumber><xsl:value-of select="/*/*/t:purchaseResponsible/t:responsibleInfo/t:contactFax"/></faxNumber>
						<!-- <uri> -->
					</contactPoint>
					<!-- Extended -->
					<x-mailAddress>
						<xsl:variable name="address" select="str:split(/*/*/t:purchaseResponsible/t:responsibleOrg/t:postAddress, ', ')"/>
						<!-- Optional -->
						<streetAddress>
							<xsl:for-each select="$address">
								<xsl:if test="position() > 4">
									<xsl:value-of select="concat(., ' ')"/>
								</xsl:if>
							</xsl:for-each>
						</streetAddress>
						<locality><xsl:value-of select="$address[4]"/></locality>
						<region><xsl:value-of select="$address[3]"/></region>
						<postalCode><xsl:value-of select="$address[2]"/></postalCode>
						<countryName><xsl:value-of select="$address[1]"/></countryName>
					</x-mailAddress>
				</xsl:variable>

				<release>
					<!-- Required -->
					<ocid>ocds-btbroot01-<xsl:value-of select="/*/*/t:purchaseNumber"/></ocid>
					<id><xsl:value-of select="/*/*/t:id"/></id>
					<date><xsl:value-of select="/*/*/t:docPublishDate"/></date>
					<tag>tender<xsl:if test="/*/*/t:modification">Amendment</xsl:if></tag>
					<initiationType>tender</initiationType>
					<!-- Optional -->
					<planning>
						<!-- Optional -->
						<budget>
							<!-- Optional -->
							<!-- <source> -->
							<!-- <id> -->
							<description><xsl:value-of select="/*/*/t:lot/t:financeSource"/></description>
							<!-- <amount> -->
							<!-- <project> -->
							<!-- <projectID> -->
							<!-- <uri> -->
						</budget>
						<!-- <rationale> -->
						<!-- <documents> -->
					</planning>
					<tender>
						<!-- Required -->
						<id><xsl:value-of select="/*/*/t:purchaseNumber"/></id>
						<!-- Optional -->
						<title><xsl:value-of select="/*/*/t:purchaseObjectInfo"/></title>
						<!-- <description> -->
						<!-- <status> -->
						<xsl:for-each select="/*/*/t:lot/t:purchaseObjects/t:purchaseObject">
							<items>
								<!-- Required -->
								<id><xsl:value-of select="t:name"/></id>
								<!-- Optional -->
								<description><xsl:value-of select="t:name"/></description>
								<classification>
									<!-- Optional -->
									<scheme>x-ОКПД</scheme>
									<id><xsl:value-of select="t:OKPD/t:code"/></id>
									<description><xsl:value-of select="t:OKPD/t:name"/></description>
									<!-- <uri> -->
								</classification>
								<!-- <additionalClassifications> -->
								<quantity><xsl:value-of select="t:quantity/t:value"/></quantity>
								<unit>
									<!-- Optional -->
									<name><xsl:value-of select="t:OKEI/t:nationalCode"/></name>
									<value>
										<!-- Optional -->
										<amount><xsl:value-of select="t:price"/></amount>
										<currency><xsl:value-of select="/*/*/t:lot/t:currency/t:code"/></currency>
									</value>
								</unit>
								<!-- Extended -->
								<xsl:for-each select="t:customerQuantities/t:customerQuantitie">
									<x-byuers>
										<!-- Optional -->
										<identifier>
											<!-- Optional -->
											<scheme>x-СПЗ</scheme>
											<id><xsl:value-of select="t:customer/t:regNum"/></id>
											<legalName><xsl:value-of select="t:customer/t:fullName"/></legalName>
											<!-- <uri> -->
										</identifier>
										<!-- <additionalIdentifiers> -->
										<name><xsl:value-of select="t:customer/t:fullName"/></name>
										<!-- <address> -->
										<!-- <contactPoint> -->
										<!-- Extended -->
										<quantity><xsl:value-of select="t:quantity/t:value"/></quantity>
									</x-byuers>
								</xsl:for-each>
							</items>
						</xsl:for-each>
						<!-- <minValue> -->
						<value>
							<!-- Optional -->
							<amount><xsl:value-of select="/*/*/t:lot/t:maxPrice"/></amount>
							<currency><xsl:value-of select="/*/*/t:lot/t:currency/t:code"/></currency>
						</value>
						<procurementMethod>selective</procurementMethod>
						<!-- <procurementMethodRationale> -->
						<awardCriteria>lowestCost</awardCriteria>
						<awardCriteriaDetails>
							<xsl:for-each select="/*/*/t:lot/t:preferenses/t:preferense">
								<xsl:value-of select="concat('Преимущество ', t:code, ': ', t:name, ' = ', t:prefValue, ' // ')"/>
							</xsl:for-each>
						</awardCriteriaDetails>
						<submissionMethod>electronicSubmission</submissionMethod>
						<submissionMethod>inPerson</submissionMethod>
						<submissionMethod>written</submissionMethod>
						<submissionMethodDetails>
							<xsl:value-of select="concat(
								/*/*/t:procedureInfo/t:collecting/t:place, ' // ',
								/*/*/t:procedureInfo/t:collecting/t:order, ' // ',
								/*/*/t:procedureInfo/t:collecting/t:form
							)"/>
						</submissionMethodDetails>
						<tenderPeriod>
							<!-- Optional -->
							<startDate><xsl:value-of select="/*/*/t:procedureInfo/t:collecting/t:startDate"/></startDate>
							<endDate><xsl:value-of select="/*/*/t:procedureInfo/t:collecting/t:endDate"/></endDate>
						</tenderPeriod>
						<!-- <enquiryPeriod> -->
						<!-- <hasEnquiries> -->
						<eligibilityCriteria>
							<xsl:for-each select="/*/*/t:lot/t:requirements/t:requirement">
								<xsl:value-of select="concat(t:code, ': ', t:name, ' // ')"/>
							</xsl:for-each>
						</eligibilityCriteria>
						<!-- <awardPeriod> -->
						<!-- <numberOfTenderers> -->
						<!-- <tenderers> -->
						<procuringEntity><xsl:copy-of select="$procuringEntity"/></procuringEntity>
						<documents>
							<!-- Required -->
							<id>__self__</id>
							<!-- Optional -->
							<documentType>Tender notice</documentType>
							<title>Этот документ</title>
							<url><xsl:value-of select="/*/*/t:href"/></url>
							<datePublished><xsl:value-of select="/*/*/t:docPublishDate"/></datePublished>
							<!-- <dateModified> -->
							<format>text/html</format>
							<language>ru</language>
						</documents>
						<documents>
							<!-- Required -->
							<id>__print__</id>
							<!-- Optional -->
							<documentType>Tender notice</documentType>
							<title>Этот документ (для печати)</title>
							<url><xsl:value-of select="/*/*/t:printForm"/></url>
							<datePublished><xsl:value-of select="/*/*/t:docPublishDate"/></datePublished>
							<!-- <dateModified> -->
							<format>text/html</format>
							<language>ru</language>
						</documents>
						<xsl:for-each select="/*/*/t:attachments/t:attachment">
							<documents>
								<!-- Required -->
								<id><xsl:value-of select="t:fileName"/></id>
								<!-- Optional -->
								<documentType>Tender notice</documentType>
								<title><xsl:value-of select="t:fileName"/></title>
								<description><xsl:value-of select="t:docDescription"/></description>
								<url><xsl:value-of select="t:url"/></url>
								<!-- <datePublished> -->
								<!-- <dateModified> -->
								<!-- <format> -->
								<language>ru</language>
							</documents>
						</xsl:for-each>
						<!-- <milestones> -->
						<xsl:if test="/*/*/t:modification">
							<amendment>
								<!-- Optional -->
								<date><xsl:value-of select="/*/*/t:docPublishDate"/></date>
								<!-- <changes> -->
								<rationale><xsl:value-of select="/*/*/t:modification/t:info"/></rationale>
							</amendment>
						</xsl:if>
					</tender>
					<xsl:if test="/*/*/t:purchaseResponsible/t:responsibleRole = 'CU'">
						<buyer><xsl:copy-of select="$procuringEntity"/></buyer>
					</xsl:if>
					<!-- <awards> -->
					<!-- <contracts> -->
					<language>ru</language>
					<x-source><xsl:copy-of select="/"/></x-source>
				</release>
			</xsl:when>
			
			<xsl:when test="/e:export/e:fcsPurchaseDocument[@schemeVersion=1.0] and /*/*/t:docType/t:code='P'">
				<release>
					<!-- Required -->
					<ocid>ocds-btbroot01-<xsl:value-of select="/*/*/t:purchaseNumber"/></ocid>
					<id><xsl:value-of select="/*/*/t:id"/></id>
					<date><xsl:value-of select="/*/*/t:docPublishDate"/></date>
					<tag>tenderUpdate</tag>
					<initiationType>tender</initiationType>
					<!-- Optional -->
					<!-- <planning> -->
					<tender>
						<!-- Required -->
						<id><xsl:value-of select="/*/*/t:purchaseNumber"/></id>
						<!-- Optional -->
						<!-- <title> -->
						<!-- <description> -->
						<!-- <status> -->
						<!-- <items> -->
						<!-- <minValue> -->
						<!-- <value> -->
						<!-- <procurementMethod> -->
						<!-- <procurementMethodRationale> -->
						<!-- <awardCriteria> -->
						<!-- <awardCriteriaDetails> -->
						<!-- <submissionMethod> -->
						<!-- <submissionMethodDetails> -->
						<!-- <tenderPeriod> -->
						<!-- <enquiryPeriod> -->
						<!-- <hasEnquiries> -->
						<!-- <eligibilityCriteria> -->
						<!-- <awardPeriod> -->
						<!-- <numberOfTenderers> -->
						<!-- <tenderers> -->
						<!-- <procuringEntity> -->
						<documents>
							<!-- Required -->
							<id>__print__</id>
							<!-- Optional -->
							<documentType>evaluationReports</documentType>
							<title>Этот документ (для печати)</title>
							<url><xsl:value-of select="/*/*/t:printForm"/></url>
							<datePublished><xsl:value-of select="/*/*/t:docPublishDate"/></datePublished>
							<!-- <dateModified> -->
							<format>text/html</format>
							<language>ru</language>
						</documents>
						<xsl:for-each select="/*/*/t:attachments/t:attachment">
							<documents>
								<!-- Required -->
								<id><xsl:value-of select="t:fileName"/></id>
								<!-- Optional -->
								<documentType>evaluationReports</documentType>
								<title><xsl:value-of select="t:fileName"/></title>
								<description><xsl:value-of select="t:docDescription"/></description>
								<url><xsl:value-of select="t:url"/></url>
								<!-- <datePublished> -->
								<!-- <dateModified> -->
								<!-- <format> -->
								<language>ru</language>
							</documents>
						</xsl:for-each>
						<!-- <milestones> -->
						<!-- <amendment> -->
					</tender>
					<!-- <buyer> -->
					<!-- <awards> -->
					<!-- <contracts> -->
					<language>ru</language>
					<!-- Extended -->
					<x-source><xsl:copy-of select="/"/></x-source>
				</release>
			</xsl:when>
			
			<xsl:when test="/e:export/e:contract[@schemeVersion=1.0] and /*/*/t:foundation/t:fcsOrder/t:placing=9">
				<release>
					<!-- Required -->
					<ocid>ocds-btbroot01-<xsl:value-of select="/*/*/t:foundation/t:fcsOrder/t:notificationNumber"/></ocid>
					<id><xsl:value-of select="/*/*/t:id"/></id>
					<date><xsl:value-of select="/*/*/t:publishDate"/></date>
					<tag>contract<xsl:if test="/*/*/t:modification">Amendment</xsl:if></tag>
					<initiationType>tender</initiationType>
					<!-- Optional -->
					<planning>
						<!-- Optional -->
						<budget>
							<!-- Optional -->
							<!-- <source> -->
							<id><xsl:value-of select="/*/*/t:finances/t:budget/t:code"/></id>
							<description><xsl:value-of select="/*/*/t:finances/t:budget/t:name"/></description>
							<amount>
								<!-- Optional -->
								<amount><xsl:value-of select="sum(/*/*/t:finances/t:budgetary/t:price)"/></amount>
								<currency>RUB</currency>
							</amount>
							<!-- <project> -->
							<!-- <projectID> -->
							<!-- <uri> -->
						</budget>
						<!-- <rationale> -->
						<!-- <documents> -->
						<!-- Extended -->
						<x-extrabudget>
							<!-- Optional -->
							<!-- <source> -->
							<id><xsl:value-of select="/*/*/t:finances/t:extrabudget/t:code"/></id>
							<description><xsl:value-of select="/*/*/t:finances/t:extrabudget/t:name"/></description>
							<amount>
								<!-- Optional -->
								<amount><xsl:value-of select="sum(/*/*/t:finances/t:extrabudgetary/t:price)"/></amount>
								<currency>RUB</currency>
							</amount>
							<!-- <project> -->
							<!-- <projectID> -->
							<!-- <uri> -->
						</x-extrabudget>
					</planning>
					<!-- <tender> -->
					<!-- <buyer> -->
					<awards>
						<!-- Required -->
						<id><xsl:value-of select="/*/*/t:regNum"/></id>
						<!-- Optional -->
						<!-- <title> -->
						<!-- <description> -->
						<!-- <status> -->
						<!-- <date> -->
						<value>
							<!-- Optional -->
							<amount><xsl:value-of select="/*/*/t:price"/></amount>
							<currency><xsl:value-of select="/*/*/t:currency/t:code"/></currency>
						</value>
						<xsl:for-each select="/*/*/t:suppliers/t:supplier">
							<suppliers>
								<!-- Optional -->
								<identifier>
									<!-- Optional -->
									<scheme>x-ИНН</scheme>
									<id><xsl:value-of select="t:inn"/></id>
									<legalName><xsl:value-of select="concat(t:legalForm/t:singularName, ' ', t:organizationName)"/></legalName>
									<!-- <uri> -->
								</identifier>
								<additionalIdentifiers>
									<!-- Optional -->
									<scheme>x-КПП</scheme>
									<id><xsl:value-of select="t:kpp"/></id>
									<!-- <legalName> -->
									<!-- <uri> -->
								</additionalIdentifiers>
								<additionalIdentifiers>
									<!-- Optional -->
									<!-- <scheme> -->
									<id><xsl:value-of select="t:idNumber"/></id>
									<!-- <legalName> -->
									<!-- <uri> -->
								</additionalIdentifiers>
								<additionalIdentifiers>
									<!-- Optional -->
									<!-- <scheme> -->
									<id><xsl:value-of select="t:idNumberExtension"/></id>
									<!-- <legalName> -->
									<!-- <uri> -->
								</additionalIdentifiers>
								<name><xsl:value-of select="t:firmName"/></name>
								<address>
									<xsl:variable name="address" select="str:split(t:factualAddress, ', ')"/>
									<!-- Optional -->
									<streetAddress>
										<xsl:for-each select="$address">
											<xsl:if test="position() > 3">
												<xsl:value-of select="concat(., ' ')"/>
											</xsl:if>
										</xsl:for-each>
									</streetAddress>
									<locality><xsl:value-of select="$address[3]"/></locality>
									<region><xsl:value-of select="$address[2]"/></region>
									<postalCode><xsl:value-of select="$address[1]"/></postalCode>
									<countryName><xsl:value-of select="t:country/t:countryFullName"/></countryName>
								</address>
								<contactPoint>
									<!-- Optional -->
									<name>
										<xsl:value-of select="concat(
											t:contactInfo/t:lastName, ' ', t:contactInfo/t:firstName, ' ', t:contactInfo/t:middleName
										)"/>
									</name>
									<!-- <email> -->
									<telephone><xsl:value-of select="t:contactPhone"/></telephone>
									<!-- <faxNumber> -->
									<!-- <uri> -->
								</contactPoint>
								<!-- Extended -->
								<x-mailAddress>
									<xsl:variable name="address" select="str:split(t:postAddress, ', ')"/>
									<!-- Optional -->
									<streetAddress>
										<xsl:for-each select="$address">
											<xsl:if test="position() > 3">
												<xsl:value-of select="concat(., ' ')"/>
											</xsl:if>
										</xsl:for-each>
									</streetAddress>
									<locality><xsl:value-of select="$address[3]"/></locality>
									<region><xsl:value-of select="$address[2]"/></region>
									<postalCode><xsl:value-of select="$address[1]"/></postalCode>
									<countryName><xsl:value-of select="t:country/t:countryFullName"/></countryName>
								</x-mailAddress>
							</suppliers>
						</xsl:for-each>
						<xsl:for-each select="/*/*/t:products/t:product">
							<items>
								<!-- Required -->
								<id><xsl:value-of select="t:name"/></id>
								<!-- Optional -->
								<description><xsl:value-of select="t:name"/></description>
								<classification>
									<!-- Optional -->
									<scheme>x-ОКПД</scheme>
									<id><xsl:value-of select="t:OKPD/t:code"/></id>
									<description><xsl:value-of select="t:OKPD/t:name"/></description>
									<!-- <uri> -->
								</classification>
								<!-- <additionalClassifications> -->
								<quantity><xsl:value-of select="t:quantity/t:value"/></quantity>
								<unit>
									<!-- Optional -->
									<name><xsl:value-of select="t:OKEI/t:nationalCode"/></name>
									<value>
										<!-- Optional -->
										<amount><xsl:value-of select="t:price"/></amount>
										<currency><xsl:value-of select="/*/*/t:currency/t:code"/></currency>
									</value>
								</unit>
							</items>
						</xsl:for-each>
						<!-- <contractPeriod> -->
						<!-- <documents> -->
						<!-- <amendment> -->
					</awards>
					<contracts>
						<!-- Required -->
						<id><xsl:value-of select="/*/*/t:regNum"/></id>
						<awardId><xsl:value-of select="/*/*/t:regNum"/></awardId>
						<!-- Optional -->
						<!-- <title> -->
						<!-- <description> -->
						<!-- <status> -->
						<period>
							<!-- Optional -->
							<!-- <startDate> -->
							<endDate><xsl:value-of select="concat(/*/*/t:executionDate/t:year, '-', /*/*/t:executionDate/t:month, '-01')"/></endDate>
						</period>
						<value>
							<!-- Optional -->
							<amount><xsl:value-of select="/*/*/t:price"/></amount>
							<currency><xsl:value-of select="/*/*/t:currency/t:code"/></currency>
						</value>
						<!-- <items> -->
						<dateSigned><xsl:value-of select="/*/*/t:signDate"/></dateSigned>
						<documents>
							<!-- Required -->
							<id>__self__</id>
							<!-- Optional -->
							<documentType>Contract notice</documentType>
							<title>Этот документ</title>
							<url><xsl:value-of select="/*/*/t:href"/></url>
							<datePublished><xsl:value-of select="/*/*/t:publishDate"/></datePublished>
							<!-- <dateModified> -->
							<format>text/html</format>
							<language>ru</language>
						</documents>
						<documents>
							<!-- Required -->
							<id>__print__</id>
							<!-- Optional -->
							<documentType>Contract notice</documentType>
							<title>Этот документ (для печати)</title>
							<url><xsl:value-of select="/*/*/t:printForm"/></url>
							<datePublished><xsl:value-of select="/*/*/t:publishDate"/></datePublished>
							<!-- <dateModified> -->
							<format>text/html</format>
							<language>ru</language>
						</documents>
						<xsl:for-each select="/*/*/t:attachments/t:attachment | /*/*/t:scanDocuments/t:attachment | /*/*/t:medicalDocuments/t:attachment">
							<documents>
								<!-- Required -->
								<id><xsl:value-of select="t:fileName"/></id>
								<!-- Optional -->
								<documentType>Contract notice</documentType>
								<title><xsl:value-of select="t:fileName"/></title>
								<description><xsl:value-of select="t:docDescription"/></description>
								<url><xsl:value-of select="t:url"/></url>
								<!-- <datePublished> -->
								<!-- <dateModified> -->
								<!-- <format> -->
								<language>ru</language>
							</documents>
						</xsl:for-each>
						<!-- <amendment> -->
						<!-- <implementation> -->
					</contracts>
					<language>ru</language>
					<x-source><xsl:copy-of select="/"/></x-source>
				</release>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message terminate="yes">Unrecognized input type.</xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet> 
