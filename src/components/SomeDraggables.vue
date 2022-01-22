<script setup lang="ts">
import { ref } from 'vue'
import draggable from 'vuedraggable'

const draggables = ref([
  {
    label: 'Hi'
  }
])
</script>

<template>
  <draggable
      :list="draggables"
  >
    <template #item="{ element }">
      <div>{{ element.label }}</div>
    </template>
  </draggable>
</template>
