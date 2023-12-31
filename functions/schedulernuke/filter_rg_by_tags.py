"""Filter azure resouces with tags."""

from typing import Iterator

from azure.identity import DefaultAzureCredential
from azure.mgmt.resource import ResourceManagementClient


class FilterResourceGroupsByTags:
    """Abstract Filter azure resources by tags in a class."""

    def __init__(self, subscription_id: str) -> None:
        """Initialize Azure client."""
        self.resource_client = ResourceManagementClient(
            credential=DefaultAzureCredential(), subscription_id=subscription_id
        )

    def get_rg_name(self, tag_key: str, tag_value: str) -> Iterator[str]:
        """Filter azure resources using resource type and defined tags.

        Returns all the tagged defined resource_group that are located in
        the specified the Azure subscription.

        :param str tag_key:
            The key of the tag that you want to filter by.
        :param str tag_value:
            The value of the tag that you want to filter by.
        :yield Iterator[str]:
            The ids of the resources
        """
        exclude_tag = {tag_key: tag_value}
        rg_list = self.resource_client.resource_groups.list()
        for rg in rg_list:
            if rg.tags is None or not exclude_tag.items() <= rg.tags.items():
                yield rg.name
