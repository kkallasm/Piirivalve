<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="ee.itcollege.jejee.entities.Piiriloik"%>
<%@page import="ee.itcollege.jejee.entities.Intsident"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib  uri="http://www.springframework.org/tags/form" prefix="fo" %>
<%@ taglib tagdir="/WEB-INF/tags/form/fields" prefix="field" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Intsidendid piiril�igul</title>
</head>
<body>

<div id="ipiir_wrapper">
	<div id="ylemine_div">
		<spring:url value="/ipiir" var="url" />
		<fo:form action="${url}" method="GET" commandName="piirivalvur_intsidendis_abi" >
			<table>
				<tr>
					<td>
						<field:datetime id="alates" field="alates" dateTimePattern="yyyy-MM-dd" label="Alates" ></field:datetime>
					</td>
					<td>
						<field:datetime id="kuni" field="kuni" dateTimePattern="yyyy-MM-dd" label="Kuni"></field:datetime>
					</td>
					<td>
						<fo:select path="piiriloik_ID" style="width:100px" itemLabel="Piiril�ik">
						<fo:option value="0">---</fo:option>
						<c:forEach var="piir" items="${piiriloiks}">
							<fo:option value="${piir.id}">${piir.nimetus}</fo:option>
						</c:forEach>
						</fo:select>
					</td>
					<td width="100px">
						<input type="submit" name="mysubmit" value="V�rskenda" />
					</td>
				</tr>
			</table>
		</fo:form>	
	</div>
	
	<div id="alumine_div">
	<c:forEach var="ints" items="${ints_piiriloigul_piirivalvur}">
		<div>
		<table>
			<tr>
				<th>${ints.piirivalvur.soduri_kood}: ${ints.piirivalvur.perekonnanimi}, ${ints.piirivalvur.eesnimed}</th>
    			<th></th>
			</tr>
						
			<c:forEach var="i" items="${ints.pints_arr}" >
				<tr>
					<td width="500px">
						${i.intsident.nimetus}
					</td>
					<td>
						<spring:url value="/detail/${i.id}/p/${i.piirivalvur.id}" var="url" />
						<input type="button" name="btn" value="Vaata" onclick="window.location='${url}'" />
					</td>
				</tr>
			</c:forEach>
			
			<tr>
				<td height="10px"></td>
				<td></td>
			</tr>
			<tr>
				<td>
					<i>intsidente kokku - ${ints.kogus}</i>
				</td>
				<td>
				
				</td>
			</tr>
			
		</table>
		</div>
		<br/>
	</c:forEach>
	
	</div>
</div>

</body>
</html>