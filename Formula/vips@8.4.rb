# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT84 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "eba75c7d23ba4c8cdbc8b781b99a10601cf65363ef6eb6953c070b11867601fd"
    sha256 cellar: :any,                 arm64_ventura:  "e58f9093229f9ebfc1b0a23ed49540d4ea563a0ea65062b9cf72fce7900c26ad"
    sha256 cellar: :any,                 arm64_monterey: "cc58cd397fa34e9938f4675c4b3940e58d87aadafaa1b4f324a63664badd397b"
    sha256 cellar: :any,                 ventura:        "aa1c66da845411c05e0ccdba05cea0d671af3bdc783c97b49977dcc4e80f585e"
    sha256 cellar: :any,                 monterey:       "86e70266794e352f0b7992d8dfdfa8a3758844b56148628c9e7f50f77a9fee69"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f9513eda4818efe7453647f105f007c79398b87dd68458cf65c2b5d7e5afff35"
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
