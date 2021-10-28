<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Bảng điều khiển</title>

<!-- Jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- Bs 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<!-- Jquery validation -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"
	integrity="sha512-37T7leoNS06R80c8Ulq7cdCDU5MNQBwlYoy1TX/WUsLFC2eYNqtKlV0QjH7r8JpG/S0GUMZwebnVFLPd6SU5yg=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- Jquery additional methods -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/additional-methods.min.js"
	integrity="sha512-XZEy8UQ9rngkxQVugAdOuBRDmJ5N4vCuNXCh8KlniZgDKTvf7zl75QBtaVG1lEhMFe2a2DuA22nZYY+qsI2/xA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<link rel="stylesheet" href="${base}/css/common/utils.css">
<link rel="stylesheet" href="${base}/css/admin/lib/adminSidebar.css">
<link rel="stylesheet" href="${base}/css/admin/dashboard/style.css">
<script defer src="${base}/js/common/utils.js"></script>
<script defer src="${base}/js/admin/lib/adminSidebar.js"></script>
<script defer src="${base}/js/admin/dashboard/main.js"></script>


</head>
<body>

	<div id="app">
		<!-- sidebar and logo top -->
		<jsp:include page="/WEB-INF/views/admin/fragment/sidebar.jsp"></jsp:include>

		<main class="content">
			<div class="body flex-grow-1 px-3 mt-5">
				<div class="container-lg">
					<div class="row">
						<div class="col-sm-6 col-lg-3">
							<div class="card mb-4 text-white bg-primary-gradient" style="background: var(--secondary-color)">
								<div
									class="card-body pb-0 d-flex justify-content-between align-items-start">
									<div>
										<div class="fs-4 fw-semibold">
											26K <span class="fs-6 fw-normal">(-12.4% <svg
													class="icon">
<use xlink:href="vendors/@coreui/icons/svg/free.svg#cil-arrow-bottom"></use>
</svg>)
											</span>
										</div>
										<div>Users</div>
									</div>
									<div class="dropdown">
										<button class="btn btn-transparent text-white p-0"
											type="button" data-coreui-toggle="dropdown"
											aria-haspopup="true" aria-expanded="false">
											<svg class="icon">
<use xlink:href="vendors/@coreui/icons/svg/free.svg#cil-options"></use>
</svg>
										</button>
										<div class="dropdown-menu dropdown-menu-end">
											<a class="dropdown-item" href="#">Action</a><a
												class="dropdown-item" href="#">Another action</a><a
												class="dropdown-item" href="#">Something else here</a>
										</div>
									</div>
								</div>
								<div class="c-chart-wrapper mt-3 mx-3" style="height: 70px;">
									<canvas class="chart" id="card-chart1" height="70" width="189"
										style="display: block; box-sizing: border-box; height: 70px; width: 189px;"></canvas>
									<div class="chartjs-tooltip"
										style="opacity: 0; left: 241px; top: 129.847px;">
										<table style="margin: 0px;">
											<thead class="chartjs-tooltip-header">
												<tr class="chartjs-tooltip-header-item"
													style="border-width: 0px;">
													<th style="border-width: 0px;">June</th>
												</tr>
											</thead>
											<tbody class="chartjs-tooltip-body">
												<tr class="chartjs-tooltip-body-item">
													<td style="border-width: 0px;"><span
														style="background: rgb(50, 31, 219); border-color: rgba(255, 255, 255, 0.55); border-width: 2px; margin-right: 10px; height: 10px; width: 10px; display: inline-block;"></span>My
														First dataset: 55</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

						<div class="col-sm-6 col-lg-3">
							<div class="card mb-4 text-white bg-info-gradient" style="background: var(--tertiary-color)">
								<div
									class="card-body pb-0 d-flex justify-content-between align-items-start">
									<div>
										<div class="fs-4 fw-semibold">
											$6.200 <span class="fs-6 fw-normal">(40.9% <svg
													class="icon">
<use xlink:href="vendors/@coreui/icons/svg/free.svg#cil-arrow-top"></use>
</svg>)
											</span>
										</div>
										<div>Income</div>
									</div>
									<div class="dropdown">
										<button class="btn btn-transparent text-white p-0"
											type="button" data-coreui-toggle="dropdown"
											aria-haspopup="true" aria-expanded="false">
											<svg class="icon">
