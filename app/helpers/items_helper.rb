module ItemsHelper
  def platform_icon(platform)
    {
      "PC" => "fa-solid fa-desktop",
      "XBOX" => "fa-brands fa-xbox",
      "PlayStation" => "fa-brands fa-playstation",
      "Nintendo" => "fa-solid fa-gamepad",
      "Sega" => "fa-solid fa-gamepad"
    }[platform]
  end
end
