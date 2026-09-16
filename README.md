<<<<<<< HEAD
# online-bike-store
The project includes bike listings, product details, customer management, shopping functionality, and order processing.
=======
# Bike Shop — CodeIgniter 3 Application

This package converts the supplied HTML/CSS/image design into a server-side CodeIgniter 3 + MySQL ecommerce application.

## Implemented
- Existing visual assets preserved under `assets/`.
- Home/product catalog backed by MySQL.
- Customer registration/login/logout using PHP password hashing and CI sessions.
- Server-side shopping cart with quantities, remove, update and empty actions.
- Authenticated checkout with shipping address and payment-method selection.
- Orders persisted in MySQL with order items and confirmation page.
- Customer dashboard and profile update/password change.
- Contact-message storage.
- Admin dashboard, product CRUD and order-status management.
- CSRF protection, form validation and authorization checks.
- Database schema + seed products.

## Requirements
- PHP 7.4+ (PHP 8.x recommended for the host)
- MySQL/MariaDB
- Apache with mod_rewrite, or equivalent rewrite rules
- CodeIgniter 3.1.13

## Install
1. Download/extract the official CodeIgniter 3.1.13 framework so its `system/` directory is beside this project's `index.php`. The included `composer.json` also pins `codeigniter/framework` to 3.1.13 if you prefer Composer.
2. Import `sql/bike_shop.sql` into MySQL.
3. Edit `application/config/database.php` with your DB username/password/database.
4. Change `application/config/config.php` `$config['base_url']` to your real URL and set a strong `$config['encryption_key']`.
5. Make sure `application/cache/` is writable if your deployment uses it.
6. Point Apache's document root at this project folder.
7. Open `/`.

## Demo admin
Username: `admin`
Email: `admin@bikeshop.local`
Password: `ChangeMe123!`

**Change the demo password immediately in production.**

## Payment note
The original HTML simulated card/banking/Paytm completion entirely in the browser. This implementation deliberately does not store card numbers/CVV. For production online payments, connect a real gateway (Stripe, PayPal, JazzCash, Easypaisa, etc.) and verify payment server-side through its API/webhooks.

## Mapping from original HTML
- `index.html` -> `Home::index()`
- `login.html` -> `Auth::login()`
- `register.html` -> `Auth::register()`
- `cart.html` -> `Cart::index()`
- `checkout.html` -> `Checkout::index()` / `Checkout::place_order()`
- `order.html` -> `Orders::index()`
- `orderconfirmation.html` -> `Orders::confirmation()`
- `dashboard.html` -> `Account::index()`
- `profile-edit.html` -> `Account::profile()` / `Account::update_profile()`

The original ZIP is kept outside the generated project; the project uses the supplied CSS and image assets in the new CI3 structure.
>>>>>>> c573a35 (initial commit)
