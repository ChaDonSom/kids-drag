<script setup lang="ts">
import { onMounted, ref } from 'vue'
import draggable from 'vuedraggable'
import { useIconsStore } from '@/stores/icons'
import goldfishImage from '@/assets/goldfish.png'

const draggables = ref<Array<{ name?: string, img?: string, id: number, color: string }>>([
])

/**
Whether any draggables are being dragged or not
 */
const drag = ref(false)

const colors = ref([
  'red',
  'yellow',
  'orange',
  'green',
  'blue',
  'purple',
  'brown',
  'gray',
  'black',
])

const icons = useIconsStore()

function add() {
  draggables.value.push({
    name: icons.icons[Math.floor(Math.random() * icons.icons.length)],
    color: colors.value[Math.floor(Math.random() * colors.value.length)],
    id: Math.random()
  })
}

function addFish() {
  draggables.value.push({
    img: goldfishImage,
    color: colors.value[Math.floor(Math.random() * colors.value.length)],
    id: Math.random()
  })
}

function remove() {
  draggables.value.pop()
}

function reset() {
  draggables.value = []
}

function shuffle() {
  draggables.value = shuffleArray(draggables.value)
}

function shuffleArray<T>(array: Array<T>): Array<T> {
  let currentIndex = array.length,  randomIndex;

  // While there remain elements to shuffle...
  while (currentIndex > 0) {

    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex--;

    // And swap it with the current element.
    [array[currentIndex], array[randomIndex]] = [
      array[randomIndex], array[currentIndex]];
  }

  return array;
}

function getCorrectTextColor(hex?: string | false) {
  /*
  From this W3C document: http://www.webmasterworld.com/r.cgi?f=88&d=9769&url=http://www.w3.org/TR/AERT#color-contrast
  Color brightness is determined by the following formula: 
  ((Red value X 299) + (Green value X 587) + (Blue value X 114)) / 1000
  */
  if (!hex) return 'black'
  let threshold = 130; /* about half of 256. Lower threshold equals more dark text on dark background  */
  let hRed = hexToR(hex);
  let hGreen = hexToG(hex);
  let hBlue = hexToB(hex);
  function hexToR(h: string) {return parseInt((cutHex(h)).substring(0,2),16)}
  function hexToG(h: string) {return parseInt((cutHex(h)).substring(2,4),16)}
  function hexToB(h: string) {return parseInt((cutHex(h)).substring(4,6),16)}
  function cutHex(h: string) {return (h.charAt(0)=="#") ? h.substring(1,7):h}
  let cBrightness = ((hRed * 299) + (hGreen * 587) + (hBlue * 114)) / 1000;

  if (cBrightness > threshold) return "#000000"
  else return "#ffffff"
}

