<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\FailUser */

$this->title = 'Update Fail User: ' . ' ' . $model->name;
$this->params['breadcrumbs'][] = ['label' => 'Fail Users', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->name, 'url' => ['view', 'id' => $model->code]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="fail-user-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
