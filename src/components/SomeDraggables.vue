<script setup lang="ts">
import { ref } from 'vue'
import draggable from 'vuedraggable'

const draggables = ref([
  { name: 'Hi', id: 0 },
  { name: 'Dog', id: 1 },
  { name: 'Tip', id: 2 },
  { name: 'Tag', id: 3 },
  { name: 'Tow', id: 4 },
  { name: 'Cow', id: 5 },
  { name: 'Ran', id: 6 },
  { name: 'Hid', id: 7 },
  { name: 'There', id: 8 },
  { name: 'That', id: 9 },
  { name: 'Pig', id: 10 },
])
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
          <div class="m-auto">{{ element.name }}</div>
        </div>
      </template>
    </draggable>
  </div>
</template>