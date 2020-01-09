# Populate the drive letter you want to check

$drive = "f:"

# Initialize outputarray
            
$outputarray = new-object PSObject

$outputarray | add-member NoteProperty Drive $drive

# Initialize output

$output = (fsutil fsinfo ntfsinfo $drive)

# Split each line of fsutil into a seperate array value

foreach ($line in $output) {

    $info = $line.split(':')

    $outputarray | add-member NoteProperty $info[0].trim().Replace(' ','_') $info[1].trim()

    $info = $null

}

# Format and display results

$results = 'Disk Block Size for ' + $drive + ' ' + $outputarray.Bytes_Per_Cluster/1024 + 'KB'
                  
$results
