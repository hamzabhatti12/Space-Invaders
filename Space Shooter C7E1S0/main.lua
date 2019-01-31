love.graphics.setDefaultFilter('nearest', 'nearest' )
enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}
enemies_controller.image = love.graphics.newImage('enemy02.png')
love.graphics.setDefaultFilter('nearest', 'nearest' )
player = {}
player.plays= {}
player.image = love.graphics.newImage('playership02.png')

--Function to remove enemies-----------------
function checkCollisions(enemies, bulletsup) --Make new function
	for i, e in ipairs(enemies) do
		for v, b in pairs(bulletsup) do
			if b.y <= e.y + e.height then
				if (b.x + b.width > e.x and b.x < e.x + e.width) then
				table.remove(enemies,i)
				table.remove(bulletsup,v)
				score = score + 1
				count = count + 1
				count_enemy = count_enemy - 1
				end
			end
		end
	end
end

--Everything after this loads only once-------------------------
function love.load()
	gameover = false
	score = 0
	count = 0
	wave = 0
	wavestart = 0
	count_enemy = 0
	player = {}
	player.x = 300
    player.y = 300
	player.speed = 10
	player.size = 50
	--bullet table values
	player.bulletsup ={} --first change: done
	player.bulletsup2 ={}
	player.bulletsup3 ={}
	--Standard values-----------
	player.speed = 10
	player.cooldown = 20
	player.fire = function()
		if player.cooldown <= 0 then
			player.cooldown = 20
			-- used for bullet values
			bulletup = {} --second change
			bulletup2 = {}
			bulletup3 = {}
			--used for bullet positions
			-- for bulletup---------
			bulletup.x = player.x +20
			bulletup.y = player.y
			bulletup.width = 10
			-- for bulletup2---------
			bulletup2.x = player.x 
			bulletup2.y = player.y
			bulletup2.width = 10
			-- for bulletup3---------
			bulletup3.x = player.x + 40
			bulletup3.y = player.y
			bulletup3.width = 10
			--Used for creation of bullets
			table.insert(player.bulletsup, bulletup)
			if(count >= 16) then 
				table.insert(player.bulletsup2, bulletup2)
				table.insert(player.bulletsup3, bulletup3)
			end
		end
	end
--	enemies_controller:spawnWave(wavestart)

end

--to spawn a  wave of enemies
function enemies_controller:spawnWave(wavestart)
	count_enemy = count_enemy + 16
	enemies_controller:spawnEnemy(0,wavestart)
	enemies_controller:spawnEnemy(50,wavestart)
	enemies_controller:spawnEnemy(100,wavestart)
	enemies_controller:spawnEnemy(150,wavestart)
	enemies_controller:spawnEnemy(200,wavestart)
	enemies_controller:spawnEnemy(250,wavestart)
	enemies_controller:spawnEnemy(300,wavestart)
	enemies_controller:spawnEnemy(350,wavestart)
	enemies_controller:spawnEnemy(400,wavestart)
	enemies_controller:spawnEnemy(450,wavestart)
	enemies_controller:spawnEnemy(500,wavestart)
	enemies_controller:spawnEnemy(550,wavestart)
	enemies_controller:spawnEnemy(600,wavestart)
	enemies_controller:spawnEnemy(650,wavestart)
	enemies_controller:spawnEnemy(700,wavestart)
	enemies_controller:spawnEnemy(750,wavestart)
end

--To spawn enemies--------------------------------------------------
function enemies_controller:spawnEnemy(x,y)
	enemy = {}
	enemy.x = x
	enemy.y = y
	enemy.height = 7
	enemy.width = 30
    enemy.bullets = {}
    enemy.cooldown = 20
    enemy.speed = 10
	table.insert(self.enemies, enemy)
end

--For enenmies that shoot--------------------------------------------
function enemy:fire()
	if self.cooldown <= 0 then
		self.cooldown = 20
		bullet = {}
		bullet.x = player.x
		bullet.y = player.y
		table.insert(self.bullets, bullet)
	end
