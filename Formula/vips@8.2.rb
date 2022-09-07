# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT82 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "d8526a9206d8a62a9bcbbf04aefa50d3e0272c1db8d7d405f2959c0709fd9c9e"
    sha256 cellar: :any,                 arm64_big_sur:  "9080e78258d5227e47b5b6ba5413dbc51ff91e25d7d7bcad529a4b1abdbf8001"
    sha256 cellar: :any,                 monterey:       "0291eab75adfae5ae87f07b100ae55b14bcba547aa0fb453f84432b8a8089316"
    sha256 cellar: :any,                 big_sur:        "ffa3f8725c2bcb7417c70ffc5fc4de0d6c2492dac30f19fb7e88dfff86df1b13"
    sha256 cellar: :any,                 catalina:       "9ce586b25f078eefedbf3ee69ac5cd03a836070c48f9f9402bbb280f3dc9e124"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "16e6c17516e163f8826f220ae43433b05c704a2d50079e544b259a01acadbb66"
  end

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
