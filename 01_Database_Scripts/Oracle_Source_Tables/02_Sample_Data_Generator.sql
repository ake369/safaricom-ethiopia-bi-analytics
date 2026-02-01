-- ============================================
-- TELECOM SAMPLE DATA FOR SAFARICOM ETHIOPIA
-- Time Range: August 2022 to January 2026
-- 2000+ Customers with Ethiopian MSISDNs (+2517...)
-- ============================================

-- Disable foreign key constraints temporarily
ALTER SESSION SET CONSTRAINTS = DEFERRED;

-- Clear existing data (if any)
DELETE FROM FINANCIAL_TRANSACTIONS;
DELETE FROM SMS_RECORDS;
DELETE FROM DATA_USAGE;
DELETE FROM CALL_DETAIL_RECORDS;
DELETE FROM CUSTOMERS;
COMMIT;

-- ============================================
-- 1. CUSTOMERS TABLE (2000+ customers)
-- ============================================
-- First 10 customers
INSERT INTO CUSTOMERS VALUES (1, '+251711234567', 'Abebe Bikila', 'Addis Ababa', 'Center', 'Addis Ababa CBD', TO_DATE('2022-08-01', 'YYYY-MM-DD'), 'Prepaid', 'Basic', 'Active');
INSERT INTO CUSTOMERS VALUES (2, '+251712345678', 'Mesenbet Debebe', 'Addis Ababa', 'North', 'Addis Ketema', TO_DATE('2022-08-02', 'YYYY-MM-DD'), 'Postpaid', 'Premium', 'Active');
INSERT INTO CUSTOMERS VALUES (3, '+251713456789', 'Tigist Getahun', 'Oromia', 'East', 'Adama', TO_DATE('2022-08-03', 'YYYY-MM-DD'), 'Prepaid', 'Standard', 'Active');
INSERT INTO CUSTOMERS VALUES (4, '+251714567890', 'Mekonnen Haile', 'Amhara', 'North', 'Bahir Dar', TO_DATE('2022-08-04', 'YYYY-MM-DD'), 'Postpaid', 'Business', 'Active');
INSERT INTO CUSTOMERS VALUES (5, '+251715678901', 'Selamawit Tesfaye', 'SNNPR', 'Gurage', 'Wolkite', TO_DATE('2022-08-05', 'YYYY-MM-DD'), 'Prepaid', 'Student', 'Active');
INSERT INTO CUSTOMERS VALUES (6, '+251716789012', 'Yohannes Assefa', 'Tigray', 'Central', 'Mekelle', TO_DATE('2022-08-06', 'YYYY-MM-DD'), 'Hybrid', 'Standard', 'Suspended');
INSERT INTO CUSTOMERS VALUES (7, '+251717890123', 'Marta Solomon', 'Addis Ababa', 'South', 'Nifas Silk', TO_DATE('2022-08-07', 'YYYY-MM-DD'), 'Postpaid', 'Premium', 'Active');
INSERT INTO CUSTOMERS VALUES (8, '+251718901234', 'Kebede Michael', 'Dire Dawa', 'City', 'Dire Dawa', TO_DATE('2022-08-08', 'YYYY-MM-DD'), 'Prepaid', 'Basic', 'Active');
INSERT INTO CUSTOMERS VALUES (9, '+251719012345', 'Hana Girma', 'Oromia', 'West', 'Jimma', TO_DATE('2022-08-09', 'YYYY-MM-DD'), 'Postpaid', 'Business', 'Active');
INSERT INTO CUSTOMERS VALUES (10, '+251720123456', 'Dawit Bekele', 'Amhara', 'South', 'Debre Markos', TO_DATE('2022-08-10', 'YYYY-MM-DD'), 'Prepaid', 'Standard', 'Active');
COMMIT;

