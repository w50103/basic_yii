<?php
/**
 * Created by IntelliJ IDEA.
 * User: neo
 * Date: 15/12/21
 * Time: 下午10:19
 */

namespace app\service;


use yii\base\Exception;

class SocketServerService
{
    public $master; //连接Server的Client
    public $sockets = array();
    public $handStaus = false;//握手状态

    public function __construct($address = '127.0.0.1', $port = '80'){

        try{
            $this->master = socket_create(AF_INET, SOCK_STREAM,SOL_TCP);
            socket_set_option($this->master, SOL_SOCKET, SO_REUSEADDR, 1);
            socket_bind($this->master, $address, $port);
            socket_listen($this->master, 2);
            $this->sockets[] = $this->master;
        }catch (Exception $e)
        {
            die($e->getMessage());
        }

    }

    public function init()
    {
        while(true){
            //自动选择来消息的socket
            $write = null;
            $except = null;
            socket_select($this->sockets,$write,$except,null);

            foreach($this->sockets as $socket){
                if($socket == $this->master){
                    $client = socket_accept($this->master);
                    if(is_resource($client)){
                        array_push($this->sockets,$client);
                    }else{
                        echo 'accept failed';
                        continue;
                    }
                }else{
                    $bytes = socket_recv($socket,$buffer,2048,0);

                    if($bytes == 0) return;
                    if(!$this->handStaus){
                        $this->dohandShake($socket,$buffer);
                        echo 'shand hand';
                    }else{
                        $buffer = base64_decode($buffer);
                        echo 'send file';
                    }
                }
            }
        }
    }

    protected function getKey($req)
    {
        $key = null;
        if(preg_match('/Sec-WebSocket-Key:(.*)\r\n/i',$req,$match)){

            $key = $match[1];
        }
        return $key;
    }

    protected function encrypt($req){
        $key = $this->getKey($req);
        $mask = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";
        return base64_encode(sha1($key.$mask,true));

    }

    public function dohandShake($socket, $req){
        $acceptKey = $this->encrypt($req);
        $upgrade = "HTTP/1.1 101 Switching Protocols\r\n".
            "Upgrade: websocket\r\n".
            "Connection: Upgrade\r\n".
            "Sec-WebSocket-Accept:".$acceptKey."\r\n".
            "\r\n";

        socket_write($socket,$upgrade.chr(0),strlen($upgrade.chr(0)));
        $this->handStaus = true;
    }
}

$res = new SocketServerService('localhost',4000);
$res->init();