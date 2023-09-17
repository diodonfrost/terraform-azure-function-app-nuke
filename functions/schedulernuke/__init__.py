"""Main function entrypoint for Azure Function App."""
import os

import azure.functions as func

from .nuke_resource_groups import NukeResourceGroup


def main(schedulernuke: func.TimerRequest) -> None:
    """Main function entrypoint for Azure Function App."""
    current_rg_name = os.environ["CURRENT_RESOURCE_GROUP"]
    tag_key = os.environ["TAG_KEY"]
    tag_value = os.environ["TAG_VALUE"]
    exclude_rg = [current_rg_name]
    current_subscription_id = os.environ["CURRENT_SUBSCRIPTION_ID"]

    nuke_rg = NukeResourceGroup(subscription_id=current_subscription_id)
    nuke_rg.nuke(tag_key=tag_key, tag_value=tag_value, exclude_rg=exclude_rg)
