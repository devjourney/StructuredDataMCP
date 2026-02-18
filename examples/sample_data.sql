-- Sample Data: Realistic e-commerce dataset
-- Populates all tables with categories, users, products, orders, reviews, and carts
-- Run with: sqlite3 examples/sample.db < examples/sample_data.sql

-- ============================================================================
-- CATEGORIES (7 categories)
-- ============================================================================

INSERT INTO categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Clothing'),
(4, 'Home & Garden'),
(5, 'Office & Workspace'),
(6, 'Fitness & Outdoors'),
(7, 'Kitchen & Dining');

-- ============================================================================
-- USERS (14 customers)
-- ============================================================================

INSERT INTO users (user_id, username, email, created_at, last_login) VALUES
(1,  'alice',   'alice@example.com',   '2024-01-15 10:00:00', '2026-02-10 14:30:00'),
(2,  'bob',     'bob@example.com',     '2024-01-20 11:00:00', '2025-12-18 09:15:00'),
(3,  'charlie', 'charlie@example.com', '2024-02-01 12:00:00', '2026-01-28 16:45:00'),
(4,  'diana',   'diana@example.com',   '2024-02-05 15:30:00', '2025-11-20 10:20:00'),
(5,  'eve',     'eve@example.com',     '2024-02-08 09:45:00', '2025-08-15 14:10:00'),
(6,  'frank',   'frank@example.com',   '2023-12-10 08:00:00', '2025-11-30 11:30:00'),
(7,  'grace',   'grace@example.com',   '2024-03-01 09:00:00', '2026-01-05 10:20:00'),
(8,  'henry',   'henry@example.com',   '2024-04-10 14:30:00', '2025-06-12 08:45:00'),
(9,  'irene',   'irene@example.com',   '2024-03-25 11:15:00', '2025-09-20 16:00:00'),
(10, 'jack',    'jack@example.com',    '2024-09-15 10:00:00', '2025-12-22 13:30:00'),
(11, 'karen',   'karen@example.com',   '2024-12-20 08:30:00', '2025-10-15 09:45:00'),
(12, 'leo',     'leo@example.com',     '2024-02-10 16:00:00', '2025-08-04 14:15:00'),
(13, 'mia',     'mia@example.com',     '2024-01-05 13:00:00', '2026-02-12 17:30:00'),
(14, 'nathan',  'nathan@example.com',  '2025-10-20 10:30:00', '2026-02-08 11:00:00');

-- ============================================================================
-- PRODUCTS (34 products across 7 categories)
-- ============================================================================

-- Electronics (category 1)
INSERT INTO products (product_id, name, description, price, stock_quantity, category_id, active, created_at) VALUES
(1,  'Laptop Pro',            'High-performance laptop with 16GB RAM',            1299.99, 15,  1, 1, '2024-01-10 08:00:00'),
(2,  'Wireless Mouse',        'Ergonomic wireless mouse with 3 buttons',            24.99, 45,  1, 1, '2024-01-10 08:00:00'),
(3,  'USB-C Cable',           'Premium 6ft USB-C charging cable',                   12.99, 120, 1, 1, '2024-01-10 08:00:00'),
(4,  'Bluetooth Headphones',  'Noise-cancelling over-ear headphones',              199.99, 8,   1, 1, '2024-01-10 08:00:00'),
(5,  '4K Monitor',            '27-inch 4K IPS display',                            449.99, 5,   1, 1, '2024-01-10 08:00:00'),
(15, 'Webcam HD 1080p',       'Full HD webcam with auto-focus and ring light',      59.99, 35,  1, 1, '2024-02-20 08:00:00'),
(16, 'Portable SSD 1TB',      'USB-C portable solid state drive, 1050 MB/s read',  89.99, 20,  1, 1, '2024-02-20 08:00:00'),
(17, 'Mechanical Keyboard',   'Cherry MX Brown switches, TKL layout with RGB',    129.99, 25,  1, 1, '2024-02-20 08:00:00');

-- Books (category 2)
INSERT INTO products (product_id, name, description, price, stock_quantity, category_id, active, created_at) VALUES
(6,  'Python Programming',          'Learn Python programming from scratch',               39.99, 30, 2, 1, '2024-01-10 08:00:00'),
(7,  'Web Development Guide',       'Complete guide to modern web development',             45.99, 22, 2, 1, '2024-01-10 08:00:00'),
(8,  'Data Science Handbook',       'Practical data science with Python',                   54.99, 18, 2, 1, '2024-01-10 08:00:00'),
(18, 'Cloud Architecture Patterns', 'Designing distributed systems at scale',               49.99, 15, 2, 1, '2024-03-15 08:00:00'),
(19, 'Machine Learning Fundamentals', 'From linear regression to deep neural networks',     59.99, 20, 2, 1, '2024-03-15 08:00:00');

-- Clothing (category 3)
INSERT INTO products (product_id, name, description, price, stock_quantity, category_id, active, created_at) VALUES
(9,  'Cotton T-Shirt',  'Comfortable cotton t-shirt in various colors',  19.99, 75, 3, 1, '2024-01-10 08:00:00'),
(10, 'Denim Jeans',     'Classic fit denim jeans',                       49.99, 40, 3, 1, '2024-01-10 08:00:00'),
(11, 'Winter Jacket',   'Warm winter jacket with hood',                  89.99, 12, 3, 1, '2024-01-10 08:00:00'),
(20, 'Running Shoes',   'Lightweight mesh running shoes with arch support', 74.99, 30, 3, 1, '2024-04-01 08:00:00'),
(21, 'Hoodie',          'Midweight fleece pullover hoodie',              39.99, 50, 3, 1, '2024-04-01 08:00:00');

-- Home & Garden (category 4)
INSERT INTO products (product_id, name, description, price, stock_quantity, category_id, active, created_at) VALUES
(12, 'Garden Tools Set',  'Complete set of essential garden tools',                79.99, 6,  4, 1, '2024-01-10 08:00:00'),
(13, 'Plant Pot Set',     'Set of 5 ceramic plant pots',                          34.99, 25, 4, 1, '2024-01-10 08:00:00'),
(14, 'LED Desk Lamp',     'Adjustable LED desk lamp with USB port',               29.99, 3,  4, 1, '2024-01-10 08:00:00'),
(22, 'Smart Thermostat',  'WiFi-enabled programmable thermostat with app control', 149.99, 10, 4, 1, '2024-06-01 08:00:00');

-- Office & Workspace (category 5)
INSERT INTO products (product_id, name, description, price, stock_quantity, category_id, active, created_at) VALUES
(23, 'Standing Desk',       'Electric sit-stand desk, 48x30 inch bamboo top',   399.99, 8,  5, 1, '2024-02-15 08:00:00'),
(24, 'Ergonomic Office Chair', 'Mesh-back chair with adjustable lumbar support', 549.99, 6,  5, 1, '2024-02-15 08:00:00'),
(25, 'Desk Organizer Set',  'Bamboo desktop organizer with 5 compartments',       24.99, 40, 5, 1, '2024-02-15 08:00:00'),
(26, 'Whiteboard 36x24',    'Magnetic dry-erase whiteboard with markers',         44.99, 20, 5, 1, '2024-02-15 08:00:00');

-- Fitness & Outdoors (category 6)
INSERT INTO products (product_id, name, description, price, stock_quantity, category_id, active, created_at) VALUES
(27, 'Yoga Mat Premium',      'Extra-thick 6mm non-slip yoga mat',                34.99, 35, 6, 1, '2024-04-01 08:00:00'),
(28, 'Stainless Water Bottle', 'Insulated 32oz water bottle, keeps cold 24hrs',   19.99, 60, 6, 1, '2024-04-01 08:00:00'),
(29, 'Hiking Backpack 40L',   'Waterproof daypack with hydration sleeve',         89.99, 15, 6, 1, '2024-04-01 08:00:00'),
(30, 'Resistance Bands Set',  'Set of 5 latex bands, 10-50 lb range',            24.99, 45, 6, 1, '2024-04-01 08:00:00');

-- Kitchen & Dining (category 7)
INSERT INTO products (product_id, name, description, price, stock_quantity, category_id, active, created_at) VALUES
(31, 'Coffee Maker Programmable', '12-cup drip coffee maker with delay brew',     79.99, 18, 7, 1, '2024-05-01 08:00:00'),
(32, 'Chef''s Knife Set',         '8-piece forged stainless steel knife block',  119.99, 12, 7, 1, '2024-05-01 08:00:00'),
(33, 'Cast Iron Skillet',         'Pre-seasoned 12-inch cast iron skillet',        39.99, 20, 7, 1, '2024-05-01 08:00:00'),
(34, 'French Press',              'Double-wall insulated 34oz French press',       29.99, 25, 7, 1, '2024-05-01 08:00:00');

-- ============================================================================
-- ORDERS (100 orders across 14 users, Jan 2024 – Feb 2026)
-- ============================================================================

