# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT83 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "e77070c178073ed2b688945eefd51bfcf5ed20d1e87f673e300604f94e89209b"
    sha256 cellar: :any,                 arm64_big_sur:  "3af823cbc3b704f3d31a64a068019d0a0f96becc6aca6b06a1794ac59f29f151"
    sha256 cellar: :any,                 ventura:        "ed2772717fe617e14abc7231c7bbfa6501d067ff9577dca62b3a7dcd8db9081b"
    sha256 cellar: :any,                 monterey:       "1fd2e22b537b61f210c6b0b7a023b10ce43857cdb94a7ea8ba664069917c7ab9"
    sha256 cellar: :any,                 big_sur:        "fac010fa2df620e7b5d9c1ee62664388c5be8f9c186d47bf9de6264132294c65"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "29342a46e4c1ea6713dbaf556f698ecdec3e0f1ad3ca2e34a45a583bb0fa233f"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    inreplace "php_gearman_worker.c", "ZVAL_NEW_ARR", "array_init"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
