<?xml version="1.0" encoding="UTF-8"?>
<!-- 
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
-->

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
						<postalCode type="string"><xsl:value-of select="$address[2]"/></postalCode>
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
						<postalCode type="string"><xsl:value-of select="$address[2]"/></postalCode>
						<countryName><xsl:value-of select="$address[1]"/></countryName>
					</x-mailAddress>
				</xsl:variable>

				<release>
					<!-- Required -->
					<ocid>ocds-btbroot01-<xsl:value-of select="/*/*/t:purchaseNumber"/></ocid>
					<id type="string"><xsl:value-of select="/*/*/t:id"/></id>
					<date><xsl:value-of select="/*/*/t:docPublishDate"/></date>
					<tag type="array">
						<element>tender<xsl:if test="/*/*/t:modification">Amendment</xsl:if></element>
					</tag>
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
						<status>active</status>
						<items type="array">
							<xsl:for-each select="/*/*/t:lot/t:purchaseObjects/t:purchaseObject">
								<element>
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
									<!-- <quantity> -->
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
									<x-share type="array">
										<xsl:for-each select="t:customerQuantities/t:customerQuantitie">
											<element>
												<buyer>
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
												</buyer>
												<x-quantity><xsl:value-of select="t:quantity/t:value"/></x-quantity>
											</element>
										</xsl:for-each>
									</x-share>
									<x-quantity><xsl:value-of select="t:quantity/t:value"/></x-quantity>
								</element>
							</xsl:for-each>
						</items>
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
							<url><xsl:value-of select="/*/*/t:printForm/t:url"/></url>
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
					<!-- <buyer> -->
					<!-- <awards> -->
					<!-- <contracts> -->
					<language>ru</language>
					<x-source><xsl:copy-of select="/"/></x-source>
					<!-- Extended -->
					<x-buyers type="array">
						<xsl:choose>
							<xsl:when test="/*/*/t:purchaseResponsible/t:responsibleRole = 'CU'">
								<element><xsl:copy-of select="$procuringEntity"/></element>
							</xsl:when>
							<xsl:otherwise>
								<xsl:for-each select="t:customerQuantities/t:customerQuantitie">
									<element>
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
									</element>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</x-buyers>
				</release>
			</xsl:when>
			
			<xsl:when test="/e:export/e:fcsPurchaseDocument[@schemeVersion=1.0] and /*/*/t:docType/t:code='P'">
				<release>
					<!-- Required -->
					<ocid>ocds-btbroot01-<xsl:value-of select="/*/*/t:purchaseNumber"/></ocid>
					<id type="string"><xsl:value-of select="/*/*/t:id"/></id>
					<date><xsl:value-of select="/*/*/t:docPublishDate"/></date>
					<tag type="array">
						<element>tenderUpdate</element>
					</tag>
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
						<documents type="array">
							<element>
								<!-- Required -->
								<id>__print__</id>
								<!-- Optional -->
								<documentType>evaluationReports</documentType>
								<title>Этот документ (для печати)</title>
								<url><xsl:value-of select="/*/*/t:printForm/t:url"/></url>
								<datePublished><xsl:value-of select="/*/*/t:docPublishDate"/></datePublished>
								<!-- <dateModified> -->
								<format>text/html</format>
								<language>ru</language>
							</element>
							<xsl:for-each select="/*/*/t:attachments/t:attachment">
								<element>
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
								</element>
							</xsl:for-each>
						</documents>
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
					<id type="string"><xsl:value-of select="concat(/*/*/t:regNum, '_', /*/*/t:id)"/></id>
					<date><xsl:value-of select="/*/*/t:publishDate"/></date>
					<tag type="array">
						<element>contract<xsl:if test="/*/*/t:modification">Amendment</xsl:if></element>
					</tag>
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
					<tender>
						<!-- Required -->
						<id><xsl:value-of select="/*/*/t:foundation/t:fcsOrder/t:notificationNumber"/></id>
						<!-- Optional -->
						<!-- <title> -->
						<!-- <description> -->
						<status>complete</status>
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
						<!-- <documents> -->
						<!-- <milestones> -->
						<!-- <amendment> -->
					</tender>
					<!-- <buyer> -->
					<awards type="array">
						<element>
							<!-- Required -->
							<id><xsl:value-of select="/*/*/t:regNum"/></id>
							<!-- Optional -->
							<!-- <title> -->
							<!-- <description> -->
							<status>active</status>
							<!-- <date> -->
							<value>
								<!-- Optional -->
								<amount><xsl:value-of select="/*/*/t:price"/></amount>
								<currency><xsl:value-of select="/*/*/t:currency/t:code"/></currency>
							</value>
							<suppliers type="array">
								<xsl:for-each select="/*/*/t:suppliers/t:supplier">
									<element>
										<!-- Optional -->
										<identifier>
											<!-- Optional -->
											<scheme>x-ИНН</scheme>
											<id><xsl:value-of select="t:inn"/></id>
											<legalName><xsl:value-of select="concat(t:legalForm/t:singularName, ' ', t:organizationName)"/></legalName>
											<!-- <uri> -->
										</identifier>
										<additionalIdentifiers type="array">
											<element>
												<!-- Optional -->
												<scheme>x-КПП</scheme>
												<id><xsl:value-of select="t:kpp"/></id>
												<!-- <legalName> -->
												<!-- <uri> -->
											</element>
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
											<postalCode type="string"><xsl:value-of select="$address[1]"/></postalCode>
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
											<postalCode type="string"><xsl:value-of select="$address[1]"/></postalCode>
											<countryName><xsl:value-of select="t:country/t:countryFullName"/></countryName>
										</x-mailAddress>
									</element>
								</xsl:for-each>
							</suppliers>
							<items type="array">
								<xsl:for-each select="/*/*/t:products/t:product">
									<element>
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
										<!-- <quantity> -->
										<unit>
											<!-- Optional -->
											<name><xsl:value-of select="t:OKEI/t:nationalCode"/></name>
											<value>
												<!-- Optional -->
												<amount><xsl:value-of select="t:price"/></amount>
												<currency><xsl:value-of select="/*/*/t:currency/t:code"/></currency>
											</value>
										</unit>
										<!-- Extended -->
										<x-quantity><xsl:value-of select="t:quantity"/></x-quantity>
									</element>
								</xsl:for-each>
							</items>
							<!-- <contractPeriod> -->
							<!-- <documents> -->
							<!-- <amendment> -->
						</element>
					</awards>
					<contracts type="array">
						<element>
							<!-- Required -->
							<id><xsl:value-of select="/*/*/t:regNum"/></id>
							<awardID><xsl:value-of select="/*/*/t:regNum"/></awardID>
							<!-- Optional -->
							<!-- <title> -->
							<!-- <description> -->
							<status>active</status>
							<period>
								<!-- Optional -->
								<!-- <startDate> -->
								<!-- <endDate> -->
								<!-- Extended -->
								<x-endMonth><xsl:value-of select="concat(/*/*/t:executionDate/t:year, '-', /*/*/t:executionDate/t:month)"/></x-endMonth>
							</period>
							<value>
								<!-- Optional -->
								<amount><xsl:value-of select="/*/*/t:price"/></amount>
								<currency><xsl:value-of select="/*/*/t:currency/t:code"/></currency>
							</value>
							<!-- <items> -->
							<!-- <dateSigned> -->
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
								<url><xsl:value-of select="/*/*/t:printForm/t:url"/></url>
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
							<!-- Extended -->
							<x-buyer>
								<!-- Optional -->
								<identifier>
									<!-- Optional -->
									<scheme>x-СПЗ</scheme>
									<id><xsl:value-of select="/*/*/t:customer/t:regNum"/></id>
									<legalName><xsl:value-of select="/*/*/t:customer/t:fullName"/></legalName>
									<!-- <uri> -->
								</identifier>
								<additionalIdentifiers>
									<!-- Optional -->
									<scheme>x-ИНН</scheme>
									<id><xsl:value-of select="/*/*/t:customer/t:inn"/></id>
									<!-- <legalName> -->
									<!-- <uri> -->
								</additionalIdentifiers>
								<additionalIdentifiers>
									<!-- Optional -->
									<scheme>x-КПП</scheme>
									<id><xsl:value-of select="/*/*/t:customer/t:kpp"/></id>
									<!-- <legalName> -->
									<!-- <uri> -->
								</additionalIdentifiers>
								<name><xsl:value-of select="/*/*/t:customer/t:fullName"/></name>
								<!-- <address> -->
								<!-- <contactPoint> -->
							</x-buyer>
							<x-dateSignedDate><xsl:value-of select="/*/*/t:signDate"/></x-dateSignedDate>
						</element>
					</contracts>
					<language>ru</language>
					<x-source><xsl:copy-of select="/"/></x-source>
				</release>
			</xsl:when>

			<xsl:when test="/e:export/e:contractProcedure[@schemeVersion=1.0]">
				<release>
					<!-- Required -->
					<ocid/>
					<id type="string"><xsl:value-of select="concat(/*/*/t:regNum, '_', /*/*/t:id)"/></id>
					<date><xsl:value-of select="/*/*/t:publishDate"/></date>
					<tag type="array">
						<xsl:if test="/*/*/t:executions/t:finalStageExecution=1 or /*/*/t:terminations">
							<element>contractTermination</element>
						</xsl:if>
						<element>implementationUpdate</element>
					</tag>
					<initiationType>tender</initiationType>
					<!-- Optional -->
					<!-- <planning> -->
					<!-- <tender> -->
					<!-- <buyer> -->
					<!-- <awards> -->
					<contracts type="array">
						<element>
							<!-- Required -->
							<id><xsl:value-of select="/*/*/t:regNum"/></id>
							<awardID><xsl:value-of select="/*/*/t:regNum"/></awardID>
							<!-- Optional -->
							<!-- <title> -->
							<!-- <description> -->
							<xsl:if test="/*/*/t:executions/t:finalStageExecution=1 or /*/*/t:terminations">
								<status>terminated</status>
							</xsl:if>
							<!-- <period> -->
							<!-- <value> -->
							<!-- <items> -->
							<!-- <dateSigned> -->
							<!-- <documents> -->
							<!-- <amendment> -->
							<implementation>
								<!-- Optional -->
								<transactions type="array">
									<xsl:for-each select="/*/*/t:executions/t:execution">
										<xsl:if test="t:paid">
											<element>
												<!-- Required -->
												<id>
													<xsl:value-of select="t:documentName"/>
													<xsl:value-of select="t:documentNum"/>
												</id>
												<!-- Optional -->
												<!-- <source> -->
												<!-- <date> -->
												<amount>
													<!-- Optional -->
													<amount><xsl:value-of select="t:paid"/></amount>
												</amount>
												<!-- <providerOrganization> -->
												<!-- <receiverOrganization> -->
												<!-- <uri> -->
												<!-- Extended -->
												<x-dateDate><xsl:value-of select="t:documentDate"/></x-dateDate>
											</element>
										</xsl:if>
									</xsl:for-each>
								</transactions>
								<!-- <milestones> -->
								<documents type="array">
									<element>
										<!-- Required -->
										<id>__print__</id>
										<!-- Optional -->
										<documentType>physicalProcessReport</documentType>
										<title>Этот документ (для печати)</title>
										<url><xsl:value-of select="/*/*/t:printForm/t:url"/></url>
										<datePublished><xsl:value-of select="/*/*/t:PublishDate"/></datePublished>
										<!-- <dateModified> -->
										<format>text/html</format>
										<language>ru</language>
									</element>
									<xsl:for-each select="/*/*/t:paymentDocuments/t:attachment">
										<element>
											<!-- Required -->
											<id><xsl:value-of select="t:fileName"/></id>
											<!-- Optional -->
											<!-- <documentType> -->
											<title><xsl:value-of select="t:fileName"/></title>
											<description><xsl:value-of select="t:docDescription"/></description>
											<url><xsl:value-of select="t:url"/></url>
											<!-- <datePublished> -->
											<!-- <dateModified> -->
											<!-- <format> -->
											<language>ru</language>
										</element>
									</xsl:for-each>
								</documents>
							</implementation>
						</element>
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