-- --------------------------------------------------------------------------
-- Alice (user 1): 10 orders — loyal early adopter
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(1,  1, 'delivered', 1324.98, '123 Main St, NYC, NY 10001', '2024-01-20 14:30:00', '2024-01-20 14:30:00', '2024-01-22 08:00:00', '2024-01-25 16:30:00'),
(2,  1, 'delivered',  238.96, '123 Main St, NYC, NY 10001', '2024-02-05 10:15:00', '2024-02-05 10:15:00', '2024-02-06 09:00:00', '2024-02-08 14:20:00'),
(3,  1, 'delivered',  462.98, '123 Main St, NYC, NY 10001', '2024-02-10 16:45:00', '2024-02-11 09:00:00', '2024-02-11 15:30:00', '2024-02-14 10:00:00'),
(16, 1, 'delivered',   50.97, '123 Main St, NYC, NY 10001', '2024-04-12 09:30:00', '2024-04-12 09:30:00', '2024-04-13 10:00:00', '2024-04-16 14:00:00'),
(17, 1, 'delivered',   49.99, '123 Main St, NYC, NY 10001', '2024-07-05 11:00:00', '2024-07-05 11:00:00', '2024-07-06 08:30:00', '2024-07-09 15:00:00'),
(18, 1, 'delivered',  129.99, '123 Main St, NYC, NY 10001', '2024-10-08 14:20:00', '2024-10-08 14:20:00', '2024-10-09 09:00:00', '2024-10-12 12:00:00'),
(19, 1, 'delivered',  399.99, '123 Main St, NYC, NY 10001', '2025-01-15 10:00:00', '2025-01-15 10:00:00', '2025-01-17 11:00:00', '2025-01-22 16:30:00'),
(20, 1, 'delivered',  109.98, '123 Main St, NYC, NY 10001', '2025-05-03 15:45:00', '2025-05-03 15:45:00', '2025-05-05 08:30:00', '2025-05-08 13:00:00'),
(21, 1, 'delivered',   89.99, '123 Main St, NYC, NY 10001', '2025-09-18 12:30:00', '2025-09-18 12:30:00', '2025-09-19 10:00:00', '2025-09-22 14:15:00'),
(22, 1, 'delivered',   54.98, '123 Main St, NYC, NY 10001', '2026-01-22 09:15:00', '2026-01-22 09:15:00', '2026-01-23 10:00:00', '2026-01-26 15:00:00');

-- --------------------------------------------------------------------------
-- Bob (user 2): 7 orders
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(4,  2, 'delivered', 1749.98, '456 Oak Ave, Los Angeles, CA 90001', '2024-01-25 11:20:00', '2024-01-25 11:20:00', '2024-01-27 10:00:00', '2024-01-30 12:45:00'),
(5,  2, 'delivered',  199.99, '456 Oak Ave, Los Angeles, CA 90001', '2024-02-12 14:00:00', '2024-02-12 18:30:00', '2024-02-14 09:00:00', '2024-02-17 11:30:00'),
(23, 2, 'delivered',  114.98, '456 Oak Ave, Los Angeles, CA 90001', '2024-04-20 10:30:00', '2024-04-20 10:30:00', '2024-04-21 09:00:00', '2024-04-24 14:00:00'),
(24, 2, 'delivered',  114.98, '456 Oak Ave, Los Angeles, CA 90001', '2024-07-15 13:00:00', '2024-07-15 13:00:00', '2024-07-16 10:00:00', '2024-07-19 15:30:00'),
(25, 2, 'delivered',  159.98, '456 Oak Ave, Los Angeles, CA 90001', '2024-11-08 09:45:00', '2024-11-08 09:45:00', '2024-11-09 10:00:00', '2024-11-12 13:00:00'),
(26, 2, 'delivered',   59.99, '456 Oak Ave, Los Angeles, CA 90001', '2025-03-10 11:00:00', '2025-03-10 11:00:00', '2025-03-11 09:30:00', '2025-03-14 14:00:00'),
(27, 2, 'delivered',   89.99, '456 Oak Ave, Los Angeles, CA 90001', '2025-07-22 14:30:00', '2025-07-22 14:30:00', '2025-07-23 08:00:00', '2025-07-26 12:00:00');

-- --------------------------------------------------------------------------
-- Charlie (user 3): 9 orders — high spender
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(6,  3, 'delivered',  125.96, '789 Pine Rd, Chicago, IL 60601', '2024-02-02 09:30:00', '2024-02-02 09:30:00', '2024-02-03 11:00:00', '2024-02-06 15:20:00'),
(7,  3, 'delivered',  129.96, '789 Pine Rd, Chicago, IL 60601', '2024-02-08 13:15:00', '2024-02-08 13:15:00', '2024-02-09 08:30:00', '2024-02-11 10:00:00'),
(8,  3, 'delivered', 1299.99, '789 Pine Rd, Chicago, IL 60601', '2024-02-11 10:45:00', '2024-02-11 12:00:00', '2024-02-12 14:15:00', '2024-02-15 16:30:00'),
(9,  3, 'delivered',  449.99, '789 Pine Rd, Chicago, IL 60601', '2024-02-13 16:20:00', '2024-02-13 16:20:00', '2024-02-15 09:00:00', '2024-02-18 14:00:00'),
(28, 3, 'delivered',  949.98, '789 Pine Rd, Chicago, IL 60601', '2024-05-05 08:30:00', '2024-05-05 08:30:00', '2024-05-07 10:00:00', '2024-05-12 15:00:00'),
(29, 3, 'delivered',   59.98, '789 Pine Rd, Chicago, IL 60601', '2024-08-12 14:00:00', '2024-08-12 14:00:00', '2024-08-13 09:00:00', '2024-08-16 12:30:00'),
(30, 3, 'delivered',  129.98, '789 Pine Rd, Chicago, IL 60601', '2024-12-05 11:15:00', '2024-12-05 11:15:00', '2024-12-06 10:00:00', '2024-12-09 16:00:00'),
(31, 3, 'delivered',  149.99, '789 Pine Rd, Chicago, IL 60601', '2025-04-15 09:00:00', '2025-04-15 09:00:00', '2025-04-16 08:30:00', '2025-04-19 14:00:00'),
(32, 3, 'delivered',  159.98, '789 Pine Rd, Chicago, IL 60601', '2025-09-20 13:30:00', '2025-09-20 13:30:00', '2025-09-21 10:00:00', '2025-09-24 15:00:00');

-- --------------------------------------------------------------------------
-- Diana (user 4): 7 orders
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(10, 4, 'delivered',  119.98, '321 Elm St, Boston, MA 02101', '2024-02-06 12:00:00', '2024-02-06 12:00:00', '2024-02-07 09:30:00', '2024-02-09 14:15:00'),
(11, 4, 'cancelled', 1299.99, '321 Elm St, Boston, MA 02101', '2024-02-09 15:30:00', '2024-02-10 09:00:00', NULL, NULL),
(33, 4, 'delivered',  134.96, '321 Elm St, Boston, MA 02101', '2024-06-08 10:15:00', '2024-06-08 10:15:00', '2024-06-09 09:00:00', '2024-06-12 14:30:00'),
(34, 4, 'delivered',  119.98, '321 Elm St, Boston, MA 02101', '2024-09-15 08:30:00', '2024-09-15 08:30:00', '2024-09-16 10:00:00', '2024-09-19 13:00:00'),
(35, 4, 'delivered',   59.98, '321 Elm St, Boston, MA 02101', '2025-02-10 11:00:00', '2025-02-10 11:00:00', '2025-02-11 09:30:00', '2025-02-14 15:00:00'),
(36, 4, 'delivered',  219.98, '321 Elm St, Boston, MA 02101', '2025-06-25 14:45:00', '2025-06-25 14:45:00', '2025-06-26 10:00:00', '2025-06-30 12:00:00'),
(99, 4, 'delivered',   49.98, '321 Elm St, Boston, MA 02101', '2025-11-05 09:20:00', '2025-11-05 09:20:00', '2025-11-06 10:00:00', '2025-11-09 14:30:00');

-- --------------------------------------------------------------------------
-- Eve (user 5): 6 orders
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(12, 5, 'delivered',  224.98, '654 Maple Dr, Seattle, WA 98101', '2024-02-09 10:00:00', '2024-02-09 10:00:00', '2024-02-10 11:30:00', '2024-02-12 16:45:00'),
(13, 5, 'delivered',   79.99, '654 Maple Dr, Seattle, WA 98101', '2024-02-13 14:30:00', '2024-02-13 14:30:00', '2024-02-14 09:00:00', '2024-02-17 13:00:00'),
(37, 5, 'delivered',   89.98, '654 Maple Dr, Seattle, WA 98101', '2024-05-18 09:30:00', '2024-05-18 09:30:00', '2024-05-19 10:00:00', '2024-05-22 14:00:00'),
(38, 5, 'delivered',  114.98, '654 Maple Dr, Seattle, WA 98101', '2024-09-22 11:45:00', '2024-09-22 11:45:00', '2024-09-23 09:00:00', '2024-09-26 15:00:00'),
(39, 5, 'delivered',  109.98, '654 Maple Dr, Seattle, WA 98101', '2025-03-08 10:00:00', '2025-03-08 10:00:00', '2025-03-10 08:30:00', '2025-03-13 14:00:00'),
(100, 5, 'delivered', 179.98, '654 Maple Dr, Seattle, WA 98101', '2025-08-10 13:00:00', '2025-08-10 13:00:00', '2025-08-11 09:00:00', '2025-08-14 12:30:00');

