```php
<?php

/*
 *---------------------------------------------------------------
 * APPLICATION ENVIRONMENT
 *---------------------------------------------------------------
 *
 * You can load different configurations depending on the
 * environment.
 */

if (!defined('ENVIRONMENT')) {
    define(
        'ENVIRONMENT',
        isset($_SERVER['CI_ENV']) ? $_SERVER['CI_ENV'] : 'development'
    );
}


/*
 *---------------------------------------------------------------
 * ERROR REPORTING
 *---------------------------------------------------------------
 *
 * CodeIgniter 3.1.13 can produce compatibility notices on
 * newer PHP versions. Keep normal errors visible while hiding
 * deprecated notices.
 */

error_reporting(E_ALL & ~E_DEPRECATED & ~E_USER_DEPRECATED);


/*
 *---------------------------------------------------------------
 * DISPLAY ERRORS
 *---------------------------------------------------------------
 */

switch (ENVIRONMENT) {

    case 'development':
        ini_set('display_errors', 1);
        break;

    case 'testing':
    case 'production':
        ini_set('display_errors', 0);
        break;

    default:
        header('HTTP/1.1 503 Service Unavailable.', TRUE, 503);
        echo 'The application environment is not set correctly.';
        exit(1);
}


/*
 *---------------------------------------------------------------
 * SYSTEM DIRECTORY NAME
 *---------------------------------------------------------------
 */

$system_path = 'system';


/*
 *---------------------------------------------------------------
 * APPLICATION DIRECTORY NAME
 *---------------------------------------------------------------
 */

$application_folder = 'application';


/*
 *---------------------------------------------------------------
 * VIEW DIRECTORY NAME
 *---------------------------------------------------------------
 */

$view_folder = '';


/*
 *---------------------------------------------------------------
 * SET CURRENT DIRECTORY
 *---------------------------------------------------------------
 */

if (defined('STDIN')) {
    chdir(dirname(__FILE__));
}


/*
 *---------------------------------------------------------------
 * DETERMINE SYSTEM PATH
 *---------------------------------------------------------------
 */

if (($_temp = realpath($system_path)) !== FALSE) {

    $system_path = $_temp . DIRECTORY_SEPARATOR;

} else {

    $system_path = strtr(
        rtrim($system_path, '/\\'),
        '/\\',
        DIRECTORY_SEPARATOR . DIRECTORY_SEPARATOR
    ) . DIRECTORY_SEPARATOR;
}


/*
 *---------------------------------------------------------------
 * TEST SYSTEM DIRECTORY
 *---------------------------------------------------------------
 */

if (!is_dir($system_path)) {

    header('HTTP/1.1 503 Service Unavailable.', TRUE, 503);

    echo 'Your system folder path does not appear to be set correctly.';

    exit(3);
}


/*
 *---------------------------------------------------------------
 * DEFINE BASEPATH
 *---------------------------------------------------------------
 */

define('BASEPATH', $system_path);


/*
 *---------------------------------------------------------------
 * DEFINE FRONT CONTROLLER PATH
 *---------------------------------------------------------------
 */

define('FCPATH', dirname(__FILE__) . DIRECTORY_SEPARATOR);


/*
 *---------------------------------------------------------------
 * DEFINE SYSTEM DIRECTORY NAME
 *---------------------------------------------------------------
 */

define('SYSDIR', basename(BASEPATH));


/*
 *---------------------------------------------------------------
 * DETERMINE APPLICATION PATH
 *---------------------------------------------------------------
 */

if (is_dir($application_folder)) {

    if (($_temp = realpath($application_folder)) !== FALSE) {

        $application_folder = $_temp;

    } else {

        $application_folder = strtr(
            rtrim($application_folder, '/\\'),
            '/\\',
            DIRECTORY_SEPARATOR . DIRECTORY_SEPARATOR
        );
    }

} else {

    if (!is_dir(BASEPATH . $application_folder . DIRECTORY_SEPARATOR)) {

        header('HTTP/1.1 503 Service Unavailable.', TRUE, 503);

        echo 'Your application folder path does not appear to be set correctly.';

        exit(3);
    }
}


/*
 *---------------------------------------------------------------
 * DEFINE APPLICATION PATH
 *---------------------------------------------------------------
 */

define('APPPATH', $application_folder . DIRECTORY_SEPARATOR);


/*
 *---------------------------------------------------------------
 * DETERMINE VIEW PATH
 *---------------------------------------------------------------
 */

if (!isset($view_folder[0]) && is_dir(APPPATH . 'views' . DIRECTORY_SEPARATOR)) {

    $view_folder = APPPATH . 'views';
}


/*
 *---------------------------------------------------------------
 * DETERMINE VIEW DIRECTORY
 *---------------------------------------------------------------
 */

if (is_dir($view_folder)) {

    if (($_temp = realpath($view_folder)) !== FALSE) {

        $view_folder = $_temp . DIRECTORY_SEPARATOR;

    } else {

        $view_folder = strtr(
            rtrim($view_folder, '/\\'),
            '/\\',
            DIRECTORY_SEPARATOR . DIRECTORY_SEPARATOR
        ) . DIRECTORY_SEPARATOR;
    }

} elseif (is_dir(APPPATH . 'views' . DIRECTORY_SEPARATOR)) {

    $view_folder = APPPATH . 'views' . DIRECTORY_SEPARATOR;

} else {

    header('HTTP/1.1 503 Service Unavailable.', TRUE, 503);

    echo 'Your view folder path does not appear to be set correctly.';

    exit(3);
}


/*
 *---------------------------------------------------------------
 * DEFINE VIEW PATH
 *---------------------------------------------------------------
 */

define('VIEWPATH', $view_folder);


/*
 *---------------------------------------------------------------
 * LOAD CODEIGNITER
 *---------------------------------------------------------------
 */

require_once BASEPATH . 'core/CodeIgniter.php';

