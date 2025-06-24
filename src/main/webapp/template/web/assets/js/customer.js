document.addEventListener('DOMContentLoaded', function() {
    // Sample data for pets and food
    const petsData = {
        dogs: [
            { id: 1, name: "Buddy", breed: "Labrador", age: 12, price: 800, image: "https://images.unsplash.com/photo-1586671267731-da2cf3ceeb80?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", description: "Friendly and playful Labrador puppy" },
            { id: 2, name: "Max", breed: "Poodle", age: 24, price: 1200, image: "https://images.unsplash.com/photo-1594149929911-78975a43d4f5?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", description: "Smart and elegant standard poodle" },
            { id: 3, name: "Charlie", breed: "Beagle", age: 18, price: 600, image: "https://images.unsplash.com/photo-1505628346881-b72b27e84530?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", description: "Curious and friendly beagle" }
        ],
        cats: [
            { id: 4, name: "Luna", breed: "Siamese", age: 8, price: 400, image: "https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", description: "Beautiful blue-eyed Siamese" },
            { id: 5, name: "Oliver", breed: "Persian", age: 36, price: 700, image: "https://images.unsplash.com/photo-1533738363-b7f9aef128ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", description: "Fluffy and regal Persian cat" },
            { id: 6, name: "Leo", breed: "Bengal", age: 12, price: 900, image: "https://images.unsplash.com/photo-1592194996308-7b43878e84b6?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", description: "Energetic and spotted Bengal" }
        ],
        bunnies: [
            { id: 7, name: "Coco", breed: "Dutch", age: 4, price: 80, image: "https://images.unsplash.com/photo-1556838803-cc94986cb631?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", description: "Adorable Dutch bunny with perfect markings" },
            { id: 8, name: "Snowball", breed: "Lionhead", age: 8, price: 120, image: "https://images.unsplash.com/photo-1469532773895-0d5d14a49c06?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", description: "Fluffy Lionhead bunny with a mane" },
            { id: 9, name: "Thumper", breed: "Flemish Giant", age: 6, price: 150, image: "https://images.unsplash.com/photo-1585969646097-a1b0038c37a1?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", description: "Large and gentle Flemish Giant" }
        ]
    };

    const foodData = [
        { id: 10, name: "Royal Canin Dog Food", type: "dog", brand: "Royal Canin", size: "5kg", price: 45, image: "https://images.unsplash.com/photo-1589927986089-35812388d1f4?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", description: "Premium dog food for all breeds" },
        { id: 11, name: "Purina Cat Chow", type: "cat", brand: "Purina", size: "3kg", price: 25, image: "https://images.unsplash.com/photo-1628840042765-356cda07504e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", description: "Complete nutrition for adult cats" },
        { id: 12, name: "Hills Science Diet Bunny Food", type: "bunny", brand: "Hills Science Diet", size: "2kg", price: 18, image: "https://m.media-amazon.com/images/I/81hCyBvQD5L._AC_UF1000,1000_QL80_.jpg", description: "Specially formulated for rabbits" },
        { id: 13, name: "Iams Proactive Health Dog Food", type: "dog", brand: "Iams", size: "10kg", price: 65, image: "https://images.unsplash.com/photo-1607623488994-03c5d9785c29?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", description: "Supports healthy digestion" },
        { id: 14, name: "Royal Canin Persian Cat Food", type: "cat", brand: "Royal Canin", size: "4kg", price: 50, image: "https://images.unsplash.com/photo-1628840042765-356cda07504e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", description: "Specially shaped kibble for Persian cats" },
        { id: 15, name: "Oxbow Bunny Basics", type: "bunny", brand: "Oxbow", size: "1kg", price: 12, image: "https://m.media-amazon.com/images/I/71YHjVXyR0L._AC_UF1000,1000_QL80_.jpg", description: "Timothy hay-based pellet food" }
    ];

    // Shopping cart
    let cart = JSON.parse(localStorage.getItem('monitoCart')) || [];
    updateCartCount();

    // Display pets and food
    displayPets('dogs', petsData.dogs);
    displayPets('cats', petsData.cats);
    displayPets('bunnies', petsData.bunnies);
    displayFood(foodData);

    // Set up filters
    setupFilters();

    // Cart button
    const cartBtn = document.getElementById('cart-btn');
    cartBtn.addEventListener('click', function() {
        if (cart.length > 0) {
            localStorage.setItem('monitoCart', JSON.stringify(cart));
            window.location.href = 'payment.html';
        } else {
            alert('Your cart is empty. Please add some items first.');
        }
    });

    function displayPets(type, pets) {
        const grid = document.getElementById(`${type}-grid`);
        grid.innerHTML = '';

        pets.forEach(pet => {
            const card = document.createElement('div');
            card.className = 'pet-card';
            card.innerHTML = `
                <img src="${pet.image}" alt="${pet.name}">
                <h3>${pet.name}</h3>
                <p>Breed: ${pet.breed}</p>
                <p>Age: ${pet.age} months</p>
                <p>Price: $${pet.price}</p>
                <p>${pet.description}</p>
                <button class="add-to-cart" data-id="${pet.id}" data-name="${pet.name}" data-price="${pet.price}">Add to Cart</button>
            `;
            grid.appendChild(card);
        });

        // Add event listeners to add-to-cart buttons
        document.querySelectorAll(`#${type}-grid .add-to-cart`).forEach(button => {
            button.addEventListener('click', function() {
                const id = parseInt(this.getAttribute('data-id'));
                const name = this.getAttribute('data-name');
                const price = parseFloat(this.getAttribute('data-price'));
                
                addToCart(id, name, price, 'pet');
            });
        });
    }

    function displayFood(foodItems) {
        const grid = document.getElementById('food-grid');
        grid.innerHTML = '';

        foodItems.forEach(food => {
            const card = document.createElement('div');
            card.className = 'pet-card';
            card.innerHTML = `
                <img src="${food.image}" alt="${food.name}">
                <h3>${food.name}</h3>
                <p>Brand: ${food.brand}</p>
                <p>Size: ${food.size}</p>
                <p>Price: $${food.price}</p>
                <p>${food.description}</p>
                <button class="add-to-cart" data-id="${food.id}" data-name="${food.name}" data-price="${food.price}">Add to Cart</button>
            `;
            grid.appendChild(card);
        });

        // Add event listeners to add-to-cart buttons
        document.querySelectorAll('#food-grid .add-to-cart').forEach(button => {
            button.addEventListener('click', function() {
                const id = parseInt(this.getAttribute('data-id'));
                const name = this.getAttribute('data-name');
                const price = parseFloat(this.getAttribute('data-price'));
                
                addToCart(id, name, price, 'food');
            });
        });
    }

    function setupFilters() {
        // Dogs filter
        document.getElementById('dog-filter').addEventListener('change', function() {
            filterPets('dogs', petsData.dogs);
        });
        document.getElementById('dog-age-filter').addEventListener('change', function() {
            filterPets('dogs', petsData.dogs);
        });
        document.getElementById('dog-price-filter').addEventListener('change', function() {
            filterPets('dogs', petsData.dogs);
        });

        // Cats filter
        document.getElementById('cat-filter').addEventListener('change', function() {
            filterPets('cats', petsData.cats);
        });
        document.getElementById('cat-age-filter').addEventListener('change', function() {
            filterPets('cats', petsData.cats);
        });
        document.getElementById('cat-price-filter').addEventListener('change', function() {
            filterPets('cats', petsData.cats);
        });

        // Bunnies filter
        document.getElementById('bunny-filter').addEventListener('change', function() {
            filterPets('bunnies', petsData.bunnies);
        });
        document.getElementById('bunny-age-filter').addEventListener('change', function() {
            filterPets('bunnies', petsData.bunnies);
        });
        document.getElementById('bunny-price-filter').addEventListener('change', function() {
            filterPets('bunnies', petsData.bunnies);
        });

        // Food filter
        document.getElementById('food-type-filter').addEventListener('change', function() {
            filterFood(foodData);
        });
        document.getElementById('food-brand-filter').addEventListener('change', function() {
            filterFood(foodData);
        });
        document.getElementById('food-size-filter').addEventListener('change', function() {
            filterFood(foodData);
        });
    }

    function filterPets(type, pets) {
        const breedFilter = document.getElementById(`${type}-filter`).value;
        const ageFilter = document.getElementById(`${type}-age-filter`).value;
        const priceFilter = document.getElementById(`${type}-price-filter`).value;

        let filteredPets = [...pets];

        if (breedFilter !== 'all') {
            filteredPets = filteredPets.filter(pet => pet.breed.toLowerCase() === breedFilter.toLowerCase());
        }

        if (ageFilter !== 'all') {
            if (ageFilter === 'puppy' || ageFilter === 'kitten' || ageFilter === 'baby') {
                filteredPets = filteredPets.filter(pet => pet.age <= 12);
            } else if (ageFilter === 'young') {
                filteredPets = filteredPets.filter(pet => pet.age > 12 && pet.age <= 36);
            } else if (ageFilter === 'adult') {
                filteredPets = filteredPets.filter(pet => pet.age > 36);
            }
        }

        if (priceFilter !== 'all') {
            if (priceFilter === 'low') {
                filteredPets = filteredPets.filter(pet => pet.price < (type === 'dogs' ? 500 : (type === 'cats' ? 300 : 100)));
            } else if (priceFilter === 'medium') {
                filteredPets = filteredPets.filter(pet => 
                    pet.price >= (type === 'dogs' ? 500 : (type === 'cats' ? 300 : 100)) && 
                    pet.price <= (type === 'dogs' ? 1000 : (type === 'cats' ? 600 : 200)));
            } else if (priceFilter === 'high') {
                filteredPets = filteredPets.filter(pet => pet.price > (type === 'dogs' ? 1000 : (type === 'cats' ? 600 : 200)));
            }
        }

        displayPets(type, filteredPets);
    }

    function filterFood(foodItems) {
        const typeFilter = document.getElementById('food-type-filter').value;
        const brandFilter = document.getElementById('food-brand-filter').value;
        const sizeFilter = document.getElementById('food-size-filter').value;

        let filteredFood = [...foodItems];

        if (typeFilter !== 'all') {
            filteredFood = filteredFood.filter(food => food.type === typeFilter);
        }

        if (brandFilter !== 'all') {
            filteredFood = filteredFood.filter(food => food.brand.toLowerCase().replace(' ', '-') === brandFilter);
        }

        if (sizeFilter !== 'all') {
            if (sizeFilter === 'small') {
                filteredFood = filteredFood.filter(food => parseFloat(food.size) <= 5);
            } else if (sizeFilter === 'medium') {
                filteredFood = filteredFood.filter(food => parseFloat(food.size) > 5 && parseFloat(food.size) <= 10);
            } else if (sizeFilter === 'large') {
                filteredFood = filteredFood.filter(food => parseFloat(food.size) > 10);
            }
        }

        displayFood(filteredFood);
    }

    function addToCart(id, name, price, type) {
        // Check if item already in cart
        const existingItem = cart.find(item => item.id === id);
        
        if (existingItem) {
            existingItem.quantity += 1;
        } else {
            cart.push({
                id,
                name,
                price,
                type,
                quantity: 1
            });
        }
        
        updateCartCount();
        alert(`${name} added to cart!`);
    }

    function updateCartCount() {
        const count = cart.reduce((total, item) => total + item.quantity, 0);
        document.getElementById('cart-count').textContent = count;
    }
});