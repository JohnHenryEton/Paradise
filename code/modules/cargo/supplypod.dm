/obj/structure/closet/supplypod
	name = "supply pod" //Names and descriptions are normally created with the setStyle() proc during initialization, but we have these default values here as a failsafe
	desc = "A Nanotrasen supply drop pod."
	icon = 'icons/obj/supplypods.dmi'
	icon_state = "supplypod"
	pixel_x = -16 //2x2 sprite
	pixel_y = -5
	layer = TABLE_LAYER //So that the crate inside doesn't appear underneath
	//allow_objects = TRUE
	//allow_dense = TRUE
	//delivery_icon = null
	//can_weld_shut = FALSE
	armor = list("melee" = 30, "bullet" = 50, "laser" = 50, "energy" = 100, "bomb" = 100, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 80)
	anchored = TRUE //So it cant slide around after landing
	//anchorable = FALSE
	//*****NOTE*****: Many of these comments are similarly described in centcom_podlauncher.dm. If you change them here, please consider doing so in the centcom podlauncher code as well!
	var/adminNamed = FALSE //Determines whether or not the pod has been named by an admin. If true, the pod's name will not get overridden when the style of the pod changes (changing the style of the pod normally also changes the name+desc)
	var/bluespace = FALSE //If true, the pod deletes (in a shower of sparks) after landing
	var/landingDelay = 30 //How long the pod takes to land after launching
	var/openingDelay = 30 //How long the pod takes to open after landing
	var/departureDelay = 30 //How long the pod takes to leave after opening (if bluespace=true, it deletes. if reversing=true, it flies back to centcom)
	var/damage = 0 //Damage that occurs to any mob under the pod when it lands.
	var/effectStun = FALSE //If true, stuns anyone under the pod when it launches until it lands, forcing them to get hit by the pod. Devilish!
	var/effectLimb = FALSE //If true, pops off a limb (if applicable) from anyone caught under the pod when it lands
	var/effectGib = FALSE //If true, anyone under the pod will be gibbed when it lands
	var/effectStealth = FALSE //If true, a target icon isnt displayed on the turf where the pod will land
	var/effectQuiet = FALSE //The female sniper. If true, the pod makes no noise (including related explosions, opening sounds, etc)
	var/effectMissile = FALSE //If true, the pod deletes the second it lands. If you give it an explosion, it will act like a missile exploding as it hits the ground
	var/effectCircle = FALSE //If true, allows the pod to come in at any angle. Bit of a weird feature but whatever its here
	//var/style = STYLE_STANDARD //Style is a variable that keeps track of what the pod is supposed to look like. It acts as an index to the POD_STYLES list in cargo.dm defines to get the proper icon/name/desc for the pod.
	var/reversing = FALSE //If true, the pod will not send any items. Instead, after opening, it will close again (picking up items/mobs) and fly back to centcom
	var/landingSound //Admin sound to play when the pod lands
	var/openingSound //Admin sound to play when the pod opens
	var/leavingSound //Admin sound to play when the pod leaves
	var/soundVolume = 50 //Volume to play sounds at. Ignores the cap
	var/bay //Used specifically for the centcom_podlauncher datum. Holds the current bay the user is launching objects from. Bays are specific rooms on the centcom map.
	var/list/explosionSize = list(0,0,2,3)


/obj/structure/closet/supplypod/take_contents()
	var/itemcount = 0
	for(var/obj/I in loc)
		if(I == src) continue
		I.forceMove(src)
		// Ensure the storage cap is respected
		if(++itemcount >= storage_capacity)
			break

