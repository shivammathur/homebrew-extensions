# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT81 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_ventura:  "e9a472c43d81f7b2156d80e0bf02e269884b76fe489b307438d1bc6d7d330194"
    sha256 cellar: :any,                 arm64_monterey: "c837545cdd87500e2b995f38f536c8eb08fe41fde6891b272ce41b0be6bd0ed9"
    sha256 cellar: :any,                 arm64_big_sur:  "b7f6bc155a882077e29872d40e0734bfeb6c94dd6b0eba0df5e6b05f4e534f60"
    sha256 cellar: :any,                 ventura:        "92ed3cef0b757796caff0a7fbbb1f8d81d69219026f90bf425be5e3ef79b0e5e"
    sha256 cellar: :any,                 monterey:       "66ded56dd3120e85d09b98d6857401151625e75a44851bd93e886f0acf3ca1c6"
    sha256 cellar: :any,                 big_sur:        "742fbe5094b013952621f52858520b52c8735f0f4e6b7762ac742e6faa405bba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4d3f9896bf790f8bb0b28aeb5a0f46bfb00d7f5f0cc6cfaf867148368f19a815"
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
