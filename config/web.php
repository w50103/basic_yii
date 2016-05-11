<?php

$params = require(__DIR__ . '/params.php');

$config = [
	'id' => '0x001', //最好为数字
	'basePath' => dirname(__DIR__),//系统 @app代表此
	//路径别名
	'aliases' => [
		'@name1' => 'path/to/path1',
		'@name2' => 'path/to/path2'
	],
	//定义启动阶段需要运行的组件
	'bootstrap' => ['log'],


	//注册多个其它地方使用的应用组件
	'components' => [
		'request' => [
			//###test
			// !!! insert a secret key in the following (if it is empty) - this is required by cookie validation
			'cookieValidationKey' => 'JUN0f4laEjQNNXmpRRnIK8vnIs0-uShl',
		],
		'cache' => [
			'class' => 'yii\caching\FileCache',
		],
		'user' => [
			'identityClass' => 'app\models\User',
			'enableAutoLogin' => true,
		],
		'errorHandler' => [
			'errorAction' => 'site/error',
		],
		'mailer' => [
			'class' => 'yii\swiftmailer\Mailer',
			// send all mails to a file by default. You have to set
			// 'useFileTransport' to false and configure a transport
			// for the mailer to send real emails.
			'useFileTransport' => true,
		],
		'log' => [
			'traceLevel' => YII_DEBUG ? 3 : 0,
			'targets' => [
				[
					'class' => 'yii\log\FileTarget',
					'levels' => ['error', 'warning'],
				],
			],
		],
		'db' => require(__DIR__ . '/local-db.php'),
		'phoneDB' => require (__DIR__.'/phone-db.php'),
		'urlManager' => [
			'enablePrettyUrl' => true,
			'showScriptName' => false,
		],
	],
	'params' => $params,
];

if(YII_ENV_DEV)
{
	// configuration adjustments for 'dev' environment
	$config['bootstrap'][] = 'debug';
	$config['modules']['debug'] = [
		'class' => 'yii\debug\Module',
	];

	$config['bootstrap'][] = 'gii';
	$config['modules']['gii'] = [
		'class' => 'yii\gii\Module',
		'allowedIPs' => ['127.0.0.1', '::1']
	];
}
return $config;
