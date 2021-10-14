# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT71 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "121c6bdcc966f805c367785063a3a20b04adb52b68fb154f90a6a946015e1e5c"
    sha256 cellar: :any_skip_relocation, big_sur:       "725cb5263b31d2f11f2d6b511e1fd76681c091b7c6d2c9f6723c96c0331526c2"
    sha256 cellar: :any_skip_relocation, catalina:      "6a28ef46f0b5dd23a8a0a6f5f8e5e253754082e61f0603a12deef0c2bc4f2277"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "95b90fe4bd1150e1d1154033177d4402f7e64539b1d92cadc7c6cde17756a855"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
