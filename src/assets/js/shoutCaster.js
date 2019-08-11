import sounds from './sounds'

class ShoutCaster {
  constructor(userId, socket) {
    socket.connect()
    this.channel = socket.channel(`users:${userId}`, {})

    this.setUpChannel()
    this.setUpFriends()
  }

  setUpChannel() {
    this
      .channel
      .join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    this.channel.on("received_shout", (resp) => {
      console.log("Shout Received:", resp.message)
      const teamId = resp.team_id
      sounds[teamId].play()
    })
  }

  joinChannel() {
    this
      .channel
      .join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })
  }

  setUpFriends() {
    const friends = Array.from(document.querySelectorAll('.shout'))

    friends.forEach((friend) => {
      friend.addEventListener('click', (e) => {
        let element = e.target
        let friendId = element.getAttribute('data-friend-id')
        this.sendShout(friendId)
      })
    })
  }

  sendShout(friendId) {
    this.channel.push("send_shout", {recipient_id: friendId}).receive("error", e => console.log(e))
  }
}

export default ShoutCaster
