<?php defined('BASEPATH') OR exit('No direct script access allowed');
class MY_Controller extends CI_Controller {
    protected function require_login(){ if(!$this->session->userdata('user_id')) redirect('login'); }
    protected function require_admin(){ $this->require_login(); if($this->session->userdata('role')!=='admin'){ show_error('Access denied',403); } }
    protected function view($view,$data=array()){ $this->load->view('layouts/header',$data); $this->load->view($view,$data); $this->load->view('layouts/footer',$data); }
}
