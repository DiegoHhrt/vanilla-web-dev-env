<?php

echo "Hello, World!";

// A simple function to demonstrate PHP functionality
function greet($name)
{
    return "Hello, " . htmlspecialchars($name) . "!";
}
