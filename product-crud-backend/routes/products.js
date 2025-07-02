const express = require('express');
const { getPool, sql } = require('../database');
const router = express.Router();

// Validation helper
const validateProduct = (name, price, stock) => {
  const errors = [];
  
  if (!name || name.trim() === '') {
    errors.push('Product name is required and cannot be empty');
  }
  
  if (!price || isNaN(price) || parseFloat(price) <= 0) {
    errors.push('Price must be a positive number');
  }
  
  if (!stock || isNaN(stock) || parseInt(stock) < 0) {
    errors.push('Stock must be a non-negative number');
  }
  
  return errors;
};

// GET all products
router.get('/', async (req, res) => {
  try {
    const pool = getPool();
    const result = await pool.request().query('SELECT * FROM PRODUCTS ORDER BY PRODUCTID DESC');
    
    res.status(200).json({
      success: true,
      data: result.recordset,
      message: 'Products retrieved successfully'
    });
  } catch (error) {
    console.error('Error fetching products:', error);
    res.status(500).json({
      success: false,
      message: 'Internal server error',
      error: error.message
    });
  }
});

// GET product by ID
router.get('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    if (!id || isNaN(id)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid product ID'
      });
    }
    
    const pool = getPool();
    const result = await pool.request()
      .input('id', sql.Int, parseInt(id))
      .query('SELECT * FROM PRODUCTS WHERE PRODUCTID = @id');
    
    if (result.recordset.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Product not found'
      });
    }
    
    res.status(200).json({
      success: true,
      data: result.recordset[0],
      message: 'Product retrieved successfully'
    });
  } catch (error) {
    console.error('Error fetching product:', error);
    res.status(500).json({
      success: false,
      message: 'Internal server error',
      error: error.message
    });
  }
});

// POST create new product
router.post('/', async (req, res) => {
  try {
    const { productName, price, stock } = req.body;
    
    // Validate input
    const validationErrors = validateProduct(productName, price, stock);
    if (validationErrors.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Validation failed',
        errors: validationErrors
      });
    }
    
    const pool = getPool();
    const result = await pool.request()
      .input('productName', sql.NVarChar(100), productName.trim())
      .input('price', sql.Decimal(10, 2), parseFloat(price))
      .input('stock', sql.Int, parseInt(stock))
      .query(`
        INSERT INTO PRODUCTS (PRODUCTNAME, PRICE, STOCK) 
        OUTPUT INSERTED.* 
        VALUES (@productName, @price, @stock)
      `);
    
    res.status(201).json({
      success: true,
      data: result.recordset[0],
      message: 'Product created successfully'
    });
  } catch (error) {
    console.error('Error creating product:', error);
    res.status(500).json({
      success: false,
      message: 'Internal server error',
      error: error.message
    });
  }
});

// PUT update product by ID
router.put('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { productName, price, stock } = req.body;
    
    if (!id || isNaN(id)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid product ID'
      });
    }
    
    // Validate input
    const validationErrors = validateProduct(productName, price, stock);
    if (validationErrors.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Validation failed',
        errors: validationErrors
      });
    }
    
    const pool = getPool();
    
    // Check if product exists
    const checkResult = await pool.request()
      .input('id', sql.Int, parseInt(id))
      .query('SELECT PRODUCTID FROM PRODUCTS WHERE PRODUCTID = @id');
    
    if (checkResult.recordset.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Product not found'
      });
    }
    
    // Update product
    const result = await pool.request()
      .input('id', sql.Int, parseInt(id))
      .input('productName', sql.NVarChar(100), productName.trim())
      .input('price', sql.Decimal(10, 2), parseFloat(price))
      .input('stock', sql.Int, parseInt(stock))
      .query(`
        UPDATE PRODUCTS 
        SET PRODUCTNAME = @productName, PRICE = @price, STOCK = @stock 
        OUTPUT INSERTED.* 
        WHERE PRODUCTID = @id
      `);
    
    res.status(200).json({
      success: true,
      data: result.recordset[0],
      message: 'Product updated successfully'
    });
  } catch (error) {
    console.error('Error updating product:', error);
    res.status(500).json({
      success: false,
      message: 'Internal server error',
      error: error.message
    });
  }
});

// DELETE product by ID
router.delete('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    if (!id || isNaN(id)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid product ID'
      });
    }
    
    const pool = getPool();
    
    // Check if product exists and get its data before deletion
    const checkResult = await pool.request()
      .input('id', sql.Int, parseInt(id))
      .query('SELECT * FROM PRODUCTS WHERE PRODUCTID = @id');
    
    if (checkResult.recordset.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Product not found'
      });
    }
    
    // Delete product
    await pool.request()
      .input('id', sql.Int, parseInt(id))
      .query('DELETE FROM PRODUCTS WHERE PRODUCTID = @id');
    
    res.status(200).json({
      success: true,
      data: checkResult.recordset[0],
      message: 'Product deleted successfully'
    });
  } catch (error) {
    console.error('Error deleting product:', error);
    res.status(500).json({
      success: false,
      message: 'Internal server error',
      error: error.message
    });
  }
});

module.exports = router;