-- --------------------------------------------------------------------------
-- Frank (user 6): 5 orders — long-time customer
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(14, 6, 'delivered', 475.97, '987 Birch Ln, Austin, TX 78701', '2023-12-15 08:45:00', '2023-12-15 08:45:00', '2023-12-16 10:00:00', '2023-12-19 13:30:00'),
(15, 6, 'delivered', 169.97, '987 Birch Ln, Austin, TX 78701', '2024-02-11 11:15:00', '2024-02-11 11:15:00', '2024-02-12 09:00:00', '2024-02-13 15:00:00'),
(40, 6, 'delivered',  94.98, '987 Birch Ln, Austin, TX 78701', '2024-03-22 10:00:00', '2024-03-22 10:00:00', '2024-03-23 09:00:00', '2024-03-26 14:30:00'),
(41, 6, 'delivered',  69.98, '987 Birch Ln, Austin, TX 78701', '2024-08-05 14:30:00', '2024-08-05 14:30:00', '2024-08-06 10:00:00', '2024-08-09 13:00:00'),
(42, 6, 'delivered', 124.98, '987 Birch Ln, Austin, TX 78701', '2025-06-12 11:30:00', '2025-06-12 11:30:00', '2025-06-13 09:00:00', '2025-06-16 15:00:00');

-- --------------------------------------------------------------------------
-- Grace (user 7): 6 orders — software developer building a workstation
-- Rapid cluster in March 2024: laptop → display → desk → peripherals
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(43, 7, 'delivered', 1324.98, '55 Tech Park Way, San Jose, CA 95110',   '2024-03-05 09:00:00', '2024-03-05 09:00:00', '2024-03-07 10:00:00', '2024-03-10 14:30:00'),
(44, 7, 'delivered',  579.98, '55 Tech Park Way, San Jose, CA 95110',   '2024-03-08 18:45:00', '2024-03-08 18:45:00', '2024-03-10 09:00:00', '2024-03-13 16:00:00'),
(45, 7, 'delivered',  949.98, '55 Tech Park Way, San Jose, CA 95110',   '2024-03-11 11:30:00', '2024-03-11 11:30:00', '2024-03-14 10:00:00', '2024-03-20 15:00:00'),
(46, 7, 'delivered',  128.95, '55 Tech Park Way, San Jose, CA 95110',   '2024-03-13 08:15:00', '2024-03-13 08:15:00', '2024-03-14 14:00:00', '2024-03-17 11:00:00'),
(47, 7, 'delivered',  289.98, '55 Tech Park Way, San Jose, CA 95110',   '2024-03-22 16:30:00', '2024-03-22 16:30:00', '2024-03-24 09:00:00', '2024-03-27 13:00:00'),
(48, 7, 'delivered',   69.98, '55 Tech Park Way, San Jose, CA 95110',   '2024-04-05 10:00:00', '2024-04-05 10:00:00', '2024-04-06 09:00:00', '2024-04-09 14:00:00');

-- --------------------------------------------------------------------------
-- Henry (user 8): 5 orders — fitness enthusiast
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(49, 8, 'delivered',  79.97, '200 River Walk, Denver, CO 80202',   '2024-04-18 07:30:00', '2024-04-18 07:30:00', '2024-04-19 10:00:00', '2024-04-22 12:00:00'),
(50, 8, 'delivered', 114.98, '200 River Walk, Denver, CO 80202',   '2024-05-12 08:00:00', '2024-05-12 08:00:00', '2024-05-13 09:00:00', '2024-05-16 14:00:00'),
(51, 8, 'delivered',  89.99, '200 River Walk, Denver, CO 80202',   '2024-06-25 06:45:00', '2024-06-25 06:45:00', '2024-06-26 10:00:00', '2024-06-29 15:30:00'),
(52, 8, 'delivered',  79.96, '200 River Walk, Denver, CO 80202',   '2024-09-08 09:15:00', '2024-09-08 09:15:00', '2024-09-09 10:00:00', '2024-09-12 13:00:00'),
(53, 8, 'delivered', 139.98, '200 River Walk, Denver, CO 80202',   '2025-01-12 10:30:00', '2025-01-12 10:30:00', '2025-01-13 09:00:00', '2025-01-16 14:00:00');

-- --------------------------------------------------------------------------
-- Irene (user 9): 6 orders — book collector who transitions into tech
-- Starts with books, then buys a laptop and peripherals to learn hands-on
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(54, 9, 'delivered',  85.98, '18 Library Ln, Portland, OR 97201',   '2024-04-02 14:00:00', '2024-04-02 14:00:00', '2024-04-03 09:00:00', '2024-04-06 12:00:00'),
(55, 9, 'delivered', 114.98, '18 Library Ln, Portland, OR 97201',   '2024-05-20 10:30:00', '2024-05-20 10:30:00', '2024-05-21 09:00:00', '2024-05-24 14:30:00'),
(56, 9, 'delivered',  49.99, '18 Library Ln, Portland, OR 97201',   '2024-07-15 15:00:00', '2024-07-15 15:00:00', '2024-07-16 10:00:00', '2024-07-19 13:00:00'),
(57, 9, 'delivered', 1299.99, '18 Library Ln, Portland, OR 97201',  '2024-08-25 09:00:00', '2024-08-25 09:00:00', '2024-08-27 10:00:00', '2024-08-30 16:00:00'),
(58, 9, 'delivered', 115.97, '18 Library Ln, Portland, OR 97201',   '2024-10-10 11:30:00', '2024-10-10 11:30:00', '2024-10-11 09:00:00', '2024-10-14 14:00:00'),
(59, 9, 'delivered', 189.98, '18 Library Ln, Portland, OR 97201',   '2025-02-05 13:00:00', '2025-02-05 13:00:00', '2025-02-06 10:00:00', '2025-02-09 15:30:00');

-- --------------------------------------------------------------------------
-- Jack (user 10): 8 orders — holiday gift shopper
-- Heavy clustering around Nov-Dec 2024 (6 orders in 4 weeks)
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(60, 10, 'delivered', 259.96, '400 Holiday Ct, Minneapolis, MN 55401', '2024-11-22 10:00:00', '2024-11-22 10:00:00', '2024-11-23 09:00:00', '2024-11-26 14:00:00'),
(61, 10, 'delivered', 249.97, '400 Holiday Ct, Minneapolis, MN 55401', '2024-11-26 08:30:00', '2024-11-26 08:30:00', '2024-11-27 10:00:00', '2024-11-30 12:00:00'),
(62, 10, 'delivered', 229.97, '400 Holiday Ct, Minneapolis, MN 55401', '2024-12-02 12:15:00', '2024-12-02 12:15:00', '2024-12-03 09:00:00', '2024-12-06 15:00:00'),
(63, 10, 'delivered',  99.98, '400 Holiday Ct, Minneapolis, MN 55401', '2024-12-10 14:00:00', '2024-12-10 14:00:00', '2024-12-11 10:00:00', '2024-12-14 13:00:00'),
(64, 10, 'delivered', 149.97, '400 Holiday Ct, Minneapolis, MN 55401', '2024-12-15 09:30:00', '2024-12-15 09:30:00', '2024-12-16 10:00:00', '2024-12-19 14:30:00'),
(65, 10, 'delivered', 139.93, '400 Holiday Ct, Minneapolis, MN 55401', '2024-12-20 11:45:00', '2024-12-20 11:45:00', '2024-12-21 09:00:00', '2024-12-23 16:00:00'),
(66, 10, 'delivered', 949.98, '400 Holiday Ct, Minneapolis, MN 55401', '2025-11-28 08:00:00', '2025-11-28 08:00:00', '2025-11-29 10:00:00', '2025-12-03 14:00:00'),
(67, 10, 'delivered', 309.97, '400 Holiday Ct, Minneapolis, MN 55401', '2025-12-08 13:30:00', '2025-12-08 13:30:00', '2025-12-09 09:00:00', '2025-12-12 15:00:00');

-- --------------------------------------------------------------------------
-- Karen (user 11): 7 orders — home office setup
-- Rapid cluster in Jan-Feb 2025: desk → chair → computer → peripherals
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(68, 11, 'delivered',  399.99, '72 Sunset Blvd, Phoenix, AZ 85001',  '2025-01-08 08:00:00', '2025-01-08 08:00:00', '2025-01-10 10:00:00', '2025-01-15 16:00:00'),
(69, 11, 'delivered',  549.99, '72 Sunset Blvd, Phoenix, AZ 85001',  '2025-01-12 09:30:00', '2025-01-12 09:30:00', '2025-01-14 10:00:00', '2025-01-18 14:00:00'),
(70, 11, 'delivered', 1359.98, '72 Sunset Blvd, Phoenix, AZ 85001',  '2025-01-16 11:00:00', '2025-01-16 11:00:00', '2025-01-18 09:00:00', '2025-01-22 15:30:00'),
(71, 11, 'delivered',  579.98, '72 Sunset Blvd, Phoenix, AZ 85001',  '2025-01-20 14:15:00', '2025-01-20 14:15:00', '2025-01-22 10:00:00', '2025-01-25 13:00:00'),
(72, 11, 'delivered',   93.95, '72 Sunset Blvd, Phoenix, AZ 85001',  '2025-01-25 10:30:00', '2025-01-25 10:30:00', '2025-01-26 09:00:00', '2025-01-29 12:00:00'),
(73, 11, 'delivered',  244.98, '72 Sunset Blvd, Phoenix, AZ 85001',  '2025-02-03 08:45:00', '2025-02-03 08:45:00', '2025-02-04 10:00:00', '2025-02-07 14:30:00'),
(74, 11, 'delivered',   89.98, '72 Sunset Blvd, Phoenix, AZ 85001',  '2025-02-15 16:00:00', '2025-02-15 16:00:00', '2025-02-17 09:00:00', '2025-02-20 13:00:00');

