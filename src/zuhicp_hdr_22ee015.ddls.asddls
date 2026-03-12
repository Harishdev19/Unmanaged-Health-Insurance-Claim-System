@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View - Claim Header UI 22EE015'
@Metadata.allowExtensions: true
define root view entity ZUHICP_HDR_22EE015
  as projection on ZUHICR_HDR_22EE015
{
  key ClaimId,
      PatientName,
      PatientDob,
      PolicyNumber,
      InsurerName,
      ClaimDate,
      HospitalName,
      HospitalCity,
      TotalClaimAmount,
      Currency,
      OverallStatus,
      ApprovedAmount,
      CreatedBy,
      CreatedAt,
      ChangedBy,
      ChangedAt,
      _ClaimItems : redirected to composition child ZUHICP_ITM_22EE015
}
