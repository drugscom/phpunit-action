<?php
// load mheap\GithubActionsReporter printer
require '/usr/local/shared/phpunit/Printers/mheap/GithubActionsReporter/Functions/helpers.php';
spl_autoload_register(function ($class) {
	$prefix = 'mheap\\GithubActionsReporter\\';
	$base_dir = '/usr/local/shared/phpunit/Printers/mheap/GithubActionsReporter/';

	$len = strlen($prefix);

	if (strncmp($prefix, $class, $len) !== 0) {
		return;
	}

	$relative_class = substr($class, $len);

	$file = $base_dir . str_replace('\\', '/', $relative_class) . '.php';

	if (file_exists($file)) {
		require $file;
	}
});


// bootstraping
use PHPUnit\TextUI\Arguments\ArgumentsBuilder;
use PHPUnit\TextUI\Configuration\Loader;

$aditionalBootstrap = getenv('PHPUNIT_ADDITIONAL_BOOTSTRAP');
if (!empty($aditionalBootstrap)) {
	include_once $aditionalBootstrap;
} else {
	$arguments = (new ArgumentsBuilder)->fromParameters($_SERVER['argv'], []);
	if ($arguments->hasConfiguration()) {
		$phpunitConfiguration = (new Loader)->load($arguments->configuration())->phpunit();
		if ($phpunitConfiguration->hasBootstrap()) {
			include_once $phpunitConfiguration->bootstrap();
		}
	}	
}
