<?php
/* zKillboard
 * Copyright (C) 2012-2013 EVE-KILL Team and EVSCO.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

$involved = array();
$message = "";

if($pageview == "comments")
	$app->redirect("/detail/$id/#comment", 301);

$info = User::getUserInfo();
$name = $info["username"];
$userID = $info["id"];
$email = $info["email"];


if($_POST)
{
	$report = Util::getPost("report");
	if (isset($report))
	{
		if($id < 0)
		{
			$tags = "Reported Kill";
			Db::execute("INSERT INTO zz_tickets (userid, name, email, tags, ticket, killID) VALUES (:userid, :name, :email, :tags, :ticket, :killid)",
			array(":userid" => $userID, ":name" => $name, ":email" => $email, ":tags" => $tags, ":ticket" => $report, ":killid" => $id));
			global $baseAddr;
			$reportID = Db::queryField("SELECT id FROM zz_tickets WHERE killID = :killID AND name = :name", "id", array(":killID" => $id, ":name" => $name));
			Log::ircAdmin("Kill Reported by $name: https://$baseAddr/detail/$id/ - https://$baseAddr/moderator/reportedkills/$reportID/");
			$app->redirect("/detail/$id/");
		}
	}
}

if ($id < 0) {
	// See if this manual mail has an api verified version
	$mKillID = -1 * $id;
	$killID = Db::queryField("select killID from zz_manual_mails where mKillID = :mKillID", "killID", array(":mKillID" => $mKillID), 1);
	if ($killID > 0) {
		$app->redirect("/detail/$killID/");
	}
}

// Create the details on this kill
$killdata = Kills::getKillDetails($id);

if (sizeof($killdata["victim"]) == 0) {
	return $app->render("detail.html", array("message" => "KillID $id does not exist."));
}

// create the dropdown involved array
$allinvolved = $killdata["involved"];
$cnt = 0;
while($cnt < 10)
{
	if(isset($allinvolved[$cnt]))
	{
		$involved[] = $allinvolved[$cnt];
		unset($allinvolved[$cnt]);
	}
	$cnt++;
	continue;
}
$topDamage = $finalBlow = null;
if (sizeof($killdata["involved"]) > 1){
	$topDamage = $killdata["involved"][0];
	foreach($killdata["involved"] as $inv) {
		if ($inv["finalBlow"] == 1) $finalBlow = $inv;
	}
}

$extra = array();
// And now give all the arrays and whatnots to twig..
if($pageview == "overview")
{
	$extra["items"] = combineditems(md5($id), $killdata["items"]);
	$extra["invAll"] = involvedCorpsAndAllis(md5($id), $killdata["involved"]);
	$extra["involved"] = $involved;
	$extra["allinvolved"] = $allinvolved;
}
if($pageview == "comments")
{
	$extra["cmtChars"] = Api::getCharacters($userID);
	$extra["cmtChars"][] = array("characterID" => 0, "characterName" => "Anonymous");
}

$extra["droppedisk"] = droppedIsk(md5($id), $killdata["items"]);
$extra["lostisk"] = $killdata["info"]["total_price"] - $extra["droppedisk"];
$extra["fittedisk"] = fittedIsk(md5($id), $killdata["items"]);
$extra["relatedtime"] = date("YmdH00", strtotime($killdata["info"]["killTime"]));
$extra["fittingwheel"] = eftarray(md5($id), $killdata["items"], $killdata["victim"]["characterID"]);
$extra["involvedships"] = involvedships($killdata["involved"]);
$extra["involvedshipscount"] = count($extra["involvedships"]);
$extra["totalprice"] = usdeurgbp($killdata["info"]["total_price"]);
$extra["destroyedprice"] = usdeurgbp($extra["lostisk"]);
$extra["droppedprice"] = usdeurgbp($extra["droppedisk"]);
$extra["fittedprice"] = usdeurgbp($extra["fittedisk"]);
$extra["efttext"] = Fitting::EFT($extra["fittingwheel"]);
$extra["dnatext"] = Fitting::DNA($killdata["items"],$killdata["info"]["shipTypeID"]);
$extra["edkrawmail"] = Kills::getRawMail($id);
$extra["zkbrawmail"] = Kills::getRawMail($id, array(), false);
$extra["reports"] = Db::queryField("SELECT count(*) as cnt FROM zz_tickets WHERE killID = :killid", "cnt", array(":killid" => $id), 0);
$extra["slotCounts"] = Info::getSlotCounts($killdata["victim"]["shipTypeID"]);
$extra["commentID"] = Info::commentID($id);
$extra["crest"] = Db::queryRow("select killID, hash from zz_crest_killmail where killID = :killID and processed = 1", array(":killID" => $id), 300);

$systemID = $killdata["info"]["solarSystemID"];
$data = Info::getWormholeSystemInfo($systemID);
$extra["wormhole"] = $data;

$url = "https://". $_SERVER["SERVER_NAME"] ."/detail/$id/";
$app->render("detail.html", array("pageview" => $pageview, "killdata" => $killdata, "extra" => $extra, "message" => $message, "flags" => Info::$effectToSlot, "topDamage" => $topDamage, "finalBlow" => $finalBlow, "url" => $url));

function involvedships($array)
{
	$involved = array();
	foreach($array as $inv)
	{
		if(isset($involved[$inv["shipTypeID"]]) && isset($inv["shipName"]))
			$involved[$inv["shipTypeID"]] = array("shipName" => $inv["shipName"], "shipTypeID" => $inv["shipTypeID"], "count" => $involved[$inv["shipTypeID"]]["count"] + 1);
		elseif(isset($inv["shipTypeID"]) && isset($inv["shipName"]))
		{
			$involved[$inv["shipTypeID"]] = array("shipName" => $inv["shipName"], "shipTypeID" => $inv["shipTypeID"], "count" => 1);
		}
		else
			continue;
	}

	usort($involved, "sortByOrder");
	return $involved;
}

function sortByOrder($a, $b)
{
	return $a["count"] < $b["count"];
}

function usdeurgbp($totalprice)
{
    $usd = 17;
    $eur = 13;
    $gbp = 10;
    $plex = Price::getItemPrice("29668", date("Ymd"));
    $usdval = $plex / $usd;
    $eurval = $plex / $eur;
    $gbpval = $plex / $gbp;

    return array("usd" => $totalprice / $usdval, "eur" => $totalprice / $eurval, "gbp" => $totalprice / $gbpval);
}

function eftarray($md5, $items, $victimID = 0)
{
	$Cache = Cache::get($md5."eftarray");
	if ($Cache) return $Cache;

	// EFT / Fitting Wheel
	$eftarray["high"] = array(); // high
	$eftarray["mid"] = array(); // mid
	$eftarray["low"] = array(); // low
	$eftarray["rig"] = array(); // rig
	$eftarray["drone"] = array(); // drone
	$eftarray["sub"] = array(); // sub
	$eftammo["high"] = array(); // high ammo
	$eftammo["mid"] = array(); // mid ammo

	foreach($items as $itm)
	{

		if ($victimID >= 2100000000 && $victimID <= 2999999999) $itm["flagName"] = Info::getGroupName(Info::getGroupID($itm["typeID"]));
		else if (!isset($itm["flagName"])) $itm["flagName"] = Info::getFlagName($itm["flag"]);

		if ($itm["flagName"] == "Infantry Modules") $itm["flagName"] = "Mid Slots";
		if ($itm["flagName"] == "Infantry Weapons") $itm["flagName"] = "High Slots";
		if ($itm["flagName"] == "Infantry Equipment") $itm["flagName"] = "Low Slots";

		if (!isset($itm["flag"]) || $itm["flag"] == 0) {
			if ($itm["flagName"] == "High Slots") $itm["flag"] = 27;
			if ($itm["flagName"] == "Mid Slots") $itm["flag"] = 19;
			if ($itm["flagName"] == "Low Slots") $itm["flag"] = 11;
		}

		$key = $itm["typeName"] . "|" . $itm["flagName"];
		if(isset($itm["flagName"]))
		{
			if($itm["fittable"] && $itm["inContainer"] == 0) // not ammo or whatever
			{
				$repeats = $itm["qtyDropped"] + $itm["qtyDestroyed"];
				$i = 0;
				while($i < $repeats)
				{
					if($itm["flagName"] == "High Slots")
					{
						high:
						if(isset($eftarray["high"][$itm["flag"]]))
						{
							$itm["flag"] = $itm["flag"]+1;
							goto high;
						}
						$eftarray["high"][$itm["flag"]][] = array("typeName" => $itm["typeName"], "typeID" => $itm["typeID"]);
					}
					if($itm["flagName"] == "Mid Slots")
					{
						mid:
						if(isset($eftarray["mid"][$itm["flag"]]))
						{
							$itm["flag"] = $itm["flag"]+1;
							goto mid;
						}
						$eftarray["mid"][$itm["flag"]][] = array("typeName" => $itm["typeName"], "typeID" => $itm["typeID"]);
					}
					if($itm["flagName"] == "Low Slots")
					{
						low:
						if(isset($eftarray["low"][$itm["flag"]]))
						{
							$itm["flag"] = $itm["flag"]+1;
							goto low;
						}
						$eftarray["low"][$itm["flag"]][] = array("typeName" => $itm["typeName"], "typeID" => $itm["typeID"]);
					}
					if($itm["flagName"] == "Rigs")
					{
						rigs:
						if(isset($eftarray["rig"][$itm["flag"]]))
						{
							$itm["flag"] = $itm["flag"]+1;
							goto rigs;
						}
						$eftarray["rig"][$itm["flag"]][] = array("typeName" => $itm["typeName"], "typeID" => $itm["typeID"]);
					}
					if($itm["flagName"] == "SubSystems")
					{
						subs:
						if(isset($eftarray["sub"][$itm["flag"]]))
						{
							$itm["flag"] = $itm["flag"]+1;
							goto subs;
						}
						$eftarray["sub"][$itm["flag"]][] = array("typeName" => $itm["typeName"], "typeID" => $itm["typeID"]);
					}
					$i++;
				}
			}
			else
			{
				if($itm["flagName"] == "Drone Bay")
					$eftarray["drone"][$itm["flag"]][] = array("typeName" => $itm["typeName"], "typeID" => $itm["typeID"], "qty" => $itm["qtyDropped"] + $itm["qtyDestroyed"]);
			}
		}
	}

	// Ammo shit
	foreach($items as $itm) {
		if($itm["inContainer"] == 0 && !$itm["fittable"] && isset($itm["flagName"])) // possibly ammo
		{
			if($itm["flagName"] == "High Slots") // high slot ammo
				$eftarray["high"][$itm["flag"]][] = array("typeName" => $itm["typeName"], "typeID" => $itm["typeID"], "charge" => true);
			if($itm["flagName"] == "Mid Slots") // mid slot ammo
				$eftarray["mid"][$itm["flag"]][] = array("typeName" => $itm["typeName"], "typeID" => $itm["typeID"], "charge" => true);
		}
	}
	foreach($eftarray as $key=>$value) {
		if (sizeof($value)) {
			asort($value);
			$eftarray[$key] = $value;
		} else unset($eftarray[$key]);
	}
	Cache::set($md5."eftarray", $eftarray);
	return $eftarray;
}

function combineditems($md5, $items)
{
	$Cache = Cache::get($md5."combineditems");
	if($Cache) return $Cache;

	// Create the new item array with combined items and whatnot
	$itemList = array();
	foreach($items as $itm)
	{
		if ($itm["inContainer"] == 1) $itm["flag"] = 0;
		if (!isset($itm["flagName"])) $itm["flagName"] = Info::getFlagName($itm["flag"]);
		for ($i = 0; $i <= 1; $i++) {
			$mItem = $itm;
			if ($i == 0) $mItem["qtyDropped"] = 0;
			if ($i == 1) $mItem["qtyDestroyed"] = 0;
			if ($mItem["qtyDropped"] == 0 && $mItem["qtyDestroyed"] == 0) continue;
			$key = buildItemKey($mItem);

			if(!isset($itemList[$key])) {
				$itemList[$key] = $mItem;
				$itemList[$key]["price"] = $mItem["price"] * ($mItem["qtyDropped"] + $mItem["qtyDestroyed"]);
			}
			else {
				$itemList[$key]["qtyDropped"] += $mItem["qtyDropped"];
				$itemList[$key]["qtyDestroyed"] += $mItem["qtyDestroyed"];
				$itemList[$key]["price"] += $mItem["price"] * ($mItem["qtyDropped"] + $mItem["qtyDestroyed"]);
			}
		}
	}
	Cache::set($md5."combineditems", $itemList);
	return $itemList;
}

function buildItemKey($itm)
{
	$key = $itm["typeName"] . ($itm["singleton"] == 2 ? " (Copy)" : "");
	$key .= "|" . ($itm["qtyDropped"] > 0 ? "dropped" : "destroyed");
	if (!isset($itm["flagName"])) $itm["flagName"] = Info::getFlagName($itm["flag"]);
	$key .= "|" . $itm["flagName"];
	if ($itm["groupID"] == 649) $key .= microtime() . rand(0, 10000);
	return $key;
}

function involvedCorpsAndAllis($md5, $involved)
{
	$Cache = Cache::get($md5."involvedCorpsAndAllis");
	if($Cache) return $Cache;

	$involvedAlliCount = 0;
	$involvedCorpCount = 0;
	// Create the involved corps / alliances list
	$invAll = array();
	foreach($involved as $inv) {
		$allianceID = $inv["allianceID"];
		$corporationID = $inv["corporationID"];
		if (!isset($invAll["$allianceID"])) {
			$involvedAlliCount++;
			$invAll["$allianceID"] = array();
			if ($allianceID != 0) $invAll["$allianceID"]["allianceName"] = $inv["allianceName"];
			if ($allianceID != 0) $invAll["$allianceID"]["name"] = $inv["allianceName"];
			if ($allianceID != 0) $invAll["$allianceID"]["allianceID"] = $allianceID;
			$invAll["$allianceID"]["corporations"] = array();
			$invAll["$allianceID"]["involved"] = 0;
		}
		$involvedCount = $invAll["$allianceID"]["involved"];
		$invAll["$allianceID"]["involved"] = $involvedCount + 1;

		if (!isset($invAll["$allianceID"]["corporations"]["$corporationID"])) {
			$involvedCorpCount++;
			$invAll["$allianceID"]["corporations"]["$corporationID"] = array();
			$invAll["$allianceID"]["corporations"]["$corporationID"]["corporationName"] = isset($inv["corporationName"]) ? $inv["corporationName"] : "";
			$invAll["$allianceID"]["corporations"]["$corporationID"]["name"] = isset($inv["corporationName"]) ? $inv["corporationName"] : "";
			$invAll["$allianceID"]["corporations"]["$corporationID"]["corporationID"] = $corporationID;
			$invAll["$allianceID"]["corporations"]["$corporationID"]["involved"] = 0;
		}
		$involvedCount =  $invAll["$allianceID"]["corporations"]["$corporationID"]["involved"];
		$invAll["$allianceID"]["corporations"]["$corporationID"]["involved"] =  $involvedCount + 1;
	}
	uasort($invAll, "involvedSort");
	foreach($invAll as $id=>$alliance) {
		$corps = $alliance["corporations"];
		uasort($corps, "involvedSort");
		$invAll["$id"]["corporations"] = $corps;
	}
	if ($involvedCorpCount <= 1 && $involvedAlliCount <= 1) $invAll = array();
	Cache::set($md5."involvedCorpsAndAllis", $invAll);
	return $invAll;
}

function involvedSort($field1, $field2)
{
	if ($field1["involved"] == $field2["involved"] && isset($field1["name"]) && isset($field2["name"])) return strcasecmp($field1["name"], $field2["name"]);
	return $field2["involved"] - $field1["involved"];
}

function droppedIsk($md5, $items)
{
	$Cache = Cache::get($md5."droppedisk");
	if($Cache) return $Cache;

	$droppedisk = 0;
	foreach($items as $dropped) {
		$droppedisk += $dropped["price"] * ($dropped["singleton"] ? $dropped["qtyDropped"] / 100 : $dropped["qtyDropped"]);
	}

	Cache::set($md5."droppedisk", $droppedisk);
	return $droppedisk;
}

function fittedIsk($md5, $items)
{
	$key = $md5 . "fittedIsk";
	$cache = Cache::get($key);
	if($cache)
		return $cache;

	$fittedIsk = 0;
	$flags = array("High Slots", "Mid Slots", "Low Slots", "SubSystems", "Rigs", "Drone Bay", "Fuel Bay");
	foreach($items as $item)
	{
		if(isset($item["flagName"]) && in_array($item["flagName"], $flags)) {
			$qty = isset($item["qtyDropped"]) ? $item["qtyDropped"] : 0;
			$qty += isset($item["qtyDestroyed"]) ? $item["qtyDestroyed"] : 0;
			$fittedIsk = $fittedIsk + ($item["price"] * $qty);
		}
	}
	Cache::set($key, $fittedIsk);
	return $fittedIsk;
}
