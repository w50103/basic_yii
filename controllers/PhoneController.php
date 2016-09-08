<?php

namespace app\controllers;

use app\models\Phone;

class PhoneController extends \yii\web\Controller
{
    public function actionIndex($uuid)
    {
        for($i =1; $i<129; $i++){

            $res = Phone::getPhones($i, $uuid);
            if(!empty($res)){
                var_dump($res);

            }
        }
        return $this->render('index');
    }



}
