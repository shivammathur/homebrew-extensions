# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT71 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "e5612ad1d7bd1c46da896105b058259228fc9422d8233f86bf70d572eaad00e6"
    sha256 cellar: :any,                 arm64_sonoma:  "4895ec42d8a2c1d49ff0775614eca22b621011b41da0a0a37d0271572cdb655b"
    sha256 cellar: :any,                 arm64_ventura: "49c5c4d197023f387fde4ae09ae206fd7223da5a6c410bec825284493284b671"
    sha256 cellar: :any,                 ventura:       "9dbb02bea37257e56b112afe936fc0c41fe5e340f87cd94ffaf8accb126198b9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "852f09d361644a77206a1ae090ba0f235267811af456e4dfab7250699b4c7b77"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c1db4a519b3924e75695bdc88e25dc9957268c3b7866e564b12577ada9a57b55"
  end

  depends_on "gettext"
  depends_on "glib"
  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Formula["vips"].opt_prefix}
    ]
    Dir.chdir "vips-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
