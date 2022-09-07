# typed: false
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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "7a4074077ee306c09f8b758a48ca341700ea3a35b0738faf5626d7dbfd3157c7"
    sha256 cellar: :any,                 arm64_big_sur:  "27704177864a110b32f0954046b2658e1a40f06cfc01bcc30929b262c9da4a0a"
    sha256 cellar: :any,                 monterey:       "c4b8cb0a6616808b775d1d7daf8abd6201c840755d9b8b121b8b55d34d721210"
    sha256 cellar: :any,                 big_sur:        "0c5f6723a575810415f5cf7a084799e5272bc234d9f8365fcb92a775de840f6d"
    sha256 cellar: :any,                 catalina:       "5b8c9acbab19aede94732eef385649f2b6e41644f482132276c995492560d663"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c36a1f940b27ee4236d9bcb7a5b654448b7624561eda62a1d625165cd94ea39f"
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
