<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>MZBSD0080_I01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: MZBSD0080_I01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include MZBSD0080_I01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  USER_COMMAND_0100  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE user_command_0100 INPUT.

  CASE OK_CODE.
    WHEN 'BACK' OR 'CANC'.
      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.
      LEAVE PROGRAM.

    WHEN 'CRT'.             "생성버튼
      CALL SCREEN 110
        STARTING AT 5 5.

    WHEN 'MOD' OR 'DEL'.    "수정 / 삭제 버튼
      PERFORM ZBSD_GET_SEL_DATA.

    WHEN 'SHR_BTN'.         "조회버튼
      PERFORM ZBSD_GET_SHRDATA.


    WHEN 'REFRESH'.        "새로고침
      PERFORM ZBSD_CLEAR_ALL.

  ENDCASE.

ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  USER_COMMAND_0110  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE user_command_0110 INPUT.
  CASE OK_CODE.
    WHEN 'OKAY'.
      PERFORM ZBSD_SAVE_DATA. "데이터 저장
      LEAVE TO SCREEN 0.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  USER_COMMAND_0120  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE USER_COMMAND_0120 INPUT.
  CASE OK_CODE.
    WHEN 'OKAY'.
      PERFORM ZBSD_MODIFY_SHR. "데이터 수정 서브루틴
      LEAVE TO SCREEN 0.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  USER_COMMAND_0130  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE USER_COMMAND_0130 INPUT.

  CASE OK_CODE.
    WHEN 'OKAY' OR 'CANCEL'.
      CLEAR: ZTBSD1030.
      LEAVE TO SCREEN 0.
   ENDCASE.

ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  EXIT  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE EXIT INPUT.
  CASE OK_CODE.
    WHEN 'EXIT'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  EXIT120  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE EXIT_0120 INPUT.
  CASE OK_CODE.
    WHEN 'EXIT'.
      CLEAR: ZTBMM1020-PLTCODE, ZTBMM1020-PLTNAME.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  EXIT_0130  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE EXIT_0130 INPUT.
  CASE OK_CODE.
    WHEN 'EXIT'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
