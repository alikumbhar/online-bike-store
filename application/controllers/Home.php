<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Home extends MY_Controller {
 public function __construct(){parent::__construct();$this->load->model('Product_model');}
 public function index(){
  $filters=array('q'=>$this->input->get('q',true),'category'=>$this->input->get('category',true),'sale'=>$this->input->get('sale',true),'sort'=>$this->input->get('sort',true));
  $this->view('home/index',array('products'=>$this->Product_model->all($filters),'filters'=>$filters));
 }
}