-- Insert 1990 more customers using PL/SQL loop
BEGIN
    FOR i IN 11..2000 LOOP
        INSERT INTO CUSTOMERS (
            CUSTOMER_ID, 
            MSISDN, 
            CUSTOMER_NAME, 
            REGION, 
            ZONE, 
            CITY, 
            REGISTRATION_DATE, 
            CUSTOMER_TYPE, 
            TARIFF_PLAN, 
            ACCOUNT_STATUS
        ) VALUES (
            i,
            '+2517' || LPAD(MOD(i, 10), 1, '0') || LPAD(MOD(DBMS_RANDOM.VALUE(1, 10000000), 10000000), 7, '0'),
            CASE MOD(i, 20)
                WHEN 0 THEN 'Alemayehu Bekele'
                WHEN 1 THEN 'Biruk Tesfaye'
                WHEN 2 THEN 'Chaltu Girma'
                WHEN 3 THEN 'Dereje Haile'
                WHEN 4 THEN 'Eleni Solomon'
                WHEN 5 THEN 'Fasil Mengistu'
                WHEN 6 THEN 'Genet Abebe'
                WHEN 7 THEN 'Habtamu Tadesse'
                WHEN 8 THEN 'Imani Mohammed'
                WHEN 9 THEN 'Jemal Hussein'
                WHEN 10 THEN 'Kalkidan Yohannes'
                WHEN 11 THEN 'Liya Getahun'
                WHEN 12 THEN 'Mulualem Assefa'
                WHEN 13 THEN 'Nardos Daniel'
                WHEN 14 THEN 'Omor Ahmed'
                WHEN 15 THEN 'Saba Mesfin'
                WHEN 16 THEN 'Tedros Kebede'
                WHEN 17 THEN 'Urge Teshome'
                WHEN 18 THEN 'Wendimu Michael'
                ELSE 'Yordanos Worku'
            END,
            CASE MOD(i, 6)
                WHEN 0 THEN 'Addis Ababa'
                WHEN 1 THEN 'Oromia'
                WHEN 2 THEN 'Amhara'
                WHEN 3 THEN 'Tigray'
                WHEN 4 THEN 'SNNPR'
                ELSE 'Dire Dawa'
            END,
            CASE MOD(i, 6)
                WHEN 0 THEN 'Center'
                WHEN 1 THEN 'East'
                WHEN 2 THEN 'North'
                WHEN 3 THEN 'Central'
                WHEN 4 THEN 'Gurage'
                ELSE 'City'
            END,
            CASE MOD(i, 6)
                WHEN 0 THEN 'Addis Ababa CBD'
                WHEN 1 THEN 'Adama'
                WHEN 2 THEN 'Bahir Dar'
                WHEN 3 THEN 'Mekelle'
                WHEN 4 THEN 'Wolkite'
                ELSE 'Dire Dawa'
            END,
            TO_DATE('2022-08-01', 'YYYY-MM-DD') + DBMS_RANDOM.VALUE(0, 1260),
            CASE MOD(i, 10)
                WHEN 0 THEN 'Postpaid'
                WHEN 1 THEN 'Hybrid'
                ELSE 'Prepaid'
            END,
            CASE MOD(i, 5)
                WHEN 0 THEN 'Basic'
                WHEN 1 THEN 'Standard'
                WHEN 2 THEN 'Premium'
                WHEN 3 THEN 'Business'
                ELSE 'Student'
            END,
            CASE MOD(i, 20)
                WHEN 0 THEN 'Suspended'
                WHEN 1 THEN 'Terminated'
                WHEN 2 THEN 'Inactive'
                ELSE 'Active'
            END
        );
        
        IF MOD(i, 100) = 0 THEN
            COMMIT;
        END IF;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserted 2000 customers');
END;
/

-- ============================================
-- 2. CALL_DETAIL_RECORDS TABLE (10,000+ records)
-- ============================================
DECLARE
    v_cdr_id NUMBER := 1;
    v_calling_msisdn VARCHAR2(15);
    v_called_msisdn VARCHAR2(15);
    v_call_start TIMESTAMP;
    v_call_end TIMESTAMP;
    v_duration NUMBER;
    v_cell_id VARCHAR2(20);
    v_charge NUMBER(10,2);
    v_call_types VARCHAR2(20);
    v_cust_count NUMBER;
    CURSOR cust_cursor IS 
        SELECT MSISDN, REGISTRATION_DATE 
        FROM CUSTOMERS 
        WHERE ACCOUNT_STATUS = 'Active';