-- --------------------------------------------------------------------------
-- Leo (user 12): 5 orders — casual, sporadic buyer
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(75, 12, 'delivered', 24.99, '88 Lakeview Dr, Nashville, TN 37201',  '2024-02-20 15:00:00', '2024-02-20 15:00:00', '2024-02-21 10:00:00', '2024-02-24 14:00:00'),
(76, 12, 'delivered', 39.98, '88 Lakeview Dr, Nashville, TN 37201',  '2024-05-25 11:30:00', '2024-05-25 11:30:00', '2024-05-26 09:00:00', '2024-05-29 13:00:00'),
(77, 12, 'delivered', 89.98, '88 Lakeview Dr, Nashville, TN 37201',  '2024-08-30 14:00:00', '2024-08-30 14:00:00', '2024-08-31 10:00:00', '2024-09-03 15:00:00'),
(78, 12, 'delivered', 79.99, '88 Lakeview Dr, Nashville, TN 37201',  '2024-11-15 09:45:00', '2024-11-15 09:45:00', '2024-11-16 10:00:00', '2024-11-19 14:00:00'),
(79, 12, 'delivered', 29.99, '88 Lakeview Dr, Nashville, TN 37201',  '2025-03-20 10:00:00', '2025-03-20 10:00:00', '2025-03-21 09:00:00', '2025-03-24 13:30:00');

-- --------------------------------------------------------------------------
-- Mia (user 13): 14 orders — loyal regular, roughly monthly
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(80,  13, 'delivered',  39.99, '310 Crescent Ave, San Diego, CA 92101', '2024-01-18 13:00:00', '2024-01-18 13:00:00', '2024-01-19 10:00:00', '2024-01-22 14:00:00'),
(81,  13, 'delivered',  37.98, '310 Crescent Ave, San Diego, CA 92101', '2024-03-02 10:30:00', '2024-03-02 10:30:00', '2024-03-03 09:00:00', '2024-03-06 13:00:00'),
(82,  13, 'delivered',  89.97, '310 Crescent Ave, San Diego, CA 92101', '2024-04-25 15:00:00', '2024-04-25 15:00:00', '2024-04-26 10:00:00', '2024-04-29 14:30:00'),
(83,  13, 'delivered', 199.99, '310 Crescent Ave, San Diego, CA 92101', '2024-06-10 09:30:00', '2024-06-10 09:30:00', '2024-06-11 10:00:00', '2024-06-14 15:00:00'),
(84,  13, 'delivered', 164.98, '310 Crescent Ave, San Diego, CA 92101', '2024-08-08 12:00:00', '2024-08-08 12:00:00', '2024-08-09 09:00:00', '2024-08-12 14:00:00'),
(85,  13, 'delivered', 149.98, '310 Crescent Ave, San Diego, CA 92101', '2024-10-01 14:30:00', '2024-10-01 14:30:00', '2024-10-02 10:00:00', '2024-10-05 13:00:00'),
(86,  13, 'delivered', 129.98, '310 Crescent Ave, San Diego, CA 92101', '2024-11-20 11:00:00', '2024-11-20 11:00:00', '2024-11-21 09:00:00', '2024-11-24 14:30:00'),
(87,  13, 'delivered',  49.99, '310 Crescent Ave, San Diego, CA 92101', '2025-01-05 10:15:00', '2025-01-05 10:15:00', '2025-01-06 09:00:00', '2025-01-09 13:00:00'),
(88,  13, 'delivered', 399.99, '310 Crescent Ave, San Diego, CA 92101', '2025-03-15 08:30:00', '2025-03-15 08:30:00', '2025-03-17 10:00:00', '2025-03-21 15:00:00'),
(89,  13, 'delivered', 449.99, '310 Crescent Ave, San Diego, CA 92101', '2025-06-20 14:00:00', '2025-06-20 14:00:00', '2025-06-22 09:00:00', '2025-06-25 14:00:00'),
(90,  13, 'delivered', 159.98, '310 Crescent Ave, San Diego, CA 92101', '2025-09-05 11:30:00', '2025-09-05 11:30:00', '2025-09-06 10:00:00', '2025-09-09 14:00:00'),
(91,  13, 'delivered', 549.99, '310 Crescent Ave, San Diego, CA 92101', '2025-12-10 09:00:00', '2025-12-10 09:00:00', '2025-12-12 10:00:00', '2025-12-16 15:30:00'),
(92,  13, 'delivered',  79.97, '310 Crescent Ave, San Diego, CA 92101', '2026-01-28 10:00:00', '2026-01-28 10:00:00', '2026-01-29 09:00:00', '2026-02-01 14:00:00'),
(93,  13, 'processing', 29.99, '310 Crescent Ave, San Diego, CA 92101', '2026-02-12 17:30:00', '2026-02-12 18:00:00', NULL, NULL);

-- --------------------------------------------------------------------------
-- Nathan (user 14): 5 orders — new customer ramping up (books → hardware)
-- --------------------------------------------------------------------------

INSERT INTO orders (order_id, user_id, order_status, total_amount, shipping_address, created_at, updated_at, shipped_at, delivered_at) VALUES
(94, 14, 'delivered',   99.98, '15 College Rd, Raleigh, NC 27601',  '2025-10-25 10:00:00', '2025-10-25 10:00:00', '2025-10-27 09:00:00', '2025-10-30 14:00:00'),
(95, 14, 'delivered',  115.97, '15 College Rd, Raleigh, NC 27601',  '2025-11-15 11:30:00', '2025-11-15 11:30:00', '2025-11-16 10:00:00', '2025-11-19 13:00:00'),
(96, 14, 'delivered',  104.98, '15 College Rd, Raleigh, NC 27601',  '2025-12-20 09:00:00', '2025-12-20 09:00:00', '2025-12-22 10:00:00', '2025-12-26 15:00:00'),
(97, 14, 'shipped',   1299.99, '15 College Rd, Raleigh, NC 27601',  '2026-01-15 14:00:00', '2026-01-16 09:00:00', '2026-01-16 15:00:00', NULL),
(98, 14, 'pending',    579.98, '15 College Rd, Raleigh, NC 27601',  '2026-02-05 11:00:00', '2026-02-05 11:00:00', NULL, NULL);

-- ============================================================================
-- ORDER ITEMS (178 line items across 100 orders)
-- ============================================================================

-- --------------------------------------------------------------------------
-- Alice's order items
-- --------------------------------------------------------------------------

-- Order 1: Laptop + Mouse
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(1, 1, 1, 1, 1299.99, 1299.99),   -- Laptop Pro
(2, 1, 2, 1, 24.99, 24.99);       -- Wireless Mouse

-- Order 2: Headphones + Cables
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(3, 2, 4, 1, 199.99, 199.99),     -- Bluetooth Headphones
(4, 2, 3, 3, 12.99, 38.97);       -- USB-C Cable x3

-- Order 3: Monitor + Book
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(5, 3, 5, 1, 449.99, 449.99),     -- 4K Monitor
(6, 3, 6, 1, 12.99, 12.99);       -- Python Programming (sale price)

-- Order 16: Desk Organizer + Cables
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(28, 16, 25, 1, 24.99, 24.99),    -- Desk Organizer Set
(29, 16, 3, 2, 12.99, 25.98);     -- USB-C Cable x2

-- Order 17: Cloud Architecture book
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(30, 17, 18, 1, 49.99, 49.99);    -- Cloud Architecture Patterns

-- Order 18: Mechanical Keyboard
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(31, 18, 17, 1, 129.99, 129.99);  -- Mechanical Keyboard

-- Order 19: Standing Desk
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(32, 19, 23, 1, 399.99, 399.99);  -- Standing Desk

-- Order 20: Coffee Maker + French Press
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(33, 20, 31, 1, 79.99, 79.99),    -- Coffee Maker
(34, 20, 34, 1, 29.99, 29.99);    -- French Press

-- Order 21: Portable SSD
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(35, 21, 16, 1, 89.99, 89.99);    -- Portable SSD

-- Order 22: Yoga Mat + Water Bottle
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(36, 22, 27, 1, 34.99, 34.99),    -- Yoga Mat
(37, 22, 28, 1, 19.99, 19.99);    -- Water Bottle

-- --------------------------------------------------------------------------
-- Bob's order items
-- --------------------------------------------------------------------------

