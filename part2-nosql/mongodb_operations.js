// Switch to FlexiMart database
use fleximart_nosql;

// =====================================================
// Operation 1: Load Data
// Import products_catalog.json into products collection
// =====================================================

// Run this command in terminal (not inside mongosh):
// mongoimport --db fleximart_nosql --collection products --file products_catalog.json --jsonArray


// =====================================================
// Operation 2: Basic Query
// Find all Electronics products with price < 50000
// Return only name, price, and stock
// =====================================================

db.products.find(
  {
    category: "Electronics",
    price: { $lt: 50000 }
  },
  {
    _id: 0,
    name: 1,
    price: 1,
    stock: 1
  }
);


// =====================================================
// Operation 3: Review Analysis
// Find products with average rating >= 4.0
// =====================================================

db.products.aggregate([
  {
    $addFields: {
      average_rating: { $avg: "$reviews.rating" }
    }
  },
  {
    $match: {
      average_rating: { $gte: 4.0 }
    }
  },
  {
    $project: {
      _id: 0,
      name: 1,
      category: 1,
      average_rating: 1
    }
  }
]);


// =====================================================
// Operation 4: Update Operation
// Add a new review to product ELEC001
// =====================================================

db.products.updateOne(
  { product_id: "ELEC001" },
  {
    $push: {
      reviews: {
        user_id: "U999",
        username: "ValueSeeker",
        rating: 4,
        comment: "Good value",
        date: new Date()
      }
    }
  }
);


// =====================================================
// Operation 5: Complex Aggregation
// Calculate average price by category
// =====================================================

db.products.aggregate([
  {
    $group: {
      _id: "$category",
      avg_price: { $avg: "$price" },
      product_count: { $sum: 1 }
    }
  },
  {
    $project: {
      _id: 0,
      category: "$_id",
      avg_price: 1,
      product_count: 1
    }
  },
  {
    $sort: { avg_price: -1 }
  }
]);
