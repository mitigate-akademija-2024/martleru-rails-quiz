module ApplicationHelper

    def get_btn_class
        "inline-block rounded border border-indigo-600 bg-indigo-600 px-12 py-3 text-sm font-medium text-white hover:bg-transparent hover:text-indigo-600 focus:outline-none focus:ring active:text-indigo-500"
    end

    def get_add_btn_class
        "inline-block rounded-md border border-gray-300 bg-gray-100 px-8 py-3 text-base font-medium text-gray-800 hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-gray-300 md:px-6 md:py-2 md:text-sm"
    end

    def get_form_class
        "max-w-lg mx-auto p-6 border border-gray-300 rounded-lg bg-white shadow-md space-y-4"
    end

    def format_date(date)
        date.strftime('%F')
    end

    def destroy_quiz_svg
        '<svg fill="#000000" height="24px" width="24px" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512 512" xml:space="preserve"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g> <g> <path d="M372.87,200.349v228.175c0,9.22-7.475,16.696-16.696,16.696c-9.221,0-16.696-7.475-16.696-16.696V200.349h-66.783v228.175 c0,9.22-7.475,16.696-16.696,16.696c-9.22,0-16.696-7.475-16.696-16.696V200.349h-66.783v228.175 c0,9.22-7.475,16.696-16.696,16.696c-9.221,0-16.696-7.475-16.696-16.696V200.349H72.347v294.958 c0,9.214,7.482,16.693,16.696,16.693h333.914c9.214,0,16.696-7.481,16.696-16.693V200.349H372.87z"></path> </g> </g> <g> <g> <path d="M456.349,66.783h-116.87V16.696c0-9.161-7.46-16.696-16.696-16.696H189.217c-9.18,0-16.696,7.477-16.696,16.696v50.087 H55.651c-9.18,0-16.696,7.477-16.696,16.696v66.783c0,9.214,7.482,16.693,16.696,16.693h400.697 c9.214,0,16.696-7.481,16.696-16.693V83.479C473.044,74.317,465.585,66.783,456.349,66.783z M306.087,66.783H205.913V33.391 h100.174V66.783z"></path> </g> </g> </g></svg>'
      end
end
