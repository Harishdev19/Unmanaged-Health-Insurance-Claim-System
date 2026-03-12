CLASS lhc_ClaimHeader DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE ClaimHeader.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE ClaimHeader.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE ClaimHeader.

    METHODS read FOR READ
      IMPORTING keys FOR READ ClaimHeader RESULT result.

    METHODS rba_Claimitems FOR READ
      IMPORTING keys_rba FOR READ ClaimHeader\_Claimitems
                FULL result_requested RESULT result LINK association_links.

    METHODS cba_Claimitems FOR MODIFY
      IMPORTING entities_cba FOR CREATE ClaimHeader\_Claimitems.

ENDCLASS.

CLASS lhc_ClaimHeader IMPLEMENTATION.

  METHOD create.
    DATA lt_hdr TYPE TABLE OF zuhi_hdr_22ee015.
    DATA lv_now TYPE utclong.
    DATA lv_id  TYPE n LENGTH 10.
    lv_now = utclong_current( ).

    SELECT MAX( claim_id ) FROM zuhi_hdr_22ee015 INTO @lv_id.
    lv_id = lv_id + 1.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<e>).
      APPEND INITIAL LINE TO lt_hdr ASSIGNING FIELD-SYMBOL(<db>).
      <db>-claim_id           = lv_id.
      <db>-patient_name       = <e>-PatientName.
      <db>-patient_dob        = <e>-PatientDob.
      <db>-policy_number      = <e>-PolicyNumber.
      <db>-insurer_name       = <e>-InsurerName.
      <db>-claim_date         = <e>-ClaimDate.
      <db>-hospital_name      = <e>-HospitalName.
      <db>-hospital_city      = <e>-HospitalCity.
      <db>-total_claim_amount = <e>-TotalClaimAmount.
      <db>-currency           = <e>-Currency.
      <db>-overall_status     = 'PENDING'.
      <db>-approved_amount    = <e>-ApprovedAmount.
      <db>-created_by         = sy-uname.
      <db>-created_at         = lv_now.
      <db>-changed_by         = sy-uname.
      <db>-changed_at         = lv_now.
      lv_id = lv_id + 1.
    ENDLOOP.

    INSERT zuhi_hdr_22ee015 FROM TABLE @lt_hdr.
  ENDMETHOD.

  METHOD update.
    DATA lv_now TYPE utclong.
    lv_now = utclong_current( ).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<e>).
      UPDATE zuhi_hdr_22ee015 SET
        patient_name       = @<e>-PatientName,
        patient_dob        = @<e>-PatientDob,
        policy_number      = @<e>-PolicyNumber,
        insurer_name       = @<e>-InsurerName,
        claim_date         = @<e>-ClaimDate,
        hospital_name      = @<e>-HospitalName,
        hospital_city      = @<e>-HospitalCity,
        total_claim_amount = @<e>-TotalClaimAmount,
        currency           = @<e>-Currency,
        overall_status     = @<e>-OverallStatus,
        approved_amount    = @<e>-ApprovedAmount,
        changed_by         = @sy-uname,
        changed_at         = @lv_now
        WHERE claim_id     = @<e>-ClaimId.
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<k>).
      DELETE FROM zuhi_itm_22ee015 WHERE claim_id = @<k>-ClaimId.
      DELETE FROM zuhi_hdr_22ee015 WHERE claim_id = @<k>-ClaimId.
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<k>).
      SELECT SINGLE * FROM zuhi_hdr_22ee015
        WHERE claim_id = @<k>-ClaimId INTO @DATA(ls).
      IF sy-subrc = 0.
        APPEND VALUE #(
          ClaimId          = ls-claim_id
          PatientName      = ls-patient_name
          PatientDob       = ls-patient_dob
          PolicyNumber     = ls-policy_number
          InsurerName      = ls-insurer_name
          ClaimDate        = ls-claim_date
          HospitalName     = ls-hospital_name
          HospitalCity     = ls-hospital_city
          TotalClaimAmount = ls-total_claim_amount
          Currency         = ls-currency
          OverallStatus    = ls-overall_status
          ApprovedAmount   = ls-approved_amount
        ) TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD rba_Claimitems.
    LOOP AT keys_rba ASSIGNING FIELD-SYMBOL(<k>).
      SELECT * FROM zuhi_itm_22ee015
        WHERE claim_id = @<k>-ClaimId
        INTO TABLE @DATA(lt_itm).
      LOOP AT lt_itm ASSIGNING FIELD-SYMBOL(<i>).
        APPEND VALUE #(
          ClaimId         = <i>-claim_id
          ItemId          = <i>-item_id
          TreatmentType   = <i>-treatment_type
          TreatmentDate   = <i>-treatment_date
          DoctorName      = <i>-doctor_name
          DiagnosisCode   = <i>-diagnosis_code
          DiagnosisText   = <i>-diagnosis_text
          ItemAmount      = <i>-item_amount
          Currency        = <i>-currency
          ItemStatus      = <i>-item_status
          ApprovedItemAmt = <i>-approved_item_amt
          RejectionReason = <i>-rejection_reason
        ) TO result.
        APPEND VALUE #(
          source-%key = <k>-%key
          target-%key = VALUE #(
            ClaimId = <i>-claim_id
            ItemId  = <i>-item_id )
        ) TO association_links.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD cba_Claimitems.
    DATA lt_itm TYPE TABLE OF zuhi_itm_22ee015.
    DATA lv_now TYPE utclong.
    lv_now = utclong_current( ).

    LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<e>).
      LOOP AT <e>-%target ASSIGNING FIELD-SYMBOL(<t>).
        SELECT MAX( item_id ) FROM zuhi_itm_22ee015
          WHERE claim_id = @<e>-ClaimId
          INTO @DATA(lv_item).
        lv_item = lv_item + 1.

        APPEND INITIAL LINE TO lt_itm ASSIGNING FIELD-SYMBOL(<db>).
        <db>-claim_id       = <e>-ClaimId.
        <db>-item_id        = lv_item.
        <db>-treatment_type = <t>-TreatmentType.
        <db>-treatment_date = <t>-TreatmentDate.
        <db>-doctor_name    = <t>-DoctorName.
        <db>-diagnosis_code = <t>-DiagnosisCode.
        <db>-diagnosis_text = <t>-DiagnosisText.
        <db>-item_amount    = <t>-ItemAmount.
        <db>-currency       = <t>-Currency.
        <db>-item_status    = 'PENDING'.
        <db>-created_by     = sy-uname.
        <db>-created_at     = lv_now.
        <db>-changed_by     = sy-uname.
        <db>-changed_at     = lv_now.
      ENDLOOP.
    ENDLOOP.

    INSERT zuhi_itm_22ee015 FROM TABLE @lt_itm.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ClaimItem DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE ClaimItem.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE ClaimItem.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE ClaimItem.

    METHODS read FOR READ
      IMPORTING keys FOR READ ClaimItem RESULT result.

