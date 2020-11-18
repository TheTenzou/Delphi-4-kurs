CREATE TRIGGER update_total_summ_before_insert
	BEFORE INSERT ON Order_info
BEGIN
	UPDATE Orders
		SET Total_summ = Orders.Total_summ + new.Count_ * new.Price
		WHERE Orders.ID = new.Order_id;
END;

CREATE TRIGGER update_total_summ_before_update
	BEFORE UPDATE ON Order_info
BEGIN
	UPDATE Orders
		SET Total_summ = Orders.Total_summ + new.Count_ * new.Price - old.Count_ * old.Price
		WHERE id = new.Order_id;
END;

CREATE TRIGGER update_total_summ_before_delete
	BEFORE DELETE ON Order_info
BEGIN
	UPDATE Orders
		set Total_summ = Orders.Total_summ - old.Count_ * old.Price
		WHERE id = old.Order_id;
END;