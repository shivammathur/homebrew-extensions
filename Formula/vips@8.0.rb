# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT80 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "4e598f0fe520329673080294c0cacdc9cf2f232bd27f0f2e61513a2aca1d1ae4"
    sha256 cellar: :any,                 arm64_big_sur:  "7e95104a4e7e868b20db3c30725841d13694bb5d2e4ea5a78cb471af3535e64a"
    sha256 cellar: :any,                 monterey:       "36d7550fb5e32a318ad8d8ce670b0a9ccd2cb432db195d943dad42ab5888002b"
    sha256 cellar: :any,                 big_sur:        "9441a2b5918d4069f18d6c9192e6cbc2dfa9ed1412f1346cce1d5d2d153046e4"
    sha256 cellar: :any,                 catalina:       "75cbe37743be7a991d8983139c6edd725e8d6144dfcaf98311e66d1013dec9c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5f0b5bac038616c6eacd092346b46a57710d3a687400ac5bd9d77a80565368a6"
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
