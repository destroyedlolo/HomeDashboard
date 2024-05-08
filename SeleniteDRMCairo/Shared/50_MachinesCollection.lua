-- Handle machines' statistics
--
-- Notez-bien : to avoid race condition, data are stored into FIFO queue using
-- 	asynchronous function.
-- 	The drawback is these function can't know on which object they are attached
-- 	too -> no other way than hard coding ID

function MachinesCollection(
	surfaces,	-- "Machine" surface to display figures
	max_srf,	-- max surface identifier (included)
	opts
)
--[[ known options  :
--]]
	if not opts then
		opts = {}
	end

	local lst_machines = {}
	local qncpu = SelFIFO.Create("Machines ncpu")	-- Number of CPU
	local qload1 = SelFIFO.Create("Machines load1")	-- Loads

	local function rcvmch(tp, v)
		-- As call back, this function is called outside main State
		-- consequently, the only solution is to use a FIFO queue to
		-- communicate with the main context
		local mch = tp:match("Machines/(%a-.-)/")	-- Extract name
		local figure = tp:sub(string.len("Machines/".. mch) + 2)

		if figure == "ncpu" then
			local q = SelFIFO.Find("Machines ncpu")
			q:Push( mch, tonumber(v))	-- tonumber() needed to store value as well
			return true	-- let triggers to be launched
		elseif figure == "Load/1" then
			local q = SelFIFO.Find("Machines load1")
			q:Push( mch, tonumber(v))	-- tonumber() needed to store value as well
			return true	-- let triggers to be launched
		end
		return false	-- not a topic to process
	end

	local function process_ncpu()
		while true do
			local mch, ncpu = qncpu:Pop()
			if not mch then break end	-- Nothing to do

			if not lst_machines[mch] then
				lst_machines[mch]={}
			end
			lst_machines[mch].ncpu = ncpu
		end
	end

	local function process_load1()
		while true do
			local mch,ld  = qload1:Pop()

			if not mch then break end

			if lst_machines[mch] then	-- We got amount of CPU
				if not lst_machines[mch].surface then -- need to allocate a new surface
					for i=0,max_srf do
						if not surfaces[i].getName() then -- found free surface
							surfaces[i].allocate( mch, lst_machines[mch].ncpu, lst_machines[mch] )
							lst_machines[mch].surface = i
							break;
						end
					end
					if not lst_machines[mch].surface then -- Surface collection exhausted
							SelLog.Log('E', "Too many machines : ignoring '".. mch .."'")
							lst_machines[mch] = nil	-- Don't process other data for this host
													-- to avoid additional error messages
							return
					end
				end
				surfaces[lst_machines[mch].surface].Add(ld)
			end
		end
	end

	local self = MQTTinput("machines", "Machines/#", rcvmch, { taskonce=process_ncpu } )
	self.TaskOnceAdd(process_load1)

	return self
end
