<?php
/**
 * Created by IntelliJ IDEA.
 * User: neo
 * Date: 15/11/23
 * Time: 上午2:52
 */
use yii\helpers\Html;
use yii\widgets\ActiveForm;

?>

<?php $form = ActiveForm::begin();?>
<?= $form->field($model, 'name');?>
<?= $form->field($model, 'email');?>
<div class="form-group">
	<?= Html::submitButton('Submit',['class'=>'btn btn-primary'])?>
</div>
<?php ActiveForm::end();?>
