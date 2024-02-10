# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT84 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "c01bf7a3bca47e9fce420d59c28f79e618a81b279d6105aa97e03e74e05b4a2c"
    sha256 cellar: :any,                 arm64_ventura:  "d5c3b5563c46c2c32c92206655c0508bd57dcb972eda57d3ac38310a839d61ff"
    sha256 cellar: :any,                 arm64_monterey: "f67cc057aa63cbc7920f8ab718774cc0b9d44edcc7dbcae9563ea6c998102db1"
    sha256 cellar: :any,                 ventura:        "600d7d1c112f833b3c8f90d94b999e843ed6ee1f692c7d6952b8b4b14fead7f4"
    sha256 cellar: :any,                 monterey:       "2112c8e205de7a7363fd675c4fc44864ab17c321e4ded471cbba1fbb0dc28a69"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7db01ef099aa2d8b1ed92a60b04df7c14435d5aa0c4542fe1cc7f8770430ba21"
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
