<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBBMM0020</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBBMM0020</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  [MM] 인포레코드 업로드 프로그램</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Report ZBBMM0020</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&    [MM]</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&    개발자                : CL2 KDT-B-03 권민지</font>
<font color ="#0000FF">*&    프로그램 개요           : 인포레코드 업로드  프로그램</font>
<font color ="#0000FF">*&    개발 시작일            : '2024.10.31'</font>
<font color ="#0000FF">*&    개발 완료일            :'2024.11.11'</font>
<font color ="#0000FF">*&    개발 상태             : 개발완료.</font>
<font color ="#0000FF">*&    단위테스트 여부</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>

REPORT ZBBMM0020 MESSAGE-ID ZMSG_CLASS.


include <a href ="zbbmm0020_top.html">ZBBMM0020_TOP</a>.
include <a href ="zbbmm0020_s01.html">ZBBMM0020_S01</a>.
include <a href ="zbbmm0020_i01.html">ZBBMM0020_I01</a>.
include <a href ="zbbmm0020_o01.html">ZBBMM0020_O01</a>.
include <a href ="zbbmm0020_f01.html">ZBBMM0020_F01</a>.


INITIALIZATION. "FUCNTION KEY 최대 5개까지 설정 가능 FC01 FC02 ~~
  SSCRFIELDS-FUNCTXT_01 = ICON_XLS && '양식 다운로드'. "버튼 생성

"파일경로
AT SELECTION-SCREEN ON VALUE-REQUEST FOR PA_PATH.
   PERFORM GET_FILE_PATH.


 " '양식 다운로드' 버튼 눌렀을 때, EXCEL 파일 다운로드 후 실행.
AT SELECTION-SCREEN.
   CASE SSCRFIELDS-UCOMM.
   	WHEN 'FC01'.
       PERFORM DOWN_FILE.
   ENDCASE.


START-OF-SELECTION.
   PERFORM CHECK_EXCEL. "파일을 선택했는지 확인
   PERFORM UPLOAD_EXCEL. "엑셀 업로드
   CALL SCREEN 100.

<font color ="#0000FF">*GUI Texts</font>
<font color ="#0000FF">*----------------------------------------------------------</font>
<font color ="#0000FF">* T100 --&gt; Excel 데이터 확인</font>
<font color ="#0000FF">* T100 --&gt; Excel 데이터 확인</font>

<font color ="#0000FF">*Text elements</font>
<font color ="#0000FF">*----------------------------------------------------------</font>
<font color ="#0000FF">* T01 EXCEL 업로드</font>


<font color ="#0000FF">*Selection texts</font>
<font color ="#0000FF">*----------------------------------------------------------</font>
<font color ="#0000FF">* PA_PATH         파일 경로</font>


<font color ="#0000FF">*Messages</font>
<font color ="#0000FF">*----------------------------------------------------------</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">* Message class: ZMSG_CLASS</font>
<font color ="#0000FF">*000   업로드할 Excel 파일을 선택해주세요.</font>
<font color ="#0000FF">*002   Excel 양식을 성공적으로 다운로드 하였습니다.</font>
<font color ="#0000FF">*003   해당 파일을 찾지 못했습니다.</font>
<font color ="#0000FF">*005   Excel 업로드를 실패했습니다.</font>
<font color ="#0000FF">*006   Excel 데이터를 성공적으로 저장했습니다.</font>
<font color ="#0000FF">*007   Excel 데이터를 저장하지 못했습니다.</font>
<font color ="#0000FF">*029</font>
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
