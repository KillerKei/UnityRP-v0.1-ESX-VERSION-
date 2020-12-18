resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

-- Example custom radios
supersede_radio "RADIO_01_CLASS_ROCK" { url = "http://media-ice.musicradio.com:80/Gold", volume = 0.1, name = "GOLD" }
supersede_radio "RADIO_02_POP" { url = "http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p?s=1569781025&e=1569795425&h=48e2341ad6d3ee50de2a834a986f3583", volume = 0.1, name = "BBC R1Xtra" }
supersede_radio "RADIO_03_HIPHOP_NEW" { url = "http://media-ice.musicradio.com:80/CapitalUKMP3", volume = 0.1, name = "Capital FM" }
supersede_radio "RADIO_04_PUNK" { url = "http://media-ice.musicradio.com:80/CapitalXTRAReloaded", volume = 0.1, name = "CapXTRA Reloaded" }
supersede_radio "RADIO_05_TALK_01" { url = "http://tx.planetradio.co.uk/icecast.php?i=kissnational.mp3", volume = 0.1, name = "KISS" }
supersede_radio "RADIO_06_COUNTRY" { url = "http://tx.planetradio.co.uk/icecast.php?i=kisstory.mp3", volume = 0.1, name = "KISSTORY" }
supersede_radio "RADIO_07_DANCE_01" { url = "http://tx.planetradio.co.uk/icecast.php?i=kissfresh.mp3", volume = 0.1, name = "KISS Fresh" }
supersede_radio "RADIO_08_MEXICAN" { url = "http://radio.virginradio.co.uk/stream?ref=rf", volume = 0.1, name = "Virgin Radio" }
supersede_radio "RADIO_09_HIPHOP_OLD" { url = "http://media-ice.musicradio.com:80/HeartUKMP3", volume = 0.1, name = "Heart" }
supersede_radio "RADIO_12_REGGAE" { url = "http://tx.planetradio.co.uk/icecast.php?i=hits.aac", volume = 0.1, name = "Hits Radio" }
supersede_radio "RADIO_13_JAZZ" { url = "http://media-ice.musicradio.com:80/SmoothUK", volume = 0.1, name = "Smooth" }
supersede_radio "RADIO_14_DANCE_02" { url = "http://live-absolute.sharp-stream.com/absolute90shigh.aac", volume = 0.1, name = "Absolute Radio 90s" }
supersede_radio "RADIO_15_MOTOWN" { url = "http://str1.sad.ukrd.com/pirate-east", volume = 0.1, name = "Pirate FM" }
supersede_radio "RADIO_16_SILVERLAKE" { url = "http://live-absolute.sharp-stream.com/absolute00shigh.aac", volume = 0.1, name = "Absolute Radio 00s" }
supersede_radio "RADIO_17_FUNK" { url = "http://tx.planetradio.co.uk/icecast.php?i=viking.aac", volume = 0.1, name = "Viking FM" }
supersede_radio "RADIO_18_90S_ROCK" { url = "http://edge-audio-01-cr.sharp-stream.com:80/kmfmdab.mp3", volume = 0.1, name = "kmfm" }
supersede_radio "RADIO_20_THELAB" { url = "http://media-ice.musicradio.com:80/RadioXUKMP3", volume = 0.1, name = "Radio X" }
supersede_radio "RADIO_11_TALK_02" { url = "http://radio.talksport.com/stream?aisGetOriginalStream=true", volume = 0.1, name = "talkSPORT" }
supersede_radio "RADIO_21_DLC_XM17" { url = "http://gbradio.cdn.tibus.net/TASTK?ref=rf", volume = 0.1, name = "Total Access" }
supersede_radio "RADIO_22_DLC_BATTLE_MIX1_RADIO" { url = "http://radio3.citrus3.com:8584/stream", volume = 0.1, name = "Panjab Radio" }

files {
	"index.html"
}

ui_page "index.html"

client_scripts {
	"data.js",
	"client.js"
}

