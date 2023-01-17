# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/imagick@8.2-3.7.0"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "845a77b0bb608e174f984bda520f9f66749a70da9f1c96fe62c46608a8264a5c"
    sha256 cellar: :any,                 arm64_big_sur:  "0091c1bec8e406cd21aab4750b29c73df57c12c6ef127daafe9634f945165136"
    sha256 cellar: :any,                 monterey:       "44079e87b6325e389f52b149b98e0e63ad6371abaff9df2df8dee9a8a4059f60"
    sha256 cellar: :any,                 big_sur:        "cdb077fde39738497735a412302ffe6a1a3a4a90e32b57bd848464798dbf9684"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ce480bb0137283ab33678e486e457897bbfacc5547888b69c1683cf3e533b18e"
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
