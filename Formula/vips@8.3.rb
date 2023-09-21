# typed: false
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
    rebuild 8
    sha256 cellar: :any,                 arm64_ventura:  "f3174d5e02c86dc618530c3e5ba6749d196db93c716aa8c76e2365d6e13f693d"
    sha256 cellar: :any,                 arm64_monterey: "8d40d8111003d0d3d5b7b21460e33205c626ce429578ece71e6f07cd30c9f9ae"
    sha256 cellar: :any,                 arm64_big_sur:  "41a3cc8088daca1b00ea4f6d6f6cd5b510671c97a89b9328792bbb280e6d7741"
    sha256 cellar: :any,                 ventura:        "65930316b46a5b508ebd874feba9de8a1c8709c5ce36d21bf5bf0368d5bd154b"
    sha256 cellar: :any,                 monterey:       "fc49fbbf682a32cef09ee0ceb383b2390e749bc92b5de4272d1db20ab4841315"
    sha256 cellar: :any,                 big_sur:        "03fa87d5ae5162b4d01b58119d80113765c3763c5afc23f5a9dc13f5be60df64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1a76b4545d9f97e350384105a04c42a9383d6147ce2a564d4ae36b63033e44ea"
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
