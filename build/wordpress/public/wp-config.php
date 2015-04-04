<?php
/**
 * Stolen shamelessly with some modifications from Mark Jaquith WordPress and John P Bloch.
 * Skeleton project: https://github.com/markjaquith/WordPress-Skeleton
 * WordPress project: https://github.com/johnpbloch/wordpress-project
 */

require_once(dirname(__DIR__) . '/vendor/autoload.php');

/**
 * Load database info and local parameters.
 */
if (file_exists(__DIR__ . 'local-config.php')) {
	// Production
	include(__DIR__ . 'local-config.php');
} else {
	// Development
	define('WP_DEBUG', true);
	define('WP_DEBUG_LOG', true);
	define('WP_DEBUG_DISPLAY', true);
	define('SCRIPT_DEBUG', true);
	define('SAVEQUERIES', true);

	define('WP_HTTP_BLOCK_EXTERNAL', false);

	define('DB_NAME', 'wpbox');
	define('DB_USER', 'wpbox');
	define('DB_PASSWORD', 'wpbox');
	define('DB_HOST', '127.0.0.1');
}

/**
 * Database Charset and Collate type. Don't change this if in doubt.
 */
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * Custom content directories.
 */
define('WP_CONTENT_DIR', __DIR__ . '/content');
define('WP_CONTENT_URL', 'http://' . $_SERVER['HTTP_HOST'] . '/content');
define('UPLOADS', '../uploads');

/**
 * Tell WordPress where the source files are.
 */
define('WP_SITEURL', 'http://' . $_SERVER['HTTP_HOST'] . '/wp');
define('WP_HOME',    'http://' . $_SERVER['HTTP_HOST']);

/**
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 */
define('AUTH_KEY',         'put your unique phrase here');
define('SECURE_AUTH_KEY',  'put your unique phrase here');
define('LOGGED_IN_KEY',    'put your unique phrase here');
define('NONCE_KEY',        'put your unique phrase here');
define('AUTH_SALT',        'put your unique phrase here');
define('SECURE_AUTH_SALT', 'put your unique phrase here');
define('LOGGED_IN_SALT',   'put your unique phrase here');
define('NONCE_SALT',       'put your unique phrase here');

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * Security.
 *
 * No file edits unless explicitly allowed in local-config.php.
 */
define('DISALLOW_FILE_EDIT', true);
define('DISALLOW_FILE_MODS', true);
define('WP_AUTO_UPDATE_CORE', false);
define('AUTOMATIC_UPDATER_DISABLED', true);

/**
 * Absolute path to the WordPress directory.
 */
if (!defined('ABSPATH')) {
	define('ABSPATH', __DIR__ . '/wp/');
}
require_once(ABSPATH . 'wp-settings.php');