BEGIN
    SELECT COUNT(*) INTO v_cust_count FROM CUSTOMERS WHERE ACCOUNT_STATUS = 'Active';
    
    FOR cust IN cust_cursor LOOP
        v_calling_msisdn := cust.MSISDN;
        
        -- Generate 5-15 calls per customer
        FOR j IN 1..(5 + MOD(ABS(DBMS_RANDOM.RANDOM), 11)) LOOP
            -- Random call date
            v_call_start := CAST(cust.REGISTRATION_DATE AS TIMESTAMP) + 
                           NUMTODSINTERVAL(DBMS_RANDOM.VALUE(0, 11000000), 'SECOND');
            
            -- Ensure call is within range
            IF v_call_start > TIMESTAMP '2026-01-31 23:59:59' THEN
                v_call_start := TIMESTAMP '2025-12-31 00:00:00';
            END IF;
            
            v_duration := 30 + ROUND(DBMS_RANDOM.VALUE(0, 3570));
            v_call_end := v_call_start + NUMTODSINTERVAL(v_duration, 'SECOND');
            
            -- Random called number
            IF DBMS_RANDOM.VALUE < 0.8 THEN
                -- Get random customer MSISDN
                SELECT MSISDN INTO v_called_msisdn 
                FROM (
                    SELECT MSISDN FROM CUSTOMERS 
                    WHERE MSISDN != v_calling_msisdn 
                    AND ACCOUNT_STATUS = 'Active'
                    ORDER BY DBMS_RANDOM.VALUE
                ) WHERE ROWNUM = 1;
            ELSE
                -- Generate external number
                v_called_msisdn := '+2517' || 
                                  ROUND(DBMS_RANDOM.VALUE(0, 9)) || 
                                  LPAD(ROUND(DBMS_RANDOM.VALUE(0, 9999999)), 7, '0');
            END IF;
            
            -- Random call type
            IF DBMS_RANDOM.VALUE < 0.1 THEN
                v_call_types := 'International';
            ELSIF DBMS_RANDOM.VALUE < 0.2 THEN
                v_call_types := 'Roaming';
            ELSIF DBMS_RANDOM.VALUE < 0.4 THEN
                v_call_types := 'National';
            ELSE
                v_call_types := 'Local';
            END IF;
            
            -- Generate cell ID
            v_cell_id := 'CELL' || LPAD(MOD(v_cdr_id, 1000), 4, '0');
            
            -- Calculate charge
            IF v_call_types = 'International' THEN
                v_charge := ROUND(v_duration * 0.05, 2);
            ELSIF v_call_types = 'Roaming' THEN
                v_charge := ROUND(v_duration * 0.03, 2);
            ELSIF v_call_types = 'National' THEN
                v_charge := ROUND(v_duration * 0.01, 2);
            ELSE
                v_charge := ROUND(v_duration * 0.005, 2);
            END IF;
            
            -- Insert CDR
            INSERT INTO CALL_DETAIL_RECORDS VALUES (
                v_cdr_id,
                v_calling_msisdn,
                v_called_msisdn,
                v_call_start,
                v_call_end,
                v_duration,
                v_call_types,
                v_cell_id,
                'IMSI' || LPAD(MOD(ABS(DBMS_RANDOM.RANDOM), 1000000000), 15, '0'),
                'IMEI' || LPAD(MOD(ABS(DBMS_RANDOM.RANDOM), 1000000000), 15, '0'),
                v_charge
            );
            
            v_cdr_id := v_cdr_id + 1;
            
            IF MOD(v_cdr_id, 500) = 0 THEN
                COMMIT;
            END IF;
        END LOOP;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserted ' || (v_cdr_id - 1) || ' CDR records');
END;
/

-- ============================================
-- 3. DATA_USAGE TABLE (8,000+ records)
-- ============================================
DECLARE
    v_data_id NUMBER := 1;
    v_msisdn VARCHAR2(15);
    v_session_start TIMESTAMP;
    v_session_end TIMESTAMP;
    v_data_volume NUMBER(10,2);
    v_service_types VARCHAR2(30);
    v_apn VARCHAR2(50);
    v_charge NUMBER(10,2);
    CURSOR cust_cursor IS 
        SELECT MSISDN, REGISTRATION_DATE 
        FROM CUSTOMERS 
        WHERE ACCOUNT_STATUS = 'Active';