ENDCLASS.

CLASS lhc_ClaimItem IMPLEMENTATION.

  METHOD create.
    DATA lt_itm TYPE TABLE OF zuhi_itm_22ee015.
    DATA lv_now TYPE utclong.
    DATA lv_id  TYPE n LENGTH 5.
    lv_now = utclong_current( ).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<e>).
      SELECT MAX( item_id ) FROM zuhi_itm_22ee015
        WHERE claim_id = @<e>-ClaimId
        INTO @lv_id.
      lv_id = lv_id + 1.

      APPEND INITIAL LINE TO lt_itm ASSIGNING FIELD-SYMBOL(<db>).
      <db>-claim_id       = <e>-ClaimId.
      <db>-item_id        = lv_id.
      <db>-treatment_type = <e>-TreatmentType.
      <db>-treatment_date = <e>-TreatmentDate.
      <db>-doctor_name    = <e>-DoctorName.
      <db>-diagnosis_code = <e>-DiagnosisCode.
      <db>-diagnosis_text = <e>-DiagnosisText.
      <db>-item_amount    = <e>-ItemAmount.
      <db>-currency       = <e>-Currency.
      <db>-item_status    = 'PENDING'.
      <db>-created_by     = sy-uname.
      <db>-created_at     = lv_now.
      <db>-changed_by     = sy-uname.
      <db>-changed_at     = lv_now.
    ENDLOOP.

    INSERT zuhi_itm_22ee015 FROM TABLE @lt_itm.
  ENDMETHOD.

  METHOD update.
    DATA lv_now TYPE utclong.
    lv_now = utclong_current( ).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<e>).
      UPDATE zuhi_itm_22ee015 SET
        treatment_type    = @<e>-TreatmentType,
        treatment_date    = @<e>-TreatmentDate,
        doctor_name       = @<e>-DoctorName,
        diagnosis_code    = @<e>-DiagnosisCode,
        diagnosis_text    = @<e>-DiagnosisText,
        item_amount       = @<e>-ItemAmount,
        currency          = @<e>-Currency,
        item_status       = @<e>-ItemStatus,
        approved_item_amt = @<e>-ApprovedItemAmt,
        rejection_reason  = @<e>-RejectionReason,
        changed_by        = @sy-uname,
        changed_at        = @lv_now
        WHERE claim_id    = @<e>-ClaimId
          AND item_id     = @<e>-ItemId.
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<k>).
      DELETE FROM zuhi_itm_22ee015
        WHERE claim_id = @<k>-ClaimId
          AND item_id  = @<k>-ItemId.
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<k>).
      SELECT SINGLE * FROM zuhi_itm_22ee015
        WHERE claim_id = @<k>-ClaimId
          AND item_id  = @<k>-ItemId
        INTO @DATA(ls).
      IF sy-subrc = 0.
        APPEND VALUE #(
          ClaimId         = ls-claim_id
          ItemId          = ls-item_id
          TreatmentType   = ls-treatment_type
          TreatmentDate   = ls-treatment_date
          DoctorName      = ls-doctor_name
          DiagnosisCode   = ls-diagnosis_code
          DiagnosisText   = ls-diagnosis_text
          ItemAmount      = ls-item_amount
          Currency        = ls-currency
          ItemStatus      = ls-item_status
          ApprovedItemAmt = ls-approved_item_amt
          RejectionReason = ls-rejection_reason
        ) TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZUHICR_HDR_22EE015 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.
    METHODS check_before_save REDEFINITION.
    METHODS save REDEFINITION.
    METHODS cleanup REDEFINITION.
    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZUHICR_HDR_22EE015 IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
