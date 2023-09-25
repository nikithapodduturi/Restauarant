const express = require('express');
const mysql = require('mysql2/promise');
const app = express();
const port = process.env.PORT || 5000;
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { sendConfirmationEmail } = require('../src/Components/email');

// Create a MySQL connection pool
const pool = mysql.createPool({
    host: 'localhost',
    user: 'nikitha',
    password: '1234',
    database: 'restaurants',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});


app.use(express.json());

//1. Endpoint for retrieving all restaurants or filtered and sorted restaurants
app.get('/api/restaurants', async (req, res) => {
    const query = req.query;
    const filters = [];
    const sortingOptions = [];

    if (query.cuisine) {
        filters.push(`Cuisine = '${query.cuisine}'`);
    }

    if (query.rating) {
        filters.push(`Rating >= ${query.rating}`);
    }

    if (query.location) {
        filters.push(`Location = '${query.location}'`);
    }

    // Define sorting options based on the 'sort' query parameter
    if (query.sort) {
        const sortCriteria = query.sort.split(',');

        sortCriteria.forEach(criteria => {
            switch (criteria) {
                case 'name_asc':
                    sortingOptions.push('Name ASC');
                    break;
                case 'name_desc':
                    sortingOptions.push('Name DESC');
                    break;
                case 'rating_asc':
                    sortingOptions.push('Rating ASC');
                    break;
                case 'rating_desc':
                    sortingOptions.push('Rating DESC');
                    break;
                default:
                    break;
            }
        });
    }

    let sql = 'SELECT * FROM Restaurant';

    if (filters.length > 0) {
        sql += ' WHERE ' + filters.join(' AND ');
    }

    if (sortingOptions.length > 0) {
        sql += ` ORDER BY ${sortingOptions.join(', ')}`;
    }

    try {
        const [results] = await pool.query(sql);
        res.json(results);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'An error occurred while fetching restaurants' });
    }
});

//3. Endpoint filtering
app.get('/api/restaurants/filter', async (req, res) => {
    try {
      const { cuisine, deliveryoptions } = req.query;
  
      // Build the SQL query dynamically based on the filter criteria
      let sql = 'SELECT * FROM restaurant WHERE 1';
      const params = [];
  
      if (cuisine) {
        sql += ' AND cuisine = ?';
        params.push(cuisine);
      }
      if (deliveryoptions) {
        sql += ' AND deliveryoptions = ?';
        params.push(deliveryoptions);
      }
  
      // Execute the SQL query with parameterized queries
      const [results] = await pool.query(sql, params);
  
      res.json(results);
    } catch (error) {
      console.error('Error:', error);
      res.status(500).json({ error: 'Database error' });
    }
});

//4. Endpoint for retrieving the menu of a specific restaurant
app.get('/api/restaurants/:restaurant_id/menu', async (req, res) => {
    const restaurantId = req.params.restaurant_id;

    try {
        // Query menu items and categories for the specific restaurant
        const [categoryResults] = await pool.query('SELECT * FROM Categories WHERE RestaurantID = ?', [restaurantId]);
        const [menuResults] = await pool.query('SELECT * FROM MenuItems WHERE RestaurantID = ?', [restaurantId]);

        if (!categoryResults || !menuResults) {
            return res.status(404).json({ error: 'No menu found for this restaurant' });
        }

        // Organize menu items by category
        const menu = {};
        categoryResults.forEach(category => {
            const categoryId = category.CategoryID;
            menu[categoryId] = {
                categoryName: category.CategoryName,
                items: menuResults.filter(item => item.CategoryID === categoryId).map(item => ({
                    name: item.Name,
                    description: item.Description,
                    price: item.Price
                }))
            };
        });

        res.json(menu);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'An error occurred while fetching the menu' });
    }
});

//5. Endpoint for retrieving restaurant reviews by restaurant ID
app.get('/api/restaurants/:restaurant_id/reviews', async (req, res) => {
    const restaurantId = req.params.restaurant_id;

    try {
        const [results] = await pool.query('SELECT reviewid,restaurantid,rating,comment FROM Reviews WHERE RestaurantID = ?', [restaurantId]);

        if (results.length === 0) {
            res.status(404).json({ error: 'No reviews found for this restaurant' });
        } else {
            res.json(results);
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'An error occurred while fetching reviews' });
    }
});

