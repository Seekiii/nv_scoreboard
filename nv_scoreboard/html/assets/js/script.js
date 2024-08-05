var curJob = null
var playerlist = []
var firstTime = true
window.addEventListener('message', function(e) {
    var data = e.data
    if (data.type == "playerlist"){
        playerlist = data.data
        load_players(playerlist)
    }
    if (data.type == "visible"){
        if (firstTime){
            $("html").append(`<style>:root{--main:${data.theme[0]},${data.theme[1]},${data.theme[2]}}</style>`)
            firstTime = false
        }
        open_scoreboard(data.data)
    }
});

$(document).keydown(function(e) {
    if (e.key === "Escape") {$.post("https://nv_scoreboard/exit")}
});

function open_scoreboard(status){
    if (status){$("body").fadeIn(200)}
    else{$("body").fadeOut(200);}
}

$(document).on("click","#scoreboard .tags .item",function(){
    $("#scoreboard .tags .item.act").removeClass("act")
    $(this).addClass("act")
    curJob = $(this).attr("job")
    load_players(playerlist,curJob)
})

function load_players(list, job){
    var name = $(".search").val()
    $(".players-list").html("")
    list.sort((a, b) => a.id - b.id)
    list.forEach(function(player){
        if (job && job != "all"){if (player.job != job){return}}
        if (name && !player.name.toLowerCase().includes(name.toLowerCase())){return}
        $(".players-list").prepend(`
            <div class="player" s_id="${player.id}">
                <p><span>${player.id}</span> ${player.name}</p>
                <b class="job ${player.job}">${player.job}</b>
            </div>
        `)
    })
}

function xss(text){return text.replaceAll("<","&lt;").replaceAll(">","&gt;")}