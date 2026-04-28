-- =========================
-- TRIGGER FUNCTION (Q2)
-- =========================

CREATE OR REPLACE FUNCTION check_stock_before_insert()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.qty > (
        SELECT stock_qty 
        FROM Tbl_Products 
        WHERE prod_id = NEW.prod_id
    ) THEN
        RAISE EXCEPTION 'Order quantity exceeds available stock';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- =========================
-- TRIGGER (Q2)
-- =========================

CREATE TRIGGER trg_check_stock
BEFORE INSERT ON Tbl_Orders
FOR EACH ROW
EXECUTE FUNCTION check_stock_before_insert();
