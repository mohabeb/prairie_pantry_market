ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: "Dashboard"

  content title: "Prairie Pantry Market Dashboard" do
    div class: "admin-dashboard-hero" do
      h2 "Prairie Pantry Market"
      para "Store management dashboard for product catalogue, orders, customers, and content pages."
    end

    div class: "admin-dashboard-cards" do
      div class: "admin-stat-card" do
        h3 "Products"
        h2 Product.count
        para "#{Product.where(active: true).count} active products"
      end

      div class: "admin-stat-card" do
        h3 "Categories"
        h2 Category.count
        para "Catalogue groups"
      end

      div class: "admin-stat-card" do
        h3 "Orders"
        h2 Order.count
        para "Saved customer orders"
      end

      div class: "admin-stat-card" do
        h3 "Revenue"
        h2 "$#{format('%.2f', Order.sum(:total_cents).to_i / 100.0)}"
        para "Total order value"
      end
    end

    div class: "admin-dashboard-cards" do
      div class: "admin-stat-card" do
        h3 "On Sale"
        h2 Product.where(on_sale: true).count
        para "Promotional products"
      end

      div class: "admin-stat-card" do
        h3 "New Arrivals"
        h2 Product.where(new_arrival: true).count
        para "Recently added products"
      end

      div class: "admin-stat-card" do
        h3 "Low Stock"
        h2 Product.where("stock_quantity <= ?", 15).count
        para "Products at or below 15 units"
      end

      div class: "admin-stat-card" do
        h3 "Pages"
        h2 Page.count
        para "Editable content pages"
      end
    end

    columns do
      column do
        panel "Recent Orders" do
          if Order.any?
            table_for Order.order(created_at: :desc).limit(5) do
              column("Order") { |order| link_to "Order ##{order.id}", admin_order_path(order) }
              column("Customer") { |order| order.customer&.email || "N/A" }
              column("Status") { |order| order.status.to_s.titleize }
              column("Total") { |order| "$#{format('%.2f', order.total_cents.to_i / 100.0)}" }
              column("Date") { |order| order.created_at.strftime("%Y-%m-%d") }
            end
          else
            para "No orders have been created yet."
          end
        end
      end

      column do
        panel "Low Stock Products" do
          low_stock_products = Product.order(:stock_quantity).limit(6)

          table_for low_stock_products do
            column("Product") { |product| link_to product.name, admin_product_path(product) }
            column("Stock") { |product| product.stock_quantity }
            column("Price") { |product| "$#{format('%.2f', product.price_cents.to_i / 100.0)}" }
            column("Active") { |product| product.active? ? "Yes" : "No" }
          end
        end
      end
    end

    columns do
      column do
        panel "Product Category Summary" do
          table_for Category.order(:name) do
            column("Category") { |category| link_to category.name, admin_category_path(category) }
            column("Products") { |category| category.products.count }
          end
        end
      end

      column do
        panel "Quick Actions" do
          ul do
            li link_to("Manage Products", admin_products_path)
            li link_to("Manage Categories", admin_categories_path)
            li link_to("Review Orders", admin_orders_path)
            li link_to("Edit About / Contact Pages", admin_pages_path)
            li link_to("Manage Provinces", admin_provinces_path)
          end
        end

        panel "Dashboard Notes" do
          ul do
            li "Product images, stock, prices, categories, and status flags are managed from Products."
            li "Orders preserve product prices and tax values at checkout."
            li "About and Contact content can be maintained from Pages."
          end
        end
      end
    end
  end
end