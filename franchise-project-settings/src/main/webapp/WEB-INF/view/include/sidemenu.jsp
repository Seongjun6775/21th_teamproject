<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <!-- sidebar -->
  <div class="flex-shrink-0 p-3 bg-dark bg-opacity-75" style="width: 230px; position: fixed;top: 0;bottom: 0;">
    <a href="/" class="d-flex align-items-center pb-3 mb-3 link-body-emphasis text-decoration-none border-bottom">
      <svg class="bi pe-none me-2" width="30" height="24"><use xlink:href="#bootstrap"/></svg>
      <span class="text-light fs-5 fw-semibold">프렌차이즈</span>
    </a>
    <ul class="list-unstyled ps-0">
      <li class="mb-1">
        <button class="text-light btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="true">
          회원
        </button>
        <div class="collapse show" id="home-collapse">
          <ul class="text-light btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li class="rounded"><a href="#" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">회원관리</a></li>
            <li class="rounded"><a href="#" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">쪽지관리</a></li>
            <li class="rounded"><a href="#" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">주문목록</a></li>
          </ul>
        </div>
      </li>
      <li class="border-top my-3"></li>
      <li class="mb-1">
        <button class="text-light btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="false">
          매장
        </button>
        <div class="collapse" id="dashboard-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li class="rounded"><a href="#" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">매장관리</a></li>
            <li class="rounded"><a href="#" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">메뉴관리</a></li>
            <li class="rounded"><a href="#" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">이벤트관리</a></li>
            <li class="rounded"><a href="#" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">리뷰관리</a></li>
          </ul>
        </div>
      </li>
      <li class="mb-1">
        <button class="text-light btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#orders-collapse" aria-expanded="false">
          게시판
        </button>
        <div class="collapse" id="orders-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li class="rounded"><a href="#" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">관리자게시판</a></li>
            <li class="rounded"><a href="#" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">댓글관리</a></li>
          </ul>
        </div>
      </li>
      <li class="border-top my-3"></li>
      <li class="mb-1">
        <button class="text-light btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#account-collapse" aria-expanded="false">
          Account
        </button>
        <div class="collapse" id="account-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li><a href="#" class="text-light link-dark d-inline-flex text-decoration-none rounded">New...</a></li>
            <li><a href="#" class="text-light link-dark d-inline-flex text-decoration-none rounded">Profile</a></li>
            <li><a href="#" class="text-light link-dark d-inline-flex text-decoration-none rounded">Settings</a></li>
            <li><a href="#" class="text-light link-dark d-inline-flex text-decoration-none rounded">Sign out</a></li>
          </ul>
        </div>
      </li>
    </ul>
  </div>
  <!-- /sidebar -->
