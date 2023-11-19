# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT83 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sonoma:   "2f00e7f3a8db7c6de66dd4a0b83a4c3a36a2cd08d4e952659cc7b0674d6a74cd"
    sha256 cellar: :any,                 arm64_ventura:  "d9d3e0b0daddabe970beb16e1334e3e209275e33b9771a0c929e2d85958b7e97"
    sha256 cellar: :any,                 arm64_monterey: "d80e287d074e381943077459423c5bcc43c0337dfbf524c9f8cb1c426fe4f9c7"
    sha256 cellar: :any,                 ventura:        "c22badbacc935251e8072c62ee62f82231b34eb8c01e6574ee67af4204b644dd"
    sha256 cellar: :any,                 monterey:       "265b2cb1421b611e0a0f126bfa76367ee4fa91075c14ecbbcf46e5b2dbed813a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c5007edd3f6d4e52441cbf16c5be46a0b7d32acfaf588cea443736da5c297f07"
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
