"""Filter azure resouces with tags."""

from typing import Iterator

from azure.mgmt.resource import ResourceManagementClient
from azure.identity import DefaultAzureCredential


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
        resources = self.resource_client.resource_groups.list()
        for resource in resources:
            if not (exclude_tag.items() <= resource.tags.items()):
                yield resource.name
