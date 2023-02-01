let ws;

console.log('memberId@ws.js :', memberId);
setTimeout(() => {
	
	ws = new WebSocket(`ws://${location.host}/comma/commaWebSocket`);
	console.log(`ws://${location.host}/comma/commaWebSocket`);
	ws.addEventListener('open', (e) => {
		console.log('open : ', e);
	});
	ws.addEventListener('message', (e) => {
		console.log('message : ', e);
		const wrapper = document.querySelector("#msgContainer");
		const notification = document.querySelector("#notification");
		
		const {message, messageType, datetime, sender, receiver, chatNo} = JSON.parse(e.data);
		console.log(message, messageType, datetime, sender, receiver, chatNo);
		
		switch (messageType) {
			case "NOTIFY_NEW_LETTER" :
				const i = document.createElement("i");
				i.classList.add('fa-regular', 'fa-bell', 'bell');
				i.addEventListener('click', () => {
					alert(message);
					i.remove();
				});
				
				notification.append(i);
				break;
			case "NOTIFY_NEW_COMMENT" :
				const notification = document.querySelector("#notification");
				const i1 = document.createElement("i");
				i1.classList.add('fa-solid', 'fa-bell', 'bell');
				i1.addEventListener('click', () => {
					alert(message);
					i1.remove();
				});
				
				notification.append(i1);
				break;
			case "CHATROOM_ENTER" :
				$.ajax({
					url: `http://localhost:8080/comma/chat/chatLoad`,
					data: {chatNo},
					dataType: "json",
					success(chatLogs){
						console.log(chatLogs);
						chatLogs.forEach((log)=>{
							if(log.memberNick == memberId){
								wrapper.insertAdjacentHTML('beforeend', `<div class="right ${log.memberNick} fontStyle"><span class="sender">${log.memberNick}</span> <span id="message" class="pointColor">${log.content}</span></div>`);
							} else{
								wrapper.insertAdjacentHTML('beforeend', `<div class="left ${log.memberNick} fontStyle"><span class="sender">${log.memberNick}</span><span id="message" class="pointColor">${log.content}</span></div>`);
							}	
						})
					},
					error: console.log,
					complete: wrapper.insertAdjacentHTML('beforeend', `<div class="line fontStyle">${sender}님이 입장했습니다.</div>`)
				});
				
				// beforeend : 마지막에 넣어달라
				break;
			case "CHATROOM_LEAVE" :
				wrapper.insertAdjacentHTML('beforeend', `<div class="line fontStyle">${sender}님이 퇴장했습니다.</div>`);		
				break;
			case "CHAT_MSG" :
				console.log(sender, memberId);
				if(sender == memberId){
					wrapper.insertAdjacentHTML('beforeend', `<div class="right ${memberId} fontStyle"><span class="sender">${sender}</span> <span id="message" class="pointColor">${message}</span></div>`);
				} else{
					wrapper.insertAdjacentHTML('beforeend', `<div class="left ${memberId} fontStyle"><span class="sender">${sender}</span> <span id="message" class="pointColor">${message}</span></div>`);
				}		
				break;
		} // switch end
		
		// 스크롤 처리
		wrapper.scrollTop = wrapper.scrollHeight;
	});
	ws.addEventListener('error', (e) => {
		console.log('error : ', e);
	});
	ws.addEventListener('close', (e) => {
		console.log('close : ', e);
	});
	
}, 500);