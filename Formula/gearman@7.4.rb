# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_ventura:  "9a72f5b34dd28ab77e07883165318ecda423fe409d83165fa25aedc440ad73e5"
    sha256 cellar: :any,                 arm64_monterey: "bc96d519e516624255f31540b87adb99326e1831e44c1b81fbca9b7e8f9e2bd9"
    sha256 cellar: :any,                 arm64_big_sur:  "2f24197554ec41be1cf98e338d08204e58c6cb97288e685189a22e89d2e0bae2"
    sha256 cellar: :any,                 ventura:        "db65cad02ba16c22aeda53a2f84e23736a1c89e1272cb34120305230bb077607"
    sha256 cellar: :any,                 monterey:       "46da8997bb8cbd2091c21ead17dacda2b18a45ee7e5f554c7b550eb981891fee"
    sha256 cellar: :any,                 big_sur:        "21a8667363a3d23f395f887440da8feec117aea2cec3fe75ac3ce7d9ab360675"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f7002fc7bf6bb61a3e731f4aebbf4491c5b6bf9533e63f5c3f0029000e4d9ce0"
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