function colorNameToHex(color: string) {
    var colors: { [key: string]: string } = {"aliceblue":"#f0f8ff","antiquewhite":"#faebd7","aqua":"#00ffff","aquamarine":"#7fffd4","azure":"#f0ffff",
    "beige":"#f5f5dc","bisque":"#ffe4c4","black":"#000000","blanchedalmond":"#ffebcd","blue":"#0000ff","blueviolet":"#8a2be2","brown":"#a52a2a","burlywood":"#deb887",
    "cadetblue":"#5f9ea0","chartreuse":"#7fff00","chocolate":"#d2691e","coral":"#ff7f50","cornflowerblue":"#6495ed","cornsilk":"#fff8dc","crimson":"#dc143c","cyan":"#00ffff",
    "darkblue":"#00008b","darkcyan":"#008b8b","darkgoldenrod":"#b8860b","darkgray":"#a9a9a9","darkgreen":"#006400","darkkhaki":"#bdb76b","darkmagenta":"#8b008b","darkolivegreen":"#556b2f",
    "darkorange":"#ff8c00","darkorchid":"#9932cc","darkred":"#8b0000","darksalmon":"#e9967a","darkseagreen":"#8fbc8f","darkslateblue":"#483d8b","darkslategray":"#2f4f4f","darkturquoise":"#00ced1",
    "darkviolet":"#9400d3","deeppink":"#ff1493","deepskyblue":"#00bfff","dimgray":"#696969","dodgerblue":"#1e90ff", "firebrick":"#b22222","floralwhite":"#fffaf0","forestgreen":"#228b22","fuchsia":"#ff00ff", "gainsboro":"#dcdcdc","ghostwhite":"#f8f8ff","gold":"#ffd700","goldenrod":"#daa520","gray":"#808080","green":"#008000","greenyellow":"#adff2f",
    "honeydew":"#f0fff0","hotpink":"#ff69b4", "indianred ":"#cd5c5c","indigo":"#4b0082","ivory":"#fffff0","khaki":"#f0e68c", "lavender":"#e6e6fa","lavenderblush":"#fff0f5","lawngreen":"#7cfc00","lemonchiffon":"#fffacd","lightblue":"#add8e6","lightcoral":"#f08080","lightcyan":"#e0ffff","lightgoldenrodyellow":"#fafad2",
    "lightgrey":"#d3d3d3","lightgreen":"#90ee90","lightpink":"#ffb6c1","lightsalmon":"#ffa07a","lightseagreen":"#20b2aa","lightskyblue":"#87cefa","lightslategray":"#778899","lightsteelblue":"#b0c4de",
    "lightyellow":"#ffffe0","lime":"#00ff00","limegreen":"#32cd32","linen":"#faf0e6", "magenta":"#ff00ff","maroon":"#800000","mediumaquamarine":"#66cdaa","mediumblue":"#0000cd","mediumorchid":"#ba55d3","mediumpurple":"#9370d8","mediumseagreen":"#3cb371","mediumslateblue":"#7b68ee",
    "mediumspringgreen":"#00fa9a","mediumturquoise":"#48d1cc","mediumvioletred":"#c71585","midnightblue":"#191970","mintcream":"#f5fffa","mistyrose":"#ffe4e1","moccasin":"#ffe4b5",
    "navajowhite":"#ffdead","navy":"#000080", "oldlace":"#fdf5e6","olive":"#808000","olivedrab":"#6b8e23","orange":"#ffa500","orangered":"#ff4500","orchid":"#da70d6", "palegoldenrod":"#eee8aa","palegreen":"#98fb98","paleturquoise":"#afeeee","palevioletred":"#d87093","papayawhip":"#ffefd5","peachpuff":"#ffdab9","peru":"#cd853f","pink":"#ffc0cb","plum":"#dda0dd","powderblue":"#b0e0e6","purple":"#800080",
    "rebeccapurple":"#663399","red":"#ff0000","rosybrown":"#bc8f8f","royalblue":"#4169e1", "saddlebrown":"#8b4513","salmon":"#fa8072","sandybrown":"#f4a460","seagreen":"#2e8b57","seashell":"#fff5ee","sienna":"#a0522d","silver":"#c0c0c0","skyblue":"#87ceeb","slateblue":"#6a5acd","slategray":"#708090","snow":"#fffafa","springgreen":"#00ff7f","steelblue":"#4682b4", "tan":"#d2b48c","teal":"#008080","thistle":"#d8bfd8","tomato":"#ff6347","turquoise":"#40e0d0",
    "violet":"#ee82ee", "wheat":"#f5deb3","white":"#ffffff","whitesmoke":"#f5f5f5", "yellow":"#ffff00","yellowgreen":"#9acd32"};

    if (typeof colors[color.toLowerCase()] != 'undefined')
        return colors[color.toLowerCase()];

    return false;
}

onMounted(() => icons.getIcons())
</script>

<template>
  <div class="fixed top-0 my-5 z-10 flex flex-row gap-5">
    <button class="bg-gray-100 rounded-3xl h-12 w-12 flex align-center border-2 border-gray-200"
        @click="reset"
    >
      <div class="m-auto material-icons">refresh</div>
    </button>
    <button class="bg-gray-100 rounded-3xl h-12 w-12 flex align-center border-2 border-gray-200"
        @click="shuffle"
    >
      <div class="m-auto material-icons">swap_horiz</div>
    </button>
  </div>
  <div 
      class="flex flex-row flex-wrap gap-5 mt-12"
  >
    <draggable
        item-key="id"
        tag="transition-group"
        :list="draggables"
        :component-data="{ name: drag ? null : 'fly' }"
        :animation="200"
        @start="drag = true"
        @end="drag = false"
    >
      <template #item="{ element }">
        <div
            class="rounded-3xl h-24 w-24 flex border-2 border-black"
            :style="{ backgroundColor: element.color }"
        >
          <div
              class="m-auto"
              :class="{
                'material-icons' : element.name
              }"
              :style="{
                color: getCorrectTextColor(colorNameToHex(element.color))
              }"
          >
            <span v-if="element.name">{{ element.name }}</span>
            <img v-if="element.img" :src="element.img">
          </div>
        </div>
      </template>
    </draggable>
  </div>
  <div class="my-5">
    <button class="fixed bottom-6 right-24 bg-gray-100 rounded-3xl h-12 w-12 flex border-2 border-gray-200"
        @click="addFish"
    >
      <div class="m-auto material-icons">set_meal</div>
    </button>
    <button class="fixed bottom-6 right-6 bg-gray-100 rounded-3xl h-12 w-12 flex border-2 border-gray-200"
        @click="add"
    >
      <div class="m-auto material-icons">add</div>
    </button>
    <button class="fixed bottom-6 right-33 bg-gray-100 rounded-3xl h-12 w-12 flex border-2 border-gray-200"
        @click="remove"
    >
      <div class="m-auto material-icons">remove</div>
    </button>
  </div>
</template>

<style scoped>
.fly-enter-from, .fly-leave-to {
  transform: translate(0, 1500px);
  opacity: 0;
}
.fly-enter-active, .fly-leave-active {
  transition: opacity 200ms ease-out,
    transform 350ms ease-out;
}
.fly-move {
  transition: transform 250ms ease;
}
</style>