BEGIN
    FOR cust IN cust_cursor LOOP
        v_msisdn := cust.MSISDN;
        
        -- Generate 3-8 data sessions per customer
        FOR j IN 1..(3 + MOD(ABS(DBMS_RANDOM.RANDOM), 6)) LOOP
            -- Random session date
            v_session_start := CAST(cust.REGISTRATION_DATE AS TIMESTAMP) + 
                              NUMTODSINTERVAL(DBMS_RANDOM.VALUE(0, 9000000), 'SECOND');
            
            IF v_session_start > TIMESTAMP '2026-01-31 23:59:59' THEN
                v_session_start := TIMESTAMP '2025-12-31 00:00:00';
            END IF;
            
            -- Session duration 1 min to 2 hours
            v_session_end := v_session_start + 
                            NUMTODSINTERVAL(60 + DBMS_RANDOM.VALUE(0, 7140), 'SECOND');
            
            -- Random data volume (1MB to 5GB)
            v_data_volume := ROUND(1 + DBMS_RANDOM.VALUE(0, 4999), 2);
            
            -- Random service type
            IF DBMS_RANDOM.VALUE < 0.01 THEN
                v_service_types := '5G';
            ELSIF DBMS_RANDOM.VALUE < 0.03 THEN
                v_service_types := 'WiFi';
            ELSIF DBMS_RANDOM.VALUE < 0.08 THEN
                v_service_types := '2G';
            ELSIF DBMS_RANDOM.VALUE < 0.3 THEN
                v_service_types := '3G';
            ELSE
                v_service_types := '4G';
            END IF;
            
            -- Random APN
            CASE MOD(ABS(DBMS_RANDOM.RANDOM), 4)
                WHEN 0 THEN v_apn := 'internet';
                WHEN 1 THEN v_apn := 'mms';
                WHEN 2 THEN v_apn := 'wapservice';
                ELSE v_apn := 'vpn';
            END CASE;
            
            -- Calculate charge
            v_charge := ROUND(v_data_volume * 0.01, 2);
            
            -- Insert data usage record
            INSERT INTO DATA_USAGE VALUES (
                v_data_id,
                v_msisdn,
                v_session_start,
                v_session_end,
                v_data_volume,
                v_service_types,
                v_apn,
                v_charge
            );
            
            v_data_id := v_data_id + 1;
            
            IF MOD(v_data_id, 500) = 0 THEN
                COMMIT;
            END IF;
        END LOOP;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserted ' || (v_data_id - 1) || ' data usage records');
END;
/

-- ============================================
-- 4. SMS_RECORDS TABLE (6,000+ records)
-- ============================================
DECLARE
    v_sms_id NUMBER := 1;
    v_sender_msisdn VARCHAR2(15);
    v_receiver_msisdn VARCHAR2(15);
    v_sms_timestamp TIMESTAMP;
    v_sms_types VARCHAR2(20);
    v_sms_length NUMBER;
    v_sms_charge NUMBER(10,2);
    CURSOR cust_cursor IS 
        SELECT MSISDN, REGISTRATION_DATE 
        FROM CUSTOMERS 
        WHERE ACCOUNT_STATUS = 'Active';
BEGIN
    FOR cust IN cust_cursor LOOP
        v_sender_msisdn := cust.MSISDN;
        
        -- Generate 2-5 SMS per customer
        FOR j IN 1..(2 + MOD(ABS(DBMS_RANDOM.RANDOM), 4)) LOOP
            -- Random SMS date
            v_sms_timestamp := CAST(cust.REGISTRATION_DATE AS TIMESTAMP) + 
                              NUMTODSINTERVAL(DBMS_RANDOM.VALUE(0, 10000000), 'SECOND');
            
            IF v_sms_timestamp > TIMESTAMP '2026-01-31 23:59:59' THEN
                v_sms_timestamp := TIMESTAMP '2025-12-31 00:00:00';
            END IF;
            
            -- Random receiver
            IF DBMS_RANDOM.VALUE < 0.7 THEN
                -- Get random customer MSISDN
                SELECT MSISDN INTO v_receiver_msisdn 
                FROM (
                    SELECT MSISDN FROM CUSTOMERS 
                    WHERE MSISDN != v_sender_msisdn 
                    AND ACCOUNT_STATUS = 'Active'
                    ORDER BY DBMS_RANDOM.VALUE
                ) WHERE ROWNUM = 1;
            ELSE
                -- Generate external number
                v_receiver_msisdn := '+2517' || 
                                   ROUND(DBMS_RANDOM.VALUE(0, 9)) || 
                                   LPAD(ROUND(DBMS_RANDOM.VALUE(0, 9999999)), 7, '0');
            END IF;
            
            -- Random SMS type
            IF DBMS_RANDOM.VALUE < 0.05 THEN
                v_sms_types := 'International';
            ELSIF DBMS_RANDOM.VALUE < 0.1 THEN
                v_sms_types := 'Premium';
            ELSE
                v_sms_types := 'Local';
            END IF;
            
            -- Random SMS length
            v_sms_length := 10 + ROUND(DBMS_RANDOM.VALUE(0, 150));
            
            -- Calculate charge
            IF v_sms_types = 'International' THEN
                v_sms_charge := 0.50;
            ELSIF v_sms_types = 'Premium' THEN
                v_sms_charge := 1.00;
            ELSE
                v_sms_charge := 0.10;
            END IF;
            
            -- Insert SMS record
            INSERT INTO SMS_RECORDS VALUES (
                v_sms_id,
                v_sender_msisdn,
                v_receiver_msisdn,
                v_sms_timestamp,
                v_sms_types,
                v_sms_length,
                v_sms_charge
            );
            
            v_sms_id := v_sms_id + 1;
            
            IF MOD(v_sms_id, 500) = 0 THEN
                COMMIT;
            END IF;
        END LOOP;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserted ' || (v_sms_id - 1) || ' SMS records');
