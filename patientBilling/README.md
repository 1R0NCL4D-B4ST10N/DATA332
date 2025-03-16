<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Billing Data Analysis</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        h1, h2 { color: #2c3e50; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f4f4f4; }
    </style>
</head>
<body>
    <h1>📌 Patient Billing Data Analysis</h1>
    <p>This R script processes and visualizes patient billing data by integrating information from three key tables: <strong>Patients</strong>, <strong>Visits</strong>, and <strong>Billing</strong>. The script merges datasets, extracts insights, and generates graphical representations of medical visit trends and billing activity.</p>

    <h2>📂 Data Sources</h2>
    <p>The following tables serve as input data:</p>

    <h3>📝 Billing Table</h3>
    <table>
        <tr><th>Column</th><th>Description</th></tr>
        <tr><td><strong>InvoiceNum</strong></td><td>Unique identifier for an invoice</td></tr>
        <tr><td><strong>VisitID</strong></td><td>Links to the corresponding patient visit</td></tr>
        <tr><td><strong>InvoiceDate</strong></td><td>Date of billing</td></tr>
        <tr><td><strong>InvoiceAmt</strong></td><td>Total invoice amount</td></tr>
        <tr><td><strong>InvoiceItem</strong></td><td>Description of the billed service</td></tr>
        <tr><td><strong>InvoicePaid</strong></td><td>Boolean indicating if the invoice was paid</td></tr>
    </table>

    <h3>👤 Patient Table</h3>
    <table>
        <tr><th>Column</th><th>Description</th></tr>
        <tr><td><strong>PatientID</strong></td><td>Unique identifier for each patient</td></tr>
        <tr><td><strong>LastName</strong></td><td>Last name of the patient</td></tr>
        <tr><td><strong>FirstName</strong></td><td>First name of the patient</td></tr>
        <tr><td><strong>BirthDate</strong></td><td>Patient's birth date</td></tr>
        <tr><td><strong>Phone</strong></td><td>Contact phone number</td></tr>
        <tr><td><strong>Address, City, State, Zip</strong></td><td>Residential information</td></tr>
        <tr><td><strong>Email</strong></td><td>Contact email address</td></tr>
    </table>

    <h3>📅 Visit Table</h3>
    <table>
        <tr><th>Column</th><th>Description</th></tr>
        <tr><td><strong>VisitID</strong></td><td>Unique identifier for each visit</td></tr>
        <tr><td><strong>PatientID</strong></td><td>References the associated patient</td></tr>
        <tr><td><strong>VisitDate</strong></td><td>Date of the medical visit</td></tr>
        <tr><td><strong>Reason</strong></td><td>Medical reason for the visit</td></tr>
        <tr><td><strong>WalkIn</strong></td><td>Boolean indicating if the visit was a walk-in</td></tr>
    </table>

    <h2>📊 Key Features</h2>
    <ul>
        <li><strong>Data Cleaning & Processing</strong>: Merges patient, visit, and billing data.</li>
        <li><strong>Monthly Analysis</strong>: Extracts month names from visit dates.</li>
        <li><strong>Data Visualization</strong>: Generates various plots using <code>ggplot2</code>.</li>
    </ul>

    <h2>🚀 How to Use</h2>
    <p>To execute the script:</p>
    <ol>
        <li>Ensure the <code>Billing.xlsx</code>, <code>Patient.xlsx</code>, and <code>Visit.xlsx</code> files are in the working directory.</li>
        <li>Install required packages:</li>
        <pre><code>install.packages(c("ggplot2", "dplyr", "tidyverse", "readxl", "tidyr", "tidytext"))</code></pre>
        <li>Run the script:</li>
    </ol>

    <h2>📜 License</h2>
    <p>Released under the MIT License.</p>
</body>
</html>