end

--Does everything once per frame ---------------------
function love.update(dt)

	checkCollisions(enemies_controller.enemies, player.bulletsup) --fouth new function
	checkCollisions(enemies_controller.enemies, player.bulletsup2)
	checkCollisions(enemies_controller.enemies, player.bulletsup3)

	player.cooldown = player.cooldown - 1

	--Player Controls--------------------
	if love.keyboard.isDown("right") then
		if player.x < 750 then
			player.x = player.x + player.speed
		end
	elseif love.keyboard.isDown("left") then
		if player.x > 0 then
			player.x = player.x - player.speed
		end
	end

	if love.keyboard.isDown("up") then
		if player.y > 0 then
			player.y = player.y - player.speed
		end
	elseif love.keyboard.isDown("down") then
		if player.y < 550 then
			player.y = player.y + player.speed
		end
	end

	player.cooldown = player.cooldown - 1

	if love.keyboard.isDown("d") then
		if player.x < 750 then
			player.x = player.x + player.speed
		end
	elseif love.keyboard.isDown("a") then
		if player.x > 0 then
			player.x = player.x - player.speed
		end
	end

	if love.keyboard.isDown("w") then
		if player.y > 0 then
			player.y = player.y - player.speed
		end
	elseif love.keyboard.isDown("s") then
		if player.y < 550 then
			player.y = player.y + player.speed
		end
	end

	for _,e in pairs(enemies_controller.enemies) do
		e.y = e.y + 0.5
	end

	--Combat System-----------------------
	if love.keyboard.isDown("space") then
		player.fire()
	end
	--fifth new function
	for i,b in pairs(player.bulletsup) do  
		if b.y < -10 then
			table.remove( player.bulletsup, i)
		end
		b.y = b.y - 5
		
	end

	for i,b in pairs(player.bulletsup2) do  
		if b.y < -10 then
			table.remove( player.bulletsup2, i)
		end
		b.y = b.y - 5
		
	end

	for i,b in pairs(player.bulletsup3) do  
		if b.y < -10 then
			table.remove( player.bulletsup3, i)
		end
		b.y = b.y - 5
		
	end

	--[[method used for ending the game----------

	for _,e in pairs(enemies_controller.enemies) do
		if e.y < -10 then
			gameover = true
		end
	end]]
end

--while(gameover == false) do

	function love.draw()
		-- display score------------------------
		love.graphics.print(score)

		-- draw player-----------------------------------------------------------	
		love.graphics.setColor(255,255,255)
			love.graphics.rectangle("fill", player.x, player.y, 50, 50)
		--[[for _,e in pairs(player.plays) do
			love.graphics.draw(player.image, player.x, player.y, 0, .05)
		end]]

		-- draw enemies----------------------------------------------------------
		if(count_enemy == 0)then
			wave = wave + 1
			waveind = 0
			wavestart = 0
			while(waveind < wave) do
			enemies_controller:spawnWave(wavestart)
			wavestart = wavestart + 30
			waveind = waveind + 1
			end
		end
		
		love.graphics.setColor(255,255,255)
			for _,e in pairs(enemies_controller.enemies) do
				love.graphics.draw(enemies_controller.image, e.x, e.y, 0, .05)
			end

		

		-- draw bullets-----------------------------------------------------------
		love.graphics.setColor(0,200,150,2)
		for _,b in pairs(player.bulletsup) do
			love.graphics.rectangle("fill", b.x, b.y + 20,10,10)
		end

		if(count >= 16) then
			for _,b in pairs(player.bulletsup2) do --sixth change
				love.graphics.rectangle("fill", b.x, b.y + 20,10,10)
			end
			
			for _,b in pairs(player.bulletsup3) do
				love.graphics.rectangle("fill", b.x, b.y + 20,10,10)
			end
			
		end
	end
--end

--[[while(gameover == true) do
	love.graphics.print("Game Over")
end]]