END;
/

-- ============================================
-- 5. FINANCIAL_TRANSACTIONS TABLE (25,000+ records)
-- ============================================
DECLARE
    v_trans_id NUMBER := 1;
    v_msisdn VARCHAR2(15);
    v_trans_date DATE;
    v_trans_type VARCHAR2(30);
    v_amount NUMBER(10,2);
    v_payment_method VARCHAR2(30);
    v_balance_before NUMBER(10,2);
    v_balance_after NUMBER(10,2);
    v_customer_type VARCHAR2(20);
    v_reg_date DATE;
    v_current_balance NUMBER(10,2);
    CURSOR cust_cursor IS 
        SELECT MSISDN, CUSTOMER_TYPE, REGISTRATION_DATE 
        FROM CUSTOMERS;
BEGIN
    FOR cust IN cust_cursor LOOP
        v_msisdn := cust.MSISDN;
        v_customer_type := cust.CUSTOMER_TYPE;
        v_reg_date := cust.REGISTRATION_DATE;
        v_current_balance := 100 + DBMS_RANDOM.VALUE(0, 400);
        
        -- Generate transactions based on customer type
        IF v_customer_type = 'Prepaid' THEN
            -- Prepaid: 15-45 transactions
            FOR j IN 1..(15 + MOD(ABS(DBMS_RANDOM.RANDOM), 31)) LOOP
                v_trans_date := v_reg_date + DBMS_RANDOM.VALUE(0, (DATE '2026-01-31' - v_reg_date));
                
                -- 80% top-ups
                IF DBMS_RANDOM.VALUE < 0.8 THEN
                    v_trans_type := 'Top-up';
                    v_amount := ROUND(10 + DBMS_RANDOM.VALUE(0, 490), 2);
                    v_balance_before := v_current_balance;
                    v_current_balance := v_current_balance + v_amount;
                    v_balance_after := v_current_balance;
                ELSE
                    CASE MOD(ABS(DBMS_RANDOM.RANDOM), 4)
                        WHEN 0 THEN v_trans_type := 'Payment';
                        WHEN 1 THEN v_trans_type := 'Refund';
                        WHEN 2 THEN v_trans_type := 'Adjustment';
                        ELSE v_trans_type := 'Monthly Bill';
                    END CASE;
                    v_amount := ROUND(1 + DBMS_RANDOM.VALUE(0, 100), 2);
                    v_balance_before := v_current_balance;
                    
                    IF v_trans_type IN ('Payment', 'Monthly Bill') THEN
                        v_current_balance := v_current_balance - v_amount;
                    ELSE
                        v_current_balance := v_current_balance + v_amount;
                    END IF;
                    
                    v_balance_after := v_current_balance;
                END IF;
                
                -- Random payment method
                CASE MOD(ABS(DBMS_RANDOM.RANDOM), 5)
                    WHEN 0 THEN v_payment_method := 'M-PESA';
                    WHEN 1 THEN v_payment_method := 'Bank Transfer';
                    ELSE v_payment_method := 'Cash';
                END CASE;
                
                -- Insert transaction
                INSERT INTO FINANCIAL_TRANSACTIONS VALUES (
                    v_trans_id,
                    v_msisdn,
                    v_trans_type,
                    v_amount,
                    v_trans_date,
                    v_payment_method,
                    ROUND(v_balance_before, 2),
                    ROUND(v_balance_after, 2)
                );
                
                v_trans_id := v_trans_id + 1;
                
                IF MOD(v_trans_id, 500) = 0 THEN
                    COMMIT;
                END IF;
            END LOOP;
        ELSE
            -- Postpaid/Hybrid: 20-40 transactions
            FOR j IN 1..(20 + MOD(ABS(DBMS_RANDOM.RANDOM), 21)) LOOP
                v_trans_date := v_reg_date + DBMS_RANDOM.VALUE(0, (DATE '2026-01-31' - v_reg_date));
                
                -- Alternating bills and payments
                IF MOD(j, 2) = 0 THEN
                    v_trans_type := 'Monthly Bill';
                    v_amount := ROUND(50 + DBMS_RANDOM.VALUE(0, 250), 2);
                ELSE
                    v_trans_type := 'Payment';
                    v_amount := ROUND(50 + DBMS_RANDOM.VALUE(0, 250), 2);
                END IF;
                
                -- Occasional other transactions
                IF DBMS_RANDOM.VALUE < 0.1 THEN
                    CASE MOD(ABS(DBMS_RANDOM.RANDOM), 3)
                        WHEN 0 THEN v_trans_type := 'Top-up';
                        WHEN 1 THEN v_trans_type := 'Refund';
                        ELSE v_trans_type := 'Adjustment';
                    END CASE;
                    v_amount := ROUND(5 + DBMS_RANDOM.VALUE(0, 50), 2);
                END IF;
                
                v_balance_before := v_current_balance;
                
                IF v_trans_type = 'Payment' OR v_trans_type = 'Top-up' OR v_trans_type = 'Refund' THEN
                    v_current_balance := v_current_balance + v_amount;
                ELSE
                    v_current_balance := v_current_balance - v_amount;
                END IF;
                
                v_balance_after := v_current_balance;
                
                -- Random payment method
                CASE MOD(ABS(DBMS_RANDOM.RANDOM), 3)
                    WHEN 0 THEN v_payment_method := 'M-PESA';
                    WHEN 1 THEN v_payment_method := 'Bank Transfer';
                    ELSE v_payment_method := 'Cash';
                END CASE;
                
                -- Insert transaction
                INSERT INTO FINANCIAL_TRANSACTIONS VALUES (
                    v_trans_id,
                    v_msisdn,
                    v_trans_type,
                    v_amount,
                    v_trans_date,
                    v_payment_method,
                    ROUND(v_balance_before, 2),
                    ROUND(v_balance_after, 2)
                );
                
                v_trans_id := v_trans_id + 1;
                
                IF MOD(v_trans_id, 500) = 0 THEN
                    COMMIT;
                END IF;
            END LOOP;
        END IF;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserted ' || (v_trans_id - 1) || ' financial transactions');