//6. Endpoint for Searching Restaurants:
app.get('/api/restaurants/search', async (req, res) => {
    // Retrieve query parameters for searching
    const { keywords, cuisine, location } = req.query;

    try {
        // Construct a SQL query based on the search criteria
        let sql = 'SELECT * FROM Restaurant WHERE 1';

        if (keywords) {
            sql += ` AND (Name LIKE '%${keywords}%' OR Description LIKE '%${keywords}%')`;
        }

        if (cuisine) {
            sql += ` AND Cuisine = '${cuisine}'`;
        }

        if (location) {
            sql += ` AND Location = '${location}'`;
        }

        // Execute the query
        const [results] = await pool.query(sql);

        if (results.length === 0) {
            res.status(404).json({ error: 'No restaurants found matching the criteria' });
        } else {
            res.json(results);
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'An error occurred while searching for restaurants' });
    }
});

//7. Endpoint for sorting
app.get('/api/restaurants/sort', async (req, res) => {
    const { sortBy } = req.query;

    try {
        let orderBy = '';

        if (sortBy === 'rating') {
            orderBy = 'rating DESC';
        } else if (sortBy === 'deliveryOptions') {
            orderBy = 'deliveryOptions ASC';
        } else {
            throw new Error('Invalid sorting criteria');
        }

        const sql = `SELECT * FROM restaurant ORDER BY ${orderBy}`;

        // Execute the SQL query to fetch sorted restaurants
       // Execute the SQL query to fetch sorted restaurants
       const [results] = await pool.query(sql);

       res.json(results);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'An error occurred while sorting restaurants' });
    }
});

//8.Endpoint for retrieving restaurant details by restaurant ID
app.get('/api/restaurants/:restaurant_id/details', async (req, res) => {
    const restaurantId = req.params.restaurant_id;

    try {
        const [results] = await pool.query('SELECT name,location,phone,rating,openhours FROM Restaurant WHERE RestaurantID = ?', [restaurantId]);

        if (results.length === 0) {
            res.status(404).json({ error: 'Restaurant not found' });
        } else {
            res.json(results[0]);
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'An error occurred while fetching restaurant details' });
    }
});

// 2.Endpoint for retrieving a single restaurant by ID
app.get('/api/restaurants/:restaurant_id', async (req, res) => {
    const restaurantId = req.params.restaurant_id;

    try {
        const [results] = await pool.query('SELECT * FROM Restaurant WHERE RestaurantID = ?', [restaurantId]);

        if (results.length === 0) {
            res.status(404).json({ error: 'Restaurant not found' });
        } else {
            res.json(results[0]);
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'An error occurred while fetching the restaurant' });
    }
});

app.post('/register', async (req, res) => {
    const { email, password } = req.body;
    
    try {
      // Generate a salt and hash the user's password
      const saltRounds = 10; // Number of salt rounds (adjust as needed)
      const hashedPassword = await bcrypt.hash(password, saltRounds);
  
      const connection = await pool.getConnection();
      const [rows] = await connection.query('INSERT INTO users (email, password) VALUES (?, ?)', [email, hashedPassword]);
      connection.release();
      sendConfirmationEmail(email,"Nikki");
      res.status(201).json({ message: 'User registered successfully' });

    } catch (error) {
      console.error('Error inserting data:', error);
      res.status(500).json({ error: 'Error inserting data' });
    }
  });

app.post('/login', (req, res) => {
    const { email, password } = req.body;
  
    if (!email || !password) {
      return res.status(400).json({ message: 'email and password are required' });
    }
  
    const query = 'SELECT * FROM users WHERE email = ?';
    pool.query(query, [email], (err, results) => {
      if (err) {
        console.error('Database error:', err);
        return res.status(500).json({ message: 'Database error' });
      }
  
      if (results.length === 0) {
        return res.status(401).json({ message: 'Invalid email or password' });
      }
  
      const user = results[0];
  
      bcrypt.compare(password, user.password, (err, isMatch) => {
        if (err) {
          console.error('Authentication error:', err);
          return res.status(500).json({ message: 'Authentication error' });
        }
  
        if (!isMatch) {
          return res.status(401).json({ message: 'Invalid email or password' });
        }
  
        const token = jwt.sign({ userId: user.id, email: user.email }, 'd0c85c618a59e2a2f7e3192a159f2d3f', { expiresIn: '1h' });
        res.json({ token });
      });
    });
  });
  

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});

//just a sample thing