extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal regen_blood(amount)
signal save_score(uuid)

# Blood drain in mL every second
var bloodRegenMlPerSecond = 100
var timeSinceLastRegen = 0

var timeSinceLastHeartbeat = 0
var secondsBetweenHeartbeats = 2
var uuid = ""

static func getRandomInt(max_value):
  randomize()

  return randi() % max_value

static func randomBytes(n):
  var r = []

  for index in range(0, n):
    r.append(getRandomInt(256))

  return r

static func uuidbin():
  var b = randomBytes(16)

  b[6] = (b[6] & 0x0f) | 0x40
  b[8] = (b[8] & 0x3f) | 0x80
  return b

static func v4():
  var b = uuidbin()

  var low = '%02x%02x%02x%02x' % [b[0], b[1], b[2], b[3]]
  var mid = '%02x%02x' % [b[4], b[5]]
  var hi = '%02x%02x' % [b[6], b[7]]
  var clock = '%02x%02x' % [b[8], b[9]]
  var node = '%02x%02x%02x%02x%02x%02x' % [b[10], b[11], b[12], b[13], b[14], b[15]]

  return '%s-%s-%s-%s-%s' % [low, mid, hi, clock, node]

# Called when the node enters the scene tree for the first time.
func _ready():
	start_music()
	set_process(true)
	uuid = v4()

func start_music():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://assets/veins_of_gold_bg.ogg")
	player.volume_db = -25.0
	player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeSinceLastRegen = timeSinceLastRegen + delta
	timeSinceLastHeartbeat += delta
	if timeSinceLastRegen >= 1.0:
		emit_signal("regen_blood", bloodRegenMlPerSecond)
		timeSinceLastRegen = 0
	if timeSinceLastHeartbeat >= secondsBetweenHeartbeats:
		timeSinceLastHeartbeat = 0
		emit_signal("save_score", uuid)

