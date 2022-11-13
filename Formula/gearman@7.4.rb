# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "a96e9405cfe0ffb3dfdb363e51a903043a3af5ceee5f6c34c882affd8e769d28"
    sha256 cellar: :any,                 arm64_big_sur:  "2f24197554ec41be1cf98e338d08204e58c6cb97288e685189a22e89d2e0bae2"
    sha256 cellar: :any,                 monterey:       "c10ce034170fb86f3d7c202f9178b2e26f76f32b840ddda38d713940ca914cb7"
    sha256 cellar: :any,                 big_sur:        "21a8667363a3d23f395f887440da8feec117aea2cec3fe75ac3ce7d9ab360675"
    sha256 cellar: :any,                 catalina:       "f9270d7063c2ded4b7136ba4ab7c53dc940d8f1500a59ee5240c51e39348b975"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dab2ecde0dc36c82ba4b8bcd765b06b3db7a8410d041a0b90318e9e09812f151"
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
