<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Account extends MY_Controller { public function __construct(){parent::__construct();$this->load->model('User_model');$this->load->model('Order_model');}
 public function index(){$this->require_login();$uid=$this->session->userdata('user_id');$orders=$this->Order_model->for_user($uid);$this->view('account/dashboard',array('user'=>$this->User_model->find($uid),'orders'=>$orders));}
 public function profile(){$this->require_login();$this->view('account/profile',array('user'=>$this->User_model->find($this->session->userdata('user_id'))));}
 public function update_profile(){$this->require_login();$uid=$this->session->userdata('user_id');$data=array('name'=>$this->input->post('name',true),'phone'=>$this->input->post('phone',true));if($this->input->post('new_password'))$data['password_hash']=password_hash($this->input->post('new_password'),PASSWORD_DEFAULT);$this->User_model->update($uid,$data);$this->session->set_flashdata('success','Profile updated successfully.');redirect('profile');}
}
