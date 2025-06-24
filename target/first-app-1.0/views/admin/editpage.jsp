<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Pet - Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            margin: 2rem auto;
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 2rem;
            color: #4CAF50;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        input, select, textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            box-sizing: border-box;
        }
        .button-group {
            display: flex;
            gap: 1rem;
        }
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            text-decoration: none;
        }
        .btn-primary {
            background: #4CAF50;
            color: white;
        }
        .btn-primary:hover {
            background: #45a049;
        }
        .btn-cancel {
            background: #dc3545;
            color: white;
        }
        .btn-cancel:hover {
            background: #b52a37;
        }
        input[readonly] {
            background-color: #f4f4f4;
            color: #888;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Pet Details</h2>
        <form action="${pageContext.request.contextPath}/admin-editpage" method="post" enctype="multipart/form-data">
            <input type="hidden" name="petId" value="${pet.petId}">
            <div class="form-group">
                <label for="name">Pet Name</label>
                <input type="text" id="name" name="name" value="${pet.name}" required>
            </div>
            <div class="form-group">
                <label for="type">Type</label>
                <select id="type" name="type" required>
                    <option value="Dog" ${pet.type == 'Dog' ? 'selected' : ''}>Dog</option>
                    <option value="Cat" ${pet.type == 'Cat' ? 'selected' : ''}>Cat</option>
                    <option value="Bird" ${pet.type == 'Bird' ? 'selected' : ''}>Bird</option>
                    <option value="Fish" ${pet.type == 'Fish' ? 'selected' : ''}>Fish</option>
                    <option value="Other" ${pet.type == 'Other' ? 'selected' : ''}>Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="breed">Breed</label>
                <input type="text" id="breed" name="breed" value="${pet.breed}" required>
            </div>
            <div class="form-group">
                <label for="age">Age (months)</label>
                <input type="number" id="age" name="age" value="${pet.age}" required min="0">
            </div>
            <div class="form-group">
                <label for="gender">Gender</label>
                <select id="gender" name="gender" required>
                    <option value="Male" ${pet.gender == 'Male' ? 'selected' : ''}>Male</option>
                    <option value="Female" ${pet.gender == 'Female' ? 'selected' : ''}>Female</option>
                </select>
            </div>
            <div class="form-group">
                <label for="price">Price</label>
                <input type="number" step="0.01" id="price" name="price" value="${pet.price}" required min="0">
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4">${pet.description}</textarea>
            </div>
            <div class="form-group" style="display: flex; flex-direction: column; align-items: flex-start;">
                <label for="image">Pet Image</label>
                <div style="background: #fff; border: 1px solid #ddd; border-radius: 8px; padding: 1rem; width: 100%; display: flex; flex-direction: column; align-items: center;">
                    <c:if test="${not empty pet.image}">
                        <img src="data:image/jpeg;base64,${pet.base64Image}" alt="Current Image" style="max-width:120px; max-height:120px; display:block; margin-bottom:0.5rem; border-radius:8px; border:1px solid #ddd; background:#fff;" />
                        <p style="color:#888; font-size:0.95em;">Current image shown above. Select a new image to replace.</p>
                    </c:if>
                    <input type="file" id="image" name="image" accept="image/*" style="width:100%;">
                </div>
            </div>
            <div class="form-group">
                <label for="addedBy">Added By</label>
                <input type="text" id="addedBy" name="addedBy" value="${pet.addedBy}" readonly>
            </div>
            <div class="button-group">
                <button type="submit" class="btn btn-primary">Update Pet</button>
                <a href="${pageContext.request.contextPath}/admin-home" class="btn btn-cancel">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>