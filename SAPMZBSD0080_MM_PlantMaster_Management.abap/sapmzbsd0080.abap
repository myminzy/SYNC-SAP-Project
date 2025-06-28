<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>SAPMZBSD0080</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: SAPMZBSD0080</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  플랜트 MASTER 관리 프로그램 - CRUD</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module Pool      SAPMZBSD0080</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&    [공통]</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&    개발자                : CL2 kdt-b-03 권민지</font>
<font color ="#0000FF">*&    프로그램 개요           : 플랜트 MASTER 관리 프로그램</font>
<font color ="#0000FF">*&    개발 시작일            : '2024.10.24'</font>
<font color ="#0000FF">*&    개발 완료일            : '2024.10.28'</font>
<font color ="#0000FF">*&    개발 상태             : 개발완료</font>
<font color ="#0000FF">*&    단위테스트 여부</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>

include <a href ="mzbsd0080_top.html">MZBSD0080_TOP</a>.    " Global Data
include <a href ="mzbsd0080_c01.html">MZBSD0080_C01</a>.
include <a href ="mzbsd0080_o01.html">MZBSD0080_O01</a>.  " PBO-Modules
include <a href ="mzbsd0080_i01.html">MZBSD0080_I01</a>.  " PAI-Modules
include <a href ="mzbsd0080_f01.html">MZBSD0080_F01</a>.  " FORM-Routines

<font color ="#0000FF">*GUI Texts</font>
<font color ="#0000FF">*----------------------------------------------------------</font>
<font color ="#0000FF">* T100 --&gt; 플랜트 MASTER 관리 프로그램</font>
<font color ="#0000FF">* T110 --&gt; 플랜트 MASTER 데이터 생성</font>
<font color ="#0000FF">* T120 --&gt; 플랜트 MASTER 데이터 수정</font>
<font color ="#0000FF">* T130 --&gt; 사원 정보</font>


<font color ="#0000FF">*Messages</font>
<font color ="#0000FF">*----------------------------------------------------------</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">* Message class: ZCOMMON_MSG</font>
<font color ="#0000FF">*001   데이터가 성공적으로 생성되었습니다.</font>
<font color ="#0000FF">*007   데이터 삭제 오류가 발생했습니다.</font>
<font color ="#0000FF">*008   행을 먼저 선택해주세요!</font>
<font color ="#0000FF">*010   데이터 생성 실패하였습니다.</font>
<font color ="#0000FF">*011   데이터가 성공적으로 수정되었습니다.</font>
<font color ="#0000FF">*012   데이터 수정 실패하였습니다.</font>
<font color ="#0000FF">*013   데이터가 성공적으로 삭제되었습니다.</font>
<font color ="#0000FF">*014   이미 삭제된 데이터입니다.</font>
<font color ="#0000FF">*015   조회 조건에 일치하는 데이터가 없습니다.</font>
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
