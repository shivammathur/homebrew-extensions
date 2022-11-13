# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT73 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "f5a2ed60ce079bc20f9a07029ffb86e51b9597a662655da1530a5b5d56b2a440"
    sha256 cellar: :any,                 arm64_big_sur:  "7b623d5d4f8ada49848b83c5486624fa3c594da299c90b0bd9be30feac4c741f"
    sha256 cellar: :any,                 monterey:       "4b8bf5fb5b4473b83a08a9050326c0f6786b64f0091bc3ff10687267bae4670b"
    sha256 cellar: :any,                 big_sur:        "80f5d28ff80cfeb8a274365508b2c9d89d1691652dbec784918674fc5d6914c2"
    sha256 cellar: :any,                 catalina:       "251f5ebc7313c9202d30d0ddbe83a841ea8607e402624e2db604b12c91d117d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7af083face790b39df2a5fd2da9fce29bd861542dae07c464a13981e9978bd7f"
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
