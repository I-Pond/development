export default function Progress({ percent, name }) {
  return (
    <>
      <div
        class="flex items-center flex-wrap max-w-md px-10 bg-white shadow-xl rounded-2xl h-20"
        x-data="{ circumference: 50 * 2 * Math.PI, percent: 80 }"
      >
        <div class="flex items-center justify-center -m-6 overflow-hidden bg-white rounded-full">
          <svg
            class="w-32 h-32 transform translate-x-1 translate-y-1"
            x-cloak
            aria-hidden="true"
          >
            <circle
              class="text-gray-300"
              stroke-width="10"
              stroke="currentColor"
              fill="transparent"
              r="50"
              cx="60"
              cy="60"
            />
            <circle
              class="text-blue-600"
              stroke-width="10"
              // :stroke-dasharray="circumference"
              // :stroke-dashoffset="circumference - percent / 100 * circumference"
              stroke-linecap="round"
              stroke="currentColor"
              fill="transparent"
              r="50"
              cx="60"
              cy="60"
            />
          </svg>
          <span
            class="absolute text-2xl text-blue-700"
            x-text="`${percent}%`"
          ></span>
        </div>
        <p class="ml-10 font-medium text-gray-600 sm:text-xl">{name}</p>

        <span class="ml-auto text-xl font-medium text-blue-600 hidden sm:block">
          {percent}%
        </span>
      </div>
    </>
  );
}
