<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Profile</title>
<jsp:include page="bootstrap.jsp" />
<title>Your Applications</title>
</head>
<body>
<jsp:include page="navbar.jsp"></jsp:include>
<img src="${gravatar}">
<h2><c:out value="${user.firstname} ${user.lastname}"/></h2>
<p>Career Objective: <c:out value="${user.objective}"/></p>
<p>Summary: <c:out value="${user.summary}"/></p>
<p>Contact: <c:out value="${user.phone} ${user.email}"/></p>
<h4>Job History</h4>
<table>
<tr>
<th>Title</th><th>Company</th><th>Description</th><th>From</th><th>To</th>
</tr>
<c:forEach var="job" items="${user.jobs}">
<tr>
<td>${job.title}</td><td>${job.company}</td><td>${job.description}</td>
<td>${job.start}</td><td>${job.end}</td>
</tr>
</c:forEach>
</table>
<h4>Skills</h4>
<table>
<tr>
<th></th><th>Years</th>
</tr>
<c:forEach var="skill" items="${user.skills}">
<tr>
<td>${skill.name}</td><td>${skill.years}</td>
</tr>
</c:forEach>
</table>
<h4>Education</h4>
<table>
<tr>
<th>Institution</th><th>Degree</th><th>Year</th>
</tr>
<c:forEach var="edu" items="${user.education}">
<tr>
<td>${edu.school}</td><td>${edu.degree}</td><td>${edu.year}</td>
</tr>
</c:forEach>
</table>
<h4>Awards</h4>
<table>
<tr>
<th>Award name</th><th>Year Received</th>
</tr>
<c:forEach var="award" items="${user.awards}">
<tr>
<td>${award.name}</td><td>${award.year}</td>
</tr>
</c:forEach>
</table>
</body>
</html>