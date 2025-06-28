<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            background: #4CAF50;
            color: white;
        }
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .pet-section {
            background-color: white;
            padding: 1rem;
            margin-bottom: 2rem;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .pet-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px;
        }
        .pet-card {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 8px;
            background: white;
            text-align: center;
        }
        .pet-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .btn {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn:hover {
            background: #45a049;
        }
        .cart-icon {
            cursor: pointer;
            position: relative;
            display: inline-block;
            margin-right: 1rem;
        }
        .cart-count {
            position: absolute;
            top: -5px;
            right: -10px;
            background: red;
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 0.8rem;
        }
        input, select {
            width: 100%;
            font-size: 1rem;
            padding: 0.4rem;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        input:focus, select:focus {
            outline: none;
            border: 1px solid #4CAF50;
            box-shadow: 0 0 2px #4CAF50;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Monito Pet Shop - Customer</h1>
        <div class="user-info">
            <c:choose>
                <c:when test="${not empty sessionScope.username}">
                    <span>Welcome, ${sessionScope.username}!</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn">Login</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div style="text-align:center; margin: 2rem 0;">
        <a href="${pageContext.request.contextPath}/cart" class="btn" style="font-size:1.2rem; padding: 14px 32px; background: #ffc107; color: #000; border-radius: 6px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); font-weight: bold; letter-spacing: 1px;">🛒 View Cart</a>
    </div>

    <div class="container">
        <!-- Filter Form -->
        <div class="pet-section" style="margin-bottom:2rem;">
            <form method="get" action="${pageContext.request.contextPath}/shopping" style="display:grid; grid-template-columns: repeat(6, 1fr) 100px; gap:1.2rem; align-items:center; justify-items:start; background:#fafbfa; padding:1.2rem 1rem; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.06);">
                <div style="display:flex; flex-direction:column; width:100%;">
                    <label for="type" style="font-size:1rem; font-weight:bold; margin-bottom:2px;">Type</label>
                    <select name="type" id="type" style="width:100%; font-size:1rem; padding:0.4rem; border-radius:4px;">
                        <option value="">All</option>
                        <c:forEach var="type" items="${petTypes}">
                            <option value="${type}" ${param.type == type ? 'selected' : ''}>${type}</option>
                        </c:forEach>
                    </select>
                </div>
                <div style="display:flex; flex-direction:column; width:100%;">
                    <label for="breed" style="font-size:1rem; font-weight:bold; margin-bottom:2px;">Breed</label>
                    <input type="text" name="breed" id="breed" value="${fn:escapeXml(param.breed)}" placeholder="Any breed" style="width:100%; font-size:1rem; padding:0.4rem; border-radius:4px;" />
                </div>
                <div style="display:flex; flex-direction:column; width:100%;">
                    <label for="minPrice" style="font-size:1rem; font-weight:bold; margin-bottom:2px;">Min Price</label>
                    <input type="number" step="0.01" name="minPrice" id="minPrice" value="${fn:escapeXml(param.minPrice)}" min="0" style="width:100%; font-size:1rem; padding:0.4rem; border-radius:4px;" />
                </div>
                <div style="display:flex; flex-direction:column; width:100%;">
                    <label for="maxPrice" style="font-size:1rem; font-weight:bold; margin-bottom:2px;">Max Price</label>
                    <input type="number" step="0.01" name="maxPrice" id="maxPrice" value="${fn:escapeXml(param.maxPrice)}" min="0" style="width:100%; font-size:1rem; padding:0.4rem; border-radius:4px;" />
                </div>
                <div style="display:flex; flex-direction:column; width:100%;">
                    <label for="gender" style="font-size:1rem; font-weight:bold; margin-bottom:2px;">Gender</label>
                    <select name="gender" id="gender" style="width:100%; font-size:1rem; padding:0.4rem; border-radius:4px;">
                        <option value="">All</option>
                        <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                    </select>
                </div>
                <div style="align-self:end; justify-self:end;">
                    <button class="btn" type="submit" style="font-size:1rem; padding:0.6rem 1.6rem; border-radius:4px;">Filter</button>
                </div>
            </form>
        </div>
        <!-- Pet sections will be dynamically loaded -->
        <div class="pet-section">
            <h2>Available Pets</h2>
            <div class="pet-grid" id="pets-grid">
                <!-- Pet cards will be populated here -->
                 <c:if test="${empty petList}">
                            <p>No petList found in request scope.</p>
                        </c:if>
                        <c:if test="${not empty petList and empty petList.listResult}">
                            <p>petList is present, but no pets found.</p>
                </c:if>        
                <c:forEach var="pet" items="${petList.listResult}">
                    <div class="pet-card">                
                        <c:if test="${not empty pet.image}">
                            <img src="data:image/jpeg;base64,${pet.base64Image}" 
                                 alt="${pet.name}" class="pet-image">
                        </c:if>
                        <h3>${pet.name}</h3>
                        <p>Type: ${pet.type}</p>
                        <p>Breed: ${pet.breed}</p>
                        <p>Age: ${pet.age} months</p>
                        <p>Gender: ${pet.gender}</p>
                        <p>Price: $<fmt:formatNumber value="${pet.price}" pattern="#.00"/></p>                       
                        <form action="${pageContext.request.contextPath}/cart" method="post" style="margin-top:10px;">
                            <input type="hidden" name="id" value="${pet.petId}" />
                            <input type="hidden" name="name" value="${pet.name}" />
                            <input type="hidden" name="price" value="${pet.price}" />
                            <button class="btn" type="submit">Add to Cart</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

</body>
</html>
