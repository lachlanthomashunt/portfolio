//script goes here!

document.body.onload = setupCanvas();

function setupCanvas(){
	var canvas = document.getElementById("session7");

	if (canvas.getContext) {
		var ctx = canvas.getContext("2d");
		//initialising variables
		//var timer;
		//var clicker; -- the timer and clicker variables didn't seem necessary to the code, so they have been commented out.
		var score = 0;
		var user;
		var highScore = [];
		// -- a highScore variable is declaired for later use in the code.
		
		//drawing the background
		ctx.fillStyle = 'rgb(200,100,255)';
		ctx.rect(150, 140, 100, 100);
		ctx.fill();
		
		//start the game when the button is pressed
		document.getElementById('changer').addEventListener("click", startGame);
		
		function startGame(){
		//get the current username
		user = document.getElementById("name");
		//use EventListener to run the mousePos function when the canvas is clicked
		canvas.addEventListener("click", mousePos);
		//set the countdown timer
		// -- A window.setTimeout method is used to run the "stopGame" function to end the game after 5000 miliseconds (5 seconds).
		window.setTimeout(stopGame, 10000);
		}
		
		function stopGame(){
			//use removeEventListener to stop the mousePos function from being called on click
			canvas.removeEventListener("click", mousePos);
			//push the score and username into the highScore 2d array
			// -- Firstly, a separate "userScore" array is created to hold each set of values the user will create in each game.
			var userScore = [];

			// -- The user's name (if provided) and the score of the game after the 5 seconds allowed is added to the "UserScore" array using the .push method.
			// -- The .push method adds values to an array in the last index position of the array. Importantly ,it does not create a new array. The syntax for the push method is ARRAY.push(value_to_add).
			userScore.push(user.value);
			userScore.push(score);
			
			// -- userScore itself is added to the highScore array. This will store the scores which take place over the user's entire session in the browser window. It can be reset either by refreshing the window
			// -- or by clicking the "refresh" button.
			highScore.push(userScore);
			
			//sort from highest score to lowest score
			// -- The highScore array is sorted by using a custom sorting funciton, passing a(first array index) and b(next array indes) parameters through the entire array. The custom array is turned on it's head from how it normally works to produce a "high number first" array.
			// -- When the values produced are positive, that number is placed towards the end of the array. If the parameters produce a negative number, that number will be placed towards the start of the highScore array.
			highScore.sort(function(a,b){return b[1] - a[1];});
			//display highscore and username on the canvas
			// -- An array is declaired which will hold the highest highscore for displaying to the user (the values placed at the start of the highscores array).
			var displayHighScore = highScore[0];

			// -- The canvas is cleared to give more space for the following text.
			ctx.fillStyle = "#C864FF";
			ctx.clearRect(0, 0, 400, 400);
			ctx.fill();

			// -- Text is added through the canvas to inform the user of their performance.
			ctx.fillStyle = "black";
			ctx.font = "20px Calibri";
			ctx.fillText("Game Over", 100, 250);
			ctx.fillText("Your score is: " + score, 80, 280);
			ctx.fillText("The high score is " + displayHighScore[0] + " with " + displayHighScore[1], 10, 315);
			//print to the console
			// -- console.log is used to print to the console.
			console.log(highScore);
			//reset the score to allow for a new game
			// -- Each variable is reset. the highScoreTable function creates an entirely new table each time the game is over, each time adding the latest score (correctly sorted into its proper place) to the table list using the highScore variable. 
			displayHighScore = "";
			user.value = "";
			score = 0;
			user.focus();
			highScoreTable();
		}
		// -- The highScoreTable creates a new table each time it is called, swapping out the new "para1" paragraph field with the new highscore values, row after row using a for loop.
		function highScoreTable() {
		
			var para = document.getElementById("para1");
			var content = "<table><tr><th>Name</th><th>Score</th></tr>";

			for(var i = 0; i < highScore.length; i++) {
				content += "<tr><td>" + highScore[i][0] + "</td>";
				content += "<td>" + highScore[i][1] + "</td></tr>";
			}
			content += "</table>";
			para.innerHTML = content;
		}
		
		
		function mousePos(e){
			//test for bounds off the square
			if (e.offsetX>100 && e.offsetX<200 && e.offsetY>100 && e.offsetY<200){
				//if they click on the square, increment score
				// -- The score increments using ++ after the variable. This will increase the value by 1 for each click.
				score++;
				//remove old score from canvas
				// -- The code traces a new "clear" rectangle over the entire canvas to hide the text from the previous game.
				ctx.fillStyle = "#C864FF";
				ctx.clearRect(0, 0, 400, 400);
				ctx.fill();
				
				//display updated score
				// -- The new code introduces text using the canvas which is the latest score added into a string which is printed into the canvas.
				ctx.fillStyle = "#C864FF";
				ctx.font = "20px Arial";
				ctx.fillText("Your score is: " + score, 120, 220);
			}
		}

		// -- The reset buttong is given the code it needs to call if used outside of the function to ensure it works.
		// -- It requires the reset button in the html and needs to listen for a click from the user.
		document.getElementById('reset').addEventListener("click", reset);

		// -- The function resets the highScore array (which has been building up with values) back to being empty.
		function reset() {
			highScore = [];

			// -- Then the paragraph tag in the html is grabbed once again and it is replaced with an empty field. 
			// -- This will effectively delete the table from the page as it has been replaced with nothing.
			var para = document.getElementById("para1");
			para.innerHTML = "";
		}
	}
}

// -- This file was debugged using the browser's inspector tool which can detail where and what type of errors are occurring. If non-syntactic errors are occurring within the code, typing console logs into the code
// can also assist in locating errors through monitoring what variables have changed to what values at certain stages of the code. 