-- Order 4: Laptop + Monitor
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(7, 4, 1, 1, 1299.99, 1299.99),   -- Laptop Pro
(8, 4, 5, 1, 449.99, 449.99);     -- 4K Monitor

-- Order 5: Headphones
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(9, 5, 4, 1, 199.99, 199.99);     -- Bluetooth Headphones

-- Order 23: ML + Data Science books
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(38, 23, 19, 1, 59.99, 59.99),    -- ML Fundamentals
(39, 23, 8, 1, 54.99, 54.99);     -- Data Science Handbook

-- Order 24: Hoodie + Running Shoes
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(40, 24, 21, 1, 39.99, 39.99),    -- Hoodie
(41, 24, 20, 1, 74.99, 74.99);    -- Running Shoes

-- Order 25: Cast Iron Skillet + Chef's Knife Set
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(42, 25, 33, 1, 39.99, 39.99),    -- Cast Iron Skillet
(43, 25, 32, 1, 119.99, 119.99);  -- Chef's Knife Set

-- Order 26: Webcam
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(44, 26, 15, 1, 59.99, 59.99);    -- Webcam

-- Order 27: Hiking Backpack
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(45, 27, 29, 1, 89.99, 89.99);    -- Hiking Backpack

-- --------------------------------------------------------------------------
-- Charlie's order items
-- --------------------------------------------------------------------------

-- Order 6: Books + T-Shirts
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(10, 6, 6, 1, 39.99, 39.99),      -- Python Programming
(11, 6, 7, 1, 45.99, 45.99),      -- Web Development Guide
(12, 6, 9, 2, 19.99, 39.98);      -- Cotton T-Shirt x2 (subtotal adjusted from 39.98 to match legacy)

-- Order 7: Jeans + T-Shirts
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(13, 7, 10, 1, 49.99, 49.99),     -- Denim Jeans
(14, 7, 9, 4, 19.99, 79.96);      -- Cotton T-Shirt x4

-- Order 8: Laptop
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(15, 8, 1, 1, 1299.99, 1299.99);  -- Laptop Pro

-- Order 9: Monitor
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(16, 9, 5, 1, 449.99, 449.99);    -- 4K Monitor

-- Order 28: Standing Desk + Ergonomic Chair
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(46, 28, 23, 1, 399.99, 399.99),  -- Standing Desk
(47, 28, 24, 1, 549.99, 549.99);  -- Ergonomic Office Chair

-- Order 29: Resistance Bands + Yoga Mat
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(48, 29, 30, 1, 24.99, 24.99),    -- Resistance Bands
(49, 29, 27, 1, 34.99, 34.99);    -- Yoga Mat

-- Order 30: Winter Jacket + Hoodie
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(50, 30, 11, 1, 89.99, 89.99),    -- Winter Jacket
(51, 30, 21, 1, 39.99, 39.99);    -- Hoodie

-- Order 31: Smart Thermostat
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(52, 31, 22, 1, 149.99, 149.99);  -- Smart Thermostat

-- Order 32: Chef's Knife Set + Cast Iron Skillet
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(53, 32, 32, 1, 119.99, 119.99),  -- Chef's Knife Set
(54, 32, 33, 1, 39.99, 39.99);    -- Cast Iron Skillet

-- --------------------------------------------------------------------------
-- Diana's order items
-- --------------------------------------------------------------------------

-- Order 10: Books + Desk Lamp
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(17, 10, 8, 1, 54.99, 54.99),     -- Data Science Handbook
(18, 10, 7, 1, 45.99, 45.99),     -- Web Development Guide
(19, 10, 14, 1, 19.00, 19.00);    -- LED Desk Lamp (discounted)

-- Order 11: Laptop (CANCELLED)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(20, 11, 1, 1, 1299.99, 1299.99); -- Laptop Pro

-- Order 33: Running Shoes + T-Shirts
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(55, 33, 20, 1, 74.99, 74.99),    -- Running Shoes
(56, 33, 9, 3, 19.99, 59.97);     -- Cotton T-Shirt x3

-- Order 34: Coffee Maker + Cast Iron Skillet
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(57, 34, 31, 1, 79.99, 79.99),    -- Coffee Maker
(58, 34, 33, 1, 39.99, 39.99);    -- Cast Iron Skillet

-- Order 35: Yoga Mat + Resistance Bands
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(59, 35, 27, 1, 34.99, 34.99),    -- Yoga Mat
(60, 35, 30, 1, 24.99, 24.99);    -- Resistance Bands

-- Order 36: Mechanical Keyboard + Portable SSD
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(61, 36, 17, 1, 129.99, 129.99),  -- Mechanical Keyboard
(62, 36, 16, 1, 89.99, 89.99);    -- Portable SSD

-- Order 99: French Press + Water Bottle
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(175, 99, 34, 1, 29.99, 29.99),   -- French Press
(176, 99, 28, 1, 19.99, 19.99);   -- Water Bottle

-- --------------------------------------------------------------------------
-- Eve's order items
-- --------------------------------------------------------------------------

-- Order 12: Headphones + Mouse
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(21, 12, 4, 1, 199.99, 199.99),   -- Bluetooth Headphones
(22, 12, 2, 1, 24.99, 24.99);     -- Wireless Mouse

-- Order 13: Garden Tools
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(23, 13, 12, 1, 79.99, 79.99);    -- Garden Tools Set

-- Order 37: Hoodie + Denim Jeans
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(63, 37, 21, 1, 39.99, 39.99),    -- Hoodie
(64, 37, 10, 1, 49.99, 49.99);    -- Denim Jeans

-- Order 38: Garden Tools Set + Plant Pot Set
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(65, 38, 12, 1, 79.99, 79.99),    -- Garden Tools Set
(66, 38, 13, 1, 34.99, 34.99);    -- Plant Pot Set

-- Order 39: Cloud Architecture + ML Fundamentals
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(67, 39, 18, 1, 49.99, 49.99),    -- Cloud Architecture Patterns
(68, 39, 19, 1, 59.99, 59.99);    -- ML Fundamentals

-- Order 100: Smart Thermostat + LED Desk Lamp
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(177, 100, 22, 1, 149.99, 149.99), -- Smart Thermostat
(178, 100, 14, 1, 29.99, 29.99);   -- LED Desk Lamp

-- --------------------------------------------------------------------------
-- Frank's order items
-- --------------------------------------------------------------------------

-- Order 14: Monitor + Cables
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(24, 14, 5, 1, 449.99, 449.99),   -- 4K Monitor
(25, 14, 3, 2, 12.99, 25.98);     -- USB-C Cable x2 (price adjusted)

-- Order 15: Winter Jacket + T-Shirts
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(26, 15, 11, 1, 89.99, 89.99),    -- Winter Jacket
(27, 15, 9, 4, 19.99, 79.98);     -- Cotton T-Shirt x4

-- Order 40: Running Shoes + Water Bottle
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(69, 40, 20, 1, 74.99, 74.99),    -- Running Shoes
(70, 40, 28, 1, 19.99, 19.99);    -- Water Bottle

-- Order 41: Whiteboard + Desk Organizer
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(71, 41, 26, 1, 44.99, 44.99),    -- Whiteboard
(72, 41, 25, 1, 24.99, 24.99);    -- Desk Organizer

-- Order 42: Hiking Backpack + Yoga Mat
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(73, 42, 29, 1, 89.99, 89.99),    -- Hiking Backpack
(74, 42, 27, 1, 34.99, 34.99);    -- Yoga Mat

-- --------------------------------------------------------------------------
-- Grace's order items — dev workstation build
-- --------------------------------------------------------------------------

-- Order 43: Laptop + Mouse (day 1)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(75, 43, 1, 1, 1299.99, 1299.99), -- Laptop Pro
(76, 43, 2, 1, 24.99, 24.99);     -- Wireless Mouse

-- Order 44: Monitor + Keyboard (day 3)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(77, 44, 5, 1, 449.99, 449.99),   -- 4K Monitor
(78, 44, 17, 1, 129.99, 129.99);  -- Mechanical Keyboard

-- Order 45: Standing Desk + Chair (day 6)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(79, 45, 23, 1, 399.99, 399.99),  -- Standing Desk
(80, 45, 24, 1, 549.99, 549.99);  -- Ergonomic Office Chair

-- Order 46: Cables + Lamp + Webcam (day 8)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(81, 46, 3, 3, 12.99, 38.97),     -- USB-C Cable x3
(82, 46, 14, 1, 29.99, 29.99),    -- LED Desk Lamp
(83, 46, 15, 1, 59.99, 59.99);    -- Webcam

-- Order 47: SSD + Headphones (day 17)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(84, 47, 16, 1, 89.99, 89.99),    -- Portable SSD
(85, 47, 4, 1, 199.99, 199.99);   -- Bluetooth Headphones

-- Order 48: Desk Organizer + Whiteboard (finishing touches)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(86, 48, 25, 1, 24.99, 24.99),    -- Desk Organizer
(87, 48, 26, 1, 44.99, 44.99);    -- Whiteboard

-- --------------------------------------------------------------------------
-- Henry's order items — fitness focus
-- --------------------------------------------------------------------------

