/obj/machinery/rnd/destructive_analyzer/pay
	name = "Bounti-ful destructive analyzer"
	desc = "A destructive analyzer, that takes research items in exchange for money, help science, get paid!"

/obj/machinery/rnd/destructive_analyzer/pay/Insert_Item(obj/item/O, mob/user)
	if(user.a_intent != INTENT_HARM)
		. = 1
		if(!is_insertion_ready(user))
			return
		if(!user.transferItemToLoc(O, src))
			to_chat(user, span_warning("\The [O] is stuck to your hand, you cannot put it in the [src.name]!"))
			return
		if(!techweb_point_items[O.type])
			to_chat(user, span_warning("This thing is useless for research! I think..."))
			return
		SSresearch.science_tech.add_point_list(techweb_point_items[O.type])
		var/totalRSP = 0
		for(var/oough in techweb_point_items[O.type])
			totalRSP += techweb_point_items[O.type][oough]
		var/bigmoney = round(totalRSP / 40)
		to_chat(user, span_notice("You add the [O.name] to the [src.name], earning you [bigmoney] for [totalRSP] points!"))
		SSeconomy.adjust_funds(user, bigmoney, src)
		loaded_item = null
		qdel(O)
