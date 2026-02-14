-- Sample Data: Realistic e-commerce test data
-- This populates the relational tables with orders, reviews, and carts
-- Run with: sqlite3 examples/sample.db < examples/sample_data.sql

-- ============================================================================
-- ORDERS (15 orders across 6 users)
-- ============================================================================

-- Alice (user_id 1): 3 orders - active customer
INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(1, 1, 'delivered', 1324.98, '123 Main St, NYC, NY 10001', '2024-01-20 14:30:00', '2024-01-20 14:30:00', '2024-01-22 08:00:00', '2024-01-25 16:30:00'),
(2, 1, 'delivered', 237.97, '123 Main St, NYC, NY 10001', '2024-02-05 10:15:00', '2024-02-05 10:15:00', '2024-02-06 09:00:00', '2024-02-08 14:20:00'),
(3, 1, 'shipped', 462.98, '123 Main St, NYC, NY 10001', '2024-02-10 16:45:00', '2024-02-11 09:00:00', '2024-02-11 15:30:00', NULL);

-- Bob (user_id 2): 2 orders
INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(4, 2, 'delivered', 1749.98, '456 Oak Ave, Los Angeles, CA 90001', '2024-01-25 11:20:00', '2024-01-25 11:20:00', '2024-01-27 10:00:00', '2024-01-30 12:45:00'),
(5, 2, 'processing', 199.99, '456 Oak Ave, Los Angeles, CA 90001', '2024-02-12 14:00:00', '2024-02-12 18:30:00', NULL, NULL);

-- Charlie (user_id 3): 4 orders - high-value customer
INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(6, 3, 'delivered', 159.96, '789 Pine Rd, Chicago, IL 60601', '2024-02-02 09:30:00', '2024-02-02 09:30:00', '2024-02-03 11:00:00', '2024-02-06 15:20:00'),
(7, 3, 'delivered', 129.96, '789 Pine Rd, Chicago, IL 60601', '2024-02-08 13:15:00', '2024-02-08 13:15:00', '2024-02-09 08:30:00', '2024-02-11 10:00:00'),
(8, 3, 'shipped', 1299.99, '789 Pine Rd, Chicago, IL 60601', '2024-02-11 10:45:00', '2024-02-11 12:00:00', '2024-02-12 14:15:00', NULL),
(9, 3, 'pending', 449.99, '789 Pine Rd, Chicago, IL 60601', '2024-02-13 16:20:00', '2024-02-13 16:20:00', NULL, NULL);

-- Diana (user_id 4): 2 orders
INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(10, 4, 'delivered', 119.98, '321 Elm St, Boston, MA 02101', '2024-02-06 12:00:00', '2024-02-06 12:00:00', '2024-02-07 09:30:00', '2024-02-09 14:15:00'),
(11, 4, 'cancelled', 1299.99, '321 Elm St, Boston, MA 02101', '2024-02-09 15:30:00', '2024-02-10 09:00:00', NULL, NULL);

-- Eve (user_id 5): 2 orders
INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(12, 5, 'delivered', 224.98, '654 Maple Dr, Seattle, WA 98101', '2024-02-09 10:00:00', '2024-02-09 10:00:00', '2024-02-10 11:30:00', '2024-02-12 16:45:00'),
(13, 5, 'pending', 79.97, '654 Maple Dr, Seattle, WA 98101', '2024-02-13 14:30:00', '2024-02-13 14:30:00', NULL, NULL);

-- Frank (user_id 6): 2 orders - long-time customer
INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(14, 6, 'delivered', 474.98, '987 Birch Ln, Austin, TX 78701', '2023-12-15 08:45:00', '2023-12-15 08:45:00', '2023-12-16 10:00:00', '2023-12-19 13:30:00'),
(15, 6, 'delivered', 169.97, '987 Birch Ln, Austin, TX 78701', '2024-02-11 11:15:00', '2024-02-11 11:15:00', '2024-02-12 09:00:00', '2024-02-13 15:00:00');

-- ============================================================================
-- ORDER_ITEMS (35 line items across 15 orders)
-- ============================================================================

-- Order 1 (Alice): Laptop + Mouse
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(1, 1, 1, 1, 1299.99, 1299.99),  -- Laptop Pro
(2, 1, 2, 1, 24.99, 24.99);       -- Wireless Mouse

-- Order 2 (Alice): Headphones + Cables
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(3, 2, 4, 1, 199.99, 199.99),     -- Bluetooth Headphones
(4, 2, 3, 3, 12.99, 38.97);       -- USB-C Cable x3

