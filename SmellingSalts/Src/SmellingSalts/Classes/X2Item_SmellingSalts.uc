class X2Item_SmellingSalts extends X2Item config(SmellingSalts);

var config int		Usages;
var config int		Range;
var config int		BuildPrice;
var config int		SellPrice;
var config bool		IsInfinite;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	Items.AddItem(CreateSmellingSalts());

	return Items;
}

static function X2DataTemplate CreateSmellingSalts()
{
	local X2WeaponTemplate Template;
	local ArtifactCost Resources;
	
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'SmellingSalts');
	Template.ItemCat = 'heal';
	Template.WeaponCat = 'medikit';

	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_RearBackPack;
	Template.strImage = "img:///Smelling_Salts.Textures.Inv_Smelling_Salts";
	Template.EquipSound = "StrategyUI_Medkit_Equip";

	Template.iClipSize = default.Usages;
	Template.iRange = default.Range;
	Template.bMergeAmmo = true;

	Template.Abilities.AddItem('SmellingSaltsRevive');

	Template.SetUIStatMarkup(class'XLocalizedData'.default.ChargesLabel, , default.Usages);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.Range);

	if (default.IsInfinite)
	{
		Template.CanBeBuilt = false;
		Template.bInfiniteItem = true;
		Template.StartingItem = true;
	}
	else
	{
		Resources.ItemTemplateName = 'Supplies';
		Resources.Quantity = default.BuildPrice;
		Template.Cost.ResourceCosts.AddItem(Resources);
		Template.CanBeBuilt = true;
		Template.bInfiniteItem = false;
		Template.StartingItem = false;
		Template.TradingPostValue = default.SellPrice;
	}
	
	Template.PointsToComplete = 0;
	Template.Tier = 0;

	Template.bShouldCreateDifficultyVariants = true;
	return Template;
}