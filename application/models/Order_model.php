<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Order_model extends CI_Model {
 public function create($user_id,$items,$payment,$address){
  $total=0; foreach($items as $i){$total += ((float)$i['price']*(int)$i['qty']);}
  $this->db->trans_start();
  $this->db->insert('orders',array('user_id'=>$user_id,'total'=>$total,'status'=>'Processing','payment_method'=>$payment,'shipping_address'=>$address));
  $oid=$this->db->insert_id();
  foreach($items as $i){$this->db->insert('order_items',array('order_id'=>$oid,'product_id'=>(int)$i['id'],'product_name'=>$i['name'],'price'=>(float)$i['price'],'quantity'=>(int)$i['qty']));}
  $this->db->trans_complete(); return $this->db->trans_status() ? $oid : false;
 }
 public function for_user($uid){return $this->db->where('user_id',$uid)->order_by('id','DESC')->get('orders')->result();}
 public function find_for_user($id,$uid){return $this->db->where(array('id'=>$id,'user_id'=>$uid))->get('orders')->row();}
 public function items($oid){return $this->db->where('order_id',$oid)->get('order_items')->result();}
 public function all(){return $this->db->select('orders.*,users.username,users.email')->from('orders')->join('users','users.id=orders.user_id')->order_by('orders.id','DESC')->get()->result();}
 public function update_status($id,$status){return $this->db->where('id',$id)->update('orders',array('status'=>$status,'updated_at'=>date('Y-m-d H:i:s')));}
}
