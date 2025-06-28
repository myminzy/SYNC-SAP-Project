<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBRMM0030</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBRMM0030</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  [MM] 구매오더 생성 프로그램</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Report ZBRMM0030</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&    [MM]</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&    개발자                : CL2 KDT-B-03 권민지</font>
<font color ="#0000FF">*&    프로그램 개요           : 구매오더 생성 프로그램</font>
<font color ="#0000FF">*&    개발 시작일            : '2024.11.12'</font>
<font color ="#0000FF">*&    개발 완료일            : '2024.11.18'</font>
<font color ="#0000FF">*&    개발 상태             : 개발완료</font>
<font color ="#0000FF">*&    단위테스트 여부</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
REPORT ZBRMM0030.

include <a href ="zbrmm0030_top.html">ZBRMM0030_TOP</a>.
include <a href ="zbrmm0030_s01.html">ZBRMM0030_S01</a>.
<font color ="#0000FF">*INCLUDE ZBRMM0030_C01.</font>
include <a href ="zbrmm0030_o01.html">ZBRMM0030_O01</a>.
include <a href ="zbrmm0030_i01.html">ZBRMM0030_I01</a>.
include <a href ="zbrmm0030_f01.html">ZBRMM0030_F01</a>.


INITIALIZATION.

START-OF-SELECTION.
  PERFORM ZBMM_ALV_DATA.

  CALL SCREEN 100.

<font color ="#0000FF">*GUI Texts</font>
<font color ="#0000FF">*----------------------------------------------------------</font>
<font color ="#0000FF">* T100 --&gt; [MM] 구매오더 생성 프로그램</font>
<font color ="#0000FF">* T200 --&gt; 구매오더 생성 화면</font>
<font color ="#0000FF">* T100 --&gt; [MM] 구매오더 생성 프로그램</font>
<font color ="#0000FF">* T200 --&gt; 구매오더 생성 화면</font>


<font color ="#0000FF">*Selection texts</font>
<font color ="#0000FF">*----------------------------------------------------------</font>
<font color ="#0000FF">* PR_NUM         구매요청번호</font>
<font color ="#0000FF">* SO_DAT         구매요청일</font>


<font color ="#0000FF">*Messages</font>
<font color ="#0000FF">*----------------------------------------------------------</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">* Message class: ZCOMMON_MSG</font>
<font color ="#0000FF">*015   조회 조건에 일치하는 데이터가 없습니다.</font>
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
