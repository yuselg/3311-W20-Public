note
	description:
		"[
			Deferred observer objects that are informed via `update' from a subject
			of changes in the subject. 
			`update' and `up_to_date_with_subject' must be effected by a descendant,
			i.e. by a concrete observer. A concrete observer 
			will query the subject for information, and
			use the information to reconcile its state with the subject, 
			in such a way that `up_to_date_with_subject' returns true.
		]"
	author: "Jonathan S. Ostroff"
	date: "$March 24, 2002$"
	revision: "$Revision 1.0$"

deferred class OBSERVER

feature -- to be effected by a descendant

	up_to_date_with_subject: BOOLEAN
			-- is this observer up to date with its subject
		deferred
		end


	update
			-- update the observer's view of `s'
		deferred
		ensure
			up_to_date_with_subject: up_to_date_with_subject
		end


end -- class OBSERVER
