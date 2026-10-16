<?php


/*defined('BASEPATH') OR exit('No direct script access allowed');
class Home extends MY_Controller {
 public function __construct(){parent::__construct();$this->load->model('Product_model');}
 public function index(){
  $filters=array('q'=>$this->input->get('q',true),'category'=>$this->input->get('category',true),'sale'=>$this->input->get('sale',true),'sort'=>$this->input->get('sort',true));
  $this->view('home/index',array('products'=>$this->Product_model->all($filters),'filters'=>$filters));
 }
}
*/




defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends MY_Controller
{
    public function __construct()
    {
        parent::__construct();

        $this->load->model('Product_model');
        $this->load->database();
    }

    public function index()
    {
        // Import database only if it has not been imported before.
        $this->import_database_once();

        $filters = array(
            'q'        => $this->input->get('q', true),
            'category' => $this->input->get('category', true),
            'sale'     => $this->input->get('sale', true),
            'sort'     => $this->input->get('sort', true)
        );

        $this->view('home/index', array(
            'products' => $this->Product_model->all($filters),
            'filters'  => $filters
        ));
    }

    private function import_database_once()
    {
        // Store the import flag in a persistent application file.
        $flag_file = APPPATH . 'cache/shop_sql_imported.lock';

        // Stop if the SQL file has already been imported.
        if (file_exists($flag_file)) {
            return;
        }

        // SQL file location: project_root/data/shop.sql
         $sql_file = FCPATH . 'data/bike_shop.sql';

         if (!file_exists($sql_file)) {
            log_message('error', 'Database SQL file not found: ' . $sql_file);
            return;
        }

        $sql = file_get_contents($sql_file);

        if ($sql === false || trim($sql) === '') {
            log_message('error', 'Database SQL file is empty or unreadable.');
            return;
        }

        // Run the SQL dump.
        // This dump contains multiple statements, so use mysqli multi_query.
        $mysqli = $this->db->conn_id;

        if (!($mysqli instanceof mysqli)) {
            log_message('error', 'MySQLi connection is required to import shop.sql.');
            return;
        }

        if (!$mysqli->multi_query($sql)) {
            log_message('error', 'SQL import failed: ' . $mysqli->error);
            return;
        }

        // Consume every result before considering the import complete.
        do {
            if ($result = $mysqli->store_result()) {
                $result->free();
            }

            if ($mysqli->errno) {
                log_message('error', 'SQL import failed: ' . $mysqli->error);
                return;
            }
        } while ($mysqli->more_results() && $mysqli->next_result());

        // Create the flag only after a successful import.
        if (file_put_contents($flag_file, date('c')) === false) {
            log_message('error', 'Could not create the SQL import lock file.');
        }
    }
}