<use xlink:href="vendors/@coreui/icons/svg/free.svg#cil-options"></use>
</svg>
										</button>
										<div class="dropdown-menu dropdown-menu-end">
											<a class="dropdown-item" href="#">Action</a><a
												class="dropdown-item" href="#">Another action</a><a
												class="dropdown-item" href="#">Something else here</a>
										</div>
									</div>
								</div>
								<div class="c-chart-wrapper mt-3 mx-3" style="height: 70px;">
									<canvas class="chart" id="card-chart2" height="70" width="189"
										style="display: block; box-sizing: border-box; height: 70px; width: 189px;"></canvas>
									<div class="chartjs-tooltip"
										style="opacity: 0; left: 285px; top: 130.25px;">
										<table style="margin: 0px;">
											<thead class="chartjs-tooltip-header">
												<tr class="chartjs-tooltip-header-item"
													style="border-width: 0px;">
													<th style="border-width: 0px;">July</th>
												</tr>
											</thead>
											<tbody class="chartjs-tooltip-body">
												<tr class="chartjs-tooltip-body-item">
													<td style="border-width: 0px;"><span
														style="background: rgb(51, 153, 255); border-color: rgba(255, 255, 255, 0.55); border-width: 2px; margin-right: 10px; height: 10px; width: 10px; display: inline-block;"></span>My
														First dataset: 11</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

						<div class="col-sm-6 col-lg-3">
							<div class="card mb-4 text-white bg-warning-gradient bg-warning">
								<div
									class="card-body pb-0 d-flex justify-content-between align-items-start">
									<div>
										<div class="fs-4 fw-semibold">
											2.49% <span class="fs-6 fw-normal">(84.7% <svg
													class="icon">
<use xlink:href="vendors/@coreui/icons/svg/free.svg#cil-arrow-top"></use>
</svg>)
											</span>
										</div>
										<div>Conversion Rate</div>
									</div>
									<div class="dropdown">
										<button class="btn btn-transparent text-white p-0"
											type="button" data-coreui-toggle="dropdown"
											aria-haspopup="true" aria-expanded="false">
											<svg class="icon">
<use xlink:href="vendors/@coreui/icons/svg/free.svg#cil-options"></use>
</svg>
										</button>
										<div class="dropdown-menu dropdown-menu-end">
											<a class="dropdown-item" href="#">Action</a><a
												class="dropdown-item" href="#">Another action</a><a
												class="dropdown-item" href="#">Something else here</a>
										</div>
									</div>
								</div>
								<div class="c-chart-wrapper mt-3" style="height: 70px;">
									<canvas class="chart" id="card-chart3" height="70" width="221"
										style="display: block; box-sizing: border-box; height: 70px; width: 221px;"></canvas>
									<div class="chartjs-tooltip"
										style="opacity: 0; left: 0px; top: 107.4px;">
										<table style="margin: 0px;">
											<thead class="chartjs-tooltip-header">
												<tr class="chartjs-tooltip-header-item"
													style="border-width: 0px;">
													<th style="border-width: 0px;">Today</th>
												</tr>
											</thead>
											<tbody class="chartjs-tooltip-body">
												<tr class="chartjs-tooltip-body-item">
													<td style="border-width: 0px;"><span
														style="background: rgba(255, 255, 255, 0.2); border-color: rgba(255, 255, 255, 0.55); border-width: 2px; margin-right: 10px; height: 10px; width: 10px; display: inline-block;"></span>My
														First dataset: 78</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

						<div class="col-sm-6 col-lg-3">
							<div class="card mb-4 text-white bg-danger-gradient" style="background: var(--primary-color)">
								<div
									class="card-body pb-0 d-flex justify-content-between align-items-start">
									<div>
										<div class="fs-4 fw-semibold">
											44K <span class="fs-6 fw-normal">(-23.6% <svg
													class="icon">
<use xlink:href="vendors/@coreui/icons/svg/free.svg#cil-arrow-bottom"></use>
</svg>)
											</span>
										</div>
										<div>Sessions</div>
									</div>
									<div class="dropdown">
										<button class="btn btn-transparent text-white p-0"
											type="button" data-coreui-toggle="dropdown"
											aria-haspopup="true" aria-expanded="false">
											<svg class="icon">
