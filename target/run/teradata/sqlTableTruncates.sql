-- Performs a truncation of all tables. Faster that a delete.

DELETE  benchmarksql.warehouse all;

DELETE  benchmarksql.item all;

DELETE  benchmarksql.stock all;

DELETE  benchmarksql.district all;

DELETE  benchmarksql.customer all;

DELETE benchmarksql.history all;

DELETE benchmarksql.oorder all;

DELETE benchmarksql.order_line all;

DELETE benchmarksql.new_order all;