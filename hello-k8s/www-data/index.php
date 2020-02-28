<!DOCTYPE html>
<head>
    <title>Hello World!</title>
    <style>
        body {
            background-color: #2D2D2D;
        }

        h1 {
            color: #C26356;
            font-size: 30px;
            font-family: Menlo, Monaco, fixed-width;
       }

       p {
            color: white;
            font-family: "Source Code Pro", Menlo, Monaco, fixed-width;
       }
    </style>
</head>
<body>
    <h1>Hello World!</h1>
    <p>Welcome! This is your first Kubernetes application ( <?php echo file_get_contents("VERSION");?>).</p>
    <p>(Hostname: <?php echo gethostname(); ?>).</p>
</body>
</html>
