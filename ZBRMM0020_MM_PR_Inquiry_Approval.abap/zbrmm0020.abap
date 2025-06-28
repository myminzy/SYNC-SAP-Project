<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBRMM0020</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBRMM0020</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  [MM] 구매요청 조회 및 승인 프로그램</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Report ZBRMM0020</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&    [MM]</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&    개발자                : CL2 KDT-B-03 권민지</font>
<font color ="#0000FF">*&    프로그램 개요           : 구매요청 조회 및 승인 프로그램</font>
<font color ="#0000FF">*&    개발 시작일            : '2024.10.31'</font>
<font color ="#0000FF">*&    개발 완료일            :'2024.11.11'</font>
<font color ="#0000FF">*&    개발 상태             : 개발완료.</font>
<font color ="#0000FF">*&    단위테스트 여부</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>

REPORT ZBRMM0020.

"선언
include <a href ="zbrmm0020_top.html">ZBRMM0020_TOP</a>.  "데이터선언부
include <a href ="zbrmm0020_s01.html">ZBRMM0020_S01</a>.  "SCREEN 화면
include <a href ="zbrmm0020_c01.html">ZBRMM0020_C01</a>.  "CLASS

"구현
include <a href ="zbrmm0020_o01.html">ZBRMM0020_O01</a>.  "PBO
include <a href ="zbrmm0020_i01.html">ZBRMM0020_I01</a>.  "PAI
include <a href ="zbrmm0020_f01.html">ZBRMM0020_F01</a>.  "SUB-Routine

<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
 INITIALIZATION.        "프로그램 실행 시 가장 먼저 실행되는 이벤트 구간
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*  PERFORM ZBMM_SET_INIT.</font>

<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
  START-OF-SELECTION.   " 데이터 조회 및 검색 결과에 대한 출력
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
    PERFORM ZBMM_ALL_DATA.
    CALL SCREEN 100.

<font color ="#0000FF">*GUI Texts</font>
<font color ="#0000FF">*----------------------------------------------------------</font>
<font color ="#0000FF">* T100 --&gt; [MM] 구매요청 조회 및 승인 프로그램</font>
<font color ="#0000FF">* T120 --&gt; 구매요청 결재 팝업창</font>
<font color ="#0000FF">* T130 --&gt; 결재 담당자 정보</font>
<font color ="#0000FF">* T100 --&gt; [MM] 구매요청 조회 및 승인 프로그램</font>
<font color ="#0000FF">* T120 --&gt; 구매요청 결재 팝업창</font>
<font color ="#0000FF">* T130 --&gt; 결재 담당자 정보</font>


<font color ="#0000FF">*Selection texts</font>
<font color ="#0000FF">*----------------------------------------------------------</font>
<font color ="#0000FF">* PA_NUM         구매요청번호</font>
<font color ="#0000FF">* SO_DAT         구매요청일</font>


<font color ="#0000FF">*Messages</font>
<font color ="#0000FF">*----------------------------------------------------------</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">* Message class: ZCOMMON_MSG</font>
<font color ="#0000FF">*008   행을 먼저 선택해주세요!</font>
<font color ="#0000FF">*015   조회 조건에 일치하는 데이터가 없습니다.</font>
<font color ="#0000FF">*037   구매요청이 성공적으로 승인되었습니다.</font>
<font color ="#0000FF">*038   이미 구매 요청이 반려된 건입니다.</font>
<font color ="#0000FF">*039   이미 구매 요청이 완료된 건입니다.</font>
<font color ="#0000FF">*040   반려 사유를 작성해주세요.</font>
<font color ="#0000FF">*041   구매요청이 반려 되었습니다.</font>
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
