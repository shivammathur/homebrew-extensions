# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT73 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.2.tgz"
  sha256 "46ac184d0f67913ef5fbbd65596bd193a2ef11a7af896a7efd81d671a5230277"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_ventura:  "9714f6bc81d149898f9b9ee11108c03369c88a3f263fc5debac7125f487a2dd7"
    sha256 cellar: :any,                 arm64_monterey: "50ccb9b0846850bf9437626de3550ea57eb7be3fa43b30e60245af9ad44d2db6"
    sha256 cellar: :any,                 arm64_big_sur:  "7b623d5d4f8ada49848b83c5486624fa3c594da299c90b0bd9be30feac4c741f"
    sha256 cellar: :any,                 ventura:        "e8060409fb5f432b8195fa95d35346dde2068b416621d485ab7196b9c595989f"
    sha256 cellar: :any,                 monterey:       "1953b0455c85af91593b4cd2d609de17ed2534260443fde8974aa44cf159299b"
    sha256 cellar: :any,                 big_sur:        "80f5d28ff80cfeb8a274365508b2c9d89d1691652dbec784918674fc5d6914c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "db11862fec12bc7ce5cd72cb492f4c573d28e0548b73877485e054445e36e419"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
