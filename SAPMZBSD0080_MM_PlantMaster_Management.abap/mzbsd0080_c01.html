<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>MZBSD0080_C01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: MZBSD0080_C01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include MZBSD0080_C01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          MZBSD0080_C01</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*SET HANDLER 꼭 해주기</font>
CLASS LCL_EVENT_HANDLER DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      ON_HOTSPOT_CLICK FOR EVENT HOTSPOT_CLICK OF CL_GUI_ALV_GRID
        IMPORTING ES_ROW_NO E_COLUMN_ID." 클릭한 셀이 몇번째 로우인지 알려주는 거
ENDCLASS.

CLASS LCL_EVENT_HANDLER IMPLEMENTATION.

  METHOD ON_HOTSPOT_CLICK.

    "ALV에서 선택한 정보를 WORK AREA에 할당.
    READ TABLE GT_ZTBMM1020 INTO GS_ZTBMM1020 INDEX ES_ROW_NO-ROW_ID.
    "이테이블의 ROW ID에 몇번째 줄에 해당하는 데이터를 GS에 넣는다.

    IF E_COLUMN_ID-FIELDNAME = 'STAMP_USER_F'. "핫스팟으로 클릭한 어떤컬럼의 필드이름이 이거면
      GV_EMPID = GS_ZTBMM1020-STAMP_USER_F.    "헤당값을 여기에 넣어준다.
    ELSEIF E_COLUMN_ID-FIELDNAME = 'STAMP_USER_L'.
      GV_EMPID = GS_ZTBMM1020-STAMP_USER_L.
    ENDIF.
"GV_EMPID 내가 클릭한 사원 아이디가 있음.

    CALL SCREEN 130
      STARTING AT 5 5.

<font color ="#0000FF">*    "참고</font>
<font color ="#0000FF">*    MODULE GET_EMP_DATA OUTPUT.</font>
<font color ="#0000FF">*      SELECT SINGLE *</font>
<font color ="#0000FF">*        FROM ZTBSD1030</font>
<font color ="#0000FF">*        WHERE EMPID = GV_EMPID.</font>
<font color ="#0000FF">*    ENDMODULE.</font>
  ENDMETHOD.

ENDCLASS.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
