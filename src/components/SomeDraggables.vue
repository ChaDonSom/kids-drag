<script setup lang="ts">
import { onMounted, ref } from 'vue'
import draggable from 'vuedraggable'
import { useIconsStore } from '@/stores/icons'

const draggables = ref<Array<{ name: string, id: number }>>([
])

const icons = useIconsStore()

function add() {
  draggables.value.push({
    name: icons.icons[Math.floor(Math.random() * icons.icons.length)],
    id: Math.random()
  })
}

onMounted(() => icons.getIcons())
</script>

<template>
  <div 
      class="flex flex-row flex-wrap gap-5"
  >
    <draggable
        :list="draggables"
        item-key="id"
        tag="transition-group"
        :component-data="{ name: 'move' }"
        :animation="200"
    >
      <template #item="{ element }">
        <div
            class="bg-gray-200 rounded-3xl h-24 w-24 flex border-2 border-black"
        >
          <div class="m-auto material-icons">{{ element.name }}</div>
        </div>
      </template>
    </draggable>
  </div>
  <div class="my-5">
    <button class="fixed bottom-6 right-6 bg-gray-100 rounded-3xl h-12 w-12 flex border-2 border-gray-200"
        @click="add"
    >
      <div class="m-auto material-icons">add</div>
    </button>
  </div>
</template>