<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Cart extends MY_Controller { public function __construct(){parent::__construct();$this->load->model('Product_model');}
 private function get(){return $this->session->userdata('cart') ?: array();}
 private function save($cart){$this->session->set_userdata('cart',array_values($cart));}
 public function index(){ $cart=$this->get();$this->view('cart/index',array('cart'=>$cart)); }
 public function add($id){$p=$this->Product_model->find($id);if(!$p) show_404();$cart=$this->get();$found=false;foreach($cart as &$i){if($i['id']==$id){$i['qty']++;$found=true;break;}}unset($i);if(!$found)$cart[]=array('id'=>$p->id,'name'=>$p->name,'price'=>$p->price,'image'=>$p->image,'qty'=>1);$this->save($cart);$this->session->set_flashdata('success','Product added to cart.');redirect($this->input->get('redirect')?:'cart');}
 public function remove($id){$cart=$this->get();foreach($cart as $k=>$i){if($i['id']==$id)unset($cart[$k]);}$this->save($cart);redirect('cart');}
 public function update(){ $cart=$this->get();$qty=$this->input->post('qty');foreach($cart as &$i){if(isset($qty[$i['id']]))$i['qty']=max(1,(int)$qty[$i['id']]);}unset($i);$this->save($cart);redirect('cart');}
 public function empty_cart(){$this->session->unset_userdata('cart');redirect('cart');}
}
