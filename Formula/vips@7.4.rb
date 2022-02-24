# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "5a92138b11f0abe5717fa19cad1c9ce36d88df4c14928452391ca0510ccd7cbe"
    sha256 cellar: :any,                 big_sur:       "7958f0c921fcb06336a98c59ec7f5e57b8603764cfaa0e6155a1b6ff5bd3cda2"
    sha256 cellar: :any,                 catalina:      "5f6c866d9f8e68647b658489d25588e7d755f9787f06e894f7e06cd66b1a14ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d446fa5ae468a47353c74a600be25a9f24176d5f30c2ac2688d5684c243566bd"
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
