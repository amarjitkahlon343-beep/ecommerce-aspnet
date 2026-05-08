<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="Dashboardaspx.aspx.cs" Inherits="Ecomwebsite.Admin.Dashboardaspx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .stat-card {
            border-left: 4px solid;
            transition: transform 0.2s;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        .stat-card.primary { border-left-color: #4e73df; }
        .stat-card.success { border-left-color: #1cc88a; }
        .stat-card.info { border-left-color: #36b9cc; }
        .stat-card.warning { border-left-color: #f6c23e; }
        
        .stat-icon {
            font-size: 2rem;
            opacity: 0.3;
            position: absolute;
            right: 15px;
            top: 15px;
        }
        
        .recent-order-table {
            font-size: 14px;
        }
        
        .badge-status {
            padding: 5px 10px;
            border-radius: 20px;
            font-weight: 600;
        }
        
        .badge-delivered { background-color: #1cc88a; color: white; }
        .badge-processing { background-color: #f6c23e; color: white; }
        .badge-shipped { background-color: #36b9cc; color: white; }
        .badge-cancelled { background-color: #e74a3b; color: white; }
        
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .product-card {
            border: 1px solid #e3e6f0;
            border-radius: 10px;
            overflow: hidden;
            transition: all 0.3s;
            background: white;
        }
        
        .product-card:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            transform: translateY(-3px);
        }
        
        .product-image {
            height: 200px;
            background: #f8f9fc;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid #e3e6f0;
        }
        
        .product-image img {
            max-width: 100%;
            max-height: 180px;
            object-fit: contain;
        }
        
        .product-details {
            padding: 15px;
        }
        
        .product-title {
            font-weight: 600;
            margin-bottom: 5px;
            color: #333;
        }
        
        .product-price {
            color: #4e73df;
            font-weight: 700;
            font-size: 1.1rem;
        }
        
        .product-stock {
            font-size: 0.85rem;
            color: #858796;
        }
        
        .stock-in { color: #1cc88a; }
        .stock-low { color: #f6c23e; }
        .stock-out { color: #e74a3b; }
        
        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        
        .action-btn {
            width: 35px;
            height: 35px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
            background: #f8f9fc;
        }
        
        .action-btn:hover {
            background: #4e73df;
            color: white;
        }
        
        .action-btn.delete:hover { background: #e74a3b; }
        .action-btn.edit:hover { background: #1cc88a; }
        
        .chart-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            height: 300px;
        }
        
        .quick-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        
        .quick-action-btn {
            flex: 1;
            min-width: 150px;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: white;
            color: #4e73df;
            font-weight: 600;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: all 0.3s;
        }
        
        .quick-action-btn:hover {
            background: #4e73df;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(78,115,223,0.3);
        }
        
        .welcome-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        
        .welcome-section h1 {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        
        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
    </style>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Heading -->
 
    <!-- Welcome Section -->
    <div class="welcome-section">
    <%--    <h1>Welcome back, <%= GetAdminName() %>!</h1>--%>
        <p>Here's what's happening with your store today, <%= DateTime.Now.ToString("dddd, MMMM dd, yyyy") %></p>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
        <asp:LinkButton ID="btnAddProduct" runat="server" CssClass="quick-action-btn" 
            PostBackUrl="~/Admin/Product.aspx">
            <i class="fas fa-plus-circle"></i> Add New Product
        </asp:LinkButton>
        <asp:LinkButton ID="btnViewOrders" runat="server" CssClass="quick-action-btn" 
    PostBackUrl="~/Admin/vieworder.aspx">
    <i class="fas fa-shopping-cart"></i> View Orders
</asp:LinkButton>
        <asp:LinkButton ID="btnManageCategories" runat="server" CssClass="quick-action-btn" 
            PostBackUrl="~/Admin/Category.aspx">
            <i class="fas fa-tags"></i> Manage Categories
        </asp:LinkButton>
        <asp:LinkButton ID="btnViewCustomers" runat="server" CssClass="quick-action-btn" 
            PostBackUrl="~/Admin/Customer.aspx">
            <i class="fas fa-users"></i> View Customers
        </asp:LinkButton>
    </div>

    <!-- Statistics Cards Row -->
    <div class="row">
        <!-- Total Revenue -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card stat-card primary">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                Total Revenue</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                <asp:Label ID="lblTotalRevenue" runat="server" Text="$124,560.00"></asp:Label>
                            </div>
                            <div class="text-success mt-2">
                                <i class="fas fa-arrow-up"></i> 12.5% <span class="text-muted">vs last month</span>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Total Orders -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card stat-card success">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                Total Orders</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                <asp:Label ID="lblTotalOrders" runat="server" Text="2,345"></asp:Label>
                            </div>
                            <div class="text-success mt-2">
                                <i class="fas fa-arrow-up"></i> 8.2% <span class="text-muted">vs last month</span>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-shopping-cart fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Total Products -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card stat-card info">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                Total Products</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                <asp:Label ID="lblTotalProducts" runat="server" Text="1,234"></asp:Label>
                            </div>
                            <div class="row mt-2">
                                <div class="col-auto">
                                    <small class="text-success">Active: <asp:Label ID="lblActiveProducts" runat="server" Text="1,200"></asp:Label></small>
                                </div>
                                <div class="col-auto">
                                    <small class="text-warning">Low Stock: <asp:Label ID="lblLowStock" runat="server" Text="23"></asp:Label></small>
                                </div>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-boxes fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Total Customers -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card stat-card warning">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                Total Customers</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                <asp:Label ID="lblTotalCustomers" runat="server" Text="8,549"></asp:Label>
                            </div>
                            <div class="text-success mt-2">
                                <i class="fas fa-arrow-up"></i> 180 <span class="text-muted">new this month</span>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-users fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row -->
    <div class="row">
        <div class="col-lg-8">
            <div class="chart-container">
                <h5 class="mb-3">Revenue Overview <small class="text-muted">(Last 30 Days)</small></h5>
                <canvas id="revenueChart" style="height: 230px;"></canvas>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="chart-container">
                <h5 class="mb-3">Sales by Category</h5>
                <canvas id="categoryChart" style="height: 230px;"></canvas>
            </div>
        </div>
    </div>

    <!-- Filter Section -->
    

    <!-- Recent Orders Table -->
    <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex justify-content-between align-items-center">
            <h6 class="m-0 font-weight-bold text-primary">Recent Orders</h6>
            <div>
                <asp:TextBox ID="txtSearchOrder" runat="server" placeholder="Search orders..." 
                    CssClass="form-control form-control-sm d-inline-block" style="width: 200px;" />
              <%--  <asp:Button ID="btnSearchOrder" runat="server" Text="Search" 
                    CssClass="btn btn-sm btn-primary ml-2" OnClick="btnSearchOrder_Click" />--%>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="gvRecentOrders" runat="server" CssClass="table table-bordered recent-order-table" 
                    AutoGenerateColumns="False" AllowPaging="True" PageSize="10" 
                    OnPageIndexChanging="gvRecentOrders_PageIndexChanging"
                    OnRowCommand="gvRecentOrders_RowCommand"
                    EmptyDataText="No orders found.">
                    <Columns>
                        <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                        <asp:BoundField DataField="CustomerName" HeaderText="Customer" />
                        <asp:BoundField DataField="OrderDate" HeaderText="Date" DataFormatString="{0:MMM dd, yyyy}" />
                        <asp:BoundField DataField="TotalAmount" HeaderText="Amount" DataFormatString="{0:C}" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='badge-status badge-<%# Eval("Status").ToString().ToLower() %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnViewOrder" runat="server" CommandName="ViewOrder" 
                                    CommandArgument='<%# Eval("OrderID") %>' CssClass="btn btn-sm btn-info" 
                                    ToolTip="View Order">
                                    <i class="fas fa-eye"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnUpdateStatus" runat="server" CommandName="UpdateStatus" 
                                    CommandArgument='<%# Eval("OrderID") %>' CssClass="btn btn-sm btn-warning ml-1" 
                                    ToolTip="Update Status">
                                    <i class="fas fa-edit"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle CssClass="pagination-ys" />
                </asp:GridView>
            </div>
        </div>
    </div>

    <!-- Top Products Grid -->
    <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex justify-content-between align-items-center">
            <h6 class="m-0 font-weight-bold text-primary">Top Selling Products</h6>
            <asp:LinkButton ID="btnViewAllProducts" runat="server" CssClass="btn btn-sm btn-primary" 
                PostBackUrl="~/Admin/viewproduct.aspx">
                View All Products <i class="fas fa-arrow-right ml-1"></i>
            </asp:LinkButton>
        </div>
        <div class="card-body">
            <div class="product-grid">
                <asp:Repeater ID="rptTopProducts" runat="server">
                    <ItemTemplate>
                        <div class="product-card">
                            <div class="product-image">
                                <img src='<%# Eval("ImageURL") %>' alt='<%# Eval("ProductName") %>' />
                            </div>
                            <div class="product-details">
                                <div class="product-title"><%# Eval("ProductName") %></div>
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="product-price"><%# Eval("Price", "{0:C}") %></span>
                                   <%-- <span class='product-stock stock-<%# GetStockClass(Eval("Stock").ToString()) %>'--%>>
                                        <i class="fas fa-box"></i> <%# Eval("Stock") %> left
                                    </span>
                                </div>
                                <div class="text-warning mb-2">
                               <%--     <%# GenerateStarRating(Eval("Rating").ToString()) %>--%>
                                    <span class="text-muted ml-1">(<%# Eval("Reviews") %>)</span>
                                </div>
                                <div class="action-buttons">
                                   <%-- <asp:LinkButton ID="btnEditProduct" runat="server" CssClass="action-btn edit" 
                                        CommandArgument='<%# Eval("ProductID") %>' OnClick="btnEditProduct_Click">
                                        <i class="fas fa-edit"></i>
                                    </asp:LinkButton>--%>
                                    <%--<asp:LinkButton ID="btnViewProduct" runat="server" CssClass="action-btn" 
                                        CommandArgument='<%# Eval("ProductID") %>' OnClick="btnViewProduct_Click">
                                        <i class="fas fa-eye"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDeleteProduct" runat="server" CssClass="action-btn delete" 
                                        CommandArgument='<%# Eval("ProductID") %>' OnClick="btnDeleteProduct_Click"
                                        OnClientClick="return confirm('Are you sure you want to delete this product?');">
                                        <i class="fas fa-trash"></i>
                                    </asp:LinkButton>--%>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>

    <!-- Low Stock Alert -->
    <asp:Panel ID="pnlLowStockAlert" runat="server" CssClass="alert alert-warning alert-dismissible fade show" 
        role="alert" Visible="false">
        <strong><i class="fas fa-exclamation-triangle"></i> Low Stock Alert!</strong> 
        <asp:Label ID="lblLowStockAlert" runat="server" Text=""></asp:Label>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </asp:Panel>
    <!-- Recent Activities -->
<div class="row">
    <div class="col-lg-12 mb-4">
        <div class="card shadow">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Recent Activities</h6>
            </div>
            <div class="card-body">
                <div class="timeline">
                    <asp:Repeater ID="rptRecentActivities" runat="server">
                        <ItemTemplate>
                            <div class="timeline-item">
                                <div class="timeline-left">
                                    <i class="fas fa-circle text-primary"></i>
                                </div>
                                <div class="timeline-content">
                                    <div class="d-flex justify-content-between">
                                        <strong><%# Eval("UserName") %></strong>
                                        <small class="text-muted"><%# Convert.ToDateTime(Eval("created_at")).ToString("hh:mm tt") %></small>
                                    </div>
                                    <p class="mb-0"><%# Eval("action") %>: <%# Eval("description") %></p>
                                    <small class="text-muted"><%# Convert.ToDateTime(Eval("created_at")).ToString("MMM dd, yyyy") %></small>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Timeline CSS -->
<style>
    .timeline {
        position: relative;
        padding: 20px 0;
    }
    .timeline-item {
        display: flex;
        margin-bottom: 20px;
        position: relative;
    }
    .timeline-left {
        width: 30px;
        text-align: center;
        position: relative;
    }
    .timeline-left i {
        font-size: 12px;
        background: white;
        position: relative;
        z-index: 1;
    }
    .timeline-item:not(:last-child) .timeline-left:after {
        content: '';
        position: absolute;
        left: 50%;
        top: 15px;
        bottom: -15px;
        width: 2px;
        background: #e3e6f0;
        transform: translateX(-50%);
    }
    .timeline-content {
        flex: 1;
        padding-left: 15px;
        background: #f8f9fc;
        border-radius: 8px;
        padding: 10px 15px;
    }
</style>

<!-- Update the chart initialization script -->
<script>
    $(document).ready(function () {
        // Load revenue chart data
        $.ajax({
            type: "POST",
            url: "Dashboardaspx.aspx/GetChartData",
            data: JSON.stringify({ chartType: 'revenue' }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var data = JSON.parse(response.d);
                var ctx1 = document.getElementById('revenueChart').getContext('2d');
                var revenueChart = new Chart(ctx1, {
                    type: 'line',
                    data: {
                        labels: data.labels,
                        datasets: [{
                            label: 'Revenue',
                            data: data.data,
                            borderColor: '#4e73df',
                            backgroundColor: 'rgba(78, 115, 223, 0.05)',
                            tension: 0.3,
                            fill: true
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function (value) {
                                        return '$' + value;
                                    }
                                }
                            }
                        }
                    }
                });
            }
        });

        // Load category chart data
        $.ajax({
            type: "POST",
            url: "Dashboardaspx.aspx/GetChartData",
            data: JSON.stringify({ chartType: 'category' }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var data = JSON.parse(response.d);
                var ctx2 = document.getElementById('categoryChart').getContext('2d');
                var categoryChart = new Chart(ctx2, {
                    type: 'doughnut',
                    data: {
                        labels: data.labels,
                        datasets: [{
                            data: data.data,
                            backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b'],
                            hoverOffset: 4
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'bottom'
                            }
                        },
                        cutout: '70%'
                    }
                });
            }
        });
    });
</script>
    <!-- Include Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        $(document).ready(function() {
            // Revenue Chart
            var ctx1 = document.getElementById('revenueChart').getContext('2d');
            var revenueChart = new Chart(ctx1, {
            <%--    type: 'line',
                data: {
                    labels: <%= GetLast30DaysLabels() %>,
                    datasets: [{
                        label: 'Revenue',
                        data: <%= GetRevenueData() %>,
                        borderColor: '#4e73df',
                        backgroundColor: 'rgba(78, 115, 223, 0.05)',
                        tension: 0.3,
                        fill: true
                    }]
                },--%>
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return '$' + value;
                                }
                            }
                        }
                    }
                }
            });

            // Category Chart
            var ctx2 = document.getElementById('categoryChart').getContext('2d');
            var categoryChart = new Chart(ctx2, {
              <%--  type: 'doughnut',
                data: {
                    labels: <%= GetCategoryLabels() %>,
                    datasets: [{
                        data: <%= GetCategoryData() %>,
                        backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b'],
                        hoverOffset: 4
                    }]
                },--%>
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    },
                    cutout: '70%'
                }
            });
        });
    </script>
    <script type="text/javascript">
        function exportToExcel() {
            // Show loading indicator
            document.getElementById('exportLoader').style.display = 'inline-block';

            // Create a hidden form and submit it
            var form = document.createElement('form');
            form.method = 'post';
            form.action = 'Dashboardaspx.aspx/ExportToExcel';

            // Add viewstate if needed
            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = '__VIEWSTATE';
            input.value = document.getElementById('__VIEWSTATE').value;
            form.appendChild(input);

            document.body.appendChild(form);
            form.submit();
            document.body.removeChild(form);

            // Hide loader after a delay
            setTimeout(function () {
                document.getElementById('exportLoader').style.display = 'none';
            }, 3000);

            return false;
        }
    </script>

<!-- Add this loader style -->
<style>
    .export-loader {
        display: none;
        margin-left: 10px;
        color: #28a745;
    }
    .export-loader i {
        animation: spin 1s linear infinite;
    }
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
</style>
</asp:Content>
