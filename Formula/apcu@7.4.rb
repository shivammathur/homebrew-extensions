# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT74 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c6bc44a946d756ce3b5e02a08cd5ebdf1eac94275c160b9c1a24a569cf422b68"
    sha256 cellar: :any_skip_relocation, big_sur:       "5d22cbd3c60d954325af5b3b3f85b3d3ec94b5008bdf45cce6568d0bb32fa775"
    sha256 cellar: :any_skip_relocation, catalina:      "fe6d8c466531f8dd0a602d531d62b5edcbe34dea1acc6ee9bfeb9baa11113292"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e9f5e4b94ec83f6808d6783ed812784e50e799c347bc862e593cb841707cdfae"
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
