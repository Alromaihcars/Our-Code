<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>حاسبة تمويل السيارات</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
            direction: rtl;
        }
        .calculator {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }
        .calculator-header {
            background-color: #ffff00;
            color: #000;
            text-align: center;
            padding: 10px;
            margin: -20px -20px 20px -20px;
            border-radius: 8px 8px 0 0;
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        label {
            flex: 1;
        }
        input[type="number"] {
            width: 150px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            text-align: left;
        }
        .results {
            margin-top: 20px;
        }
        .result-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .result-value {
            font-weight: bold;
        }
        .green-bg {
            background-color: #4CAF50;
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
        }
        .yellow-bg {
            background-color: #ffff00;
        }
    </style>
</head>
<body>
    <div class="calculator">
        <div class="calculator-header">الرجاء إدخال المعلومات في الخلايا الصفراء</div>
        <div class="form-group">
            <label for="licenseType">نوع الترخيص</label>
            <input type="text" id="licenseType" value="تجاري" class="yellow-bg" readonly>
        </div>
        <div class="form-group">
            <label for="carPrice">سعر السيارة (شاملا ضريبة القيمة المضافة)</label>
            <input type="number" id="carPrice" value="52325.00" class="yellow-bg">
        </div>
        <div class="form-group">
            <label for="downPayment">الدفعة الأولى</label>
            <input type="number" id="downPayment" value="0.0" class="yellow-bg">
        </div>
        <div class="form-group">
            <label for="lastPayment">الدفعة الأخيرة</label>
            <input type="number" id="lastPayment" value="35.0" class="yellow-bg">
        </div>
        <div class="form-group">
            <label for="profitMargin">هامش الربح</label>
            <input type="number" id="profitMargin" value="5.75" class="yellow-bg">
        </div>
        <div class="form-group">
            <label for="insurance">التأمين</label>
            <input type="number" id="insurance" value="3.00" class="yellow-bg">
        </div>
        <div class="form-group">
            <label for="adminFee">الرسوم الإدارية</label>
            <input type="number" id="adminFee" value="1" class="yellow-bg">
        </div>
        <div class="form-group">
            <label for="term">المدة</label>
            <input type="number" id="term" value="5" class="yellow-bg">
        </div>
        <div class="results">
            <div class="result-item">
                <span>القسط الشهري</span>
                <span class="result-value green-bg" id="monthlyPayment">948 SAR</span>
            </div>
            <div class="result-item">
                <span>التكلفة النهائية</span>
                <span class="result-value" id="totalCost">76,390 SAR</span>
            </div>
            <div class="result-item">
                <span>Markup</span>
                <span class="result-value" id="markup">8.75%</span>
            </div>
            <div class="result-item">
                <span>APR</span>
                <span class="result-value" id="apr">13.90%</span>
            </div>
        </div>
    </div>

    <script>
        function calculateLoan() {
            const carPrice = parseFloat(document.getElementById('carPrice').value);
            const downPayment = parseFloat(document.getElementById('downPayment').value) / 100 * carPrice;
            const lastPayment = parseFloat(document.getElementById('lastPayment').value) / 100 * carPrice;
            const profitMargin = parseFloat(document.getElementById('profitMargin').value) / 100;
            const insurance = parseFloat(document.getElementById('insurance').value) / 100;
            const adminFee = parseFloat(document.getElementById('adminFee').value) / 100;
            const term = parseFloat(document.getElementById('term').value);

            const principal = carPrice - downPayment;
            const monthlyRate = profitMargin / 12;
            const numberOfPayments = term * 12;

            const monthlyPaymentValue = (principal * monthlyRate * Math.pow(1 + monthlyRate, numberOfPayments)) / (Math.pow(1 + monthlyRate, numberOfPayments) - 1);
            const insuranceAmount = (carPrice * insurance) / 12;
            const adminAmount = (carPrice * adminFee) / 12;

            const totalMonthlyPayment = monthlyPaymentValue + insuranceAmount + adminAmount;
            const totalCostValue = (totalMonthlyPayment * numberOfPayments) + downPayment + lastPayment;
            const markupValue = ((totalCostValue - carPrice) / carPrice) * 100;
            const aprValue = ((Math.pow(1 + monthlyRate, 12) - 1) * 100);

            document.getElementById('monthlyPayment').textContent = totalMonthlyPayment.toFixed(0) + ' SAR';
            document.getElementById('totalCost').textContent = totalCostValue.toFixed(0) + ' SAR';
            document.getElementById('markup').textContent = markupValue.toFixed(2) + '%';
            document.getElementById('apr').textContent = aprValue.toFixed(2) + '%';
        }

        // Add event listeners to all input fields
        const inputs = document.querySelectorAll('input[type="number"]');
        inputs.forEach(input => {
            input.addEventListener('input', calculateLoan);
        });

        // Initial calculation
        calculateLoan();
    </script>
</body>
</html>
