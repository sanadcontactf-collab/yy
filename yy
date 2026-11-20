<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>يومياتي - الإدارة المالية الشهرية</title>
    <!-- مكتبة تسجيل الدخول من جوجل -->
    <script src="https://accounts.google.com/gsi/client" async defer></script>
    <style>
        :root {
            --primary: #0f766e;
            --primary-dark: #115e59;
            --debt-color: #b91c1c;
            --exp-color: #c2410c;
            --inc-color: #15803d;
            --gdrive-color: #1d4ed8;
            --bg: #f1f5f9;
            --surface: #ffffff;
            --text: #0f172a;
            --muted: #64748b;
            --border: #cbd5e1;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            -webkit-tap-highlight-color: transparent;
        }

        body {
            background-color: var(--bg);
            color: var(--text);
            padding-bottom: 85px;
            line-height: 1.5;
        }

        .app-header {
            background: linear-gradient(135deg, var(--primary-dark), var(--primary));
            color: white;
            padding: 16px 16px 20px;
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;
            box-shadow: 0 4px 12px rgba(15, 118, 110, 0.2);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .app-title {
            font-size: 1.35rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .sync-badge {
            font-size: 0.72rem;
            background: rgba(255,255,255,0.2);
            padding: 3px 8px;
            border-radius: 20px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .month-picker-wrap {
            display: flex;
            align-items: center;
            gap: 6px;
            background: rgba(255, 255, 255, 0.18);
            padding: 5px 10px;
            border-radius: 10px;
        }

        .month-picker-wrap input[type="month"] {
            background: transparent;
            border: none;
            color: white;
            font-weight: 700;
            font-size: 0.95rem;
            outline: none;
            color-scheme: dark;
        }

        .balance-banner {
            background: rgba(255, 255, 255, 0.12);
            border: 1px solid rgba(255, 255, 255, 0.25);
            border-radius: 12px;
            padding: 12px 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .balance-label { font-size: 0.85rem; opacity: 0.95; }
        .balance-amount { font-size: 1.35rem; font-weight: 800; }
        .balance-deficit { background: rgba(220, 38, 38, 0.88); border-color: #fca5a5; }

        .container {
            max-width: 650px;
            margin: 0 auto;
            padding: 15px;
        }

        .tab-view { display: none; animation: fadeIn 0.2s ease; }
        .tab-view.active { display: block; }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(4px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .summary-box {
            background: var(--surface);
            border-radius: 14px;
            padding: 14px;
            margin-bottom: 15px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.04);
            border-right: 5px solid var(--primary);
        }

        .summary-box.debt { border-right-color: var(--debt-color); }
        .summary-box.expense { border-right-color: var(--exp-color); }
        .summary-box.income { border-right-color: var(--inc-color); }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 8px;
            text-align: center;
        }

        .summary-grid.two-cols { grid-template-columns: repeat(2, 1fr); }

        .stat-item {
            background: #f8fafc;
            padding: 8px 4px;
            border-radius: 8px;
        }

        .stat-title { font-size: 0.75rem; color: var(--muted); margin-bottom: 2px; }
        .stat-val { font-size: 0.98rem; font-weight: 800; }

        .form-card {
            background: var(--surface);
            border-radius: 14px;
            padding: 16px;
            margin-bottom: 18px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.04);
        }

        .form-card h3 {
            font-size: 1rem;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .input-group { margin-bottom: 12px; }
        .input-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 700;
            margin-bottom: 4px;
            color: var(--text);
        }

        .input-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        input[type="text"],
        input[type="date"] {
            width: 100%;
            padding: 11px 12px;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            font-size: 1rem;
            outline: none;
            background: #f8fafc;
            transition: border-color 0.2s;
        }

        input:focus { border-color: var(--primary); background: white; }

        .amount-input {
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .btn {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 10px;
            font-size: 0.98rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
            transition: opacity 0.2s;
        }

        .btn:disabled { opacity: 0.55; cursor: not-allowed; }
        .btn:active:not(:disabled) { opacity: 0.85; }
        .btn-debt { background: var(--debt-color); color: white; }
        .btn-expense { background: var(--exp-color); color: white; }
        .btn-income { background: var(--inc-color); color: white; }
        .btn-primary { background: var(--primary); color: white; }
        .btn-gdrive { background: var(--gdrive-color); color: white; }
        .btn-dark { background: #1e293b; color: white; }
        .btn-outline { background: white; border: 1.5px solid var(--border); color: var(--text); }

        /* Google Drive Status & Toggle */
        .gdrive-status-box {
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            border-radius: 10px;
            padding: 10px 12px;
            margin-bottom: 12px;
            font-size: 0.84rem;
            color: #1e3a8a;
        }

        .toggle-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 12px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            margin-bottom: 12px;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 46px;
            height: 24px;
        }

        .switch input { opacity: 0; width: 0; height: 0; }

        .slider {
            position: absolute;
            cursor: pointer;
            inset: 0;
            background-color: #cbd5e1;
            transition: .3s;
            border-radius: 24px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .3s;
            border-radius: 50%;
        }

        input:checked + .slider { background-color: var(--gdrive-color); }
        input:checked + .slider:before { transform: translateX(22px); }

        .item-card {
            background: var(--surface);
            border-radius: 14px;
            padding: 14px;
            margin-bottom: 12px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.05);
            border: 1px solid #e2e8f0;
        }

        .item-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 8px;
        }

        .item-title { font-size: 1.05rem; font-weight: 800; color: var(--text); }
        .item-date { font-size: 0.78rem; color: var(--muted); margin-top: 2px; }

        .carried-badge {
            display: inline-block;
            background: #fef3c7;
            color: #92400e;
            font-size: 0.72rem;
            font-weight: 700;
            padding: 2px 7px;
            border-radius: 6px;
            margin-right: 5px;
        }

        .paid-badge {
            display: inline-block;
            background: #dcfce7;
            color: #166534;
            font-size: 0.75rem;
            font-weight: 700;
            padding: 2px 8px;
            border-radius: 6px;
        }

        .debt-details {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 6px;
            background: #f8fafc;
            padding: 8px;
            border-radius: 8px;
            margin: 10px 0;
            text-align: center;
            font-size: 0.82rem;
        }

        .debt-details strong { display: block; font-size: 0.95rem; margin-top: 2px; }

        .card-actions {
            display: flex;
            gap: 6px;
            margin-top: 10px;
            flex-wrap: wrap;
        }

        .action-btn {
            flex: 1;
            min-width: 75px;
            padding: 8px 6px;
            border-radius: 8px;
            border: none;
            font-size: 0.82rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 4px;
        }

        .btn-pay { background: #dcfce7; color: #166534; }
        .btn-borrow { background: #fee2e2; color: #991b1b; }
        .btn-add-more { background: #e0f2fe; color: #075985; }
        .btn-history { background: #f1f5f9; color: #0f172a; border: 1px solid #cbd5e1; }
        .btn-icon { flex: 0 0 36px; min-width: 36px; background: #f8fafc; color: #334155; border: 1px solid #e2e8f0; }
        .btn-del { flex: 0 0 36px; min-width: 36px; background: #fef2f2; color: #dc2626; }

        .history-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 12px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            margin-bottom: 8px;
        }

        .log-actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .mini-btn {
            border: none;
            background: white;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            padding: 5px 9px;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
        }

        .mini-btn.del { color: #dc2626; border-color: #fecaca; background: #fef2f2; }

        .bottom-nav {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: var(--surface);
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            border-top: 1px solid #e2e8f0;
            box-shadow: 0 -2px 10px rgba(0,0,0,0.06);
            z-index: 200;
            padding: 6px 0;
        }

        .nav-item {
            background: none;
            border: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 3px;
            padding: 6px 2px;
            color: var(--muted);
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
        }

        .nav-item span.icon { font-size: 1.3rem; }
        .nav-item.active { color: var(--primary); }

        .modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.6);
            display: none;
            justify-content: center;
            align-items: flex-end;
            z-index: 500;
        }

        .modal-sheet {
            background: white;
            width: 100%;
            max-width: 650px;
            max-height: 85vh;
            overflow-y: auto;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
            padding: 20px;
            animation: slideUp 0.25s ease;
        }

        @keyframes slideUp {
            from { transform: translateY(100%); }
            to { transform: translateY(0); }
        }

        .empty-state {
            text-align: center;
            padding: 35px 15px;
            color: var(--muted);
            font-size: 0.95rem;
        }

        /* ===================================================== */
        /* DEDICATED PDF PRINT REPORT STYLES (COMPREHENSIVE)     */
        /* ===================================================== */
        #pdfReportArea { display: none; }

        @media print {
            body {
                background: white !important;
                padding: 0 !important;
                margin: 0 !important;
            }
            .app-header, .container, .bottom-nav, .modal-overlay {
                display: none !important;
            }
            #pdfReportArea {
                display: block !important;
                width: 100%;
                padding: 10px 14px;
                color: #000;
                direction: rtl;
            }
            .pdf-header {
                text-align: center;
                border-bottom: 2px solid #0f766e;
                padding-bottom: 10px;
                margin-bottom: 14px;
            }
            .pdf-header h1 {
                font-size: 1.35rem;
                color: #0f766e;
                margin-bottom: 4px;
            }
            .pdf-meta {
                font-size: 0.85rem;
                color: #334155;
            }
            .pdf-summary-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 8px;
                margin-bottom: 16px;
            }
            .pdf-box {
                border: 1px solid #94a3b8;
                border-radius: 8px;
                padding: 8px 6px;
                text-align: center;
                background: #f8fafc !important;
                -webkit-print-color-adjust: exact;
            }
            .pdf-box.highlight {
                background: #ecfdf5 !important;
                border: 1.5px solid #0f766e;
                -webkit-print-color-adjust: exact;
            }
            .pdf-box.deficit {
                background: #fef2f2 !important;
                border: 1.5px solid #b91c1c;
                -webkit-print-color-adjust: exact;
            }
            .pdf-box span { display: block; font-size: 0.78rem; color: #334155; }
            .pdf-box strong { display: block; font-size: 1rem; margin-top: 2px; }

            .pdf-section-title {
                font-size: 1rem;
                font-weight: 800;
                padding: 6px 10px;
                margin-top: 14px;
                margin-bottom: 6px;
                border-radius: 6px;
                color: white !important;
                -webkit-print-color-adjust: exact;
                page-break-after: avoid;
            }
            .sec-paid { background: #15803d !important; }
            .sec-unpaid { background: #b91c1c !important; }
            .sec-exp { background: #c2410c !important; }
            .sec-inc { background: #0f766e !important; }

            .pdf-table {
                width: 100%;
                border-collapse: collapse;
                font-size: 0.84rem;
                margin-bottom: 10px;
            }
            .pdf-table th, .pdf-table td {
                border: 1px solid #94a3b8;
                padding: 6px 8px;
                text-align: right;
                vertical-align: top;
            }
            .pdf-table th {
                background: #e2e8f0 !important;
                color: #0f172a !important;
                font-weight: 800;
                -webkit-print-color-adjust: exact;
            }
            .pdf-table tfoot td {
                background: #f1f5f9 !important;
                font-weight: 800;
                -webkit-print-color-adjust: exact;
            }
            .pdf-log-line {
                font-size: 0.76rem;
                border-bottom: 1px dashed #cbd5e1;
                padding: 2px 0;
            }
            .pdf-log-line:last-child { border-bottom: none; }
            .pdf-empty-note {
                font-size: 0.82rem;
                color: #64748b;
                padding: 6px 10px;
                border: 1px dashed #cbd5e1;
                border-radius: 6px;
                margin-bottom: 10px;
            }
            .pdf-footer {
                text-align: center;
                font-size: 0.78rem;
                color: #64748b;
                margin-top: 18px;
                border-top: 1px solid #cbd5e1;
                padding-top: 8px;
            }
        }
    </style>
</head>
<body>

    <header class="app-header">
        <div class="header-row">
            <div class="app-title">
                <span>📒 يومياتي</span>
                <span id="headerSyncIndicator" class="sync-badge" style="display:none;">☁️ متصل</span>
            </div>
            <div class="month-picker-wrap">
                <span style="font-size: 0.8rem;">الشهر:</span>
                <input type="month" id="monthSelector" onchange="onMonthChange()">
            </div>
        </div>

        <div class="balance-banner" id="topBalanceBanner">
            <div>
                <div class="balance-label" id="topBalanceLabel">المبلغ المتوفر لديك هذا الشهر</div>
                <div style="font-size: 0.72rem; opacity: 0.85;">(الدخل - المصاريف - المسدد من الديون)</div>
            </div>
            <div class="balance-amount" id="topBalanceValue">0 ر.ي</div>
        </div>
    </header>

    <div class="container">

        <!-- LIST 1: DEBTS -->
        <section id="view-debts" class="tab-view active">
            <div class="summary-box debt">
                <div class="summary-grid">
                    <div class="stat-item">
                        <div class="stat-title">إجمالي الديون</div>
                        <div class="stat-val" id="statDebtTotal" style="color: var(--debt-color);">0</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-title">المسدد بالشهر</div>
                        <div class="stat-val" id="statDebtPaid" style="color: var(--inc-color);">0</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-title">الباقي عليك</div>
                        <div class="stat-val" id="statDebtRem" style="color: #991b1b;">0</div>
                    </div>
                </div>
            </div>

            <div class="form-card">
                <h3 style="color: var(--debt-color);">➕ تسجيل دين جديد</h3>
                <form onsubmit="addNewDebt(event)">
                    <div class="input-group">
                        <label>الوصف (اسم الشخص المتدين منه) *</label>
                        <input type="text" id="debtPerson" required placeholder="اكتب اسم الشخص...">
                    </div>
                    <div class="input-row">
                        <div class="input-group">
                            <label>المبلغ (ريال يمني) *</label>
                            <input type="text" inputmode="decimal" class="amount-input" id="debtAmount" required placeholder="0" oninput="formatInputWithCommas(this)">
                        </div>
                        <div class="input-group">
                            <label>التاريخ *</label>
                            <input type="date" id="debtDate" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-debt">حفظ في قائمة الديون</button>
                </form>
            </div>

            <div id="debtsListContainer"></div>
        </section>

        <!-- LIST 2: EXPENSES -->
        <section id="view-expenses" class="tab-view">
            <div class="summary-box expense">
                <div class="summary-grid two-cols">
                    <div class="stat-item">
                        <div class="stat-title">عدد بنود المصاريف</div>
                        <div class="stat-val" id="statExpCount">0</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-title">إجمالي مصاريف الشهر</div>
                        <div class="stat-val" id="statExpTotal" style="color: var(--exp-color);">0 ر.ي</div>
                    </div>
                </div>
            </div>

            <div class="form-card">
                <h3 style="color: var(--exp-color);">➕ إضافة مصروف جديد</h3>
                <form onsubmit="addNewExpense(event)">
                    <div class="input-group">
                        <label>الوصف (بند الصرف) *</label>
                        <input type="text" id="expDesc" required placeholder="مثال: مواصلات، مقاضي منزل، فاتورة...">
                    </div>
                    <div class="input-row">
                        <div class="input-group">
                            <label>المبلغ (ريال يمني) *</label>
                            <input type="text" inputmode="decimal" class="amount-input" id="expAmount" required placeholder="0" oninput="formatInputWithCommas(this)">
                        </div>
                        <div class="input-group">
                            <label>التاريخ *</label>
                            <input type="date" id="expDate" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-expense">إدراج في المصاريف</button>
                </form>
            </div>

            <div id="expensesListContainer"></div>
        </section>

        <!-- LIST 3: MONTHLY INCOME -->
        <section id="view-income" class="tab-view">
            <div class="summary-box income">
                <div class="summary-grid">
                    <div class="stat-item">
                        <div class="stat-title">إجمالي الدخل</div>
                        <div class="stat-val" id="statIncTotal" style="color: var(--inc-color);">0</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-title">المصاريف + السداد</div>
                        <div class="stat-val" id="statOutTotal" style="color: var(--exp-color);">0</div>
                    </div>
                    <div class="stat-item" id="incNetStatBox">
                        <div class="stat-title" id="incNetStatTitle">المتوفر لديك</div>
                        <div class="stat-val" id="statNetBalance">0</div>
                    </div>
                </div>
            </div>

            <div class="form-card">
                <h3 style="color: var(--inc-color);">➕ إضافة دخل شهري</h3>
                <form onsubmit="addNewIncome(event)">
                    <div class="input-group">
                        <label>الجهة (مصدر الدخل) *</label>
                        <input type="text" id="incSource" required placeholder="مثال: الراتب، عمل إضافي، مستحقات...">
                    </div>
                    <div class="input-row">
                        <div class="input-group">
                            <label>المبلغ (ريال يمني) *</label>
                            <input type="text" inputmode="decimal" class="amount-input" id="incAmount" required placeholder="0" oninput="formatInputWithCommas(this)">
                        </div>
                        <div class="input-group">
                            <label>التاريخ *</label>
                            <input type="date" id="incDate" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-income">إدراج في الدخل الشهري</button>
                </form>
            </div>

            <div id="incomeListContainer"></div>
        </section>

        <!-- TAB 4: GOOGLE DRIVE SYNC, BACKUP & PDF REPORTS -->
        <section id="view-settings" class="tab-view">

            <!-- Google Drive Cloud Sync Card -->
            <div class="form-card" style="border-right: 5px solid var(--gdrive-color);">
                <h3 style="color: var(--gdrive-color);">☁️ المزامنة السحابية (Google Drive)</h3>
                <p style="font-size: 0.85rem; color: var(--muted); margin-bottom: 12px;">
                    اربط حسابك في جوجل درايف لحفظ بياناتك سحابياً واستعادتها من أي جهاز تلقائياً أو يدوياً.
                </p>

                <!-- Client ID Setup (Collapsible / Editable) -->
                <div class="input-group">
                    <label style="font-size: 0.8rem; color: var(--muted);">معرّف عميل جوجل (Google OAuth Client ID):</label>
                    <input type="text" id="googleClientIdInput" placeholder="أدخل Client ID هنا..." style="font-size: 0.82rem; padding: 8px 10px;" onchange="saveGoogleClientId()">
                </div>

                <div class="gdrive-status-box" id="gdriveStatusBox">
                    الحالة: <strong>غير مرتبط بحساب Google Drive</strong>
                </div>

                <!-- Connect / Disconnect Buttons -->
                <div id="gdriveAuthSection" style="margin-bottom: 12px;">
                    <button class="btn btn-gdrive" id="btnConnectDrive" onclick="connectGoogleDrive()">🔗 ربط الحساب وتسجيل الدخول</button>
                </div>

                <!-- Cloud Controls (Shown when connected) -->
                <div id="gdriveControlsSection" style="display: none;">
                    <div class="toggle-row">
                        <div>
                            <div style="font-weight: 700; font-size: 0.88rem;">🔄 المزامنة التلقائية</div>
                            <div style="font-size: 0.75rem; color: var(--muted);">رفع النسخة تلقائياً عند إضافة أو تعديل أي عملية</div>
                        </div>
                        <label class="switch">
                            <input type="checkbox" id="autoSyncToggle" onchange="toggleAutoSync()">
                            <span class="slider"></span>
                        </label>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 8px; margin-bottom: 10px;">
                        <button class="btn btn-gdrive" id="btnCloudExport" onclick="syncToGoogleDrive(false)">⬆️ تصدير الآن</button>
                        <button class="btn btn-outline" id="btnCloudRestore" onclick="restoreFromGoogleDrive()">⬇️ استعادة الآن</button>
                    </div>

                    <button class="btn btn-outline" style="color: var(--debt-color); border-color: #fecaca; font-size: 0.85rem; padding: 8px;" onclick="disconnectGoogleDrive()">
                        🔌 إلغاء ربط الحساب
                    </button>
                </div>
            </div>

            <!-- Comprehensive Financial PDF Report -->
            <div class="form-card" style="border-right: 5px solid var(--primary);">
                <h3 style="color: var(--primary);">📊 الكشف المالي الشامل (PDF)</h3>
                <p style="font-size: 0.86rem; color: var(--muted); margin-bottom: 14px;">
                    طباعة أو حفظ ملف PDF مرتب وواضح للشهر المختار يحتوي على: <strong>الديون المسددة، الديون غير المسددة، المصاريف، المدخلات، الإجمالي، والرصيد الباقي</strong>.
                </p>
                <button class="btn btn-primary" style="margin-bottom: 10px;" onclick="generateComprehensivePdfReport()">🖨️ طباعة / حفظ الكشف الشامل (PDF)</button>
                <button class="btn btn-outline" onclick="generateDebtPdfReport()">📄 كشف حركة الديون فقط (PDF)</button>
            </div>

            <!-- Local JSON Backup -->
            <div class="form-card" style="border-right: 5px solid #334155;">
                <h3 style="color: #334155;">💾 النسخ الاحتياطي المحلي (على الجهاز)</h3>
                <p style="font-size: 0.86rem; color: var(--muted); margin-bottom: 14px;">
                    احفظ نسخة من جميع الأشهر والبيانات على هاتفك أو استعدها يدوياً كملف.
                </p>
                <button class="btn btn-dark" style="margin-bottom: 10px;" onclick="exportBackup()">💾 حفظ نسخة احتياطية (JSON)</button>
                <button class="btn btn-outline" onclick="document.getElementById('importFile').click()">📂 استعادة نسخة احتياطية</button>
                <input type="file" id="importFile" accept=".json" style="display: none;" onchange="importBackup(event)">
            </div>
        </section>

    </div>

    <!-- Bottom Navigation Bar -->
    <nav class="bottom-nav">
        <button class="nav-item active" id="nav-debts" onclick="switchTab('debts')">
            <span class="icon">💳</span>
            <span>الديون</span>
        </button>
        <button class="nav-item" id="nav-expenses" onclick="switchTab('expenses')">
            <span class="icon">🛒</span>
            <span>المصاريف</span>
        </button>
        <button class="nav-item" id="nav-income" onclick="switchTab('income')">
            <span class="icon">💰</span>
            <span>الدخل</span>
        </button>
        <button class="nav-item" id="nav-settings" onclick="switchTab('settings')">
            <span class="icon">☁️</span>
            <span>السحابة والنسخ</span>
        </button>
    </nav>

    <!-- Modal 1: Add / Pay / Edit Operations -->
    <div class="modal-overlay" id="actionModal" onclick="closeModalOnBg(event, 'actionModal')">
        <div class="modal-sheet">
            <h3 id="modalTitle" style="margin-bottom: 4px;">عملية مالية</h3>
            <p id="modalSubtitle" style="font-size: 0.85rem; color: var(--muted); margin-bottom: 14px;"></p>
            
            <form onsubmit="submitModalAction(event)">
                <input type="hidden" id="modalActionType">
                <input type="hidden" id="modalTargetId">
                <input type="hidden" id="modalLogIndex">

                <div class="input-group" id="modalNameGroup" style="display: none;">
                    <label id="modalNameLabel">الاسم / الوصف *</label>
                    <input type="text" id="modalNameInput">
                </div>

                <div class="input-row" id="modalAmountDateGroup">
                    <div class="input-group">
                        <label>المبلغ (ريال يمني) *</label>
                        <input type="text" inputmode="decimal" class="amount-input" id="modalAmount" placeholder="0" oninput="formatInputWithCommas(this)">
                    </div>
                    <div class="input-group">
                        <label>التاريخ *</label>
                        <input type="date" id="modalDate" required>
                    </div>
                </div>

                <div style="display: flex; gap: 10px; margin-top: 10px;">
                    <button type="submit" id="modalSubmitBtn" class="btn btn-income" style="flex: 2;">تأكيد</button>
                    <button type="button" class="btn btn-outline" style="flex: 1;" onclick="closeModal('actionModal')">إلغاء</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal 2: Dedicated Movement History (Newest First) -->
    <div class="modal-overlay" id="historyModal" onclick="closeModalOnBg(event, 'historyModal')">
        <div class="modal-sheet">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
                <div>
                    <h3 id="histModalTitle" style="font-size: 1.05rem;">سجل الحركات</h3>
                    <p id="histModalSubtitle" style="font-size: 0.8rem; color: var(--muted);">مرتبة من العملية الأخيرة إلى الأقدم</p>
                </div>
                <button class="mini-btn" style="padding: 6px 12px;" onclick="closeModal('historyModal')">إغلاق ✖</button>
            </div>
            <div id="histModalListContainer" style="margin-top: 10px;"></div>
        </div>
    </div>

    <!-- Dedicated Print / PDF Area -->
    <div id="pdfReportArea"></div>

    <script>
        // =========================================================
        // GOOGLE DRIVE INTEGRATION CONFIG & STATE
        // =========================================================
        const GDRIVE_BACKUP_FILENAME = 'yawmiyati_cloud_backup.json';
        const GDRIVE_SCOPE = 'https://www.googleapis.com/auth/drive.file';

        let gdriveTokenClient = null;
        let gdriveAccessToken = localStorage.getItem('yawmiyati_gdrive_token') || '';
        let gdriveTokenExpiry = parseInt(localStorage.getItem('yawmiyati_gdrive_expiry') || '0');
        let gdriveFileId = localStorage.getItem('yawmiyati_gdrive_file_id') || '';
        let gdriveAutoSync = localStorage.getItem('yawmiyati_gdrive_autosync') === 'true';
        let gdriveLastSyncTime = localStorage.getItem('yawmiyati_gdrive_last_sync') || '';
        let autoSyncDebounceTimer = null;

        function initGoogleDriveUI() {
            const savedClientId = localStorage.getItem('yawmiyati_google_client_id') || '';
            document.getElementById('googleClientIdInput').value = savedClientId;
            document.getElementById('autoSyncToggle').checked = gdriveAutoSync;
            updateGoogleDriveStatusUI();
        }

        function saveGoogleClientId() {
            const val = document.getElementById('googleClientIdInput').value.trim();
            localStorage.setItem('yawmiyati_google_client_id', val);
        }

        function toggleAutoSync() {
            gdriveAutoSync = document.getElementById('autoSyncToggle').checked;
            localStorage.setItem('yawmiyati_gdrive_autosync', gdriveAutoSync);
            if (gdriveAutoSync) {
                syncToGoogleDrive(true);
            }
        }

        function isTokenValid() {
            return gdriveAccessToken && Date.now() < (gdriveTokenExpiry - 60000);
        }

        function updateGoogleDriveStatusUI(customStatusText = null) {
            const statusBox = document.getElementById('gdriveStatusBox');
            const authSec = document.getElementById('gdriveAuthSection');
            const ctrlSec = document.getElementById('gdriveControlsSection');
            const headerBadge = document.getElementById('headerSyncIndicator');

            if (gdriveAccessToken) {
                authSec.style.display = 'none';
                ctrlSec.style.display = 'block';
                headerBadge.style.display = 'inline-flex';
                headerBadge.textContent = customStatusText || (gdriveAutoSync ? '☁️ مزامنة تلقائية' : '☁️ متصل');

                const tokenState = isTokenValid() ? 'نشط ومتصل ✅' : 'يحتاج تجديد الجلسة عند المزامنة ⚠️';
                const lastSync = gdriveLastSyncTime ? `<br>آخر نسخة سحابية: <strong>${gdriveLastSyncTime}</strong>` : '';
                statusBox.innerHTML = `الحالة: <strong>${tokenState}</strong>${lastSync}`;
            } else {
                authSec.style.display = 'block';
                ctrlSec.style.display = 'none';
                headerBadge.style.display = 'none';
                statusBox.innerHTML = 'الحالة: <strong>غير مرتبط بحساب Google Drive</strong>';
            }
        }

        function connectGoogleDrive(callbackAfterAuth = null) {
            const clientId = document.getElementById('googleClientIdInput').value.trim();
            if (!clientId) {
                alert('يرجى إدخال معرّف عميل جوجل (Google Client ID) في الحقل المخصص أولاً.');
                document.getElementById('googleClientIdInput').focus();
                return;
            }

            if (typeof google === 'undefined' || !google.accounts || !google.accounts.oauth2) {
                alert('مكتبة جوجل قيد التحميل أو لا يوجد اتصال بالإنترنت. حاول بعد لحظات.');
                return;
            }

            gdriveTokenClient = google.accounts.oauth2.initTokenClient({
                client_id: clientId,
                scope: GDRIVE_SCOPE,
                callback: (tokenResponse) => {
                    if (tokenResponse.error) {
                        alert('فشل الربط مع جوجل: ' + tokenResponse.error);
                        return;
                    }
                    gdriveAccessToken = tokenResponse.access_token;
                    gdriveTokenExpiry = Date.now() + (Number(tokenResponse.expires_in || 3500) * 1000);
                    localStorage.setItem('yawmiyati_gdrive_token', gdriveAccessToken);
                    localStorage.setItem('yawmiyati_gdrive_expiry', gdriveTokenExpiry.toString());

                    updateGoogleDriveStatusUI();
                    if (typeof callbackAfterAuth === 'function') {
                        callbackAfterAuth();
                    } else {
                        alert('✅ تم ربط التطبيق بحسابك في Google Drive بنجاح!');
                    }
                }
            });

            gdriveTokenClient.requestAccessToken({ prompt: isTokenValid() ? '' : 'consent' });
        }

        function disconnectGoogleDrive() {
            if (!confirm('هل تريد إلغاء ربط التطبيق بحساب Google Drive؟ (ستبقى بياناتك محفوظة محلياً على جهازك)')) return;
            if (gdriveAccessToken && typeof google !== 'undefined' && google.accounts) {
                google.accounts.oauth2.revoke(gdriveAccessToken, () => {});
            }
            gdriveAccessToken = '';
            gdriveTokenExpiry = 0;
            gdriveFileId = '';
            localStorage.removeItem('yawmiyati_gdrive_token');
            localStorage.removeItem('yawmiyati_gdrive_expiry');
            localStorage.removeItem('yawmiyati_gdrive_file_id');
            updateGoogleDriveStatusUI();
        }

        async function findCloudBackupFile() {
            if (gdriveFileId) {
                const checkRes = await fetch(`https://www.googleapis.com/drive/v3/files/${gdriveFileId}?fields=id,name,trashed,modifiedTime`, {
                    headers: { 'Authorization': `Bearer ${gdriveAccessToken}` }
                });
                if (checkRes.ok) {
                    const meta = await checkRes.json();
                    if (!meta.trashed) return meta;
                }
                gdriveFileId = '';
                localStorage.removeItem('yawmiyati_gdrive_file_id');
            }

            const query = encodeURIComponent(`name='${GDRIVE_BACKUP_FILENAME}' and trashed=false`);
            const searchRes = await fetch(`https://www.googleapis.com/drive/v3/files?q=${query}&spaces=drive&fields=files(id,name,modifiedTime)`, {
                headers: { 'Authorization': `Bearer ${gdriveAccessToken}` }
            });
            if (!searchRes.ok) throw new Error('فشل البحث في Google Drive');
            const data = await searchRes.json();
            if (data.files && data.files.length > 0) {
                gdriveFileId = data.files[0].id;
                localStorage.setItem('yawmiyati_gdrive_file_id', gdriveFileId);
                return data.files[0];
            }
            return null;
        }

        async function syncToGoogleDrive(isSilent = false) {
            if (!gdriveAccessToken) return;

            if (!isTokenValid()) {
                if (!isSilent) {
                    connectGoogleDrive(() => syncToGoogleDrive(false));
                } else {
                    updateGoogleDriveStatusUI('⚠️ الجلسة منتهية');
                }
                return;
            }

            const exportBtn = document.getElementById('btnCloudExport');
            if (exportBtn) exportBtn.disabled = true;
            updateGoogleDriveStatusUI('⏳ جاري الرفع...');

            try {
                const existingFile = await findCloudBackupFile();
                const payloadObj = {
                    app: 'yawmiyati',
                    updatedAt: new Date().toISOString(),
                    state: appState
                };
                const fileContent = JSON.stringify(payloadObj, null, 2);

                const metadata = {
                    name: GDRIVE_BACKUP_FILENAME,
                    mimeType: 'application/json'
                };

                const boundary = '-------314159265358979323846';
                const delimiter = "\r\n--" + boundary + "\r\n";
                const closeDelim = "\r\n--" + boundary + "--";

                const multipartRequestBody =
                    delimiter +
                    'Content-Type: application/json; charset=UTF-8\r\n\r\n' +
                    JSON.stringify(metadata) +
                    delimiter +
                    'Content-Type: application/json\r\n\r\n' +
                    fileContent +
                    closeDelim;

                const url = existingFile
                    ? `https://www.googleapis.com/upload/drive/v3/files/${existingFile.id}?uploadType=multipart`
                    : `https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart`;

                const method = existingFile ? 'PATCH' : 'POST';

                const res = await fetch(url, {
                    method: method,
                    headers: {
                        'Authorization': `Bearer ${gdriveAccessToken}`,
                        'Content-Type': `multipart/related; boundary="${boundary}"`
                    },
                    body: multipartRequestBody
                });

                if (!res.ok) throw new Error('فشل رفع الملف إلى Google Drive');
                const savedMeta = await res.json();
                gdriveFileId = savedMeta.id;
                localStorage.setItem('yawmiyati_gdrive_file_id', gdriveFileId);

                const nowLabel = new Date().toLocaleString('ar-YE', { hour12: true });
                gdriveLastSyncTime = nowLabel;
                localStorage.setItem('yawmiyati_gdrive_last_sync', nowLabel);

                updateGoogleDriveStatusUI('☁️ تم الحفظ');
                if (!isSilent) {
                    alert('✅ تم تصدير وحفظ النسخة الاحتياطية في حسابك على Google Drive بنجاح.');
                }
            } catch (err) {
                console.error(err);
                updateGoogleDriveStatusUI('⚠️ خطأ مزامنة');
                if (!isSilent) {
                    alert('❌ حدث خطأ أثناء التصدير إلى Google Drive: ' + err.message);
                }
            } finally {
                if (exportBtn) exportBtn.disabled = false;
            }
        }

        async function restoreFromGoogleDrive() {
            if (!gdriveAccessToken) return;

            if (!isTokenValid()) {
                connectGoogleDrive(() => restoreFromGoogleDrive());
                return;
            }

            const restoreBtn = document.getElementById('btnCloudRestore');
            if (restoreBtn) restoreBtn.disabled = true;
            updateGoogleDriveStatusUI('⏳ جاري الجلب...');

            try {
                const existingFile = await findCloudBackupFile();
                if (!existingFile) {
                    alert('لم يتم العثور على أي نسخة احتياطية سابقة في حسابك على Google Drive.');
                    updateGoogleDriveStatusUI();
                    return;
                }

                const downloadRes = await fetch(`https://www.googleapis.com/drive/v3/files/${existingFile.id}?alt=media`, {
                    headers: { 'Authorization': `Bearer ${gdriveAccessToken}` }
                });
                if (!downloadRes.ok) throw new Error('تعذر تنزيل الملف من Google Drive');

                const cloudData = await downloadRes.json();
                const targetState = cloudData.state ? cloudData.state : cloudData;
                const modDate = new Date(existingFile.modifiedTime).toLocaleString('ar-YE');

                if (targetState && targetState.months) {
                    if (confirm(`تم العثور على نسخة سحابية بتاريخ:\n${modDate}\n\nهل تريد استبدال بياناتك المحلية الحالية بهذه النسخة؟`)) {
                        appState = targetState;
                        localStorage.setItem('yawmiyati_app_v2_imported', JSON.stringify(appState));
                        ensureMonthInitialized(currentMonth);
                        renderAll();
                        alert('✅ تمت استعادة البيانات من Google Drive بنجاح.');
                    }
                } else if (targetState && targetState.transactions) {
                    if (confirm(`تم العثور على نسخة سحابية شاملة بتاريخ:\n${modDate}\n\nهل تريد استيرادها وتحويلها إلى الأشهر؟`)) {
                        appState = convertLegacyBackupToMonthlyState(targetState);
                        localStorage.setItem('yawmiyati_app_v2_imported', JSON.stringify(appState));
                        ensureMonthInitialized(currentMonth);
                        renderAll();
                        alert('✅ تمت استعادة البيانات وترحيلها بنجاح.');
                    }
                } else {
                    alert('الملف السحابي لا يحتوي على بيانات صالحة.');
                }
            } catch (err) {
                console.error(err);
                alert('❌ حدث خطأ أثناء الاستعادة من Google Drive: ' + err.message);
            } finally {
                if (restoreBtn) restoreBtn.disabled = false;
                updateGoogleDriveStatusUI();
            }
        }

        function triggerAutoCloudSync() {
            if (!gdriveAutoSync || !gdriveAccessToken) return;
            clearTimeout(autoSyncDebounceTimer);
            updateGoogleDriveStatusUI('⏳ مزامنة...');
            autoSyncDebounceTimer = setTimeout(() => {
                syncToGoogleDrive(true);
            }, 2500);
        }

        // =========================================================
        // EMBEDDED BACKUP DATA (ALL 299 OPERATIONS INCLUDED)
        // =========================================================
        const INITIAL_BACKUP_PAYLOAD = {
          "transactions": [
            {"id":"tx-1794924398991-2s3fwkf0q","personName":"رسوم للمدرسه","type":"borrow","amount":11000,"date":"2026-11-17","createdAt":1794924398991},
            {"id":"tx-1794923451090-52yqpflib","personName":"محمد الخضروات","type":"borrow","amount":4000,"date":"2026-11-17","createdAt":1794923451090},
            {"id":"tx-1794923390986-pj00zzorz","personName":"الاثاث","type":"repay","amount":25,"date":"2026-11-17","createdAt":1794923390986},
            {"id":"tx-1794923362418-dcyull5bh","personName":"علاء محمد ثابت صلاح","type":"repay","amount":25000,"date":"2026-11-17","createdAt":1794923362418},
            {"id":"tx-1794818490489-mr1o1e3hy","personName":"سمير للدواجن","type":"repay","amount":3000,"date":"2026-11-16","createdAt":1794818490489},
            {"id":"tx-1794818475682-5uoxba5he","personName":"صيدلية الغزالي","type":"repay","amount":3000,"date":"2026-11-16","createdAt":1794818475682},
            {"id":"tx-1794818443060-bgpzo3nse","personName":"صيدلية الغزالي","type":"borrow","amount":3000,"date":"2026-11-16","createdAt":1794818443060},
            {"id":"tx-1794818429138-tvi6c4ucz","personName":"سمير للدواجن","type":"borrow","amount":3000,"date":"2026-11-16","createdAt":1794818429138},
            {"id":"tx-1794818395422-3dv7kr0zk","personName":"عبدالله بن يحيى","type":"repay","amount":9000,"date":"2026-11-16","createdAt":1794818395422},
            {"id":"tx-1794818370661-q9qaamh99","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-11-16","createdAt":1794818370661},
            {"id":"tx-1794776086896-1poo50ozu","personName":"رسوم للمدرسه","type":"borrow","amount":1000,"date":"2026-11-15","createdAt":1794776086896},
            {"id":"tx-1794776049320-aht5gwvqo","personName":"عبدالله بن يحيى","type":"borrow","amount":2000,"date":"2026-11-15","createdAt":1794776049320},
            {"id":"tx-1794776037196-73wyadzua","personName":"بقالة الشذى","type":"borrow","amount":10000,"date":"2026-11-15","createdAt":1794776037196},
            {"id":"tx-1794765406136-wibtvi06k","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-11-15","createdAt":1794765406136},
            {"id":"tx-1794677988249-1jj37jau3","personName":"عبدالله بن يحيى","type":"borrow","amount":2000,"date":"2026-11-14","createdAt":1794677988249},
            {"id":"tx-1794557900093-sm3y0e15h","personName":"عبدالله بن يحيى","type":"borrow","amount":2000,"date":"2026-11-13","createdAt":1794557900093},
            {"id":"tx-1794500263888-slekp2yxk","personName":"تقسيط مدرسة","type":"borrow","amount":15000,"date":"2026-11-12","createdAt":1794500263892},
            {"id":"tx-1794500149257-98e7rg1w6","personName":"بقالة الشذى","type":"borrow","amount":30000,"date":"2026-11-12","createdAt":1794500149257},
            {"id":"tx-1794499852441-tjqjiztam","personName":"رسوم للمدرسه","type":"repay","amount":9000,"date":"2026-11-12","createdAt":1794499852441},
            {"id":"tx-1794499784502-wiyeaqluh","personName":"علاء محمد ثابت صلاح","type":"borrow","amount":25000,"date":"2026-11-12","createdAt":1794499784502},
            {"id":"tx-1794499455639-bno9i2kag","personName":"عبدالله بن يحيى","type":"repay","amount":9000,"date":"2026-11-12","createdAt":1794499455639},
            {"id":"tx-1794499449100-cs3e1ylj5","personName":"عبدالله بن يحيى","type":"borrow","amount":1000,"date":"2026-11-12","createdAt":1794499449100},
            {"id":"tx-1794462366721-32bpkvryi","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-11-12","createdAt":1794462366721},
            {"id":"tx-1794411011768-2likqn3ey","personName":"صيدلية الغزالي","type":"repay","amount":1800,"date":"2026-11-11","createdAt":1794411011768},
            {"id":"tx-1794410988495-d9nzwojlr","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-11-11","createdAt":1794410988495},
            {"id":"tx-1794315323375-qaixs936b","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-11-10","createdAt":1794315323375},
            {"id":"tx-1794234877227-tmgb57fno","personName":"صيدلية الغزالي","type":"borrow","amount":1800,"date":"2026-11-09","createdAt":1794234877227},
            {"id":"tx-1794234736933-6enx9jjf2","personName":"عبدالله بن يحيى","type":"borrow","amount":2000,"date":"2026-11-09","createdAt":1794234736933},
            {"id":"tx-1794216104576-reszj8m5b","personName":"سمير للدواجن","type":"repay","amount":2000,"date":"2026-11-09","createdAt":1794216104576},
            {"id":"tx-1794216094818-yd63tvqrm","personName":"سمير للدواجن","type":"borrow","amount":1000,"date":"2026-11-09","createdAt":1794216094818},
            {"id":"tx-1794140086194-oz594m2yy","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-11-08","createdAt":1794140086194},
            {"id":"tx-1793970844324-94lkvmsqp","personName":"عبدالله بن يحيى","type":"repay","amount":12000,"date":"2026-11-06","createdAt":1793970844324},
            {"id":"tx-1793954427199-mhuzj97b4","personName":"عبدالله بن يحيى","type":"borrow","amount":3000,"date":"2026-11-06","createdAt":1793954427199},
            {"id":"tx-1793783539190-m2wfwilo4","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-11-04","createdAt":1793783539190},
            {"id":"tx-1793718431123-jpds007bj","personName":"اقساط المدرسة","type":"repay","amount":9,"date":"2026-11-03","createdAt":1793718431123},
            {"id":"tx-1793718404803-2m8i6mfp6","personName":"الاقساط ورسوم للمدرسه","type":"repay","amount":9000,"date":"2026-11-03","createdAt":1793718404803},
            {"id":"tx-1793718338550-6gu8mizrz","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-11-03","createdAt":1793718338550},
            {"id":"tx-1793632649271-32vfgq9ce","personName":"محمد الخضروات","type":"borrow","amount":2000,"date":"2026-11-02","createdAt":1793632649271},
            {"id":"tx-1793632633375-7an7dxwrq","personName":"سمير للدواجن","type":"borrow","amount":1000,"date":"2026-11-02","createdAt":1793632633375},
            {"id":"tx-1793632507640-sm2tt2q4b","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-11-02","createdAt":1793632507640},
            {"id":"tx-1793534398840-dg5v41xez","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-11-01","createdAt":1793534398840},
            {"id":"tx-1793534381725-c0rub0ias","personName":"بقالة الشذى","type":"repay","amount":20000,"date":"2026-11-01","createdAt":1793534381725},
            {"id":"tx-1793455650051-9tiajdc4l","personName":"رسوم للمدرسه","type":"borrow","amount":9000,"date":"2026-10-31","createdAt":1793455650051},
            {"id":"tx-1793455441085-z25c996hy","personName":"عبدالله بن يحيى","type":"borrow","amount":3000,"date":"2026-10-31","createdAt":1793455441085},
            {"id":"tx-1793262781925-9jimal3p9","personName":"عبدالله بن يحيى","type":"repay","amount":16000,"date":"2026-10-29","createdAt":1793262781925},
            {"id":"tx-1793262771929-zxzc5xhds","personName":"عبدالله بن يحيى","type":"borrow","amount":2000,"date":"2026-10-29","createdAt":1793262771929},
            {"id":"tx-1793170069969-ktmbg1ohm","personName":"عبدالله بن يحيى","type":"borrow","amount":3000,"date":"2026-10-28","createdAt":1793170069969},
            {"id":"tx-1793025009913-zj4accm0b","personName":"بقالة الشذى","type":"borrow","amount":10000,"date":"2026-10-26","createdAt":1793025009913},
            {"id":"tx-1793004579179-vpimox97c","personName":"عبدالله بن يحيى","type":"borrow","amount":4500,"date":"2026-10-26","createdAt":1793004579179},
            {"id":"tx-1792769868303-o6lbua10s","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-10-23","createdAt":1792769868303},
            {"id":"tx-1792655735881-1q0q2l8ik","personName":"عبدالله بن يحيى","type":"borrow","amount":5000,"date":"2026-10-22","createdAt":1792655735881},
            {"id":"tx-1792655673029-lc5hje8iw","personName":"بقالة الشذى","type":"repay","amount":10000,"date":"2026-10-22","createdAt":1792655673029},
            {"id":"tx-1792407467531-6op1fwwn9","personName":"عبدالله بن يحيى","type":"repay","amount":6000,"date":"2026-10-19","createdAt":1792407467531},
            {"id":"tx-1792393738397-afca83m1o","personName":"عبدالله بن يحيى","type":"borrow","amount":3000,"date":"2026-10-19","createdAt":1792393738397},
            {"id":"tx-1792265330440-e3cuz9brf","personName":"بقالة الشذى","type":"borrow","amount":10000,"date":"2026-10-17","createdAt":1792265330440},
            {"id":"tx-1792265314883-tn7uqdjca","personName":"عبدالله بن يحيى","type":"borrow","amount":3000,"date":"2026-10-17","createdAt":1792265314883},
            {"id":"tx-1792077590933-9aole80oh","personName":"بقالة الشذى","type":"repay","amount":5000,"date":"2026-10-15","createdAt":1792077590933},
            {"id":"tx-1792077381877-oamrbesr0","personName":"عبدالله بن يحيى","type":"repay","amount":3000,"date":"2026-10-15","createdAt":1792077381877},
            {"id":"tx-1792077373573-he8camzfo","personName":"عبدالله بن يحيى","type":"borrow","amount":3000,"date":"2026-10-15","createdAt":1792077373573},
            {"id":"tx-1792067547346-dz43to3vv","personName":"الاثاث","type":"repay","amount":25,"date":"2026-10-15","createdAt":1792067547346},
            {"id":"tx-1792067526817-umhnbl58m","personName":"علاء محمد ثابت صلاح","type":"repay","amount":25000,"date":"2026-10-15","createdAt":1792067526817},
            {"id":"tx-1792067423033-jjapex58b","personName":"محمد الخضروات","type":"repay","amount":5000,"date":"2026-10-15","createdAt":1792067423033},
            {"id":"tx-1792067413203-v0i8ctoi0","personName":"بقالة الشذى","type":"borrow","amount":10000,"date":"2026-10-15","createdAt":1792067413203},
            {"id":"tx-1792067385010-p66mv9c40","personName":"بقالة الشذى","type":"repay","amount":25000,"date":"2026-10-15","createdAt":1792067385010},
            {"id":"tx-1791984015551-0phchl6ac","personName":"تقسيط مدرسة","type":"repay","amount":15000,"date":"2026-10-14","createdAt":1791984015551},
            {"id":"tx-1791983955413-rdtzzaknw","personName":"اقساط المدرسة","type":"repay","amount":15,"date":"2026-10-14","createdAt":1791983955413},
            {"id":"tx-1791983460738-o50aj8zb6","personName":"عماد اخي","type":"repay","amount":5000,"date":"2026-10-14","createdAt":1791983460738},
            {"id":"tx-1791982775843-79dyga1t4","personName":"صيدلية الغزالي","type":"repay","amount":3500,"date":"2026-10-14","createdAt":1791982775843},
            {"id":"tx-1791982756851-brxe7p13l","personName":"سمير للدواجن","type":"repay","amount":1000,"date":"2026-10-14","createdAt":1791982756851},
            {"id":"tx-1791982719983-ibjzyp9ji","personName":"محمد الخضروات","type":"repay","amount":5000,"date":"2026-10-14","createdAt":1791982719983},
            {"id":"tx-1791971198927-qsadqkwd6","personName":"عبدالله بن يحيى","type":"repay","amount":22500,"date":"2026-10-14","createdAt":1791971198927},
            {"id":"tx-1791968061385-9nes1bo0d","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-10-14","createdAt":1791968061385},
            {"id":"tx-1791902314392-4i0fr3lm3","personName":"متفرقات","type":"repay","amount":5000,"date":"2026-10-13","createdAt":1791902314392},
            {"id":"tx-1791902290585-vvw3ds1x3","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-10-13","createdAt":1791902290585},
            {"id":"tx-1791831495231-0l08nsm1s","personName":"ملحمة الشعوبي","type":"repay","amount":3000,"date":"2026-10-12","createdAt":1791831495231},
            {"id":"tx-1791822324303-tsf1sstok","personName":"متفرقات","type":"borrow","amount":4000,"date":"2026-10-12","createdAt":1791822324303},
            {"id":"tx-1791822284893-1dr2jlno7","personName":"متفرقات","type":"borrow","amount":1000,"date":"2026-10-12","note":"صفاء","createdAt":1791822284893},
            {"id":"tx-1791822096974-9435alhup","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-10-12","createdAt":1791822096974},
            {"id":"tx-1791728813642-vo6rj22ky","personName":"محمد الخضروات","type":"borrow","amount":10000,"date":"2026-10-11","createdAt":1791728813642},
            {"id":"tx-1791728715809-ptjb52xjw","personName":"بقالة الشذى","type":"borrow","amount":10000,"date":"2026-10-11","createdAt":1791728715809},
            {"id":"tx-1791723199296-djivvi4so","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-10-11","createdAt":1791723199296},
            {"id":"tx-1791643890417-26ct90d2o","personName":"صيدلية الغزالي","type":"repay","amount":3000,"date":"2026-10-10","createdAt":1791643890417},
            {"id":"tx-1791621477642-tyjrtcwvq","personName":"بقالة الشذى","type":"borrow","amount":5000,"date":"2026-10-10","createdAt":1791621477642},
            {"id":"tx-1791621460359-zfznyl3os","personName":"ملحمة الشعوبي","type":"borrow","amount":3000,"date":"2026-10-10","note":"ملحمة الشعوبي","createdAt":1791621460359},
            {"id":"tx-1791621413970-vy4fewmib","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-10-10","createdAt":1791621413970},
            {"id":"tx-1791554727234-97rzsq0lz","personName":"سمير للدواجن","type":"borrow","amount":1000,"date":"2026-10-09","createdAt":1791554727234},
            {"id":"tx-1791534689317-i9wzi2lh6","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-10-09","createdAt":1791534689317},
            {"id":"tx-1791465651929-wf21uj031","personName":"صيدلية الغزالي","type":"borrow","amount":3000,"date":"2026-10-08","createdAt":1791465651929},
            {"id":"tx-1791465611592-dokmz4n9m","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-10-08","createdAt":1791465611592},
            {"id":"tx-1791386825816-4f1ink874","personName":"بقالة الشذى","type":"borrow","amount":10000,"date":"2026-10-07","createdAt":1791386825816},
            {"id":"tx-1791386770858-46b3v3685","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-10-07","createdAt":1791386770858},
            {"id":"tx-1791386755445-cf890j14g","personName":"عماد اخي","type":"borrow","amount":5000,"date":"2026-10-07","createdAt":1791386755445},
            {"id":"tx-1791299696483-663conqa7","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-10-06","createdAt":1791299696483},
            {"id":"tx-1791229580237-ik1xvsgb0","personName":"صيدلية الغزالي","type":"borrow","amount":3500,"date":"2026-10-05","createdAt":1791229580237},
            {"id":"tx-1791224450634-jnrj017nq","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-10-05","createdAt":1791224450634},
            {"id":"tx-1791124747208-xixgzyay0","personName":"علاء محمد ثابت صلاح","type":"borrow","amount":25000,"date":"2026-10-04","createdAt":1791124747208},
            {"id":"tx-1791124734009-zexsfp5o8","personName":"تقسيط مدرسة","type":"borrow","amount":15000,"date":"2026-10-04","createdAt":1791124734009},
            {"id":"tx-1791124674664-v4gkn9hhg","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-10-04","createdAt":1791124674664},
            {"id":"tx-1791047616206-lyz549ws0","personName":"بقالة الشذى","type":"repay","amount":30000,"date":"2026-10-03","createdAt":1791047616206},
            {"id":"tx-1790978259515-605qc56cr","personName":"بقالة الشذى","type":"borrow","amount":15000,"date":"2026-10-03","createdAt":1790978259515},
            {"id":"tx-1790978213456-s5rqm0o0c","personName":"عبدالله بن يحيى","type":"borrow","amount":6000,"date":"2026-10-03","createdAt":1790978213456},
            {"id":"tx-1790607157732-z6omx302x","personName":"سمير للدواجن","type":"repay","amount":1500,"date":"2026-09-28","createdAt":1790607157732},
            {"id":"tx-1790607137263-1p1ttv706","personName":"عبدالله بن يحيى","type":"repay","amount":7000,"date":"2026-09-28","createdAt":1790607137263},
            {"id":"tx-1790588489280-2jzmampnh","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-09-28","createdAt":1790588489280},
            {"id":"tx-1790516597357-02tg4z4i7","personName":"عبدالله بن يحيى","type":"borrow","amount":3000,"date":"2026-09-27","createdAt":1790516597357},
            {"id":"tx-1790337830701-x5rwzmi20","personName":"بقالة الشذى","type":"borrow","amount":10000,"date":"2026-09-25","createdAt":1790337830701},
            {"id":"tx-1790326494652-6chhob3ys","personName":"عبدالله بن يحيى","type":"borrow","amount":1000,"date":"2026-09-25","createdAt":1790326494652},
            {"id":"tx-1790238692499-rpjldnbos","personName":"عبدالله بن يحيى","type":"repay","amount":10000,"date":"2026-09-24","createdAt":1790238692499},
            {"id":"tx-1790238677377-1b4kkr0uy","personName":"عبدالله بن يحيى","type":"borrow","amount":3000,"date":"2026-09-24","createdAt":1790238677377},
            {"id":"tx-1790091239067-f1zx61vd7","personName":"عبدالله بن يحيى","type":"borrow","amount":2000,"date":"2026-09-22","createdAt":1790091239067},
            {"id":"tx-1789981031653-ji9m51up8","personName":"بقالة الشذى","type":"borrow","amount":5000,"date":"2026-09-21","createdAt":1789981031653},
            {"id":"tx-1789980945844-lz4rhcefk","personName":"عبدالله بن يحيى","type":"borrow","amount":3500,"date":"2026-09-21","createdAt":1789980945844},
            {"id":"tx-1789834211014-l1volr6e3","personName":"بقالة الشذى","type":"borrow","amount":5000,"date":"2026-09-19","createdAt":1789834211014},
            {"id":"tx-1789834150532-rrt7om1xf","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-09-19","createdAt":1789834150532},
            {"id":"tx-1789763923279-zmoxvkqpb","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-09-18","createdAt":1789763923279},
            {"id":"tx-1789647271468-jqvwlrn9c","personName":"عبدالله بن يحيى","type":"repay","amount":9500,"date":"2026-09-17","createdAt":1789647271468},
            {"id":"tx-1789635643770-ef9tlywra","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-09-17","createdAt":1789635643770},
            {"id":"tx-1789568651283-tyv0cha81","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-09-16","createdAt":1789568651284},
            {"id":"tx-1789486406129-klh7w0dvq","personName":"بقالة الشذى","type":"repay","amount":22000,"date":"2026-09-15","createdAt":1789486406129},
            {"id":"tx-1789486398016-zbuzhu0mg","personName":"بقالة الشذى","type":"borrow","amount":3000,"date":"2026-09-15","createdAt":1789486398016},
            {"id":"tx-1789304704041-nfiiue3hn","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-09-13","createdAt":1789304704041},
            {"id":"tx-1789222194019-nm9ro8wuz","personName":"عبدالله بن يحيى","type":"borrow","amount":2000,"date":"2026-09-12","createdAt":1789222194019},
            {"id":"tx-1789137882530-ctqd2skm0","personName":"سمير للدواجن","type":"borrow","amount":1500,"date":"2026-09-11","createdAt":1789137882530},
            {"id":"tx-1789137793053-stp8k1kak","personName":"عبدالله بن يحيى","type":"borrow","amount":3000,"date":"2026-09-11","createdAt":1789137793053},
            {"id":"tx-1789137760109-yo8hj9v46","personName":"بقالة الشذى","type":"borrow","amount":10000,"date":"2026-09-11","createdAt":1789137760109},
            {"id":"tx-1788965459013-s6x9asgoi","personName":"عبدالله بن يحيى","type":"repay","amount":5500,"date":"2026-09-09","createdAt":1788965459013},
            {"id":"tx-1788943477603-4lnceogo5","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-09-09","createdAt":1788943477603},
            {"id":"tx-1788884398285-xm2hx8k65","personName":"تقسيط مدرسة","type":"repay","amount":15000,"date":"2026-09-08","createdAt":1788884398285},
            {"id":"tx-1788884337268-mt1fnm59v","personName":"اقساط المدرسة","type":"repay","amount":15,"date":"2026-09-08","createdAt":1788884337268},
            {"id":"tx-1788877830456-14ji5szvr","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-09-08","createdAt":1788877830456},
            {"id":"tx-1788877303627-xd49a3nip","personName":"الاثاث","type":"repay","amount":25,"date":"2026-09-08","createdAt":1788877303627},
            {"id":"tx-1788877286230-u8isf21fh","personName":"عماد اخي","type":"repay","amount":15000,"date":"2026-09-08","createdAt":1788877286230},
            {"id":"tx-1788877272644-uj3qmlmhi","personName":"علاء محمد ثابت صلاح","type":"repay","amount":25000,"date":"2026-09-08","createdAt":1788877272644},
            {"id":"tx-1788798581955-urvb3wsjd","personName":"عبدالله بن يحيى","type":"repay","amount":1000,"date":"2026-09-07","createdAt":1788798581955},
            {"id":"tx-1788790726020-r77adqrjl","personName":"بقالة الشذى","type":"repay","amount":50000,"date":"2026-09-07","createdAt":1788790726020},
            {"id":"tx-1788790710606-faqk3pbxx","personName":"بقالة الشذى","type":"repay","amount":1000,"date":"2026-09-07","createdAt":1788790710606},
            {"id":"tx-1788788925948-siyy4ch95","personName":"عبدالله بن يحيى","type":"repay","amount":6000,"date":"2026-09-07","createdAt":1788788925948},
            {"id":"tx-1788788745908-jo373e9ju","personName":"عبدالله بن يحيى","type":"borrow","amount":3000,"date":"2026-09-07","createdAt":1788788745908},
            {"id":"tx-1788636293319-clc39kp3k","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-09-05","createdAt":1788636293319},
            {"id":"tx-1788533429633-2b6fdtxo5","personName":"تقسيط مدرسة","type":"borrow","amount":12000,"date":"2026-09-04","createdAt":1788533429633},
            {"id":"tx-1788533388352-s8ko9jj97","personName":"علاء محمد ثابت صلاح","type":"borrow","amount":25000,"date":"2026-09-04","note":"دفعة تقسيط","createdAt":1788533388352},
            {"id":"tx-1788533320508-32ct85obe","personName":"بقالة الشذى","type":"borrow","amount":5000,"date":"2026-09-04","createdAt":1788533320508},
            {"id":"tx-1788533305989-8sibu8ux6","personName":"عبدالله بن يحيى","type":"borrow","amount":2000,"date":"2026-09-04","createdAt":1788533305989},
            {"id":"tx-1788439914070-7r4n3h4mf","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-09-03","createdAt":1788439914070},
            {"id":"tx-1788357511532-lziy85879","personName":"الاثاث","type":"repay","amount":208,"date":"2026-09-02","createdAt":1788357511532},
            {"id":"tx-1788357434002-exd20a5x5","personName":"اقساط المدرسة","type":"repay","amount":45,"date":"2026-09-02","createdAt":1788357434002},
            {"id":"tx-1788357325914-xbacuuzge","personName":"اقساط المدرسة","type":"borrow","amount":120,"date":"2026-09-02","createdAt":1788357325914},
            {"id":"tx-1788357266785-6391el60a","personName":"الاثاث","type":"borrow","amount":333,"date":"2026-09-02","createdAt":1788357266785},
            {"id":"tx-1788357041886-g9d3dyn7v","personName":"بقالة الشذى","type":"borrow","amount":5000,"date":"2026-09-02","createdAt":1788357041886},
            {"id":"tx-1788354409827-pz0ymlnkf","personName":"عبدالله بن يحيى","type":"borrow","amount":1500,"date":"2026-09-02","createdAt":1788354409827},
            {"id":"tx-1788354393038-9r8mj6bjc","personName":"سمير للدواجن","type":"repay","amount":2000,"date":"2026-09-02","createdAt":1788354393038},
            {"id":"tx-1788277894328-8l2wmppja","personName":"محمد الخضروات","type":"repay","amount":7300,"date":"2026-09-01","createdAt":1788277894328},
            {"id":"tx-1788277451842-kpvq76i7h","personName":"سمير للدواجن","type":"borrow","amount":2000,"date":"2026-09-01","createdAt":1788277451842},
            {"id":"tx-1788276440490-rati8roki","personName":"عبدالله بن يحيى","type":"repay","amount":17000,"date":"2026-09-01","createdAt":1788276440490},
            {"id":"tx-1788276420543-ov73f28jp","personName":"عبدالله بن يحيى","type":"borrow","amount":17000,"date":"2026-09-01","createdAt":1788276420543},
            {"id":"tx-1788275913577-y56ft9ac8","personName":"بقالة الشذى","type":"borrow","amount":50000,"date":"2026-09-01","createdAt":1788275913577},
            {"id":"tx-1788275857145-wg9ow3n39","personName":"عمرو صالح مسعد","type":"repay","amount":25000,"date":"2026-09-01","createdAt":1788275857145},
            {"id":"tx-1788275716047-xxo3zwwk4","personName":"عماد اخي","type":"borrow","amount":15000,"date":"2026-09-01","createdAt":1788275716047},
            {"id":"tx-1788275431380-j0vasjzv0","personName":"محمد الخضروات","type":"borrow","amount":7300,"date":"2026-09-01","createdAt":1788275431380},
            {"id":"tx-1788275401368-ol33xay0c","personName":"عمرو صالح مسعد","type":"borrow","amount":25000,"date":"2026-08-05","createdAt":1788275401368}
          ],
          "expenses": [
            {"id":"exp-1794924497396-5ckifriu4","category":"كهرباء","amount":4000,"date":"2026-11-17","createdAt":1794924497396},
            {"id":"exp-1794919673331-s0x7bnfbg","category":"مصاريف","amount":20000,"date":"2026-11-17","createdAt":1794919673331},
            {"id":"exp-1794919565765-7zfuwtfzv","category":"نزلة اب","amount":40000,"date":"2026-11-17","createdAt":1794919565765},
            {"id":"exp-1794776410943-z40ejysk3","category":"موفرة","amount":75000,"date":"2026-11-15","createdAt":1794776410943},
            {"id":"exp-1794678399412-vxfcak21y","category":"مصاريف","amount":10000,"date":"2026-11-14","createdAt":1794678399412},
            {"id":"exp-1794678029799-qzryqoowo","category":"مصاريف","amount":10000,"date":"2026-11-14","createdAt":1794678029799},
            {"id":"exp-1794499527143-vu70fosoj","category":"مصاريف","amount":10000,"date":"2026-11-12","createdAt":1794499527143},
            {"id":"exp-1794411049755-5dcz62k16","category":"مصاريف","amount":10000,"date":"2026-11-11","createdAt":1794411049755},
            {"id":"exp-1794315482175-mtb5gi8io","category":"مصاريف","amount":10000,"date":"2026-11-10","createdAt":1794315482175},
            {"id":"exp-1794315458376-13qyu4p7i","category":"موفرة","amount":4000,"date":"2026-11-10","createdAt":1794315458376},
            {"id":"exp-1794315345002-z9arr072g","category":"مصاريف","amount":10000,"date":"2026-11-10","createdAt":1794315345002},
            {"id":"exp-1794234825050-o15uump5j","category":"مصاريف","amount":5000,"date":"2026-11-09","createdAt":1794234825050},
            {"id":"exp-1794234803266-fyt1xj9my","category":"مصاريف","amount":10000,"date":"2026-11-09","createdAt":1794234803266},
            {"id":"exp-1794140118855-x2l3f4c9l","category":"مصاريف","amount":20000,"date":"2026-11-08","createdAt":1794140118855},
            {"id":"exp-1793971003661-744pil579","category":"موفرة","amount":133000,"date":"2026-11-06","createdAt":1793971003661},
            {"id":"exp-1793970903611-c4wm1cz37","category":"مصاريف","amount":20000,"date":"2026-11-06","createdAt":1793970903611},
            {"id":"exp-1793718795426-b31gr3g42","category":"مصاريف","amount":5000,"date":"2026-11-03","createdAt":1793718795427},
            {"id":"exp-1793718686705-0cn4phr1r","category":"فاتورة الماء","amount":5000,"date":"2026-11-03","createdAt":1793718686705},
            {"id":"exp-1793718474329-ev5rs0he4","category":"مصاريف","amount":10000,"date":"2026-11-03","createdAt":1793718474329},
            {"id":"exp-1793632531786-493yzqxgu","category":"مصاريف","amount":10000,"date":"2026-11-02","createdAt":1793632531786},
            {"id":"exp-1793534364703-t7rb7esu9","category":"مصاريف","amount":10000,"date":"2026-11-01","createdAt":1793534364703},
            {"id":"exp-1793455483359-zks3v5njz","category":"مصاريف بيت","amount":15000,"date":"2026-10-31","createdAt":1793455483359},
            {"id":"exp-1793213028365-lff2xtcsc","category":"مصاريف بيت","amount":10000,"date":"2026-10-28","createdAt":1793213028365},
            {"id":"exp-1793212948696-t25m04t49","category":"مصاريف بيت","amount":15000,"date":"2026-10-28","note":"غاز","createdAt":1793212948696},
            {"id":"exp-1793212888167-bxwculpck","category":"مصاريف بيت","amount":10000,"date":"2026-10-28","createdAt":1793212888167},
            {"id":"exp-1793025113822-yc1j397bs","category":"مصاريف بيت","amount":5000,"date":"2026-10-26","createdAt":1793025113822},
            {"id":"exp-1793024969547-axcn4kaxs","category":"مصاريف بيت","amount":5000,"date":"2026-10-26","createdAt":1793024969547},
            {"id":"exp-1792769963507-arpywpw6q","category":"مصاريف بيت","amount":5000,"date":"2026-10-23","createdAt":1792769963507},
            {"id":"exp-1792407400837-fbl2xhsfy","category":"مصاريف بيت","amount":20000,"date":"2026-10-19","createdAt":1792407400837},
            {"id":"exp-1792265417840-qe1tf75nf","category":"مصاريف بيت","amount":14000,"date":"2026-10-17","createdAt":1792265417840},
            {"id":"exp-1792077413130-n2lx14jf7","category":"مصاريف بيت","amount":6000,"date":"2026-10-15","createdAt":1792077413130},
            {"id":"exp-1792011843378-ajmvp5vfb","category":"ماء وانترنت","amount":10000,"date":"2026-10-15","createdAt":1792011843378},
            {"id":"exp-1791983004161-4160dta6e","category":"مصاريف بيت","amount":10000,"date":"2026-10-14","createdAt":1791983004161},
            {"id":"exp-1791902441324-ab3yuef0f","category":"مصاريف بيت","amount":15000,"date":"2026-10-13","createdAt":1791902441324},
            {"id":"exp-1791822152744-cwf62j1in","category":"مصاريف بيت","amount":1000,"date":"2026-10-12","createdAt":1791822152744},
            {"id":"exp-1791822131406-yhmdunhgt","category":"مصاريف بيت","amount":5000,"date":"2026-10-12","createdAt":1791822131406},
            {"id":"exp-1791728920019-wnc6tj0cp","category":"مصاريف بيت","amount":10000,"date":"2026-10-11","createdAt":1791728920019},
            {"id":"exp-1791554954160-81pdwzk7l","category":"مصاريف بيت","amount":10000,"date":"2026-10-09","createdAt":1791554954160},
            {"id":"exp-1791465676298-k41q4vfcn","category":"مصاريف بيت","amount":10000,"date":"2026-10-08","createdAt":1791465676298},
            {"id":"exp-1791386728268-6unz3agaq","category":"مصاريف بيت","amount":10000,"date":"2026-10-07","createdAt":1791386728268},
            {"id":"exp-1791124658875-fba6bd65o","category":"مصاريف بيت","amount":6000,"date":"2026-10-04","createdAt":1791124658875},
            {"id":"exp-1791124622050-1l1jvuq3a","category":"مصاريف بيت","amount":35000,"date":"2026-10-04","createdAt":1791124622050},
            {"id":"exp-1791047630822-igxii8nqj","category":"ملابس","amount":26000,"date":"2026-10-03","createdAt":1791047630822},
            {"id":"exp-1790985077793-5ke5vd14x","category":"معلاق وثلاجات","amount":16000,"date":"2026-10-03","createdAt":1790985077794},
            {"id":"exp-1790607256020-siyme3ks7","category":"مصاريف","amount":10000,"date":"2026-09-28","note":"تقي ومنال","createdAt":1790607256020},
            {"id":"exp-1790607195202-vbsliu0jq","category":"مصاريف","amount":10000,"date":"2026-09-28","createdAt":1790607195202},
            {"id":"exp-1790607108270-m8g9jvste","category":"مصاريف","amount":3000,"date":"2026-09-28","createdAt":1790607108270},
            {"id":"exp-1790607088081-uz4e298qz","category":"ارحام","amount":10000,"date":"2026-09-28","createdAt":1790607088081},
            {"id":"exp-1790434065120-vpq91k206","category":"مصاريف","amount":5000,"date":"2026-09-26","createdAt":1790434065120},
            {"id":"exp-1790337809816-qv2e7cytz","category":"مصاريف","amount":5000,"date":"2026-09-25","createdAt":1790337809816},
            {"id":"exp-1790337755668-ngy2lzc3j","category":"انترنت فورجي","amount":2500,"date":"2026-09-25","createdAt":1790337755668},
            {"id":"exp-1790326525301-tutgu2jtw","category":"مصاريف","amount":5000,"date":"2026-09-25","createdAt":1790326525301},
            {"id":"exp-1790091320028-n7mebk7u8","category":"مصاريف","amount":5000,"date":"2026-09-22","createdAt":1790091320028},
            {"id":"exp-1789981002113-cvg41dzpj","category":"مصاريف","amount":6000,"date":"2026-09-21","createdAt":1789981002113},
            {"id":"exp-1789834268851-3k0nm0vy9","category":"حصالة","amount":20000,"date":"2026-09-19","createdAt":1789834268851},
            {"id":"exp-1789834129525-7bf4peo1r","category":"مصاريف","amount":17000,"date":"2026-09-19","createdAt":1789834129525},
            {"id":"exp-1789763962245-a0ruelun5","category":"مصاريف","amount":5000,"date":"2026-09-18","createdAt":1789763962245},
            {"id":"exp-1789647423258-jte1alcjp","category":"عودة علاج ام محمد","amount":30000,"date":"2026-09-17","createdAt":1789647423258},
            {"id":"exp-1789647384628-solff14rn","category":"غاز","amount":13000,"date":"2026-09-17","createdAt":1789647384628},
            {"id":"exp-1789584832251-8oi0jjqz6","category":"مصاريف","amount":5000,"date":"2026-09-16","createdAt":1789584832251},
            {"id":"exp-1789584796368-gfbn5n9ly","category":"انترنت فورجي","amount":5100,"date":"2026-09-16","createdAt":1789584796368},
            {"id":"exp-1789568675333-du6cn130u","category":"مصاريف","amount":5000,"date":"2026-09-16","createdAt":1789568675333},
            {"id":"exp-1789486698072-ie84pszd2","category":"مصاريف ام محمد","amount":50000,"date":"2026-09-15","note":"حوالة من الحديدة","createdAt":1789486698072},
            {"id":"exp-1789486497648-qgstr2auo","category":"مصاريف","amount":20000,"date":"2026-09-15","createdAt":1789486497648},
            {"id":"exp-1789304728244-lv86r6yrg","category":"مصاريف","amount":10000,"date":"2026-09-13","createdAt":1789304728244},
            {"id":"exp-1789222347970-6e2vdb0n8","category":"مصاريف","amount":5000,"date":"2026-09-12","createdAt":1789222347970},
            {"id":"exp-1789222315716-mh2msvihb","category":"مصاريف","amount":5000,"date":"2026-09-12","createdAt":1789222315716},
            {"id":"exp-1789222304892-iob39mfra","category":"عودة علاج ام محمد","amount":15000,"date":"2026-09-12","createdAt":1789222304892},
            {"id":"exp-1789222254141-cmqa71j5e","category":"كاميرا لابتوب","amount":15000,"date":"2026-09-12","createdAt":1789222254141},
            {"id":"exp-1789137926193-czx6v1egr","category":"مصاريف","amount":10000,"date":"2026-09-11","createdAt":1789137926193},
            {"id":"exp-1789137901892-gh6gc8lz1","category":"مصاريف","amount":10000,"date":"2026-09-11","createdAt":1789137901892},
            {"id":"exp-1788965491467-p24y884ti","category":"مصاريف","amount":15000,"date":"2026-09-09","createdAt":1788965491467},
            {"id":"exp-1788884481642-pgf14jve4","category":"مصاريف","amount":5000,"date":"2026-09-08","createdAt":1788884481642},
            {"id":"exp-1788877683938-618bry083","category":"علاج نهى","amount":10000,"date":"2026-09-08","createdAt":1788877683938},
            {"id":"exp-1788877669313-8xk9ijcl7","category":"مصاريف","amount":10000,"date":"2026-09-08","createdAt":1788877669313},
            {"id":"exp-1788877636889-754lml9d5","category":"انترنت فورجي","amount":2500,"date":"2026-09-08","createdAt":1788877636889},
            {"id":"exp-1788877618284-dk6533jqf","category":"فاتورة الماء","amount":5000,"date":"2026-09-08","createdAt":1788877618284},
            {"id":"exp-1788790803941-8p560ee2s","category":"مصاريف","amount":10000,"date":"2026-09-07","createdAt":1788790803941},
            {"id":"exp-1788636408800-zdfb700t0","category":"مصاريف","amount":10000,"date":"2026-09-05","createdAt":1788636408800},
            {"id":"exp-1788636354343-ijplutlpr","category":"مصاريف","amount":10000,"date":"2026-09-05","createdAt":1788636354343},
            {"id":"exp-1788439997760-siyyut4ak","category":"مصاريف","amount":10000,"date":"2026-09-03","createdAt":1788439997760},
            {"id":"exp-1788356815159-k87m8qmli","category":"مصاريف","amount":4000,"date":"2026-09-02","createdAt":1788356815159},
            {"id":"exp-1788354533610-hjnavs2de","category":"دين ام محمد","amount":11000,"date":"2026-09-02","createdAt":1788354533610},
            {"id":"exp-1788354461699-wkgb4pael","category":"مصاريف","amount":16000,"date":"2026-09-02","createdAt":1788354461699},
            {"id":"exp-1788295511372-q82xigcoq","category":"لحمة","amount":3000,"date":"2026-09-01","createdAt":1788295511372},
            {"id":"exp-1788279111493-10zajshap","category":"غداء","amount":2000,"date":"2026-09-01","createdAt":1788279111493},
            {"id":"exp-1788276509672-nf7c8yhh1","category":"كهرباء","amount":3000,"date":"2026-09-01","createdAt":1788276509672},
            {"id":"exp-1788275956720-y2mo4rscw","category":"ارحام","amount":10000,"date":"2026-09-01","createdAt":1788275956720},
            {"id":"exp-1788275773656-poeki0fg2","category":"ادوات سباكة وحنفية","amount":5000,"date":"2026-09-01","createdAt":1788275773656},
            {"id":"exp-1788275751164-wxhpqfv7f","category":"علاج","amount":5000,"date":"2026-09-01","createdAt":1788275751164}
          ],
          "incomes": [
            {"id":"inc-1794919585142-31pjz4mhp","source":"شركة الغاز","amount":30000,"date":"2026-11-17","createdAt":1794919585142},
            {"id":"inc-1794775517386-wi661cmhy","source":"عليوه","amount":69000,"date":"2026-11-15","createdAt":1794775517386},
            {"id":"inc-1794759671643-1iamscfc5","source":"الميادين","amount":106000,"date":"2026-11-15","createdAt":1794759671643},
            {"id":"inc-1794678016432-zl1fz0hp9","source":"المسيرة","amount":10000,"date":"2026-11-14","createdAt":1794678016432},
            {"id":"inc-1794499504297-kifqgm15e","source":"الوزير","amount":10000,"date":"2026-11-12","createdAt":1794499504297},
            {"id":"inc-1794411068088-axxmv8jmk","source":"الوزارة","amount":5000,"date":"2026-11-11","createdAt":1794411068088},
            {"id":"inc-1794315385363-5ngknx85j","source":"الصحيفة","amount":25000,"date":"2026-11-10","createdAt":1794315385363},
            {"id":"inc-1794234555167-2002wxwuw","source":"العهد","amount":50000,"date":"2026-11-09","createdAt":1794234555167},
            {"id":"inc-1793971057098-uycejqsaw","source":"دخل باقي من الشهر الاول","amount":105000,"date":"2026-11-06","createdAt":1793971057098},
            {"id":"inc-1793970879639-bw7wi4p9v","source":"الوزارة","amount":10000,"date":"2026-11-06","note":"فعالية محاكم الاستئناف","createdAt":1793970879639},
            {"id":"inc-1793718577096-o6acbf38e","source":"الوزارة","amount":20000,"date":"2026-11-03","note":"صندوق دعم القضاء","createdAt":1793718577096},
            {"id":"inc-1793718539717-9iyxuplnz","source":"الوزارة","amount":25000,"date":"2026-11-03","createdAt":1793718539717},
            {"id":"inc-1793718513762-qi7kh3imy","source":"الوزارة","amount":25000,"date":"2026-11-03","createdAt":1793718513762},
            {"id":"inc-1793718498492-8jeave0bu","source":"الوزارة","amount":20000,"date":"2026-11-03","createdAt":1793718498492},
            {"id":"inc-1793632588592-rdgrh19d2","source":"الوزارة","amount":10000,"date":"2026-11-02","note":"تغطية فعالية الشهيد","createdAt":1793632588592},
            {"id":"inc-1793534251126-llacup0ia","source":"التفتيش","amount":25000,"date":"2026-11-01","createdAt":1793534251126},
            {"id":"inc-1793455509443-co6cdbcly","source":"الكوثر","amount":10000,"date":"2026-10-31","createdAt":1793455509443},
            {"id":"inc-1793212904219-symaby4we","source":"الوزير والوزارة","amount":10000,"date":"2026-10-28","createdAt":1793212904219},
            {"id":"inc-1793025063860-ua71eap49","source":"الهيئة","amount":12500,"date":"2026-10-26","createdAt":1793025063860},
            {"id":"inc-1792769899209-lzlmyb89t","source":"الوزير والوزارة","amount":10000,"date":"2026-10-23","createdAt":1792769899209},
            {"id":"inc-1792407386887-ky6jk205d","source":"المسيرة","amount":10000,"date":"2026-10-19","createdAt":1792407386887},
            {"id":"inc-1792407357463-rergu28ua","source":"ابو طالب","amount":100000,"date":"2026-10-19","createdAt":1792407357463},
            {"id":"inc-1792265391464-biilmjfrx","source":"الرعاية","amount":96000,"date":"2026-10-17","createdAt":1792265391464},
            {"id":"inc-1792008391460-nbw9wnsdt","source":"العربي","amount":79000,"date":"2026-10-14","createdAt":1792008391460},
            {"id":"inc-1791982959924-knvdssddq","source":"ق. العهد","amount":75000,"date":"2026-10-14","createdAt":1791982959924},
            {"id":"inc-1791902395090-3q4sb12ir","source":"الوزير والوزارة","amount":39000,"date":"2026-10-13","createdAt":1791902395090},
            {"id":"inc-1791822178767-c54exg2gs","source":"الوزير والوزارة","amount":5000,"date":"2026-10-12","createdAt":1791822178767},
            {"id":"inc-1791728906397-d4vhb80j6","source":"ابو شعر","amount":9700,"date":"2026-10-11","createdAt":1791728906397},
            {"id":"inc-1791386691690-68xeqqycx","source":"الوزير والوزارة","amount":10000,"date":"2026-10-07","createdAt":1791386691690},
            {"id":"inc-1791047579096-5x8eq4k3g","source":"مكافأة الوزارة","amount":20000,"date":"2026-10-03","createdAt":1791047579096},
            {"id":"inc-1791047511933-2jqrevbwn","source":"من الشهر السابق","amount":30000,"date":"2026-10-03","createdAt":1791047511933},
            {"id":"inc-1791047488074-qv92ufi75","source":"التفتيش","amount":25000,"date":"2026-10-03","createdAt":1791047488074},
            {"id":"inc-1791047469379-h27lk3b1i","source":"الصحيفة","amount":25000,"date":"2026-10-03","createdAt":1791047469379},
            {"id":"inc-1790985055440-9t5j19x17","source":"الهيئة","amount":16000,"date":"2026-10-03","createdAt":1790985055440},
            {"id":"inc-1790607065110-cba1o4qr3","source":"مكافأة الوكيل","amount":59000,"date":"2026-09-28","createdAt":1790607065110},
            {"id":"inc-1790607019643-km9g3c1q2","source":"الصحيفة","amount":25000,"date":"2026-09-28","createdAt":1790607019643},
            {"id":"inc-1790091302023-wvqapy7rc","source":"الوزارة","amount":5000,"date":"2026-09-22","createdAt":1790091302023},
            {"id":"inc-1790091272237-vyw3epcw7","source":"الوزير","amount":10000,"date":"2026-09-22","createdAt":1790091272237},
            {"id":"inc-1789647341145-xntoe8i85","source":"الرعاية","amount":96000,"date":"2026-09-17","createdAt":1789647341145},
            {"id":"inc-1789486384133-ehnzc2yx5","source":"حيس والخوخة","amount":129000,"date":"2026-09-15","createdAt":1789486384133},
            {"id":"inc-1789222230856-yag3g9tx7","source":"الوزارة","amount":5000,"date":"2026-09-12","createdAt":1789222230856},
            {"id":"inc-1789137852354-kh5rvxzx3","source":"قناة العربي","amount":53000,"date":"2026-09-11","createdAt":1789137852354},
            {"id":"inc-1788877228064-eems18jm7","source":"الميادين","amount":105000,"date":"2026-09-08","createdAt":1788877228064},
            {"id":"inc-1788790778314-yns8h69xa","source":"الوزارة","amount":10000,"date":"2026-09-07","createdAt":1788790778314},
            {"id":"inc-1788790753898-zbekecky2","source":"عليوه","amount":69000,"date":"2026-09-07","createdAt":1788790753898},
            {"id":"inc-1788636318116-y610gaopd","source":"الحافز","amount":20000,"date":"2026-09-05","createdAt":1788636318116},
            {"id":"inc-1788354483001-080j1scq5","source":"الصحيفة","amount":25000,"date":"2026-09-02","createdAt":1788354483001},
            {"id":"inc-1788275311329-i10g4vwd6","source":"التفتيش القضائي","amount":25000,"date":"2026-09-01","createdAt":1788275311329},
            {"id":"inc-1788275289500-q4l4ath7f","source":"مستحقات المولد النبوي","amount":79000,"date":"2026-09-01","createdAt":1788275289500}
          ]
        };

        function convertLegacyBackupToMonthlyState(rawBackup) {
            const monthsSet = new Set();
            (rawBackup.transactions || []).forEach(t => monthsSet.add(t.date.slice(0, 7)));
            (rawBackup.expenses || []).forEach(e => monthsSet.add(e.date.slice(0, 7)));
            (rawBackup.incomes || []).forEach(i => monthsSet.add(i.date.slice(0, 7)));

            const sortedMonths = Array.from(monthsSet).sort();
            const resultMonths = {};
            let runningDebtBalances = {};

            sortedMonths.forEach(ym => {
                resultMonths[ym] = { debts: [], expenses: [], incomes: [] };
                const monthDebtMap = {};

                Object.keys(runningDebtBalances).forEach(person => {
                    const rem = runningDebtBalances[person];
                    if (rem > 0) {
                        monthDebtMap[person] = {
                            id: 'd_co_' + ym + '_' + Math.random().toString(36).substr(2, 5),
                            person: person,
                            totalDebt: rem,
                            paidInMonth: 0,
                            date: `${ym}-01`,
                            carriedOver: true,
                            logs: [{ type: 'ترحيل رصيد متبقي', isRepayFlag: false, amount: rem, date: `${ym}-01` }]
                        };
                    }
                });

                const monthTxs = (rawBackup.transactions || [])
                    .filter(t => t.date.startsWith(ym))
                    .sort((a, b) => (a.createdAt || 0) - (b.createdAt || 0));

                monthTxs.forEach(t => {
                    const person = t.personName.trim();
                    const isRepay = t.type === 'repay';
                    const logLabel = isRepay ? 'سداد' : (monthDebtMap[person] ? 'استدانة إضافية' : 'دين جديد');
                    const noteSuffix = t.note ? ` (${t.note})` : '';

                    if (!monthDebtMap[person]) {
                        monthDebtMap[person] = {
                            id: 'd_' + t.id,
                            person: person,
                            totalDebt: 0,
                            paidInMonth: 0,
                            date: t.date,
                            carriedOver: false,
                            logs: []
                        };
                    }

                    monthDebtMap[person].logs.push({
                        type: logLabel + noteSuffix,
                        isRepayFlag: isRepay,
                        amount: Number(t.amount),
                        date: t.date
                    });

                    if (isRepay) {
                        monthDebtMap[person].paidInMonth += Number(t.amount);
                    } else {
                        monthDebtMap[person].totalDebt += Number(t.amount);
                    }
                    monthDebtMap[person].date = t.date;
                });

                runningDebtBalances = {};
                Object.values(monthDebtMap).forEach(d => {
                    resultMonths[ym].debts.push(d);
                    const rem = d.totalDebt - d.paidInMonth;
                    if (rem > 0) {
                        runningDebtBalances[d.person] = rem;
                    }
                });
                resultMonths[ym].debts.sort((a, b) => b.date.localeCompare(a.date));

                const monthExps = (rawBackup.expenses || [])
                    .filter(e => e.date.startsWith(ym))
                    .sort((a, b) => (a.createdAt || 0) - (b.createdAt || 0));

                const expMap = {};
                monthExps.forEach(e => {
                    const cat = e.category.trim();
                    if (!expMap[cat]) {
                        expMap[cat] = {
                            id: 'e_' + e.id,
                            desc: cat,
                            amount: 0,
                            date: e.date,
                            logs: []
                        };
                    }
                    expMap[cat].logs.push({ amount: Number(e.amount), date: e.date, note: e.note || '' });
                    expMap[cat].amount += Number(e.amount);
                    expMap[cat].date = e.date;
                });
                resultMonths[ym].expenses = Object.values(expMap).sort((a, b) => b.date.localeCompare(a.date));

                const monthIncs = (rawBackup.incomes || [])
                    .filter(i => i.date.startsWith(ym))
                    .sort((a, b) => (a.createdAt || 0) - (b.createdAt || 0));

                const incMap = {};
                monthIncs.forEach(i => {
                    const src = i.source.trim();
                    if (!incMap[src]) {
                        incMap[src] = {
                            id: 'i_' + i.id,
                            source: src,
                            amount: 0,
                            date: i.date,
                            logs: []
                        };
                    }
                    incMap[src].logs.push({ amount: Number(i.amount), date: i.date, note: i.note || '' });
                    incMap[src].amount += Number(i.amount);
                    incMap[src].date = i.date;
                });
                resultMonths[ym].incomes = Object.values(incMap).sort((a, b) => b.date.localeCompare(a.date));
            });

            return { months: resultMonths };
        }

        let appState = { months: {} };
        let currentMonth = '';
        let activeHistoryContext = null;

        // =========================================================
        // NUMBER FORMATTING WITH COMMAS (10,000)
        // =========================================================
        function formatInputWithCommas(input) {
            let raw = input.value.replace(/[^0-9.]/g, '');
            const parts = raw.split('.');
            if (parts.length > 2) {
                raw = parts[0] + '.' + parts.slice(1).join('');
            }
            if (parts[0]) {
                parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }
            input.value = parts.join('.');
        }

        function parseFormattedNumber(val) {
            if (!val) return 0;
            const clean = String(val).replace(/,/g, '');
            return parseFloat(clean) || 0;
        }

        function formatNum(num) {
            return Number(num).toLocaleString('en-US');
        }

        function formatMoney(num) {
            return formatNum(num) + ' ر.ي';
        }

        // =========================================================
        // DATE & MONTH HELPERS
        // =========================================================
        function getTodayStr() {
            const now = new Date();
            const y = now.getFullYear();
            const m = String(now.getMonth() + 1).padStart(2, '0');
            const d = String(now.getDate()).padStart(2, '0');
            return `${y}-${m}-${d}`;
        }

        function getCurrentYearMonth() {
            return getTodayStr().slice(0, 7);
        }

        function getDefaultDateForSelectedMonth() {
            const today = getTodayStr();
            if (today.startsWith(currentMonth)) return today;
            return `${currentMonth}-01`;
        }

        // =========================================================
        // INITIALIZATION
        // =========================================================
        function init() {
            const saved = localStorage.getItem('yawmiyati_app_v2_imported');
            if (saved) {
                appState = JSON.parse(saved);
            } else {
                appState = convertLegacyBackupToMonthlyState(INITIAL_BACKUP_PAYLOAD);
                localStorage.setItem('yawmiyati_app_v2_imported', JSON.stringify(appState));
            }

            currentMonth = getCurrentYearMonth();
            document.getElementById('monthSelector').value = currentMonth;

            initGoogleDriveUI();
            ensureMonthInitialized(currentMonth, false);
            setDefaultDatesInForms();
            renderAll();
        }

        function saveState() {
            localStorage.setItem('yawmiyati_app_v2_imported', JSON.stringify(appState));
            triggerAutoCloudSync();
        }

        function ensureMonthInitialized(targetMonth, shouldTriggerSync = true) {
            if (appState.months[targetMonth]) return;

            appState.months[targetMonth] = {
                debts: [],
                expenses: [],
                incomes: []
            };

            const existingMonths = Object.keys(appState.months)
                .filter(m => m < targetMonth)
                .sort();

            if (existingMonths.length > 0) {
                const lastMonth = existingMonths[existingMonths.length - 1];
                const prevDebts = appState.months[lastMonth].debts || [];

                prevDebts.forEach(d => {
                    const remaining = Number(d.totalDebt) - Number(d.paidInMonth);
                    if (remaining > 0) {
                        appState.months[targetMonth].debts.push({
                            id: 'd_' + Date.now() + Math.random().toString(36).substr(2, 4),
                            person: d.person,
                            totalDebt: remaining,
                            paidInMonth: 0,
                            date: `${targetMonth}-01`,
                            carriedOver: true,
                            logs: [{ type: 'ترحيل رصيد متبقي', isRepayFlag: false, amount: remaining, date: `${targetMonth}-01` }]
                        });
                    }
                });
            }
            localStorage.setItem('yawmiyati_app_v2_imported', JSON.stringify(appState));
            if (shouldTriggerSync) triggerAutoCloudSync();
        }

        function onMonthChange() {
            const val = document.getElementById('monthSelector').value;
            if (!val) return;
            currentMonth = val;
            ensureMonthInitialized(currentMonth);
            setDefaultDatesInForms();
            renderAll();
        }

        function setDefaultDatesInForms() {
            const defDate = getDefaultDateForSelectedMonth();
            document.getElementById('debtDate').value = defDate;
            document.getElementById('expDate').value = defDate;
            document.getElementById('incDate').value = defDate;
        }

        function switchTab(tabName) {
            document.querySelectorAll('.tab-view').forEach(el => el.classList.remove('active'));
            document.querySelectorAll('.nav-item').forEach(el => el.classList.remove('active'));

            document.getElementById(`view-${tabName}`).classList.add('active');
            document.getElementById(`nav-${tabName}`).classList.add('active');
        }

        function recalculateDebtFromLogs(debtItem) {
            let totalD = 0;
            let totalP = 0;
            debtItem.logs.forEach(l => {
                if (l.isRepayFlag || l.type.startsWith('سداد')) {
                    totalP += Number(l.amount);
                } else {
                    totalD += Number(l.amount);
                }
            });
            debtItem.totalDebt = totalD;
            debtItem.paidInMonth = totalP;
            if (debtItem.logs.length > 0) {
                debtItem.date = debtItem.logs[debtItem.logs.length - 1].date;
            }
        }

        function recalculateItemFromLogs(item) {
            item.amount = item.logs.reduce((sum, l) => sum + Number(l.amount), 0);
            if (item.logs.length > 0) {
                item.date = item.logs[item.logs.length - 1].date;
            }
        }

        // =========================================================
        // 1. DEBTS CRUD
        // =========================================================
        function addNewDebt(e) {
            e.preventDefault();
            const person = document.getElementById('debtPerson').value.trim();
            const amount = parseFormattedNumber(document.getElementById('debtAmount').value);
            const date = document.getElementById('debtDate').value;
            if (amount <= 0) return;

            const monthData = appState.months[currentMonth];
            const existing = monthData.debts.find(d => d.person === person);

            if (existing) {
                existing.logs.push({ type: 'استدانة إضافية', isRepayFlag: false, amount, date });
                recalculateDebtFromLogs(existing);
            } else {
                monthData.debts.unshift({
                    id: 'd_' + Date.now(),
                    person,
                    totalDebt: amount,
                    paidInMonth: 0,
                    date,
                    carriedOver: false,
                    logs: [{ type: 'دين جديد', isRepayFlag: false, amount, date }]
                });
            }

            saveState();
            document.getElementById('debtPerson').value = '';
            document.getElementById('debtAmount').value = '';
            renderAll();
        }

        function deleteDebt(id) {
            if (confirm('هل تريد حذف هذا الشخص وسجل ديونه بالكامل من هذا الشهر؟')) {
                const monthData = appState.months[currentMonth];
                monthData.debts = monthData.debts.filter(d => d.id !== id);
                saveState();
                closeModal('historyModal');
                renderAll();
            }
        }

        function deleteDebtLog(debtId, logIdx) {
            const monthData = appState.months[currentMonth];
            const debt = monthData.debts.find(d => d.id === debtId);
            if (!debt) return;

            if (debt.logs.length <= 1) {
                deleteDebt(debtId);
                return;
            }

            if (confirm('هل تريد حذف هذه الحركة المالية؟')) {
                debt.logs.splice(logIdx, 1);
                recalculateDebtFromLogs(debt);
                saveState();
                renderAll();
                if (activeHistoryContext) openHistoryModal(activeHistoryContext.category, activeHistoryContext.id);
            }
        }

        // =========================================================
        // 2. EXPENSES CRUD
        // =========================================================
        function addNewExpense(e) {
            e.preventDefault();
            const desc = document.getElementById('expDesc').value.trim();
            const amount = parseFormattedNumber(document.getElementById('expAmount').value);
            const date = document.getElementById('expDate').value;
            if (amount <= 0) return;

            const monthData = appState.months[currentMonth];
            const existing = monthData.expenses.find(item => item.desc === desc);

            if (existing) {
                existing.logs.push({ amount, date });
                recalculateItemFromLogs(existing);
            } else {
                monthData.expenses.unshift({
                    id: 'e_' + Date.now(),
                    desc,
                    amount,
                    date,
                    logs: [{ amount, date }]
                });
            }

            saveState();
            document.getElementById('expDesc').value = '';
            document.getElementById('expAmount').value = '';
            renderAll();
        }

        function deleteExpense(id) {
            if (confirm('هل تريد حذف هذا المصروف بالكامل؟')) {
                const monthData = appState.months[currentMonth];
                monthData.expenses = monthData.expenses.filter(item => item.id !== id);
                saveState();
                closeModal('historyModal');
                renderAll();
            }
        }

        function deleteExpenseLog(expId, logIdx) {
            const monthData = appState.months[currentMonth];
            const exp = monthData.expenses.find(e => e.id === expId);
            if (!exp) return;

            if (exp.logs.length <= 1) {
                deleteExpense(expId);
                return;
            }

            if (confirm('هل تريد حذف هذه الدفعة؟')) {
                exp.logs.splice(logIdx, 1);
                recalculateItemFromLogs(exp);
                saveState();
                renderAll();
                if (activeHistoryContext) openHistoryModal(activeHistoryContext.category, activeHistoryContext.id);
            }
        }

        // =========================================================
        // 3. INCOME CRUD
        // =========================================================
        function addNewIncome(e) {
            e.preventDefault();
            const source = document.getElementById('incSource').value.trim();
            const amount = parseFormattedNumber(document.getElementById('incAmount').value);
            const date = document.getElementById('incDate').value;
            if (amount <= 0) return;

            const monthData = appState.months[currentMonth];
            const existing = monthData.incomes.find(item => item.source === source);

            if (existing) {
                existing.logs.push({ amount, date });
                recalculateItemFromLogs(existing);
            } else {
                monthData.incomes.unshift({
                    id: 'i_' + Date.now(),
                    source,
                    amount,
                    date,
                    logs: [{ amount, date }]
                });
            }

            saveState();
            document.getElementById('incSource').value = '';
            document.getElementById('incAmount').value = '';
            renderAll();
        }

        function deleteIncome(id) {
            if (confirm('هل تريد حذف بند الدخل هذا بالكامل؟')) {
                const monthData = appState.months[currentMonth];
                monthData.incomes = monthData.incomes.filter(item => item.id !== id);
                saveState();
                closeModal('historyModal');
                renderAll();
            }
        }

        function deleteIncomeLog(incId, logIdx) {
            const monthData = appState.months[currentMonth];
            const inc = monthData.incomes.find(i => i.id === incId);
            if (!inc) return;

            if (inc.logs.length <= 1) {
                deleteIncome(incId);
                return;
            }

            if (confirm('هل تريد حذف هذه الدفعة؟')) {
                inc.logs.splice(logIdx, 1);
                recalculateItemFromLogs(inc);
                saveState();
                renderAll();
                if (activeHistoryContext) openHistoryModal(activeHistoryContext.category, activeHistoryContext.id);
            }
        }

        // =========================================================
        // DEDICATED HISTORY MODAL (ORDERED NEWEST FIRST)
        // =========================================================
        function openHistoryModal(category, id) {
            const monthData = appState.months[currentMonth];
            activeHistoryContext = { category, id };
            const container = document.getElementById('histModalListContainer');

            if (category === 'debt') {
                const item = monthData.debts.find(d => d.id === id);
                if (!item) return;
                document.getElementById('histModalTitle').textContent = `سجل حركات: ${item.person}`;

                const reversedLogs = item.logs
                    .map((log, originalIdx) => ({ ...log, originalIdx }))
                    .reverse();

                container.innerHTML = reversedLogs.map(l => {
                    const isRepay = l.isRepayFlag || l.type.startsWith('سداد');
                    return `
                        <div class="history-row">
                            <div>
                                <strong style="color:${isRepay ? 'var(--inc-color)' : 'var(--debt-color)'};">${l.type}</strong>
                                <div style="font-size:0.78rem; color:var(--muted);">التاريخ: ${l.date}</div>
                            </div>
                            <div class="log-actions">
                                <span style="font-weight:800; font-size:0.95rem;">${formatNum(l.amount)} ر.ي</span>
                                <button class="mini-btn" onclick="openActionModal('editDebtLog', '${item.id}', ${l.originalIdx})">✏️ تعديل</button>
                                <button class="mini-btn del" onclick="deleteDebtLog('${item.id}', ${l.originalIdx})">✖</button>
                            </div>
                        </div>
                    `;
                }).join('');
            } 
            else if (category === 'expense') {
                const item = monthData.expenses.find(e => e.id === id);
                if (!item) return;
                document.getElementById('histModalTitle').textContent = `سجل دفعات: ${item.desc}`;

                const reversedLogs = item.logs
                    .map((log, originalIdx) => ({ ...log, originalIdx }))
                    .reverse();

                container.innerHTML = reversedLogs.map(l => `
                    <div class="history-row">
                        <div>
                            <strong>دفعة مصروف ${l.note ? `(${l.note})` : ''}</strong>
                            <div style="font-size:0.78rem; color:var(--muted);">التاريخ: ${l.date}</div>
                        </div>
                        <div class="log-actions">
                            <span style="font-weight:800; color:var(--exp-color);">${formatNum(l.amount)} ر.ي</span>
                            <button class="mini-btn" onclick="openActionModal('editExpenseLog', '${item.id}', ${l.originalIdx})">✏️ تعديل</button>
                            <button class="mini-btn del" onclick="deleteExpenseLog('${item.id}', ${l.originalIdx})">✖</button>
                        </div>
                    </div>
                `).join('');
            } 
            else if (category === 'income') {
                const item = monthData.incomes.find(i => i.id === id);
                if (!item) return;
                document.getElementById('histModalTitle').textContent = `سجل دفعات: ${item.source}`;

                const reversedLogs = item.logs
                    .map((log, originalIdx) => ({ ...log, originalIdx }))
                    .reverse();

                container.innerHTML = reversedLogs.map(l => `
                    <div class="history-row">
                        <div>
                            <strong>دفعة دخل ${l.note ? `(${l.note})` : ''}</strong>
                            <div style="font-size:0.78rem; color:var(--muted);">التاريخ: ${l.date}</div>
                        </div>
                        <div class="log-actions">
                            <span style="font-weight:800; color:var(--inc-color);">${formatNum(l.amount)} ر.ي</span>
                            <button class="mini-btn" onclick="openActionModal('editIncomeLog', '${item.id}', ${l.originalIdx})">✏️ تعديل</button>
                            <button class="mini-btn del" onclick="deleteIncomeLog('${item.id}', ${l.originalIdx})">✖</button>
                        </div>
                    </div>
                `).join('');
            }

            document.getElementById('historyModal').style.display = 'flex';
        }

        // =========================================================
        // MODAL FOR ADDING & EDITING ALL OPERATIONS
        // =========================================================
        function openActionModal(type, id, logIdx = -1) {
            const monthData = appState.months[currentMonth];
            document.getElementById('modalActionType').value = type;
            document.getElementById('modalTargetId').value = id;
            document.getElementById('modalLogIndex').value = logIdx;

            const nameGroup = document.getElementById('modalNameGroup');
            const nameInput = document.getElementById('modalNameInput');
            const amountDateGroup = document.getElementById('modalAmountDateGroup');
            const amountInput = document.getElementById('modalAmount');
            const dateInput = document.getElementById('modalDate');
            const btn = document.getElementById('modalSubmitBtn');

            nameGroup.style.display = 'none';
            nameInput.required = false;
            amountDateGroup.style.display = 'grid';
            amountInput.required = true;
            amountInput.value = '';
            dateInput.value = getDefaultDateForSelectedMonth();

            if (type === 'payDebt') {
                const item = monthData.debts.find(d => d.id === id);
                const rem = item.totalDebt - item.paidInMonth;
                document.getElementById('modalTitle').textContent = `سداد دين: ${item.person}`;
                document.getElementById('modalSubtitle').textContent = `المبلغ المتبقي حالياً: ${formatMoney(rem)}`;
                btn.className = 'btn btn-income';
                btn.textContent = 'تأكيد السداد';
            } else if (type === 'borrowMore') {
                const item = monthData.debts.find(d => d.id === id);
                document.getElementById('modalTitle').textContent = `استدانة إضافية من: ${item.person}`;
                document.getElementById('modalSubtitle').textContent = `سيُضاف المبلغ الجديد إلى رصيد الدين الحالي`;
                btn.className = 'btn btn-debt';
                btn.textContent = 'إضافة للدين';
            } else if (type === 'addExpenseMore') {
                const item = monthData.expenses.find(e => e.id === id);
                document.getElementById('modalTitle').textContent = `إضافة مبلغ لنفس الوصف`;
                document.getElementById('modalSubtitle').textContent = `البند: ${item.desc} (الحالي: ${formatMoney(item.amount)})`;
                btn.className = 'btn btn-expense';
                btn.textContent = 'إضافة للمصروف';
            } else if (type === 'addIncomeMore') {
                const item = monthData.incomes.find(i => i.id === id);
                document.getElementById('modalTitle').textContent = `إضافة مبلغ لنفس الجهة`;
                document.getElementById('modalSubtitle').textContent = `الجهة: ${item.source} (الحالي: ${formatMoney(item.amount)})`;
                btn.className = 'btn btn-income';
                btn.textContent = 'إضافة للدخل';
            } else if (type === 'editDebtMain') {
                const item = monthData.debts.find(d => d.id === id);
                document.getElementById('modalTitle').textContent = `تعديل اسم الشخص`;
                document.getElementById('modalSubtitle').textContent = `لتعديل المبالغ، افتح "سجل الحركات"`;
                nameGroup.style.display = 'block';
                nameInput.required = true;
                document.getElementById('modalNameLabel').textContent = 'اسم الشخص المتدين منه *';
                nameInput.value = item.person;
                amountDateGroup.style.display = 'none';
                amountInput.required = false;
                btn.className = 'btn btn-primary';
                btn.textContent = 'حفظ التعديل';
            } else if (type === 'editExpenseMain') {
                const item = monthData.expenses.find(e => e.id === id);
                document.getElementById('modalTitle').textContent = `تعديل بيانات المصروف`;
                document.getElementById('modalSubtitle').textContent = `تعديل الوصف والمبلغ`;
                nameGroup.style.display = 'block';
                nameInput.required = true;
                document.getElementById('modalNameLabel').textContent = 'وصف المصروف *';
                nameInput.value = item.desc;
                if (item.logs.length === 1) {
                    amountInput.value = formatNum(item.logs[0].amount);
                    dateInput.value = item.logs[0].date;
                } else {
                    amountDateGroup.style.display = 'none';
                    amountInput.required = false;
                }
                btn.className = 'btn btn-primary';
                btn.textContent = 'حفظ التعديل';
            } else if (type === 'editIncomeMain') {
                const item = monthData.incomes.find(i => i.id === id);
                document.getElementById('modalTitle').textContent = `تعديل بيانات الدخل`;
                document.getElementById('modalSubtitle').textContent = `تعديل الجهة والمبلغ`;
                nameGroup.style.display = 'block';
                nameInput.required = true;
                document.getElementById('modalNameLabel').textContent = 'الجهة (مصدر الدخل) *';
                nameInput.value = item.source;
                if (item.logs.length === 1) {
                    amountInput.value = formatNum(item.logs[0].amount);
                    dateInput.value = item.logs[0].date;
                } else {
                    amountDateGroup.style.display = 'none';
                    amountInput.required = false;
                }
                btn.className = 'btn btn-primary';
                btn.textContent = 'حفظ التعديل';
            } else if (type === 'editDebtLog') {
                const item = monthData.debts.find(d => d.id === id);
                const log = item.logs[logIdx];
                document.getElementById('modalTitle').textContent = `تعديل حركة (${log.type})`;
                document.getElementById('modalSubtitle').textContent = `الشخص: ${item.person}`;
                amountInput.value = formatNum(log.amount);
                dateInput.value = log.date;
                btn.className = 'btn btn-primary';
                btn.textContent = 'حفظ التعديل';
            } else if (type === 'editExpenseLog') {
                const item = monthData.expenses.find(e => e.id === id);
                const log = item.logs[logIdx];
                document.getElementById('modalTitle').textContent = `تعديل دفعة مصروف`;
                document.getElementById('modalSubtitle').textContent = `البند: ${item.desc}`;
                amountInput.value = formatNum(log.amount);
                dateInput.value = log.date;
                btn.className = 'btn btn-primary';
                btn.textContent = 'حفظ التعديل';
            } else if (type === 'editIncomeLog') {
                const item = monthData.incomes.find(i => i.id === id);
                const log = item.logs[logIdx];
                document.getElementById('modalTitle').textContent = `تعديل دفعة دخل`;
                document.getElementById('modalSubtitle').textContent = `الجهة: ${item.source}`;
                amountInput.value = formatNum(log.amount);
                dateInput.value = log.date;
                btn.className = 'btn btn-primary';
                btn.textContent = 'حفظ التعديل';
            }

            document.getElementById('actionModal').style.display = 'flex';
            if (amountDateGroup.style.display !== 'none') {
                setTimeout(() => amountInput.focus(), 100);
            } else {
                setTimeout(() => nameInput.focus(), 100);
            }
        }

        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
            if (modalId === 'historyModal') activeHistoryContext = null;
        }

        function closeModalOnBg(e, modalId) {
            if (e.target.id === modalId) closeModal(modalId);
        }

        function submitModalAction(e) {
            e.preventDefault();
            const type = document.getElementById('modalActionType').value;
            const id = document.getElementById('modalTargetId').value;
            const logIdx = parseInt(document.getElementById('modalLogIndex').value);
            const amount = parseFormattedNumber(document.getElementById('modalAmount').value);
            const date = document.getElementById('modalDate').value;
            const newName = document.getElementById('modalNameInput').value.trim();
            const monthData = appState.months[currentMonth];

            if (type === 'payDebt') {
                const item = monthData.debts.find(d => d.id === id);
                if (item && amount > 0) {
                    item.logs.push({ type: 'سداد', isRepayFlag: true, amount, date });
                    recalculateDebtFromLogs(item);
                }
            } else if (type === 'borrowMore') {
                const item = monthData.debts.find(d => d.id === id);
                if (item && amount > 0) {
                    item.logs.push({ type: 'استدانة', isRepayFlag: false, amount, date });
                    recalculateDebtFromLogs(item);
                }
            } else if (type === 'addExpenseMore') {
                const item = monthData.expenses.find(e => e.id === id);
                if (item && amount > 0) {
                    item.logs.push({ amount, date });
                    recalculateItemFromLogs(item);
                }
            } else if (type === 'addIncomeMore') {
                const item = monthData.incomes.find(i => i.id === id);
                if (item && amount > 0) {
                    item.logs.push({ amount, date });
                    recalculateItemFromLogs(item);
                }
            } else if (type === 'editDebtMain') {
                const item = monthData.debts.find(d => d.id === id);
                if (item && newName) item.person = newName;
            } else if (type === 'editExpenseMain') {
                const item = monthData.expenses.find(e => e.id === id);
                if (item && newName) {
                    item.desc = newName;
                    if (item.logs.length === 1 && amount > 0) {
                        item.logs[0] = { amount, date };
                        recalculateItemFromLogs(item);
                    }
                }
            } else if (type === 'editIncomeMain') {
                const item = monthData.incomes.find(i => i.id === id);
                if (item && newName) {
                    item.source = newName;
                    if (item.logs.length === 1 && amount > 0) {
                        item.logs[0] = { amount, date };
                        recalculateItemFromLogs(item);
                    }
                }
            } else if (type === 'editDebtLog') {
                const item = monthData.debts.find(d => d.id === id);
                if (item && item.logs[logIdx] && amount > 0) {
                    item.logs[logIdx].amount = amount;
                    item.logs[logIdx].date = date;
                    recalculateDebtFromLogs(item);
                }
            } else if (type === 'editExpenseLog') {
                const item = monthData.expenses.find(e => e.id === id);
                if (item && item.logs[logIdx] && amount > 0) {
                    item.logs[logIdx].amount = amount;
                    item.logs[logIdx].date = date;
                    recalculateItemFromLogs(item);
                }
            } else if (type === 'editIncomeLog') {
                const item = monthData.incomes.find(i => i.id === id);
                if (item && item.logs[logIdx] && amount > 0) {
                    item.logs[logIdx].amount = amount;
                    item.logs[logIdx].date = date;
                    recalculateItemFromLogs(item);
                }
            }

            saveState();
            closeModal('actionModal');
            renderAll();

            if (activeHistoryContext) {
                openHistoryModal(activeHistoryContext.category, activeHistoryContext.id);
            }
        }

        // =========================================================
        // RENDERING CLEAN CARDS ON MAIN PAGE
        // =========================================================
        function renderAll() {
            const monthData = appState.months[currentMonth] || { debts: [], expenses: [], incomes: [] };

            const totalDebtAll = monthData.debts.reduce((sum, d) => sum + Number(d.totalDebt), 0);
            const totalDebtPaid = monthData.debts.reduce((sum, d) => sum + Number(d.paidInMonth), 0);
            const totalDebtRem = totalDebtAll - totalDebtPaid;

            const totalExpenses = monthData.expenses.reduce((sum, e) => sum + Number(e.amount), 0);
            const totalIncome = monthData.incomes.reduce((sum, i) => sum + Number(i.amount), 0);

            const totalOutflows = totalExpenses + totalDebtPaid;
            const netBalance = totalIncome - totalOutflows;

            const banner = document.getElementById('topBalanceBanner');
            const labelEl = document.getElementById('topBalanceLabel');
            const valEl = document.getElementById('topBalanceValue');

            if (netBalance < 0) {
                banner.classList.add('balance-deficit');
                labelEl.textContent = '⚠️ مبلغ العجز هذا الشهر';
                valEl.textContent = formatMoney(Math.abs(netBalance));
            } else {
                banner.classList.remove('balance-deficit');
                labelEl.textContent = '✅ المبلغ المتوفر لديك';
                valEl.textContent = formatMoney(netBalance);
            }

            document.getElementById('statDebtTotal').textContent = formatNum(totalDebtAll);
            document.getElementById('statDebtPaid').textContent = formatNum(totalDebtPaid);
            document.getElementById('statDebtRem').textContent = formatNum(totalDebtRem);

            document.getElementById('statExpCount').textContent = monthData.expenses.length;
            document.getElementById('statExpTotal').textContent = formatMoney(totalExpenses);

            document.getElementById('statIncTotal').textContent = formatNum(totalIncome);
            document.getElementById('statOutTotal').textContent = formatNum(totalOutflows);
            const incNetTitle = document.getElementById('incNetStatTitle');
            const incNetVal = document.getElementById('statNetBalance');
            if (netBalance < 0) {
                incNetTitle.textContent = 'مبلغ العجز';
                incNetVal.style.color = 'var(--debt-color)';
                incNetVal.textContent = formatNum(Math.abs(netBalance));
            } else {
                incNetTitle.textContent = 'المتوفر لديك';
                incNetVal.style.color = 'var(--inc-color)';
                incNetVal.textContent = formatNum(netBalance);
            }

            renderDebtsList(monthData.debts);
            renderExpensesList(monthData.expenses);
            renderIncomeList(monthData.incomes);
        }

        function renderDebtsList(debts) {
            const container = document.getElementById('debtsListContainer');
            if (debts.length === 0) {
                container.innerHTML = '<div class="empty-state">لا توجد ديون مسجلة في هذا الشهر.</div>';
                return;
            }

            container.innerHTML = debts.map(d => {
                const rem = Number(d.totalDebt) - Number(d.paidInMonth);
                const isCleared = rem <= 0;

                return `
                    <div class="item-card">
                        <div class="item-header">
                            <div>
                                <div class="item-title">
                                    ${d.person}
                                    ${d.carriedOver ? '<span class="carried-badge">مرحّل</span>' : ''}
                                </div>
                                <div class="item-date">آخر حركة: ${d.date}</div>
                            </div>
                            ${isCleared ? '<span class="paid-badge">✓ مسدد بالكامل</span>' : ''}
                        </div>

                        <div class="debt-details">
                            <div>إجمالي الدين<strong style="color: var(--text);">${formatNum(d.totalDebt)}</strong></div>
                            <div>المسدد<strong style="color: var(--inc-color);">${formatNum(d.paidInMonth)}</strong></div>
                            <div>المبلغ الباقي<strong style="color: ${isCleared ? 'var(--inc-color)' : 'var(--debt-color)'};">${formatNum(rem)}</strong></div>
                        </div>

                        <div class="card-actions">
                            <button class="action-btn btn-pay" onclick="openActionModal('payDebt', '${d.id}')">➖ سداد</button>
                            <button class="action-btn btn-borrow" onclick="openActionModal('borrowMore', '${d.id}')">➕ استدانة</button>
                            <button class="action-btn btn-history" onclick="openHistoryModal('debt', '${d.id}')">📋 السجل (${d.logs.length})</button>
                            <button class="action-btn btn-icon" onclick="openActionModal('editDebtMain', '${d.id}')" title="تعديل الاسم">✏️</button>
                            <button class="action-btn btn-del" onclick="deleteDebt('${d.id}')" title="حذف السجل">🗑️</button>
                        </div>
                    </div>
                `;
            }).join('');
        }

        function renderExpensesList(expenses) {
            const container = document.getElementById('expensesListContainer');
            if (expenses.length === 0) {
                container.innerHTML = '<div class="empty-state">لا توجد مصاريف مسجلة في هذا الشهر.</div>';
                return;
            }

            container.innerHTML = expenses.map(item => `
                <div class="item-card">
                    <div class="item-header">
                        <div>
                            <div class="item-title">${item.desc}</div>
                            <div class="item-date">آخر تحديث: ${item.date}</div>
                        </div>
                        <div style="font-size: 1.1rem; font-weight: 800; color: var(--exp-color);">
                            ${formatMoney(item.amount)}
                        </div>
                    </div>

                    <div class="card-actions">
                        <button class="action-btn btn-add-more" onclick="openActionModal('addExpenseMore', '${item.id}')">➕ إضافة مبلغ</button>
                        <button class="action-btn btn-history" onclick="openHistoryModal('expense', '${item.id}')">📋 السجل (${item.logs.length})</button>
                        <button class="action-btn btn-icon" onclick="openActionModal('editExpenseMain', '${item.id}')" title="تعديل">✏️</button>
                        <button class="action-btn btn-del" onclick="deleteExpense('${item.id}')" title="حذف">🗑️</button>
                    </div>
                </div>
            `).join('');
        }

        function renderIncomeList(incomes) {
            const container = document.getElementById('incomeListContainer');
            if (incomes.length === 0) {
                container.innerHTML = '<div class="empty-state">لم يتم تسجيل أي دخل شهري بعد.</div>';
                return;
            }

            container.innerHTML = incomes.map(item => `
                <div class="item-card">
                    <div class="item-header">
                        <div>
                            <div class="item-title">${item.source}</div>
                            <div class="item-date">آخر تحديث: ${item.date}</div>
                        </div>
                        <div style="font-size: 1.1rem; font-weight: 800; color: var(--inc-color);">
                            ${formatMoney(item.amount)}
                        </div>
                    </div>

                    <div class="card-actions">
                        <button class="action-btn btn-add-more" onclick="openActionModal('addIncomeMore', '${item.id}')">➕ إضافة مبلغ</button>
                        <button class="action-btn btn-history" onclick="openHistoryModal('income', '${item.id}')">📋 السجل (${item.logs.length})</button>
                        <button class="action-btn btn-icon" onclick="openActionModal('editIncomeMain', '${item.id}')" title="تعديل">✏️</button>
                        <button class="action-btn btn-del" onclick="deleteIncome('${item.id}')" title="حذف">🗑️</button>
                    </div>
                </div>
            `).join('');
        }

        // =========================================================
        // 1. COMPREHENSIVE FINANCIAL PDF REPORT (ALL SECTIONS)
        // =========================================================
        function generateComprehensivePdfReport() {
            const monthData = appState.months[currentMonth] || { debts: [], expenses: [], incomes: [] };

            const paidDebts = monthData.debts.filter(d => (Number(d.totalDebt) - Number(d.paidInMonth)) <= 0);
            const unpaidDebts = monthData.debts.filter(d => (Number(d.totalDebt) - Number(d.paidInMonth)) > 0);

            const totalDebtAll = monthData.debts.reduce((sum, d) => sum + Number(d.totalDebt), 0);
            const totalDebtPaid = monthData.debts.reduce((sum, d) => sum + Number(d.paidInMonth), 0);
            const totalDebtRem = totalDebtAll - totalDebtPaid;

            const totalExpenses = monthData.expenses.reduce((sum, e) => sum + Number(e.amount), 0);
            const totalIncome = monthData.incomes.reduce((sum, i) => sum + Number(i.amount), 0);
            const totalOutflows = totalExpenses + totalDebtPaid;
            const netBalance = totalIncome - totalOutflows;

            let paidDebtsHtml = '';
            if (paidDebts.length === 0) {
                paidDebtsHtml = '<div class="pdf-empty-note">لا توجد ديون مسددة بالكامل في هذا الشهر.</div>';
            } else {
                paidDebtsHtml = `
                    <table class="pdf-table">
                        <thead>
                            <tr>
                                <th style="width:30px; text-align:center;">م</th>
                                <th>اسم الشخص / الجهة</th>
                                <th>تاريخ آخر حركة</th>
                                <th>إجمالي المبلغ المسدد</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${paidDebts.map((d, idx) => `
                                <tr>
                                    <td style="text-align:center;">${idx + 1}</td>
                                    <td><strong>${d.person}</strong></td>
                                    <td>${d.date}</td>
                                    <td style="color:#15803d; font-weight:bold;">${formatNum(d.paidInMonth)} ر.ي</td>
                                </tr>
                            `).join('')}
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="3">إجمالي الديون المسددة بالكامل (${paidDebts.length})</td>
                                <td style="color:#15803d;">${formatMoney(paidDebts.reduce((s, d) => s + Number(d.paidInMonth), 0))}</td>
                            </tr>
                        </tfoot>
                    </table>
                `;
            }

            let unpaidDebtsHtml = '';
            if (unpaidDebts.length === 0) {
                unpaidDebtsHtml = '<div class="pdf-empty-note">لا توجد ديون غير مسددة (متبقية) في هذا الشهر.</div>';
            } else {
                unpaidDebtsHtml = `
                    <table class="pdf-table">
                        <thead>
                            <tr>
                                <th style="width:30px; text-align:center;">م</th>
                                <th>اسم الشخص / الجهة</th>
                                <th>إجمالي الدين</th>
                                <th>المسدد</th>
                                <th>المتبقي</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${unpaidDebts.map((d, idx) => {
                                const rem = Number(d.totalDebt) - Number(d.paidInMonth);
                                return `
                                    <tr>
                                        <td style="text-align:center;">${idx + 1}</td>
                                        <td>
                                            <strong>${d.person}</strong>
                                            ${d.carriedOver ? ' <small style="color:#b45309;">(مرحّل)</small>' : ''}
                                        </td>
                                        <td>${formatNum(d.totalDebt)}</td>
                                        <td style="color:#15803d;">${formatNum(d.paidInMonth)}</td>
                                        <td style="color:#b91c1c; font-weight:bold;">${formatNum(rem)}</td>
                                    </tr>
                                `;
                            }).join('')}
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="2">الإجمالي (${unpaidDebts.length} أشخاص)</td>
                                <td>${formatNum(unpaidDebts.reduce((s, d) => s + Number(d.totalDebt), 0))}</td>
                                <td style="color:#15803d;">${formatNum(unpaidDebts.reduce((s, d) => s + Number(d.paidInMonth), 0))}</td>
                                <td style="color:#b91c1c;">${formatMoney(totalDebtRem)}</td>
                            </tr>
                        </tfoot>
                    </table>
                `;
            }

            let expensesHtml = '';
            if (monthData.expenses.length === 0) {
                expensesHtml = '<div class="pdf-empty-note">لا توجد مصاريف مسجلة في هذا الشهر.</div>';
            } else {
                expensesHtml = `
                    <table class="pdf-table">
                        <thead>
                            <tr>
                                <th style="width:30px; text-align:center;">م</th>
                                <th>بند المصروف (الوصف)</th>
                                <th>عدد الدفعات</th>
                                <th>آخر تاريخ</th>
                                <th>المبلغ الإجمالي</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${monthData.expenses.map((e, idx) => `
                                <tr>
                                    <td style="text-align:center;">${idx + 1}</td>
                                    <td><strong>${e.desc}</strong></td>
                                    <td>${e.logs.length}</td>
                                    <td>${e.date}</td>
                                    <td style="color:#c2410c; font-weight:bold;">${formatNum(e.amount)} ر.ي</td>
                                </tr>
                            `).join('')}
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4">إجمالي المصاريف (${monthData.expenses.length} بنود)</td>
                                <td style="color:#c2410c;">${formatMoney(totalExpenses)}</td>
                            </tr>
                        </tfoot>
                    </table>
                `;
            }

            let incomesHtml = '';
            if (monthData.incomes.length === 0) {
                incomesHtml = '<div class="pdf-empty-note">لا توجد مدخلات مسجلة في هذا الشهر.</div>';
            } else {
                incomesHtml = `
                    <table class="pdf-table">
                        <thead>
                            <tr>
                                <th style="width:30px; text-align:center;">م</th>
                                <th>مصدر الدخل (الجهة)</th>
                                <th>عدد الدفعات</th>
                                <th>آخر تاريخ</th>
                                <th>المبلغ الإجمالي</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${monthData.incomes.map((i, idx) => `
                                <tr>
                                    <td style="text-align:center;">${idx + 1}</td>
                                    <td><strong>${i.source}</strong></td>
                                    <td>${i.logs.length}</td>
                                    <td>${i.date}</td>
                                    <td style="color:#15803d; font-weight:bold;">${formatNum(i.amount)} ر.ي</td>
                                </tr>
                            `).join('')}
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4">إجمالي المدخلات (${monthData.incomes.length} مصادر)</td>
                                <td style="color:#15803d;">${formatMoney(totalIncome)}</td>
                            </tr>
                        </tfoot>
                    </table>
                `;
            }

            const reportArea = document.getElementById('pdfReportArea');
            reportArea.innerHTML = `
                <div class="pdf-header">
                    <h1>تطبيق يومياتي - الكشف المالي الشهري الشامل</h1>
                    <div class="pdf-meta">الشهر: <strong>${currentMonth}</strong> | تاريخ الطباعة: ${getTodayStr()} | العملة: ريال يمني</div>
                </div>

                <div class="pdf-summary-grid">
                    <div class="pdf-box">
                        <span>إجمالي المدخلات (الدخل)</span>
                        <strong style="color:#15803d;">${formatMoney(totalIncome)}</strong>
                    </div>
                    <div class="pdf-box">
                        <span>إجمالي المصاريف</span>
                        <strong style="color:#c2410c;">${formatMoney(totalExpenses)}</strong>
                    </div>
                    <div class="pdf-box">
                        <span>المسدد من الديون</span>
                        <strong style="color:#0f766e;">${formatMoney(totalDebtPaid)}</strong>
                    </div>
                    <div class="pdf-box">
                        <span>إجمالي المصروفات الكلي</span>
                        <strong style="color:#0f172a;">${formatMoney(totalOutflows)}</strong>
                    </div>
                    <div class="pdf-box">
                        <span>الديون المتبقية عليك</span>
                        <strong style="color:#b91c1c;">${formatMoney(totalDebtRem)}</strong>
                    </div>
                    <div class="pdf-box ${netBalance < 0 ? 'deficit' : 'highlight'}">
                        <span>${netBalance < 0 ? 'مبلغ العجز الشهري' : 'الرصيد الباقي المتوفر'}</span>
                        <strong style="color:${netBalance < 0 ? '#b91c1c' : '#15803d'};">${formatMoney(Math.abs(netBalance))}</strong>
                    </div>
                </div>

                <div class="pdf-section-title sec-paid">1. الديون المسددة بالكامل خلال الشهر</div>
                ${paidDebtsHtml}

                <div class="pdf-section-title sec-unpaid">2. الديون غير المسددة (المتبقية)</div>
                ${unpaidDebtsHtml}

                <div class="pdf-section-title sec-exp">3. قائمة المصاريف الشهرية</div>
                ${expensesHtml}

                <div class="pdf-section-title sec-inc">4. قائمة المدخلات (الدخل الشهري)</div>
                ${incomesHtml}

                <div class="pdf-footer">
                    تم استخراج هذا التقرير آلياً من تطبيق "يومياتي" - صافي الرصيد المتوفر: ${formatMoney(netBalance)}
                </div>
            `;

            setTimeout(() => {
                window.print();
            }, 150);
        }

        // =========================================================
        // 2. DEBT MOVEMENTS ONLY PDF REPORT
        // =========================================================
        function generateDebtPdfReport() {
            const monthData = appState.months[currentMonth] || { debts: [] };
            if (monthData.debts.length === 0) {
                alert('لا توجد ديون مسجلة في هذا الشهر لتصديرها.');
                return;
            }

            const totalDebtAll = monthData.debts.reduce((sum, d) => sum + Number(d.totalDebt), 0);
            const totalDebtPaid = monthData.debts.reduce((sum, d) => sum + Number(d.paidInMonth), 0);
            const totalDebtRem = totalDebtAll - totalDebtPaid;

            const rowsHtml = monthData.debts.map((d, index) => {
                const rem = Number(d.totalDebt) - Number(d.paidInMonth);
                const movementsHtml = [...d.logs].reverse().map(l => `
                    <div class="pdf-log-line">
                        • ${l.type}: <strong>${formatNum(l.amount)}</strong> (${l.date})
                    </div>
                `).join('');

                return `
                    <tr>
                        <td style="text-align:center; width:30px;">${index + 1}</td>
                        <td>
                            <strong>${d.person}</strong>
                            ${d.carriedOver ? '<br><small style="color:#b45309;">(مرحّل من شهر سابق)</small>' : ''}
                        </td>
                        <td>${movementsHtml}</td>
                        <td style="white-space:nowrap;">${formatNum(d.totalDebt)}</td>
                        <td style="white-space:nowrap; color:#15803d;">${formatNum(d.paidInMonth)}</td>
                        <td style="white-space:nowrap; font-weight:bold; color:${rem > 0 ? '#b91c1c' : '#15803d'};">${formatNum(rem)}</td>
                    </tr>
                `;
            }).join('');

            const reportArea = document.getElementById('pdfReportArea');
            reportArea.innerHTML = `
                <div class="pdf-header">
                    <h1>تطبيق يومياتي - كشف حركة الديون الشهرية</h1>
                    <div class="pdf-meta">الشهر: <strong>${currentMonth}</strong> | تاريخ الإصدار: ${getTodayStr()} | العملة: ريال يمني</div>
                </div>

                <div class="pdf-summary-grid">
                    <div class="pdf-box">
                        <span>إجمالي الديون</span>
                        <strong style="color:#b91c1c;">${formatMoney(totalDebtAll)}</strong>
                    </div>
                    <div class="pdf-box">
                        <span>إجمالي المسدد</span>
                        <strong style="color:#15803d;">${formatMoney(totalDebtPaid)}</strong>
                    </div>
                    <div class="pdf-box">
                        <span>الرصيد المتبقي</span>
                        <strong style="color:#0f172a;">${formatMoney(totalDebtRem)}</strong>
                    </div>
                </div>

                <table class="pdf-table">
                    <thead>
                        <tr>
                            <th>م</th>
                            <th>اسم الشخص</th>
                            <th>تفاصيل الحركة خلال الشهر (الأحدث أولاً)</th>
                            <th>الإجمالي</th>
                            <th>المسدد</th>
                            <th>المتبقي</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${rowsHtml}
                    </tbody>
                </table>

                <div class="pdf-footer">
                    تم استخراج هذا الكشف آلياً من تطبيق "يومياتي" للإدارة المالية
                </div>
            `;

            setTimeout(() => {
                window.print();
            }, 150);
        }

        // =========================================================
        // LOCAL BACKUP & RESTORE
        // =========================================================
        function exportBackup() {
            const blob = new Blob([JSON.stringify(appState, null, 2)], { type: 'application/json' });
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = `نسخة_احتياطية_يومياتي_${getTodayStr()}.json`;
            a.click();
            URL.revokeObjectURL(url);
        }

        function importBackup(e) {
            const file = e.target.files[0];
            if (!file) return;
            const reader = new FileReader();
            reader.onload = function(ev) {
                try {
                    const data = JSON.parse(ev.target.result);
                    if (data.months) {
                        if (confirm('سيتم استبدال البيانات الحالية بالنسخة الاحتياطية. هل تريد المتابعة؟')) {
                            appState = data;
                            saveState();
                            ensureMonthInitialized(currentMonth);
                            renderAll();
                            alert('تمت استعادة البيانات بنجاح.');
                        }
                    } else if (data.transactions && data.expenses && data.incomes) {
                        if (confirm('تم التعرف على نسخة احتياطية شاملة. هل تريد استيرادها وتحويلها إلى الأشهر؟')) {
                            appState = convertLegacyBackupToMonthlyState(data);
                            saveState();
                            ensureMonthInitialized(currentMonth);
                            renderAll();
                            alert('تم استيراد وترحيل كافة البيانات بنجاح.');
                        }
                    } else {
                        alert('ملف غير صالح.');
                    }
                } catch {
                    alert('خطأ في قراءة الملف.');
                }
                e.target.value = '';
            };
            reader.readAsText(file);
        }

        // Start App
        init();
    </script>
</body>
</html>
