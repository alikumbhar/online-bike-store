<?php defined('BASEPATH') OR exit('No direct script access allowed');
class User_model extends CI_Model {
 public function find_by_login($login){return $this->db->group_start()->where('email',$login)->or_where('username',$login)->group_end()->get('users')->row();}
 public function find($id){return $this->db->where('id',$id)->get('users')->row();}
 public function create($data){$this->db->insert('users',$data);return $this->db->insert_id();}
 public function update($id,$data){return $this->db->where('id',$id)->update('users',$data);}
}