-- Order 3 (Alice): Monitor + Book
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(5, 3, 5, 1, 449.99, 449.99),     -- 4K Monitor
(6, 3, 6, 1, 12.99, 12.99);       -- Python Programming book (price adjusted)

-- Order 4 (Bob): Laptop + Monitor
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(7, 4, 1, 1, 1299.99, 1299.99),   -- Laptop Pro
(8, 4, 5, 1, 449.99, 449.99);     -- 4K Monitor

-- Order 5 (Bob): Headphones
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(9, 5, 4, 1, 199.99, 199.99);     -- Bluetooth Headphones

-- Order 6 (Charlie): Books x2 + T-Shirt x2
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(10, 6, 6, 1, 39.99, 39.99),      -- Python Programming
(11, 6, 7, 1, 45.99, 45.99),      -- Web Development Guide
(12, 6, 9, 2, 19.99, 39.98);      -- Cotton T-Shirt x2

-- Order 7 (Charlie): Jeans + T-Shirt
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(13, 7, 10, 1, 49.99, 49.99),     -- Denim Jeans
(14, 7, 9, 4, 19.99, 79.97);      -- Cotton T-Shirt x4

-- Order 8 (Charlie): Laptop
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(15, 8, 1, 1, 1299.99, 1299.99);  -- Laptop Pro

-- Order 9 (Charlie): Monitor
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(16, 9, 5, 1, 449.99, 449.99);    -- 4K Monitor

-- Order 10 (Diana): Books + Desk Lamp
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(17, 10, 8, 1, 54.99, 54.99),     -- Data Science Handbook
(18, 10, 7, 1, 45.99, 45.99),     -- Web Development Guide
(19, 10, 14, 1, 19.00, 19.00);    -- LED Desk Lamp (discounted)

-- Order 11 (Diana): Laptop - CANCELLED
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(20, 11, 1, 1, 1299.99, 1299.99); -- Laptop Pro

-- Order 12 (Eve): Headphones + Mouse
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(21, 12, 4, 1, 199.99, 199.99),   -- Bluetooth Headphones
(22, 12, 2, 1, 24.99, 24.99);     -- Wireless Mouse

-- Order 13 (Eve): Garden Tools + Cables
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(23, 13, 12, 1, 79.99, 79.99);    -- Garden Tools Set (price adjusted from 79.99)

-- Order 14 (Frank): Monitor + Jacket + Cables
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(24, 14, 5, 1, 449.99, 449.99),   -- 4K Monitor
(25, 14, 3, 2, 12.99, 25.98);     -- USB-C Cable x2 (price adjusted)

-- Order 15 (Frank): Winter Jacket + T-Shirts
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(26, 15, 11, 1, 89.99, 89.99),    -- Winter Jacket
(27, 15, 9, 4, 19.99, 79.98);     -- Cotton T-Shirt x4

-- ============================================================================
-- REVIEWS (18 reviews across multiple products)
-- ============================================================================

-- Product 1 (Laptop Pro) - 3 reviews
INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(1, 1, 1, 5, 'Excellent laptop!', 'Fast shipping, great performance. Perfect for development work. The keyboard is comfortable and the screen is crisp.', 1, 12, '2024-01-26 10:00:00', '2024-01-26 10:00:00'),
(2, 1, 2, 5, 'Best purchase this year', 'Amazing build quality and battery life. Handles everything I throw at it with ease. Highly recommended!', 1, 8, '2024-02-01 14:30:00', '2024-02-01 14:30:00'),
(3, 1, 3, 4, 'Great but pricey', 'Excellent laptop but wish it was a bit cheaper. Performance is top-notch though.', 1, 5, '2024-02-12 16:45:00', '2024-02-12 16:45:00');

-- Product 4 (Bluetooth Headphones) - 3 reviews
INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(4, 4, 1, 4, 'Good sound quality', 'Nice bass, comfortable fit. Battery lasts long. Noise cancellation works well on flights.', 1, 6, '2024-02-06 11:20:00', '2024-02-06 11:20:00'),
(5, 4, 5, 5, 'Perfect for commuting', 'Great noise cancellation and comfort. Use them daily for my commute. Worth every penny!', 1, 9, '2024-02-13 09:15:00', '2024-02-13 09:15:00'),
(6, 4, 6, 3, 'Decent but not amazing', 'Sound is okay but expected better at this price point. Comfort is good though.', 0, 2, '2024-02-11 15:30:00', '2024-02-11 15:30:00');

-- Product 2 (Wireless Mouse) - 2 reviews
INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(7, 2, 1, 5, 'Great value', 'Smooth tracking, responsive. Best mouse in this price range. Battery lasts months!', 1, 15, '2024-01-27 12:00:00', '2024-01-27 12:00:00'),
(8, 2, 4, 4, 'Solid mouse', 'Works well, good battery life. Comfortable grip for long work sessions.', 0, 4, '2024-02-10 10:30:00', '2024-02-10 10:30:00');