<use xlink:href="vendors/@coreui/icons/svg/free.svg#cil-options"></use>
</svg>
										</button>
										<div class="dropdown-menu dropdown-menu-end">
											<a class="dropdown-item" href="#">Action</a><a
												class="dropdown-item" href="#">Another action</a><a
												class="dropdown-item" href="#">Something else here</a>
										</div>
									</div>
								</div>
								<div class="c-chart-wrapper mt-3 mx-3" style="height: 70px;">
									<canvas class="chart" id="card-chart4" height="70" width="189"
										style="display: block; box-sizing: border-box; height: 70px; width: 189px;"></canvas>
								</div>
							</div>
						</div>

					</div>

					<div class="card mb-4">
						<div class="card-body" style="background: var(--quaternary-color)">
							<div class="d-flex justify-content-between">
								<div>
									<h4 class="card-title mb-0">Traffic</h4>
									<div class="small text-medium-emphasis">Today</div>
								</div>
								<div class="btn-toolbar d-none d-md-block" role="toolbar"
									aria-label="Toolbar with buttons">
									<div class="btn-group btn-group-toggle mx-3"
										data-coreui-toggle="buttons">
										<input class="btn-check" id="option1" type="radio"
											name="options" autocomplete="off"> <label
											class="btn btn-outline-secondary"> Day</label> <input
											class="btn-check" id="option2" type="radio" name="options"
											autocomplete="off" checked=""> <label
											class="btn btn-outline-secondary active"> Month</label> <input
											class="btn-check" id="option3" type="radio" name="options"
											autocomplete="off"> <label
											class="btn btn-outline-secondary"> Year</label>
									</div>
									<button class="btn btn-primary" type="button">
										<svg class="icon">
<use xlink:href="vendors/@coreui/icons/svg/free.svg#cil-cloud-download"></use>
</svg>
									</button>
								</div>
							</div>
							<div class="c-chart-wrapper"
								style="height: 300px; margin-top: 40px;">
								<canvas class="chart" id="main-chart" height="300" width="924"
									style="display: block; box-sizing: border-box; height: 300px; width: 924px;"></canvas>
							</div>
						</div>
						<div class="card-footer">
							<div class="row row-cols-1 row-cols-md-5 text-center">
								<div class="col mb-sm-2 mb-0">
									<div class="text-medium-emphasis">Visits</div>
									<div class="fw-semibold">29.703 Users (40%)</div>
									<div class="progress progress-thin mt-2">
										<div class="progress-bar bg-success-gradient"
											role="progressbar" style="width: 40%" aria-valuenow="40"
											aria-valuemin="0" aria-valuemax="100"></div>
									</div>
								</div>
								<div class="col mb-sm-2 mb-0">
									<div class="text-medium-emphasis">Unique</div>
									<div class="fw-semibold">24.093 Users (20%)</div>
									<div class="progress progress-thin mt-2">
										<div class="progress-bar bg-info-gradient" role="progressbar"
											style="width: 20%" aria-valuenow="20" aria-valuemin="0"
											aria-valuemax="100"></div>
									</div>
								</div>
								<div class="col mb-sm-2 mb-0">
									<div class="text-medium-emphasis">Pageviews</div>
									<div class="fw-semibold">78.706 Views (60%)</div>
									<div class="progress progress-thin mt-2">
										<div class="progress-bar bg-warning-gradient"
											role="progressbar" style="width: 60%" aria-valuenow="60"
											aria-valuemin="0" aria-valuemax="100"></div>
									</div>
								</div>
								<div class="col mb-sm-2 mb-0">
									<div class="text-medium-emphasis">New Users</div>
									<div class="fw-semibold">22.123 Users (80%)</div>
									<div class="progress progress-thin mt-2">
										<div class="progress-bar bg-danger-gradient"
											role="progressbar" style="width: 80%" aria-valuenow="80"
											aria-valuemin="0" aria-valuemax="100"></div>
									</div>
								</div>
								<div class="col mb-sm-2 mb-0">
									<div class="text-medium-emphasis">Bounce Rate</div>
									<div class="fw-semibold">40.15%</div>
									<div class="progress progress-thin mt-2">
										<div class="progress-bar" role="progressbar"
											style="width: 40%" aria-valuenow="40" aria-valuemin="0"
											aria-valuemax="100"></div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-6 col-lg-4">
							<div class="card mb-4" style="-cui-card-cap-bg: #3b5998">
								<div
									class="card-header position-relative d-flex justify-content-center align-items-center">
									<svg class="icon text-white my-4"
										style="height: 3rem; width: 3rem;">
