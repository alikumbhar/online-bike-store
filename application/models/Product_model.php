<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Product_model extends CI_Model {
 public function all($filters=array()){
  if(!empty($filters['q'])){ $this->db->group_start()->like('name',$filters['q'])->or_like('description',$filters['q'])->or_like('category',$filters['q'])->group_end(); }
  if(!empty($filters['category'])) $this->db->like('category',$filters['category']);
  if(!empty($filters['sale'])) $this->db->where('old_price IS NOT NULL',null,false);
  switch(isset($filters['sort'])?$filters['sort']:'featured'){
   case 'price_low': $this->db->order_by('price','ASC'); break;
   case 'price_high': $this->db->order_by('price','DESC'); break;
   case 'newest': $this->db->order_by('created_at','DESC'); break;
   default: $this->db->order_by('is_featured','DESC')->order_by('id','DESC');
  }
  return $this->db->get('products')->result();
 }
 public function find($id){return $this->db->where('id',$id)->get('products')->row();}
 public function create($data){$this->db->insert('products',$data);return $this->db->insert_id();}
 public function update($id,$data){return $this->db->where('id',$id)->update('products',$data);}
 public function delete($id){return $this->db->where('id',$id)->delete('products');}
}
