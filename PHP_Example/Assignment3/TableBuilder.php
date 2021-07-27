<?php
    /**
     * --------------------------------------------------------------------------
     * File name: TableBuilder.php
     * Project name: Assignment3
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 10/17/2018
     * Last modified: (Daniel Bishop, 10/17/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
    
    class TableBuilder
    {
        
        public static function __tableBuilder($select_all_array, $page)
        {
            ?>
            <table class="table">
                <thead>
                    <tr>
                        <?php
                        //Loop through the first part of the array to get the table headers.
                        foreach ($select_all_array[0] as $key => $part)
                        { ?>
                            <td scope=row><?= $key ?></td>
                        <?php
                        } ?>
                        <td scope=row>Update</td>
                        <td scope=row>Delete</td>
                    </tr>
                </thead>
                <tbody>
                    <?php
                        //Loop through the array to separate the individual rows
                        foreach($select_all_array as $item)
                        {?>
                            <tr>
                            <?php
                            //Loop through the rows to get the elements from them
                            foreach ($item as $part)
                            {
                            ?>
                                <td scope=row><?= htmlspecialchars($part) ?></td>
                            <?php
                            }?>
                                <td><a href ="/<?=$page?>/update?id=<?= $item->id ?>"><i class="fas fa-edit"></a></td>
                                <td><a href ="/<?=$page?>/delete?delete=<?= $item->id ?>"><i class="fas fa-trash-alt"></i></a></td>
                            </tr>
                            <?php
                        }?>
                </tbody>
                
            </table>
<?php
        }
    }
?>