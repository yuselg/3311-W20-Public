note
	description: "Objects that `notify' its observers whenever a change occurs"
	author: "Jonathan S. Ostroff"
	date: "$March 24, 2002$"
	revision: "$Revision 1.0$"

class SUBJECT create
	make

feature -- queries

	observers: LIST[OBSERVER]
		-- a list of all observers attached to this subject

	is_attached_to(o: OBSERVER): BOOLEAN
			-- Is `o' and observer
		require
			arg_not_void: o /= Void
		do
			Result := observers.has(o)
		ensure
			is_attached_defn: Result = observers.has(o)
		end


feature  -- invoked by an OBSERVER

	attach(o: OBSERVER)
			-- add `o' to the observers
		require
			arg_not_void: o /= Void
			not_yet_attached: not is_attached_to(o)
		do
			observers.extend(o)
		ensure
			is_attached: is_attached_to(o)
		end


	detach(o: OBSERVER)
			-- add `o' to the observers
		require
			arg_not_void: o /= Void
			currently_attached: is_attached_to(o)
		do
			observers.search(o)
			observers.remove
		ensure
			is_attached: not is_attached_to(o)
		end

feature -- invoked by a SUBJECT

	notify
			-- Send an `update' message to each observer
		do
			observers.do_all (agent update_action(?))
		ensure
			all_views_updated: observers.for_all (agent update_action_completed(?))
				-- cannot use do_all as it is not a contract

			observers_remain_the_same: equal(observers, observers.twin)
		end


	update_action_completed(o:OBSERVER): BOOLEAN
			-- Is agent update action completed?
			-- Used by `notify' ensure clause
		do
			Result := o.up_to_date_with_subject
		ensure
				up_to_date_result: Result = o.up_to_date_with_subject
				observers_remain_the_same: equal(observers, old observers.twin)
		end

feature{NONE} -- initialization and implementation

	update_action(o:OBSERVER)
			-- agent update action used by `notify'
		do
			o.update
		end

	make
			-- initialize `observers'
		do
			create {LINKED_LIST[OBSERVER]}observers.make
		end

invariant
	observers_not_void: observers /= Void


end -- class SUBJECT