-- Product 5 (4K Monitor) - 2 reviews
INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(9, 5, 1, 5, 'Crystal clear display', 'Perfect for design work. Colors are accurate and the 4K resolution is stunning.', 1, 7, '2024-02-12 14:00:00', '2024-02-12 14:00:00'),
(10, 5, 2, 4, 'Good monitor', 'Sharp display, good color accuracy. Stand could be better but overall happy with purchase.', 1, 3, '2024-02-02 11:00:00', '2024-02-02 11:00:00');

-- Product 6 (Python Programming book) - 2 reviews
INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(11, 6, 3, 5, 'Best Python book', 'Clear explanations, great examples. Perfect for beginners and intermediate developers.', 1, 11, '2024-02-08 09:00:00', '2024-02-08 09:00:00'),
(12, 6, 1, 4, 'Solid resource', 'Good content, well organized. Some sections could go deeper but overall very useful.', 1, 6, '2024-02-13 10:30:00', '2024-02-13 10:30:00');

-- Product 9 (Cotton T-Shirt) - 2 reviews
INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(13, 9, 3, 5, 'Comfortable and durable', 'Great quality cotton. Washes well, color stays vibrant. Ordering more!', 1, 8, '2024-02-10 15:00:00', '2024-02-10 15:00:00'),
(14, 9, 5, 4, 'Good basic tee', 'Comfortable fit, good value. True to size. Fabric is soft.', 0, 3, '2024-02-12 11:00:00', '2024-02-12 11:00:00');

-- Product 3 (USB-C Cable) - 2 reviews
INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(15, 3, 1, 5, 'Reliable cable', 'Fast charging, durable build. Bought multiple for work and home.', 1, 10, '2024-02-09 08:00:00', '2024-02-09 08:00:00'),
(16, 3, 6, 4, 'Works great', 'Good quality cable, fast data transfer. Good length for desk setup.', 0, 2, '2024-12-20 14:00:00', '2023-12-20 14:00:00');

-- Product 11 (Winter Jacket) - 1 review
INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(17, 11, 6, 5, 'Warm and stylish', 'Perfect for cold weather. Looks great and keeps me warm. Water resistant too!', 1, 5, '2024-02-12 16:00:00', '2024-02-12 16:00:00');

-- Product 8 (Data Science Handbook) - 1 review
INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(18, 8, 4, 5, 'Comprehensive guide', 'Covers all the essentials. Great reference book for data science projects.', 1, 4, '2024-02-11 13:00:00', '2024-02-11 13:00:00');

-- ============================================================================
-- CART_ITEMS (8 active cart items across 4 users)
-- ============================================================================

-- Charlie's cart (user_id 3) - 3 items
INSERT INTO cart_items (cart_item_id, user_id, product_id, quantity, added_at, updated_at) VALUES
(1, 3, 2, 2, '2024-02-13 10:00:00', '2024-02-13 10:00:00'),  -- Wireless Mouse x2
(2, 3, 3, 5, '2024-02-13 10:15:00', '2024-02-13 10:15:00'),  -- USB-C Cable x5
(3, 3, 7, 1, '2024-02-13 11:30:00', '2024-02-13 11:30:00');  -- Web Development Guide

-- Diana's cart (user_id 4) - 2 items
INSERT INTO cart_items (cart_item_id, user_id, product_id, quantity, added_at, updated_at) VALUES
(4, 4, 1, 1, '2024-02-12 14:00:00', '2024-02-12 14:00:00'),  -- Laptop Pro
(5, 4, 5, 1, '2024-02-12 14:05:00', '2024-02-12 14:05:00');  -- 4K Monitor

-- Bob's cart (user_id 2) - 2 items
INSERT INTO cart_items (cart_item_id, user_id, product_id, quantity, added_at, updated_at) VALUES
(6, 2, 3, 3, '2024-02-13 09:00:00', '2024-02-13 09:00:00'),  -- USB-C Cable x3
(7, 2, 13, 2, '2024-02-13 09:30:00', '2024-02-13 09:30:00'); -- Plant Pot Set x2

-- Eve's cart (user_id 5) - 1 item
INSERT INTO cart_items (cart_item_id, user_id, product_id, quantity, added_at, updated_at) VALUES
(8, 5, 2, 1, '2024-02-13 16:00:00', '2024-02-13 16:00:00');  -- Wireless Mouse

-- ============================================================================
-- Sample data complete
-- ============================================================================
