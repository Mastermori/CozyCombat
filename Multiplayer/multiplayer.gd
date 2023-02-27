extends Node

func host(port: int) -> bool:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return false
	multiplayer.multiplayer_peer = peer
	Global.player.set_authority(peer.get_unique_id())
	return true

func conn(ip: String, port: int) -> bool:
	if ip == "":
		OS.alert("Need a remote to connect to.")
		return false
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, port)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return false
	multiplayer.multiplayer_peer = peer
	Global.player.queue_free()
	return true
