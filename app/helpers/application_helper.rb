module ApplicationHelper  
  def get_btn_class
    "inline-block rounded-md bg-blue-600 text-white px-4 py-2 text-sm font-medium hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-300 cursor-pointer"
  end 

  def get_play_button
    "bg-indigo-600 text-white font-bold py-3 px-24 rounded-lg hover:bg-indigo-700 transition-colors duration-300 text-xl"
  end

  def get_add_btn_class
      "inline-block rounded-md border border-gray-300 bg-gray-100 px-8 py-3 text-base font-medium text-gray-800 hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-gray-300 md:px-6 md:py-2 md:text-sm"
  end

  def get_form_class
      "max-w-lg mx-auto p-6 border border-gray-300 rounded-lg bg-white shadow-md space-y-4"
  end 

  def format_date(format, date, timezone = 'Europe/Moscow')
    date_in_timezone = date.in_time_zone(timezone)
  
    case format
    when 'date'
      date_in_timezone.strftime('%F')
    when 'date_time'
      date_in_timezone.strftime('%F %H:%M')
    when 'month'
      date_in_timezone.strftime("%B %d, %Y")
    else
      date_in_timezone
    end
  end
  
  def search_svg(height, width)
    "<svg fill=\"#000000\" width=\"#{width}px\" height=\"#{height}px\" viewBox=\"0 0 #{height} #{width}\" xmlns=\"http://www.w3.org/2000/svg\">
       <g id=\"SVGRepo_bgCarrier\" stroke-width=\"0\"></g>
       <g id=\"SVGRepo_tracerCarrier\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></g>
       <g id=\"SVGRepo_iconCarrier\"> 
         <path fill=\"#000000\" fill-rule=\"evenodd\" d=\"M4 9a5 5 0 1110 0A5 5 0 014 9zm5-7a7 7 0 104.2 12.6.999.999 0 00.093.107l3 3a1 1 0 001.414-1.414l-3-3a.999.999 0 00-.107-.093A7 7 0 009 2z\"></path> 
       </g>
     </svg>"
  end
  
end
