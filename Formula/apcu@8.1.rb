# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT81 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f4df969d0178be77ce97119c23d827520845ba0bc6464b16b7721512c026d933"
    sha256 cellar: :any_skip_relocation, big_sur:       "915b731165e5cc0940f48830d3ee953c497f7de8a4d14b87c548c8eb948d3e2e"
    sha256 cellar: :any_skip_relocation, catalina:      "7a12f14403dd40d25f6bfbde719ad5ee2150c39d9102669dc2bffdcd512f71bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6b045229b733e505749a2b05b3ff478f5d5bc55afcbab4eefeda5507ca95cbd2"
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