<use xlink:href="vendors/@coreui/icons/svg/brand.svg#cib-facebook-f"></use>
</svg>
									<div
										class="chart-wrapper position-absolute top-0 start-0 w-100 h-100">
										<canvas id="social-box-chart-1" height="90"></canvas>
									</div>
								</div>
								<div class="card-body row text-center">
									<div class="col">
										<div class="fs-5 fw-semibold">89k</div>
										<div class="text-uppercase text-medium-emphasis small">friends</div>
									</div>
									<div class="vr"></div>
									<div class="col">
										<div class="fs-5 fw-semibold">459</div>
										<div class="text-uppercase text-medium-emphasis small">feeds</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-sm-6 col-lg-4">
							<div class="card mb-4" style="-cui-card-cap-bg: #00aced">
								<div
									class="card-header position-relative d-flex justify-content-center align-items-center">
									<svg class="icon text-white my-4"
										style="height: 3rem; width: 3rem;">
<use xlink:href="vendors/@coreui/icons/svg/brand.svg#cib-twitter"></use>
</svg>
									<div
										class="chart-wrapper position-absolute top-0 start-0 w-100 h-100">
										<canvas id="social-box-chart-2" height="90"></canvas>
									</div>
								</div>
								<div class="card-body row text-center">
									<div class="col">
										<div class="fs-5 fw-semibold">973k</div>
										<div class="text-uppercase text-medium-emphasis small">followers</div>
									</div>
									<div class="vr"></div>
									<div class="col">
										<div class="fs-5 fw-semibold">1.792</div>
										<div class="text-uppercase text-medium-emphasis small">tweets</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-sm-6 col-lg-4">
							<div class="card mb-4" style="-cui-card-cap-bg: #4875b4">
								<div
									class="card-header position-relative d-flex justify-content-center align-items-center">
									<svg class="icon text-white my-4"
										style="height: 3rem; width: 3rem;">