-- Order 49: Yoga Mat + Bands + Bottle
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(88, 49, 27, 1, 34.99, 34.99),    -- Yoga Mat
(89, 49, 30, 1, 24.99, 24.99),    -- Resistance Bands
(90, 49, 28, 1, 19.99, 19.99);    -- Water Bottle

-- Order 50: Running Shoes + Hoodie
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(91, 50, 20, 1, 74.99, 74.99),    -- Running Shoes
(92, 50, 21, 1, 39.99, 39.99);    -- Hoodie

-- Order 51: Hiking Backpack
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(93, 51, 29, 1, 89.99, 89.99);    -- Hiking Backpack

-- Order 52: T-Shirts + Water Bottle
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(94, 52, 9, 3, 19.99, 59.97),     -- Cotton T-Shirt x3
(95, 52, 28, 1, 19.99, 19.99);    -- Water Bottle

-- Order 53: Jeans + Winter Jacket
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(96, 53, 10, 1, 49.99, 49.99),    -- Denim Jeans
(97, 53, 11, 1, 89.99, 89.99);    -- Winter Jacket

-- --------------------------------------------------------------------------
-- Irene's order items — books → tech transition
-- --------------------------------------------------------------------------

-- Order 54: Python + Web Dev (starting to learn)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(98, 54, 6, 1, 39.99, 39.99),     -- Python Programming
(99, 54, 7, 1, 45.99, 45.99);     -- Web Development Guide

-- Order 55: Data Science + ML
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(100, 55, 8, 1, 54.99, 54.99),    -- Data Science Handbook
(101, 55, 19, 1, 59.99, 59.99);   -- ML Fundamentals

-- Order 56: Cloud Architecture
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(102, 56, 18, 1, 49.99, 49.99);   -- Cloud Architecture Patterns

-- Order 57: Laptop (ready to practice)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(103, 57, 1, 1, 1299.99, 1299.99); -- Laptop Pro

-- Order 58: SSD + Cables
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(104, 58, 16, 1, 89.99, 89.99),   -- Portable SSD
(105, 58, 3, 2, 12.99, 25.98);    -- USB-C Cable x2

-- Order 59: Keyboard + Webcam
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(106, 59, 17, 1, 129.99, 129.99), -- Mechanical Keyboard
(107, 59, 15, 1, 59.99, 59.99);   -- Webcam

-- --------------------------------------------------------------------------
-- Jack's order items — holiday gift runs
-- --------------------------------------------------------------------------

-- Order 60: Winter Jacket x2 + Hoodie x2
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(108, 60, 11, 2, 89.99, 179.98),  -- Winter Jacket x2
(109, 60, 21, 2, 39.99, 79.98);   -- Hoodie x2

-- Order 61: Headphones + Wireless Mouse x2 (Black Friday)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(110, 61, 4, 1, 199.99, 199.99),  -- Bluetooth Headphones
(111, 61, 2, 2, 24.99, 49.98);    -- Wireless Mouse x2

-- Order 62: Coffee Maker + French Press + Knife Set
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(112, 62, 31, 1, 79.99, 79.99),   -- Coffee Maker
(113, 62, 34, 1, 29.99, 29.99),   -- French Press
(114, 62, 32, 1, 119.99, 119.99); -- Chef's Knife Set

-- Order 63: Python + ML books (gift for nephew)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(115, 63, 6, 1, 39.99, 39.99),    -- Python Programming
(116, 63, 19, 1, 59.99, 59.99);   -- ML Fundamentals

-- Order 64: Plant Pots + Garden Tools (gift for parents)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(117, 64, 13, 2, 34.99, 69.98),   -- Plant Pot Set x2
(118, 64, 12, 1, 79.99, 79.99);   -- Garden Tools Set

-- Order 65: T-Shirts + Water Bottles (stocking stuffers)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(119, 65, 9, 4, 19.99, 79.96),    -- Cotton T-Shirt x4
(120, 65, 28, 3, 19.99, 59.97);   -- Water Bottle x3

-- Order 66: Chair + Desk (holiday 2025, gift for partner)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(121, 66, 24, 1, 549.99, 549.99), -- Ergonomic Office Chair
(122, 66, 23, 1, 399.99, 399.99); -- Standing Desk

-- Order 67: SSD x2 + Keyboard (holiday 2025)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(123, 67, 16, 2, 89.99, 179.98),  -- Portable SSD x2
(124, 67, 17, 1, 129.99, 129.99); -- Mechanical Keyboard

-- --------------------------------------------------------------------------
-- Karen's order items — home office setup
-- --------------------------------------------------------------------------

-- Order 68: Standing Desk
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(125, 68, 23, 1, 399.99, 399.99); -- Standing Desk

-- Order 69: Ergonomic Chair
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(126, 69, 24, 1, 549.99, 549.99); -- Ergonomic Office Chair

-- Order 70: Laptop + Webcam
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(127, 70, 1, 1, 1299.99, 1299.99), -- Laptop Pro
(128, 70, 15, 1, 59.99, 59.99);    -- Webcam

-- Order 71: Monitor + Keyboard
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(129, 71, 5, 1, 449.99, 449.99),  -- 4K Monitor
(130, 71, 17, 1, 129.99, 129.99); -- Mechanical Keyboard

-- Order 72: Lamp + Organizer + Cables
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(131, 72, 14, 1, 29.99, 29.99),   -- LED Desk Lamp
(132, 72, 25, 1, 24.99, 24.99),   -- Desk Organizer
(133, 72, 3, 3, 12.99, 38.97);    -- USB-C Cable x3

-- Order 73: Whiteboard + Headphones
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(134, 73, 26, 1, 44.99, 44.99),   -- Whiteboard
(135, 73, 4, 1, 199.99, 199.99);  -- Bluetooth Headphones

-- Order 74: Python + Cloud Architecture (learning)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(136, 74, 6, 1, 39.99, 39.99),    -- Python Programming
(137, 74, 18, 1, 49.99, 49.99);   -- Cloud Architecture Patterns

-- --------------------------------------------------------------------------
-- Leo's order items — casual buyer
-- --------------------------------------------------------------------------

-- Order 75: Wireless Mouse
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(138, 75, 2, 1, 24.99, 24.99);    -- Wireless Mouse

-- Order 76: T-Shirts
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(139, 76, 9, 2, 19.99, 39.98);    -- Cotton T-Shirt x2

-- Order 77: Jeans + Hoodie
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(140, 77, 10, 1, 49.99, 49.99),   -- Denim Jeans
(141, 77, 21, 1, 39.99, 39.99);   -- Hoodie

-- Order 78: Coffee Maker
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(142, 78, 31, 1, 79.99, 79.99);   -- Coffee Maker

-- Order 79: French Press
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(143, 79, 34, 1, 29.99, 29.99);   -- French Press

-- --------------------------------------------------------------------------
-- Mia's order items — loyal monthly buyer
-- --------------------------------------------------------------------------

-- Order 80: Python Programming
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(144, 80, 6, 1, 39.99, 39.99);    -- Python Programming

-- Order 81: Mouse + Cable
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(145, 81, 2, 1, 24.99, 24.99),    -- Wireless Mouse
(146, 81, 3, 1, 12.99, 12.99);    -- USB-C Cable

-- Order 82: T-Shirts + Jeans
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(147, 82, 9, 2, 19.99, 39.98),    -- Cotton T-Shirt x2
(148, 82, 10, 1, 49.99, 49.99);   -- Denim Jeans

-- Order 83: Headphones
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(149, 83, 4, 1, 199.99, 199.99);  -- Bluetooth Headphones

-- Order 84: Hiking Backpack + Running Shoes
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(150, 84, 29, 1, 89.99, 89.99),   -- Hiking Backpack
(151, 84, 20, 1, 74.99, 74.99);   -- Running Shoes

-- Order 85: Webcam + SSD
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(152, 85, 15, 1, 59.99, 59.99),   -- Webcam
(153, 85, 16, 1, 89.99, 89.99);   -- Portable SSD

-- Order 86: Winter Jacket + Hoodie
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(154, 86, 11, 1, 89.99, 89.99),   -- Winter Jacket
(155, 86, 21, 1, 39.99, 39.99);   -- Hoodie

-- Order 87: Cloud Architecture
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(156, 87, 18, 1, 49.99, 49.99);   -- Cloud Architecture Patterns

-- Order 88: Standing Desk
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(157, 88, 23, 1, 399.99, 399.99); -- Standing Desk

-- Order 89: 4K Monitor
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(158, 89, 5, 1, 449.99, 449.99);  -- 4K Monitor

-- Order 90: Chef's Knife Set + Cast Iron Skillet
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(159, 90, 32, 1, 119.99, 119.99), -- Chef's Knife Set
(160, 90, 33, 1, 39.99, 39.99);   -- Cast Iron Skillet

-- Order 91: Ergonomic Chair
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(161, 91, 24, 1, 549.99, 549.99); -- Ergonomic Office Chair

-- Order 92: Resistance Bands + Water Bottle + Yoga Mat
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(162, 92, 30, 1, 24.99, 24.99),   -- Resistance Bands
(163, 92, 28, 1, 19.99, 19.99),   -- Water Bottle
(164, 92, 27, 1, 34.99, 34.99);   -- Yoga Mat

