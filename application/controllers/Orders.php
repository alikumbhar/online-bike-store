<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Orders extends MY_Controller { public function __construct(){parent::__construct();$this->load->model('Order_model');}
 public function index(){$this->require_login();$this->view('orders/index',array('orders'=>$this->Order_model->for_user($this->session->userdata('user_id'))));}
 public function confirmation($id){$this->require_login();$o=$this->Order_model->find_for_user($id,$this->session->userdata('user_id'));if(!$o)show_404();$this->view('orders/confirmation',array('order'=>$o,'items'=>$this->Order_model->items($id)));}
}