<use xlink:href="vendors/@coreui/icons/svg/brand.svg#cib-linkedin"></use>
</svg>
									<div
										class="chart-wrapper position-absolute top-0 start-0 w-100 h-100">
										<canvas id="social-box-chart-3" height="90"></canvas>
									</div>
								</div>
								<div class="card-body row text-center">
									<div class="col">
										<div class="fs-5 fw-semibold">500+</div>
										<div class="text-uppercase text-medium-emphasis small">contacts</div>
									</div>
									<div class="vr"></div>
									<div class="col">
										<div class="fs-5 fw-semibold">292</div>
										<div class="text-uppercase text-medium-emphasis small">feeds</div>
									</div>
								</div>
							</div>
						</div>

					</div>

					<div class="row">
						<div class="col-md-12">
							<div class="card mb-4">
								<div class="card-header">Traffic &amp; Sales</div>
								<div class="card-body">
									<div class="row">
										<div class="col-sm-6">
											<div class="row">
												<div class="col-6">
													<div
														class="border-start border-start-4 border-start-info px-3 mb-3">
														<small class="text-medium-emphasis">New Clients</small>
														<div class="fs-5 fw-semibold">9,123</div>
													</div>
												</div>

												<div class="col-6">
													<div
														class="border-start border-start-4 border-start-danger px-3 mb-3">
														<small class="text-medium-emphasis">Recuring
															Clients</small>
														<div class="fs-5 fw-semibold">22,643</div>
													</div>
												</div>

											</div>

											<hr class="mt-0">
											<div class="progress-group mb-4">
												<div class="progress-group-prepend">
													<span class="text-medium-emphasis small">Monday</span>
												</div>
												<div class="progress-group-bars">
													<div class="progress progress-thin">
														<div class="progress-bar bg-info-gradient"
															role="progressbar" style="width: 34%" aria-valuenow="34"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
													<div class="progress progress-thin">
														<div class="progress-bar bg-danger-gradient"
															role="progressbar" style="width: 78%" aria-valuenow="78"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
											<div class="progress-group mb-4">
												<div class="progress-group-prepend">
													<span class="text-medium-emphasis small">Tuesday</span>
												</div>
												<div class="progress-group-bars">
													<div class="progress progress-thin">
														<div class="progress-bar bg-info-gradient"
															role="progressbar" style="width: 56%" aria-valuenow="56"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
													<div class="progress progress-thin">
														<div class="progress-bar bg-danger-gradient"
															role="progressbar" style="width: 94%" aria-valuenow="94"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
											<div class="progress-group mb-4">
												<div class="progress-group-prepend">
													<span class="text-medium-emphasis small">Wednesday</span>
												</div>
												<div class="progress-group-bars">
													<div class="progress progress-thin">
														<div class="progress-bar bg-info-gradient"
															role="progressbar" style="width: 12%" aria-valuenow="12"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
													<div class="progress progress-thin">
														<div class="progress-bar bg-danger-gradient"
															role="progressbar" style="width: 67%" aria-valuenow="67"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
											<div class="progress-group mb-4">
												<div class="progress-group-prepend">
													<span class="text-medium-emphasis small">Thursday</span>
												</div>
												<div class="progress-group-bars">
													<div class="progress progress-thin">
														<div class="progress-bar bg-info-gradient"
															role="progressbar" style="width: 43%" aria-valuenow="43"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
													<div class="progress progress-thin">
														<div class="progress-bar bg-danger-gradient"
															role="progressbar" style="width: 91%" aria-valuenow="91"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
											<div class="progress-group mb-4">
												<div class="progress-group-prepend">
													<span class="text-medium-emphasis small">Friday</span>
												</div>
												<div class="progress-group-bars">
													<div class="progress progress-thin">
														<div class="progress-bar bg-info-gradient"
															role="progressbar" style="width: 22%" aria-valuenow="22"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
													<div class="progress progress-thin">
														<div class="progress-bar bg-danger-gradient"
															role="progressbar" style="width: 73%" aria-valuenow="73"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
											<div class="progress-group mb-4">
												<div class="progress-group-prepend">
													<span class="text-medium-emphasis small">Saturday</span>
												</div>
												<div class="progress-group-bars">
													<div class="progress progress-thin">
														<div class="progress-bar bg-info-gradient"
															role="progressbar" style="width: 53%" aria-valuenow="53"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
													<div class="progress progress-thin">
														<div class="progress-bar bg-danger-gradient"
															role="progressbar" style="width: 82%" aria-valuenow="82"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
											<div class="progress-group mb-4">
												<div class="progress-group-prepend">
													<span class="text-medium-emphasis small">Sunday</span>
												</div>
												<div class="progress-group-bars">
													<div class="progress progress-thin">
														<div class="progress-bar bg-info-gradient"
															role="progressbar" style="width: 9%" aria-valuenow="9"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
													<div class="progress progress-thin">
														<div class="progress-bar bg-danger-gradient"
															role="progressbar" style="width: 69%" aria-valuenow="69"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
										</div>

										<div class="col-sm-6">
											<div class="row">
												<div class="col-6">
													<div
														class="border-start border-start-4 border-start-warning px-3 mb-3">
														<small class="text-medium-emphasis">Pageviews</small>
														<div class="fs-5 fw-semibold">78,623</div>
													</div>
												</div>

												<div class="col-6">
													<div
														class="border-start border-start-4 border-start-success px-3 mb-3">
														<small class="text-medium-emphasis">Organic</small>
														<div class="fs-5 fw-semibold">49,123</div>
													</div>
												</div>

											</div>

											<hr class="mt-0">
											<div class="progress-group">
												<div class="progress-group-header">
													<svg class="icon icon-lg me-2">
