# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT72 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.22.tgz"
  sha256 "010a0d8fd112e1ed7a52a356191da3696a6b76319423f7b0dfdeaeeafcb41a1e"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "018c1dfc70041ec93ddac27357978e8dacf2bbbec5b8bb3c1b3640e9d57d698c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cf906aae8b14cd731c3f43c7bcb27cbdabbc7f01f35d8a31e51f707929af8098"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ea6c96be193715a99d36c86c82a244550baf101fd47654ec34e0f1d784ba11e2"
    sha256 cellar: :any_skip_relocation, ventura:        "e0da5bbd3bede038a79f5cbf6a1887d7fb79244fbfc1325a7b051b6aaacb77b5"
    sha256 cellar: :any_skip_relocation, monterey:       "723229ecf5457464f6df38cf26cefee797a0aaf209c3b2202df9dc238cbdb8b4"
    sha256 cellar: :any_skip_relocation, big_sur:        "766105fc95400e3b8c028b0c2366c5da9ca4dad20934f2f3345aa0e47717ddc7"
    sha256 cellar: :any_skip_relocation, catalina:       "18cd51f7eaa4ade38688c1acf8651bef6fb6756473e4e15fb69c789af587cd05"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "92f1914f4a614bb9171b6f95d52c31ecae99cd53b40fb1413ca3b0490e585b53"
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
