{include file="header.tpl"}

<script type="text/javascript">
<!--

$(document).ready(function() {
    $('#pickup_list_all').dataTable( {
       "sPaginationType": "full_numbers",
       "aaSorting": [[ 4, "desc" ]],
       "aoColumns": [
       { "bSortable": false, "sTitle": "Claim ID", "sClass": "left" },
       { "sTitle": "Sender", "sClass": "left" },
       { "sTitle": "Size", "iDataSort":  4, "sClass": "left" },
       { "sTitle": "Created", "sType": "date-euro", "sClass": "center" },
       { "bVisible":  false }
       ]
    } );
} );

function doPickup(theID)
{
  document.pickup.claimID.value = theID;
  return document.pickup.submit();
}

//-->
</script>

{if $isAuthorizedUser && $isAdminUser}

  {if $countDropoffs>0}
<h1>Global Inbox</h1>
<h5>Click on a drop-off claim ID to view the information and files for that drop-off.</h5>
<table id="pickup_list_all" width="100%">
  <thead>
<!-- <table class="UD_form" cellpadding="4" width="100%">
  <thead class="UD_form_header"> -->
    <td>Claim ID</td>
    <td>Sender</td>
    <td>Size</td>
    <td>Created</td>
  </thead>

    {foreach from=$dropoffs item=d}
<!--  <tr valign="middle" class="UD_form_lined {cycle values="row,rowalt"}">
    <td class="UD_form_lined"><a class="hoverlink" href="#" onclick="doPickup('{$d.claimID}');"><tt>{$d.claimID}</tt></a></td>
    <td class="UD_form_lined">{$d.senderName}, {$d.senderOrg} ({$d.senderEmail})</td>
    <td class="UD_form_lined">{$d.formattedBytes|replace:' ':'&nbsp;'}</td>
    <td><div style="white-space: nowrap"><tt>{$d.createdDate|date_format:"%d&nbsp;%b&nbsp;%Y&nbsp;%r"}</tt></div></td>
  </tr> -->
  <tr>
    <td><a class="hoverlink" href="#" onclick="doPickup('{$d.claimID}');">{$d.claimID}</a></td>
    <td>{$d.senderName}, {$d.senderOrg} ({$d.senderEmail})</td>
    <td>{$d.formattedBytes}</td>
    <td>{$d.createdDate|date_format:"%d/%m/%Y %H:%M:%S"}</td>
    <td>{$d.Bytes}</td>
  </tr>
    {/foreach}

<!--  <tr class="UD_form_footer">
    <td colspan="3" align="center">{$countDropoffs} drop-off{if $countDropoffs ne 1}s{/if} {$formattedTotalBytes}</td>
  </tr> -->
</table>

<br/>
  <form name="pickup" method="post" action="{$zendToURL}pickup.php">
  <input type="hidden" id="claimID" name="claimID" value=""/>
</form>

  {else}
<h5>There are no drop-offs available at this time.</h5>
  {/if}

{/if}

{include file="footer.tpl"}