END;
/

-- Re-enable constraints
ALTER SESSION SET CONSTRAINTS = IMMEDIATE;

-- ============================================
-- VERIFICATION QUERIES
-- ============================================
SELECT 'CUSTOMERS' AS TABLE_NAME, COUNT(*) AS RECORD_COUNT FROM CUSTOMERS
UNION ALL
SELECT 'CALL_DETAIL_RECORDS', COUNT(*) FROM CALL_DETAIL_RECORDS
UNION ALL
SELECT 'DATA_USAGE', COUNT(*) FROM DATA_USAGE
UNION ALL
SELECT 'SMS_RECORDS', COUNT(*) FROM SMS_RECORDS
UNION ALL
SELECT 'FINANCIAL_TRANSACTIONS', COUNT(*) FROM FINANCIAL_TRANSACTIONS;

-- Sample customer with all data
SELECT '=== SAMPLE CUSTOMER DATA ===' AS INFO FROM DUAL;
SELECT CUSTOMER_ID, MSISDN, CUSTOMER_NAME, REGION, CUSTOMER_TYPE, ACCOUNT_STATUS 
FROM CUSTOMERS WHERE ROWNUM <= 5;

SELECT '=== DATE RANGE VERIFICATION ===' AS INFO FROM DUAL;
SELECT 
    MIN(REGISTRATION_DATE) AS EARLIEST_REG,
    MAX(REGISTRATION_DATE) AS LATEST_REG
FROM CUSTOMERS;

SELECT '=== MSISDN FORMAT CHECK ===' AS INFO FROM DUAL;
SELECT 'All MSISDNs start with +2517: ' || 
       CASE WHEN COUNT(*) = SUM(CASE WHEN MSISDN LIKE '+2517%' THEN 1 ELSE 0 END) 
            THEN 'YES' ELSE 'NO' END AS CHECK_RESULT
FROM CUSTOMERS;

COMMIT;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Data generation completed successfully!');
END;
/