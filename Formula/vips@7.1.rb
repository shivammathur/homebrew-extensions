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
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "26a74c40683660cc42c1cd7d331dd95d72c5867e6a5ec39ab46891de97525b40"
    sha256 cellar: :any,                 big_sur:       "ef4aac2b52a4a22278701d540dc188e44c861ceedd59fceff7ba319ac017eee5"
    sha256 cellar: :any,                 catalina:      "a329bfbdda932c271057c468b3533eef5475ba1de791d477e5faee71e2b21bf0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8c58b83a20eefe6f9bd72762f3351e1d4245f91b9ac9580f2ffb26370888a372"
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
