<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright 2015 Al Nikolov -->

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:t="http://zakupki.gov.ru/oos/types/1"
	xmlns:e="http://zakupki.gov.ru/oos/export/1"
>

	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="/e:export/e:fcsNotificationZK[@schemeVersion=1.0] and /e:export/e:fcsNotificationZK/t:placingWay/t:code='ZK44'">
				<!-- Required -->
				<xsl:variable name="prefix" select="/e:export/e:fcsNotificationZK"/>
				<prerelease>
					<ocid><xsl:value-of select="$prefix/t:purchaseNumber"/></ocid>
					<id><xsl:value-of select="$prefix/t:id"/></id>
					<date><xsl:value-of select="$prefix/t:docPublishDate"/></date>
					<tag>tender<xsl:if test="$prefix/t:modification">Amendment</xsl:if></tag>
					<initiationType>tender</initiationType>
					<!-- Optional -->
					<!-- <planning> -->
					<tender>
						<!-- Required -->
						<id><xsl:value-of select="$prefix/t:purchaseNumber"/></id>
						<!-- Optional -->
						<title><xsl:value-of select="$prefix/t:purchaseObjectInfo"/></title>
						<!-- <description> -->
						<status>active</status>
						<items>
							<xsl:for-each select="$prefix/t:lot/t:purchaseObjects/t:purchaseObject">
								<item>
									<!-- Required -->
									<id><xsl:value-of select="concat('position-', position())"/></id>
									<!-- Optional -->
									<description><xsl:value-of select="t:name"/></description>
									<classification>
										<!-- Optional -->
										<scheme>x-ОКПД</scheme>
										<id><xsl:value-of select="t:OKPD/t:code"/></id>
										<description><xsl:value-of select="t:OKPD/t:name"/></description>
										<!-- <uri> -->
									</classification>
									<!-- <additionalClassification> -->
									<quantity><xsl:value-of select="t:quantity/t:value"/></quantity>
									<unit>
										<!-- Optional -->
										<name><xsl:value-of select="t:OKEI/t:nationalCode"/></name>
										<value>
											<!-- Optional -->
											<amount><xsl:value-of select="t:price"/></amount>
											<currency><xsl:value-of select="$prefix/t:lot/t:currency/t:code"/></currency>
										</value>
									</unit>
								</item>
							</xsl:for-each>
						</items>
						<!-- <minValue> -->
						<value>
							<!-- Optional -->
							<amount><xsl:value-of select="$prefix/t:lot/t:maxPrice"/></amount>
							<currency><xsl:value-of select="$prefix/t:lot/t:currency/t:code"/></currency>
						</value>
						<procurementMethod>selective</procurementMethod>
						<!-- <procurementMethodRationale> -->
						<awardCriteria>lowestCost</awardCriteria>
						<awardCriteriaDetails>
							Преимущества:
							<xsl:for-each select="$prefix/t:lot/t:preferenses/t:preferense">
								Код: <xsl:value-of select="t:code"/>;
								Наименование: <xsl:value-of select="t:name"/>;
								Величина: <xsl:value-of select="t:prefValue"/>;
								---
							</xsl:for-each>
						</awardCriteriaDetails>
						<submissionMethod>electronicSubmission</submissionMethod>
						<submissionMethod>inPerson</submissionMethod>
						<submissionMethod>written</submissionMethod>
						<submissionMethodDetails>
							Место: <xsl:value-of select="$prefix/t:procedureInfo/t:collecting/t:place"/>;
							Порядок: <xsl:value-of select="$prefix/t:procedureInfo/t:collecting/t:order"/>;
							Форма: <xsl:value-of select="$prefix/t:procedureInfo/t:collecting/t:form"/>;
						</submissionMethodDetails>
						<tenderPeriod>
							<!-- Optional -->
							<startDate><xsl:value-of select="$prefix/t:procedureInfo/t:collecting/t:startDate"/></startDate>
							<endDate><xsl:value-of select="$prefix/t:procedureInfo/t:collecting/t:endDate"/></endDate>
						</tenderPeriod>
						<!-- <enquiryPeriod> -->
						<!-- <hasEnquiries> -->
						<eligibilityCriteria>
							<xsl:for-each select="$prefix/t:lot/t:requirements/t:requirement">
								Код: <xsl:value-of select="t:code"/>;
								Наименование: <xsl:value-of select="t:name"/>;
								Содержание: <xsl:value-of select="t:content"/>;
								---
							</xsl:for-each>
						</eligibilityCriteria>
						<!-- <awardPeriod> -->
						<!-- <numberOfTenderers> -->
						<!-- <tenderers> -->
						<procuringEntity>
							<!-- Optional -->
							<identifier>
								<!-- Optional -->
								<scheme>x-СПЗ</scheme>
								<id><xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleOrg/t:regNum"/></id>
								<legalName><xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleOrg/t:fullName"/></legalName>
								<!-- <uri> -->
							</identifier>
							<additionalIdentifiers>
								<identifier>
									<!-- Optional -->
									<scheme>x-ИНН</scheme>
									<id><xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleOrg/t:INN"/></id>
									<!-- <legalName> -->
									<!-- <uri> -->
								</identifier>
								<identifier>
									<!-- Optional -->
									<scheme>x-КПП</scheme>
									<id><xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleOrg/t:KPP"/></id>
									<!-- <legalName> -->
									<!-- <uri> -->
								</identifier>
							</additionalIdentifiers>
							<name><xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleOrg/t:fullName"/></name>
							<address>
								<!-- Optional -->
								<streetAddress><xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleOrg/t:factAddress"/></streetAddress>
								<!-- <locality> -->
								<!-- <region> -->
								<!-- <postalCode> -->
								<countryName>Российская Федерация</countryName>
							</address>
							<contactPoint>
								<!-- Optional -->
								<name>
									Адрес: <xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleInfo/t:orgFactAddress"/>;
									Почтовый адрес: <xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleInfo/t:orgPostAddress"/>;
									Фамилия: <xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleInfo/t:contactPerson/t:lastName"/>;
									Имя: <xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleInfo/t:contactPerson/t:firstName"/>;
									Отчество: <xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleInfo/t:contactPerson/t:middleName"/>; 									</name>
								<email><xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleInfo/t:contactEMail"/></email>
								<telephone><xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleInfo/t:contactPhone"/></telephone>
								<faxNumber><xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleInfo/t:contactFax"/></faxNumber>
								<!-- <uri> -->
							</contactPoint>
							<!-- Extended -->
							<x-mailAddress>
								<!-- Optional -->
								<streetAddress><xsl:value-of select="$prefix/t:purchaseResponsible/t:responsibleOrg/t:postAddress"/></streetAddress>
								<!-- <locality> -->
								<!-- <region> -->
								<!-- <postalCode> -->
								<countryName>Российская Федерация</countryName>
							</x-mailAddress>
						</procuringEntity>
						<documents>
							<document>
								<!-- Required -->
								<id><xsl:value-of select="$prefix/t:id"/></id>
								<!-- Optional -->
								<!-- <documentType> -->
								<title>Этот документ</title>
								<url><xsl:value-of select="$prefix/t:href"/></url>
								<!-- <datePublished> -->
								<!-- <dateModified> -->
								<!-- <format> -->
								<language>ru</language>
							</document>
							<xsl:for-each select="$prefix/t:attachments/t:attachment">
								<document>
									<!-- Required -->
									<id><xsl:value-of select="concat('position-', position())"/></id>
									<!-- Optional -->
									<!-- <documentType> -->
									<title><xsl:value-of select="t:fileName"/></title>
									<description><xsl:value-of select="t:docDescription"/></description>
									<url><xsl:value-of select="t:url"/></url>
									<!-- <datePublished> -->
									<!-- <dateModified> -->
									<!-- <format> -->
									<language>ru</language>
								</document>
							</xsl:for-each>
						</documents>
						<milestones>
							<xsl:for-each select="$prefix/t:lot/t:customerRequirements/t:customerRequirement">
								<milestone>
									<!-- Required -->
									<id><xsl:value-of select="concat('position-', position())"/></id>
									<!-- Optional -->
									<title>Доставка товара, выполнение работы или оказание услуги</title>
									<description>
										Место: <xsl:value-of select="t:deliveryPlace"/>;
										Срок:  <xsl:value-of select="t:deliveryTerm"/>
									</description>
									<!-- <dueDate> -->
									<!-- <dateModified> -->
									<status>notMet</status>
									<!-- <documents> -->
								</milestone>
							</xsl:for-each>
						</milestones>
						<!-- <amendment> -->
					</tender>
					<!-- <buyer> -->
					<!-- <awards> -->
					<!-- <contracts> -->
					<language>ru</language>
					<!-- Extended -->
					<x-buyers>
						<xsl:for-each select="$prefix/t:lot/t:customerRequirements/t:customerRequirement">
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
						</xsl:for-each>
					</x-buyers>
					<x-source><xsl:copy-of select="/"/></x-source>
				</prerelease>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message terminate="yes">Unrecognized input type.</xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet> 
