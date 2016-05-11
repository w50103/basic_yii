<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "phone_list".
 *
 * @property integer $id
 * @property string $UUID
 * @property string $entryUuid
 * @property string $entryMobile
 * @property string $createTime
 * @property string $entryUserName
 */
class Phone extends \yii\db\ActiveRecord
{

    public static function getPhones($id,$uuid)
    {
        $table = self::tableName($id);
        $sql = "select * from {$table} WHERE entryUuid='{$uuid}' limit 10";
        $res = Phone::findBySql($sql)->asArray()->all();
        return $res;

    }
    /**
     * @inheritdoc
     */
    public static function tableName($id = 0)
    {
        return 'phone_list_'.$id;
    }

    /**
     * @return \yii\db\Connection the database connection used by this AR class.
     */
    public static function getDb()
    {
        return Yii::$app->get('phoneDB');
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['UUID', 'entryUuid', 'entryMobile', 'entryUserName'], 'required'],
            [['createTime'], 'safe'],
            [['UUID', 'entryUuid'], 'string', 'max' => 36],
            [['entryMobile'], 'string', 'max' => 15],
            [['entryUserName'], 'string', 'max' => 20]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => '自增长ID',
            'UUID' => 'UUID',
            'entryUuid' => '用户Id',
            'entryMobile' => '手机号',
            'createTime' => 'Create Time',
            'entryUserName' => '用户姓名',
        ];
    }
}
