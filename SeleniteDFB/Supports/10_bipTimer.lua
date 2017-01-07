-- Implement a recurent timer

function bipTimer(
	itv	-- bip interval
)
	local self = {}

	-- Private fileds
	local tasksonce = {}	-- tasks to launch
	local timer,err

	-- methods
	function self.getTimer()
		return timer
	end

	function self.TaskOnceAdd( func )
		if TableTasksAdd( tasksonce, func ) == false then
			SelLog.log("*E* bipTimer.TaskOnceAdd( NULL )")
			return
		end
	end

	function self.TaskOnceRemove( func )
		TableTaskRemove( tasksonce, func )
	end

	local function bip()
		SubTasks( tasksonce )
	end

	timer, err = SelTimer.create { when=itv, interval=itv, ifunc=bip, clockid=SelTimer.ClockModeConst("CLOCK_MONOTONIC") }

	return self
end
