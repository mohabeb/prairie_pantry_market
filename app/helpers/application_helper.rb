module ApplicationHelper
  def breadcrumb_items
    items = [["Products", products_path]]

    case controller_name
    when "products"
      if action_name == "show" && defined?(@product) && @product.present?
        items << [@product.name, product_path(@product)]
      end
    when "categories"
      if defined?(@category) && @category.present?
        items << [@category.name, category_path(@category)]
      end
    when "cart"
      items << ["Cart", cart_path]
    when "checkout"
      items << ["Checkout", checkout_path] if action_name == "new"
      items << ["Order Invoice", request.path] if action_name == "show"
    when "orders"
      items << ["Orders", orders_path]
    when "pages"
      items << [@page.title, page_path(@page.slug)] if defined?(@page) && @page.present?
    end

    items
  end
end
