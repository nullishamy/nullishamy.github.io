<script>
  import { Hash } from '@steeze-ui/phosphor-icons';
  import { Icon } from '@steeze-ui/svelte-icon';
  import { Slugger } from 'marked';

  export let depth;
  export let raw;
  export let text;

  const slugger = new Slugger();
  $: id = slugger.slug(text);
</script>

{#if depth === 1}
  <h1
    {id}
    class="flex flex-row items-center justify-items-center gap-6"
  >
    <a
      href="#{id}"
      aria-label="Link to the {id} section of the article"
      class="text-sky min-h-15 min-w-15"
    >
      <Icon size="30" src={Hash} />
    </a>
    <slot></slot>
  </h1>
{:else if depth === 2}
  <h2
    {id}
    class="flex flex-row items-center justify-items-center gap-6"
  >
    <a
      href="#{id}"
      aria-label="Link to the {id} section of the article"
      class="text-sky"
    >
      <Icon size="30" src={Hash} />
    </a>
    <slot></slot>
  </h2>
{:else if depth === 3}
  <h3
    {id}
    class="flex flex-row items-center justify-items-center gap-6"
  >
    <a
      href="#{id}"
      aria-label="Link to the {id} section of the article"
      class="text-sky"
    >
      <Icon size="30" src={Hash} />
    </a>
    <slot></slot>
  </h3>
{:else if depth === 4}
  <h4
    {id}
    class="flex flex-row items-center justify-items-center gap-6"
  >
    <a
      href="#{id}"
      aria-label="Link to the {id} section of the article"
      class="text-sky"
    >
      <Icon size="30" src={Hash} />
    </a>
    <slot></slot>
  </h4>
{:else if depth === 5}
  <h5
    {id}
    class="flex flex-row items-center justify-items-center gap-6"
  >
    <a
      href="#{id}"
      aria-label="Link to the {id} section of the article"
      class="text-sky"
    >
      <Icon size="30" src={Hash} />
    </a>
    <slot></slot>
  </h5>
{:else if depth === 6}
  <h6
    {id}
    class="flex flex-row items-center justify-items-center gap-6"
  >
    <a
      href="#{id}"
      aria-label="Link to the {id} section of the article"
      class="text-sky"
    >
      <Icon size="30" src={Hash} />
    </a>
    <slot></slot>
  </h6>
{:else}
  {raw}
{/if}