<use xlink:href="vendors/@coreui/icons/svg/free.svg#cil-user"></use>
</svg>
													<div>Male</div>
													<div class="ms-auto fw-semibold">43%</div>
												</div>
												<div class="progress-group-bars">
													<div class="progress progress-thin">
														<div class="progress-bar bg-warning-gradient"
															role="progressbar" style="width: 43%" aria-valuenow="43"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
											<div class="progress-group mb-5">
												<div class="progress-group-header">
													<svg class="icon icon-lg me-2">
<use xlink:href="vendors/@coreui/icons/svg/free.svg#cil-user-female"></use>
</svg>
													<div>Female</div>
													<div class="ms-auto fw-semibold">37%</div>
												</div>
												<div class="progress-group-bars">
													<div class="progress progress-thin">
														<div class="progress-bar bg-warning-gradient"
															role="progressbar" style="width: 43%" aria-valuenow="43"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
											<div class="progress-group">
												<div class="progress-group-header">
													<svg class="icon icon-lg me-2">
<use xlink:href="vendors/@coreui/icons/svg/brand.svg#cib-google"></use>
</svg>
													<div>Organic Search</div>
													<div class="ms-auto fw-semibold me-2">191.235</div>
													<div class="text-medium-emphasis small">(56%)</div>
												</div>
												<div class="progress-group-bars">
													<div class="progress progress-thin">
														<div class="progress-bar bg-success-gradient"
															role="progressbar" style="width: 56%" aria-valuenow="56"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
											<div class="progress-group">
												<div class="progress-group-header">
													<svg class="icon icon-lg me-2">
<use xlink:href="vendors/@coreui/icons/svg/brand.svg#cib-facebook-f"></use>
</svg>
													<div>Facebook</div>
													<div class="ms-auto fw-semibold me-2">51.223</div>
													<div class="text-medium-emphasis small">(15%)</div>
												</div>
												<div class="progress-group-bars">
													<div class="progress progress-thin">
														<div class="progress-bar bg-success-gradient"
															role="progressbar" style="width: 15%" aria-valuenow="15"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
											<div class="progress-group">
												<div class="progress-group-header">
													<svg class="icon icon-lg me-2">
<use xlink:href="vendors/@coreui/icons/svg/brand.svg#cib-twitter"></use>
</svg>
													<div>Twitter</div>
													<div class="ms-auto fw-semibold me-2">37.564</div>
													<div class="text-medium-emphasis small">(11%)</div>
												</div>
												<div class="progress-group-bars">
													<div class="progress progress-thin">
														<div class="progress-bar bg-success-gradient"
															role="progressbar" style="width: 11%" aria-valuenow="11"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
											<div class="progress-group">
												<div class="progress-group-header">
													<svg class="icon icon-lg me-2">
<use xlink:href="vendors/@coreui/icons/svg/brand.svg#cib-linkedin"></use>
</svg>
													<div>LinkedIn</div>
													<div class="ms-auto fw-semibold me-2">27.319</div>
													<div class="text-medium-emphasis small">(8%)</div>
												</div>
												<div class="progress-group-bars">
													<div class="progress progress-thin">
														<div class="progress-bar bg-success-gradient"
															role="progressbar" style="width: 8%" aria-valuenow="8"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
										</div>

									</div>
								</div>
							</div>
						</div>

					</div>

				</div>
			</div>
		</main>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
</body>