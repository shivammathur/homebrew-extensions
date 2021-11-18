# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.6.0.tgz"
  sha256 "4e2965f2d70dd59a40e7957d56e590e731cad2669e9f89e0fca159d748d2947e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_big_sur: "3715f7798c983c889aaa996a5354aee928a5488669d6de592810dc22b65516ba"
    sha256                               big_sur:       "0656599462f8cb9930812c4e106a7ec495a3838c04ac1cc8fb5243bb6cb4e62f"
    sha256                               catalina:      "324afb60ecf73fbe3721427c811e4c3ba8918c515335e5fad86c48e0ece76685"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "505a1098bac2e7262127d9899f82f1ee97d166308084cfb3901c4d820b1c8cd2"
  end

  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
