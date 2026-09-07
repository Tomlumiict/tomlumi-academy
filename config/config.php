<?php
/**
 * Tomlumi Academy Configuration
 * Central configuration for database, paths, and system settings
 */

// ============================================
// DATABASE CONFIGURATION
// ============================================

define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'tomlumi_academy');
define('DB_PORT', 3306);

// ============================================
// SYSTEM PATHS
// ============================================

define('BASE_PATH', __DIR__ . '/..');
define('INCLUDES_PATH', BASE_PATH . '/includes');
define('CONFIG_PATH', BASE_PATH . '/config');
define('UPLOADS_PATH', BASE_PATH . '/uploads');
define('ASSETS_PATH', BASE_PATH . '/assets');

// ============================================
// URL CONFIGURATION
// ============================================

$protocol = isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? 'https' : 'http';
$host = $_SERVER['HTTP_HOST'];
define('BASE_URL', $protocol . '://' . $host . '/tomlumi_academy');
define('ASSETS_URL', BASE_URL . '/assets');
define('UPLOADS_URL', BASE_URL . '/uploads');

// ============================================
// SYSTEM INFORMATION
// ============================================

define('SYSTEM_NAME', 'Tomlumi Academy');
define('SYSTEM_TAGLINE', 'Personal, Educational, Professional, Digital-Learning & Communication Platform');
define('ADMIN_ACCESS_CODE_HASH', '$2y$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36joDMvu'); // hash of 7323932000

// ============================================
// TIME CONFIGURATION
// ============================================

define('TIMEZONE', 'Africa/Lusaka');
date_default_timezone_set(TIMEZONE);

// ============================================
// SESSION CONFIGURATION
// ============================================

define('SESSION_TIMEOUT', 3600); // 1 hour
define('SESSION_NAME', 'tomlumi_session');

// ============================================
// FILE UPLOAD CONFIGURATION
// ============================================

define('MAX_FILE_SIZE', 52428800); // 50MB
define('ALLOWED_DOCUMENT_TYPES', array('pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt'));
define('ALLOWED_IMAGE_TYPES', array('jpg', 'jpeg', 'png', 'gif', 'webp'));
define('ALLOWED_VIDEO_TYPES', array('mp4', 'avi', 'mov', 'webm'));

// ============================================
// PAGINATION
// ============================================

define('ITEMS_PER_PAGE', 10);
define('ADMIN_ITEMS_PER_PAGE', 20);

// ============================================
// EMAIL CONFIGURATION
// ============================================

define('MAIL_FROM', 'noreply@tomlumi.com');
define('MAIL_FROM_NAME', 'Tomlumi Academy');
define('SUPPORT_EMAIL', 'support@tomlumi.com');

// ============================================
// SECURITY FLAGS
// ============================================

define('ENABLE_DEBUG', false); // Set to true only in development
define('FORCE_HTTPS', false); // Set to true in production

// ============================================
// LOAD DATABASE CONNECTION
// ============================================

require_once CONFIG_PATH . '/database.php';
