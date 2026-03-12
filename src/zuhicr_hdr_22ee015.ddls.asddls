@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View - Health Insurance Claim Header 22EE015'
define root view entity ZUHICR_HDR_22EE015
  as select from zuhi_hdr_22ee015
  composition [0..*] of ZUHICR_ITM_22EE015 as _ClaimItems
{
  key claim_id             as ClaimId,
      patient_name         as PatientName,
      patient_dob          as PatientDob,
      policy_number        as PolicyNumber,
      insurer_name         as InsurerName,
      claim_date           as ClaimDate,
      hospital_name        as HospitalName,
      hospital_city        as HospitalCity,
      @Semantics.amount.currencyCode: 'Currency'
      total_claim_amount   as TotalClaimAmount,
      currency             as Currency,
      overall_status       as OverallStatus,
      @Semantics.amount.currencyCode: 'Currency'
      approved_amount      as ApprovedAmount,
      created_by           as CreatedBy,
      created_at           as CreatedAt,
      changed_by           as ChangedBy,
      changed_at           as ChangedAt,
      _ClaimItems
}
