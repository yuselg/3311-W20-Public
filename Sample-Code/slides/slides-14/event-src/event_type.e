note
	description: "Event Driven Publish and Subscribe"

class EVENT_TYPE [G -> TUPLE] inherit
	ANY
	 redefine default_create end
create
	default_create

feature {NONE}
	default_create
		do
			create {ARRAYED_LIST [PROCEDURE [G]]} actions.make (2)
		end

feature
	actions: LIST [PROCEDURE [G]]


	has(an_action: PROCEDURE [G]): BOOLEAN
		do
			Result :=  actions.has (an_action)
		ensure
			Result = actions.has (an_action)
		end

	count: INTEGER
		do
			Result := actions.count
		ensure
			Result = actions.count
		end



	subscribe (an_action: PROCEDURE [G])
			-- Register an action of this type
		require
			an_action_not_void: an_action /= void
			an_action_not_already_attached: not has (an_action)
		do
			actions.extend (an_action)
		ensure
			added: count = old count + 1
			subscribed: actions.has (an_action)
		end

	unsubscribe (an_action: PROCEDURE [G])
			-- deregister and action of this type
		require
			has (an_action)
		do
			actions.search (an_action)
			actions.remove
		ensure
			unsubsribed: not has (an_action)
		end


	publish (args: G)
			-- update all subscribed listeners
		do
--			actions.do_all (agent execute (?, args))
			across actions as l_action loop
				execute(l_action.item, args)
			end
		end

	execute (p: PROCEDURE [G]; args: G)
		do
			p(args)
		end

invariant
	count >= 0
end