-- Order 93: French Press
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(165, 93, 34, 1, 29.99, 29.99);   -- French Press

-- --------------------------------------------------------------------------
-- Nathan's order items — new customer, books → hardware
-- --------------------------------------------------------------------------

-- Order 94: Python + ML books (learning phase)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(166, 94, 6, 1, 39.99, 39.99),    -- Python Programming
(167, 94, 19, 1, 59.99, 59.99);   -- ML Fundamentals

-- Order 95: SSD + Cables
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(168, 95, 16, 1, 89.99, 89.99),   -- Portable SSD
(169, 95, 3, 2, 12.99, 25.98);    -- USB-C Cable x2

-- Order 96: Data Science + Cloud Architecture
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(170, 96, 8, 1, 54.99, 54.99),    -- Data Science Handbook
(171, 96, 18, 1, 49.99, 49.99);   -- Cloud Architecture Patterns

-- Order 97: Laptop (ready to build)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(172, 97, 1, 1, 1299.99, 1299.99); -- Laptop Pro

-- Order 98: Monitor + Keyboard (pending)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(173, 98, 5, 1, 449.99, 449.99),  -- 4K Monitor
(174, 98, 17, 1, 129.99, 129.99); -- Mechanical Keyboard

-- ============================================================================
-- REVIEWS (38 reviews — mix of glowing, measured, and critical)
-- ============================================================================

-- --------------------------------------------------------------------------
-- Product 1: Laptop Pro (5 reviews, avg ~4.6)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(1,  1, 1, 5, 'Excellent laptop!',
    'Fast shipping, great performance. Perfect for development work. The keyboard is comfortable and the screen is crisp.',
    1, 12, '2024-01-26 10:00:00', '2024-01-26 10:00:00'),
(2,  1, 2, 5, 'Best purchase this year',
    'Amazing build quality and battery life. Handles everything I throw at it with ease. Highly recommended!',
    1, 8, '2024-02-01 14:30:00', '2024-02-01 14:30:00'),
(3,  1, 3, 4, 'Great but pricey',
    'Excellent laptop but wish it was a bit cheaper. Performance is top-notch though.',
    1, 5, '2024-02-12 16:45:00', '2024-02-12 16:45:00'),
(34, 1, 7, 5, 'Developer''s dream machine',
    'Runs Docker, multiple IDEs, and a local Kubernetes cluster without breaking a sweat. Best investment I''ve made for my career. The fan noise is almost nonexistent compared to my old machine.',
    1, 14, '2024-03-12 09:30:00', '2024-03-12 09:30:00'),
(35, 1, 11, 4, 'Great laptop, frustrating delivery',
    'The laptop itself is superb — fast, beautiful screen, solid keyboard. Knocked off a star because it took 6 days to arrive despite paying for expedited shipping. Support was unhelpful when I called. The product deserves 5 stars, the experience deserves 3.',
    1, 22, '2025-01-24 11:00:00', '2025-01-24 11:00:00');

-- --------------------------------------------------------------------------
-- Product 4: Bluetooth Headphones (3 reviews, avg 4.0)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(4,  4, 1, 4, 'Good sound quality',
    'Nice bass, comfortable fit. Battery lasts long. Noise cancellation works well on flights.',
    1, 6, '2024-02-06 11:20:00', '2024-02-06 11:20:00'),
(5,  4, 5, 5, 'Perfect for commuting',
    'Great noise cancellation and comfort. Use them daily for my commute. Worth every penny!',
    1, 9, '2024-02-13 09:15:00', '2024-02-13 09:15:00'),
(6,  4, 6, 3, 'Decent but not amazing',
    'Sound is okay but expected better at this price point. Comfort is good though.',
    0, 2, '2024-02-11 15:30:00', '2024-02-11 15:30:00');

-- --------------------------------------------------------------------------
-- Product 2: Wireless Mouse (2 reviews, avg 4.5)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(7,  2, 1, 5, 'Great value',
    'Smooth tracking, responsive. Best mouse in this price range. Battery lasts months!',
    1, 15, '2024-01-27 12:00:00', '2024-01-27 12:00:00'),
(8,  2, 4, 4, 'Solid mouse',
    'Works well, good battery life. Comfortable grip for long work sessions.',
    0, 4, '2024-02-10 10:30:00', '2024-02-10 10:30:00');

-- --------------------------------------------------------------------------
-- Product 5: 4K Monitor (2 reviews, avg 4.5)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(9,  5, 1, 5, 'Crystal clear display',
    'Perfect for design work. Colors are accurate and the 4K resolution is stunning.',
    1, 7, '2024-02-12 14:00:00', '2024-02-12 14:00:00'),
(10, 5, 2, 4, 'Good monitor',
    'Sharp display, good color accuracy. Stand could be better but overall happy with purchase.',
    1, 3, '2024-02-02 11:00:00', '2024-02-02 11:00:00');

-- --------------------------------------------------------------------------
-- Product 6: Python Programming (2 reviews, avg 4.5)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(11, 6, 3, 5, 'Best Python book',
    'Clear explanations, great examples. Perfect for beginners and intermediate developers.',
    1, 11, '2024-02-08 09:00:00', '2024-02-08 09:00:00'),
(12, 6, 1, 4, 'Solid resource',
    'Good content, well organized. Some sections could go deeper but overall very useful.',
    1, 6, '2024-02-13 10:30:00', '2024-02-13 10:30:00');

-- --------------------------------------------------------------------------
-- Product 9: Cotton T-Shirt (2 reviews, avg 4.5)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(13, 9, 3, 5, 'Comfortable and durable',
    'Great quality cotton. Washes well, color stays vibrant. Ordering more!',
    1, 8, '2024-02-10 15:00:00', '2024-02-10 15:00:00'),
(14, 9, 5, 4, 'Good basic tee',
    'Comfortable fit, good value. True to size. Fabric is soft.',
    0, 3, '2024-02-12 11:00:00', '2024-02-12 11:00:00');

-- --------------------------------------------------------------------------
-- Product 3: USB-C Cable (2 reviews, avg 4.5)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(15, 3, 1, 5, 'Reliable cable',
    'Fast charging, durable build. Bought multiple for work and home.',
    1, 10, '2024-02-09 08:00:00', '2024-02-09 08:00:00'),
(16, 3, 6, 4, 'Works great',
    'Good quality cable, fast data transfer. Good length for desk setup.',
    1, 2, '2024-02-15 14:00:00', '2024-02-15 14:00:00');

-- --------------------------------------------------------------------------
-- Product 11: Winter Jacket (1 review)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(17, 11, 6, 5, 'Warm and stylish',
    'Perfect for cold weather. Looks great and keeps me warm. Water resistant too!',
    1, 5, '2024-02-12 16:00:00', '2024-02-12 16:00:00');

-- --------------------------------------------------------------------------
-- Product 8: Data Science Handbook (1 review)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(18, 8, 4, 5, 'Comprehensive guide',
    'Covers all the essentials. Great reference book for data science projects.',
    1, 4, '2024-02-11 13:00:00', '2024-02-11 13:00:00');

-- --------------------------------------------------------------------------
-- Product 17: Mechanical Keyboard (2 reviews, avg 4.5)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(19, 17, 7, 5, 'Perfect for coding marathons',
    'The Cherry MX Browns hit the sweet spot — tactile enough to feel each keypress without driving your coworkers insane. Build quality is tank-like. After a month of 10-hour days this thing still feels brand new.',
    1, 18, '2024-03-28 10:00:00', '2024-03-28 10:00:00'),
(20, 17, 9, 4, 'Great keyboard, louder than expected',
    'Typing feel is excellent and the RGB backlighting is tasteful. However, the Browns are noticeably louder than I expected from the reviews. Fine for a home office but I wouldn''t use this in a shared workspace. Build and features are top-tier though.',
    1, 7, '2025-02-12 14:30:00', '2025-02-12 14:30:00');

-- --------------------------------------------------------------------------
-- Product 23: Standing Desk (3 reviews, avg 4.0)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(21, 23, 7, 4, 'Great desk, painful assembly',
    'The desk itself is fantastic — smooth motor, solid bamboo top, looks professional. But the assembly instructions are atrocious. Took me 3 hours and I had to watch YouTube videos to figure out steps that were just arrows pointing at nothing. The included Allen wrench is flimsy too. Buy a decent hex set before you start.',
    1, 25, '2024-03-22 09:00:00', '2024-03-22 09:00:00'),
(22, 23, 11, 5, 'Best desk I''ve ever owned',
    'Whisper-quiet motor, beautiful bamboo surface, and the memory presets are a game-changer. Going from sitting to standing with one button press means I actually use the feature instead of leaving it at one height all day.',
    1, 11, '2025-01-18 10:00:00', '2025-01-18 10:00:00'),
(23, 23, 3, 3, 'Wobbles at standing height',
    'Looks nice and the motor is smooth, but at full standing height (I''m 6''2") there is noticeable wobble when typing. I ended up shimming the feet and adding a crossbar from a hardware store. For $400 I shouldn''t have to DIY stability fixes. Sits fine at lower heights.',
    1, 31, '2024-05-15 16:00:00', '2024-05-15 16:00:00');

