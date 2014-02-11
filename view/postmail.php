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

$error = "";

if($_POST)
{
	$keyid = Util::getPost("keyid");
	$vcode = Util::getPost("vcode");
	$killmail = Util::getPost("killmail");
	$killmailurl = Util::getPost("killmailurl");

	// Apikey stuff
	if($keyid || $vcode)
	{
		$check = Api::checkAPI($keyid, $vcode);
		if($check == "success")
		{
			Db::execute("insert ignore into zz_api (keyID, vCode) values (:keyID, :vCode)", array(":keyID" => $keyid, ":vCode" => $vcode));
			$error = "Your API Key has been added.";
		}
		else
		{
			$error = $check;
		}
	}

	if ($killmailurl)
	{
		// Looks like http://public-crest.eveonline.com/killmails/30290604/787fb3714062f1700560d4a83ce32c67640b1797/
		$exploded = explode("/", $killmailurl);

		if (count($exploded) != 7) $error = "Invalid killmail link.";
		else
		{
			if((int) $exploded[4] <= 0) $error = "Invalid killmail link";
			elseif(strlen($exploded[5]) != 40) $error = "Invalid killmail link";
			else
			{
				$killID = (int) $exploded[4];
				$hash = (string) $exploded[5];
				$i = Db::execute("insert ignore into zz_crest_killmail (killID, hash) values (:killID, :hash)", array(":killID" => $killID, ":hash" => $hash));
				Db::execute("update zz_crest_killmail set processed = 0 where processed = -1 and killID = :killID", array(":killID" => $killID));

				$timer = new Timer();
				do {
					// Has the kill been processed?
					$crestStatus = Db::queryField("select processed from zz_crest_killmail where killID = :killID", "processed", array(":killID" => $killID), 0);
					$processed = Db::queryField("select processed from zz_killmails where killID = :killID", "processed", array(":killID" => $killID), 0);
					if ($crestStatus == -1) $error = "There was an error processing that mail.  Please contact support.";
					else if ($processed == 1) $app->redirect("/detail/$killID/");
					else if ($processed == 2) $error = "There was an error processing your killmail.  Please contact support.";
					else if ($processed == 3) $error = "Your mail is an NPC only mail and will not be displayed.";
					else usleep(200);
				} while ($timer->stop() < 20000 && $error == "");
				if ($error == "") $error = "We waited 20 seconds for the kill to be processed but the server must be busy atm, please wait!";
			}
		}
	}
}

if(!is_array($error)) $error = array($error);

$app->render("postmail.html", array("message" => $error));
