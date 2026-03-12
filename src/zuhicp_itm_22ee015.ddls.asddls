@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View - Claim Items UI 22EE015'
@Metadata.allowExtensions: true
define view entity ZUHICP_ITM_22EE015
  as projection on ZUHICR_ITM_22EE015
{
  key ClaimId,
  key ItemId,
      TreatmentType,
      TreatmentDate,
      DoctorName,
      DiagnosisCode,
      DiagnosisText,
      ItemAmount,
      Currency,
      ItemStatus,
      ApprovedItemAmt,
      RejectionReason,
      CreatedBy,
      CreatedAt,
      ChangedBy,
      ChangedAt,
      _ClaimHeader : redirected to parent ZUHICP_HDR_22EE015
}
