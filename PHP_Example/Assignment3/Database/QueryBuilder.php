<?php
    /**
     * --------------------------------------------------------------------------
     * File name: QueryBuilder.php
     * Project name: Assignment2
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 09/18/2018
     * Last modified: (Daniel Bishop, 09/18/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
    
    class QueryBuilder
    {
        private $pdo;
    
        public function __construct(PDO $pdo)
        {
            $this->pdo = $pdo;
        }
        
        
        public function selectAll($table, $class)
        {
            $string = "select * from $table";
            $stmt = $this->pdo->prepare($string);
            $stmt->execute();
    
            return $data = $stmt->fetchAll(PDO::FETCH_CLASS, $class);
        }
    
    
        public function create($table, $array)
        {
            $string = "insert into $table (";
            $stringPart2 = "";
        
            foreach ($array as $key => $value)
            {
                $string .= "'$key'";
                $stringPart2 .= "'$value'";
                if(next($array))
                {
                    $string .= ",";
                    $stringPart2 .= ", ";
                }
            }
            $string .= ") values (" . $stringPart2 . ")";
            $stmt = $this->pdo->prepare($string);
            $stmt->execute();
        }//end function
        
        
        public function selectOne($table, $class, $id)
        {
            $string = "select * from $table where id = ?";
            $stmt = $this->pdo->prepare($string);
            $stmt->execute([$id]);
            
            return $stmt->fetchAll(PDO::FETCH_CLASS, $class)[0];
        }
        
        
        public function update($table, $array, $id)
        {
            $string = "update $table set ";
            
            foreach ($array as $key => $value)
            {
                $string .= "'$key' = '$value' ";
                
                if (next($array)) {
                    $string .= ", ";
                }
            }
            $string .= "where id = ?";
            $stmt = $this->pdo->prepare($string);
            $stmt->execute([$id]);
        }
        
        
        public function delete($table, $id)
        {
            $stmt = $this->pdo->prepare("delete from $table where id = ?");
            $stmt->execute([$id]);
        }
    
        public function getPDO()
        {
            return $this->pdo;
        }
    }

?>