-- --------------------------------------------------------------------------
-- Product 24: Ergonomic Office Chair (2 reviews, avg 4.5)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(24, 24, 11, 5, 'Worth every penny for my back',
    'After years of cheap chairs and back pain, this was a revelation. The mesh breathes well, the adjustments are intuitive, and I can sit for 8 hours without discomfort. It''s expensive but way cheaper than a chiropractor.',
    1, 16, '2025-01-22 11:00:00', '2025-01-22 11:00:00'),
(25, 24, 3, 4, 'Comfortable but lumbar support is mediocre',
    'Overall a good chair — breathable mesh, smooth recline, solid build. But the lumbar support pad feels like an afterthought. It doesn''t stay in the right position and the adjustment range is too small for larger frames. I ended up buying a separate lumbar pillow. Still better than most chairs at this price.',
    1, 13, '2024-05-18 14:00:00', '2024-05-18 14:00:00');

-- --------------------------------------------------------------------------
-- Product 16: Portable SSD (2 reviews, avg 4.5)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(26, 16, 13, 5, 'Lightning fast transfers',
    'Transferred 200GB of project files in under 5 minutes. The build feels rugged and the silicone bumper gives peace of mind throwing it in a bag. Best portable drive I''ve owned.',
    1, 9, '2024-10-08 10:00:00', '2024-10-08 10:00:00'),
(27, 16, 14, 4, 'Fast but runs warm',
    'Transfer speeds are impressive and the size is perfect. My only concern is it gets noticeably warm during large sustained transfers — not hot enough to worry about data, but warm enough that I looked it up online. Apparently normal for NVMe drives. Would still buy again.',
    1, 6, '2025-11-22 15:00:00', '2025-11-22 15:00:00');

-- --------------------------------------------------------------------------
-- Product 19: Machine Learning Fundamentals (2 reviews, avg 4.0)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(28, 19, 9, 5, 'This book changed my career trajectory',
    'I went from knowing nothing about ML to building a working recommendation engine for my side project. The progression from linear regression through neural networks is perfectly paced. The practical exercises at the end of each chapter are worth the price alone.',
    1, 20, '2024-06-10 09:00:00', '2024-06-10 09:00:00'),
(29, 19, 14, 3, 'Good foundations but code examples are dated',
    'The theoretical explanations are clear and well-structured. However, several code examples use deprecated sklearn APIs and the TensorFlow sections still reference TF 1.x patterns. I spent more time debugging import errors than learning concepts. The author should really publish an updated edition. Still useful for the theory.',
    1, 17, '2025-11-05 10:30:00', '2025-11-05 10:30:00');

-- --------------------------------------------------------------------------
-- Product 31: Coffee Maker (2 reviews, avg 4.5)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(30, 31, 12, 4, 'Makes great coffee, feels cheap',
    'The coffee it brews is genuinely excellent — hot, well-extracted, and the delay brew feature means I wake up to fresh coffee. But the plastic carafe handle feels like it could snap off, and the buttons have that squishy membrane-keyboard feel. For $80 I expected a more premium build. That said, I use it every single day and the coffee quality keeps me from complaining too loudly.',
    1, 11, '2024-11-25 08:30:00', '2024-11-25 08:30:00'),
(31, 31, 4, 5, 'Morning essential',
    'Delay brew is the best feature — set it the night before and wake up to fresh coffee. Easy to clean, consistent results. Bought one for my mother too.',
    1, 5, '2024-09-22 09:00:00', '2024-09-22 09:00:00');

-- --------------------------------------------------------------------------
-- Product 29: Hiking Backpack (2 reviews, avg 4.5)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(32, 29, 8, 5, 'Survived a Colorado thunderstorm',
    'Got caught in a sudden downpour on a 14er. Everything inside the pack was bone dry. The waterproof coating is legit, not just marketing. Comfortable hip belt distributes weight well and the hydration sleeve fits my 3L bladder perfectly. 10/10.',
    1, 19, '2024-07-08 18:00:00', '2024-07-08 18:00:00'),
(33, 29, 13, 4, 'Solid pack, wish it had more pockets',
    'Good capacity, genuinely waterproof, and the back ventilation keeps sweat to a minimum. My gripe is the pocket layout — there''s one big main compartment and two tiny side pockets. I want a dedicated pocket for my phone, one for snacks, and somewhere to stash trekking poles. Ended up buying strap-on pouches separately. The pack itself is great quality though.',
    1, 8, '2024-08-15 11:00:00', '2024-08-15 11:00:00');

-- --------------------------------------------------------------------------
-- Product 20: Running Shoes (1 review)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(36, 20, 8, 4, 'Comfortable but runs half a size small',
    'Great arch support and very lightweight — my feet barely notice them on long runs. Fair warning though: order a half size up. I normally wear 10.5 and these fit like a 10. Had to exchange them which was easy enough but worth mentioning. After getting the right size, no complaints at all.',
    1, 12, '2024-05-20 07:30:00', '2024-05-20 07:30:00');

-- --------------------------------------------------------------------------
-- Product 32: Chef's Knife Set (1 review)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(37, 32, 2, 5, 'Restaurant-quality knives at home',
    'The chef''s knife alone is worth the price — balanced, razor sharp, and holds its edge through meal prep for a family of four. The block is attractive on the counter and the full set covers everything from bread to boning. Best kitchen upgrade I''ve made.',
    1, 10, '2024-11-18 14:00:00', '2024-11-18 14:00:00');

-- --------------------------------------------------------------------------
-- Product 22: Smart Thermostat (1 review — critical)
-- --------------------------------------------------------------------------

INSERT INTO reviews (review_id, product_id, user_id, rating, title, comment, verified_purchase, helpful_count, created_at, updated_at) VALUES
(38, 22, 3, 2, 'App crashes constantly, thermostat is fine',
    'The actual thermostat hardware works well — accurate temperature readings, responsive controls on the unit itself, and the scheduling via the physical interface is fine. But the app is terrible. It crashes on both iOS and Android, takes 15+ seconds to connect to the device when it does work, and lost my schedule twice after updates. For a "smart" thermostat, the smart part is broken. I would have returned it but the HVAC integration was too annoying to redo. Fix the app and this is a 4-star product.',
    1, 28, '2025-05-02 10:00:00', '2025-05-02 10:00:00');

-- ============================================================================
-- CART ITEMS (13 active cart items across 7 users)
-- ============================================================================

-- Charlie's cart (user 3)
INSERT INTO cart_items (cart_item_id, user_id, product_id, quantity, added_at, updated_at) VALUES
(1, 3, 2, 2, '2024-02-13 10:00:00', '2024-02-13 10:00:00'),   -- Wireless Mouse x2
(2, 3, 3, 5, '2024-02-13 10:15:00', '2024-02-13 10:15:00'),   -- USB-C Cable x5
(3, 3, 7, 1, '2024-02-13 11:30:00', '2024-02-13 11:30:00');   -- Web Development Guide

-- Diana's cart (user 4) — still considering after cancelled order 11
INSERT INTO cart_items (cart_item_id, user_id, product_id, quantity, added_at, updated_at) VALUES
(4, 4, 1, 1, '2024-02-12 14:00:00', '2024-02-12 14:00:00'),   -- Laptop Pro
(5, 4, 5, 1, '2024-02-12 14:05:00', '2024-02-12 14:05:00');   -- 4K Monitor

-- Bob's cart (user 2)
INSERT INTO cart_items (cart_item_id, user_id, product_id, quantity, added_at, updated_at) VALUES
(6, 2, 3, 3, '2024-02-13 09:00:00', '2024-02-13 09:00:00'),   -- USB-C Cable x3
(7, 2, 13, 2, '2024-02-13 09:30:00', '2024-02-13 09:30:00');  -- Plant Pot Set x2

-- Eve's cart (user 5)
INSERT INTO cart_items (cart_item_id, user_id, product_id, quantity, added_at, updated_at) VALUES
(8, 5, 2, 1, '2024-02-13 16:00:00', '2024-02-13 16:00:00');   -- Wireless Mouse

-- Nathan's cart (user 14) — eyeing accessories for his new laptop
INSERT INTO cart_items (cart_item_id, user_id, product_id, quantity, added_at, updated_at) VALUES
(9,  14, 15, 1, '2026-02-06 10:00:00', '2026-02-06 10:00:00'), -- Webcam
(10, 14, 25, 1, '2026-02-06 10:15:00', '2026-02-06 10:15:00'); -- Desk Organizer

-- Grace's cart (user 7) — exploring kitchen gear
INSERT INTO cart_items (cart_item_id, user_id, product_id, quantity, added_at, updated_at) VALUES
(11, 7, 31, 1, '2026-01-05 09:30:00', '2026-01-05 09:30:00'), -- Coffee Maker
(12, 7, 34, 1, '2026-01-05 09:45:00', '2026-01-05 09:45:00'); -- French Press

-- Henry's cart (user 8) — considering tech gear
INSERT INTO cart_items (cart_item_id, user_id, product_id, quantity, added_at, updated_at) VALUES
(13, 8, 16, 1, '2025-06-10 08:00:00', '2025-06-10 08:00:00'); -- Portable SSD

-- ============================================================================
-- Sample data complete
-- ============================================================================
