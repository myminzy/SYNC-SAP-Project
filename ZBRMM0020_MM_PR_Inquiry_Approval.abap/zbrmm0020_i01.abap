<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBRMM0020_I01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBRMM0020_I01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include ZBRMM0020_I01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          ZBRMM0020_I01</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  USER_COMMAND_0100  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE USER_COMMAND_0100 INPUT.
  CASE OK_CODE.
    WHEN 'BACK' OR 'CANCEL'.
       LEAVE TO SCREEN 0.
     WHEN 'ORDER'.
       CLEAR : GV_VF, GV_VF1, GV_VF2.
       PERFORM ZBMM_SEL_DATA.

  ENDCASE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  USER_COMMAND_0120  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE USER_COMMAND_0120 INPUT.

  CASE OK_CODE.

    "승인
    "승인 버튼을 눌렀을 경우
    WHEN 'OKAY120'.
      GV_VF1 = 'X'.
      PERFORM ZBMM_ODER_CHECK.
      PERFORM ZBMM_ORDER_OKAY.
      PERFORM ZBMM_ALV1_REFRESH.

    "반려
    "반려 버튼을 눌렀을 경우
    WHEN 'REJECT120'.
      GV_VF2 = 'X'.
      PERFORM ZBMM_REJECT_CHECK.

<font color ="#0000FF">*    반려사유 입력 후 반려확정 버튼을 눌렀을 경우</font>
    WHEN 'OK'.
          IF ZTBMM0010-PRNGT IS INITIAL.
            MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '040' DISPLAY LIKE 'E'.
            "반려사유를 작성해주세요.
            ENDIF.
           IF ZTBMM0010-PRNGT IS NOT INITIAL.
                 GV_VF = 'X'.
           ENDIF.
            IF ZTBMM0010-PRNGT IS NOT INITIAL AND GV_VF EQ 'X'.
              PERFORM ZBMM_ORDER_UPDATE.
              PERFORM ZBMM_ALV1_REFRESH.
            ENDIF.

<font color ="#0000FF">*BREAK-POINT.</font>
<font color ="#0000FF">*      CALL METHOD CL_GUI_CFW=&gt;FLUSH.</font>
  ENDCASE.



ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  EXIT_0120  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE EXIT_0120 INPUT.
  CASE OK_CODE.
    WHEN 'CANCEL' OR 'CANC' OR 'CAC'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  CHECK_RETEXT  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE CHECK_RETEXT INPUT.

  CONDENSE ZTBMM0010-PRNGT.

  IF ZTBMM0010-PRNGT IS INITIAL.
    " 반려사유를 작성해주세요.
  MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '037' DISPLAY LIKE 'E'.
  ELSE.
  ENDIF.

ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  USER_COMMAND_0130  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE USER_COMMAND_0130 INPUT.
  CASE OK_CODE.
    WHEN 'OKAY130' OR 'CANCEL130' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
   ENDCASE.
ENDMODULE.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
