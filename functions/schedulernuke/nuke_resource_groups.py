"""Module deleting all Azure resource groups."""

from typing import List

from azure.core.exceptions import AzureError
from azure.identity import DefaultAzureCredential
from azure.mgmt.resource import ResourceManagementClient

from .filter_rg_by_tags import FilterResourceGroupsByTags


class NukeResourceGroup:
    """Abstract resource group nuke in a class."""

    def __init__(self, subscription_id: str) -> None:
        """Initialize Azure client."""
        self.resource_client = ResourceManagementClient(
            credential=DefaultAzureCredential(), subscription_id=subscription_id
        )
        self.mgmt = FilterResourceGroupsByTags(subscription_id=subscription_id)

    def nuke(self, tag_key: str, tag_value: str, exclude_rg: List[str]) -> None:
        """Destroy target resource groups in the current subscription.

        :param str tag_key:
            The key of the tag that you want to filter by.
        :param str tag_value:
            The value of the tag that you want to filter by.
        :param List[str] exclude_rg:
            The list of resource groups to exclude from deletion.
        """
        for rg_name in self.mgmt.get_rg_name(tag_key, tag_value):
            print(f"Found resource group: {rg_name}")
            if rg_name in exclude_rg:
                print(f"Skipping resource group: {rg_name}")
            else:
                try:
                    self.resource_client.resource_groups.begin_delete(
                        resource_group_name=rg_name
                    )
                    print(f"Deleting resource group: {rg_name}")
                except AzureError as err:
                    print(f"Failed to delete resource group: {rg_name}")
                    print(f"Error: {err}")
