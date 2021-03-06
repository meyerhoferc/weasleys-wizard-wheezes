class Admin::OrdersController < Admin::BaseController
  include ActionView::Helpers::TextHelper

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def sort_orders
    if params[:order][:status] == "all"
      @orders = Order.all
      render "admin/orders/index"
    else
      @orders = Order.get_by_status(params[:order][:status])
      render 'admin/orders/index'
    end
  end

  def update
    order = Order.find(params[:id])
    if order.update_attribute(:status, params[:status])
      flash[:notice] = "Updated order status"
      redirect_to admin_dashboard_path
    else
      flash[:notice] = "Something didn't happen"
      redirect_to admin_dashboard_path
    end
  end
end
