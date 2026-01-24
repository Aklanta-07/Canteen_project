<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h2 class="section-header">Menu List</h2>
              <form action="">
                <table class="menu-list-table">
                    <thead>
                        <tr>
                            <th>Menu ID</th>
                            <th>Date</th>
                            <th>Meal Type</th>
                            <th>Dish Name</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${users}" var="user" varStatus="index">
                        <tr>
                            <td>${user.MENU_ID}</td>
                            <td><span class="badge badge-breakfast">${user.MENU_DATE}</span></td>
                            <td>${user.MEAL_TYPE}</td>
                            <td>${user.DISH_NAME}</td>
                            <td>${user.Price}</td>
                            <td>${user.AVAILABILITY}</td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-edit">✏️ Edit</button>
                                    <button class="btn-delete">🗑️ Delete</button>
                                </div>
                            </td>
                        </tr>
                     </c:forEach>  
                    </tbody>
                </table>
               </form> 
</body>
</html>