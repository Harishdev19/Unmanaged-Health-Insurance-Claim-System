@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View - Health Insurance Claim Items 22EE015'
define view entity ZUHICR_ITM_22EE015
  as select from zuhi_itm_22ee015
  association to parent ZUHICR_HDR_22EE015 as _ClaimHeader
    on $projection.ClaimId = _ClaimHeader.ClaimId
{
  key claim_id             as ClaimId,
  key item_id              as ItemId,
      treatment_type       as TreatmentType,
      treatment_date       as TreatmentDate,
      doctor_name          as DoctorName,
      diagnosis_code       as DiagnosisCode,
      diagnosis_text       as DiagnosisText,
      @Semantics.amount.currencyCode: 'Currency'
      item_amount          as ItemAmount,
      currency             as Currency,
      item_status          as ItemStatus,
      @Semantics.amount.currencyCode: 'Currency'
      approved_item_amt    as ApprovedItemAmt,
      rejection_reason     as RejectionReason,
      created_by           as CreatedBy,
      created_at           as CreatedAt,
      changed_by           as ChangedBy,
      changed_at           as ChangedAt,
      _ClaimHeader
}
