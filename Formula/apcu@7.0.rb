# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT70 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.25.tgz"
  sha256 "c4e7bae1cc2b9f68857889c022c7ea8cbc38b830c07273a2226cc44dc6de3048"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0551fb90d547efe413c64379e4c6b467b7dd2028cab45bc8b99bd1a1128a1b8d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bf3f384ace2ca918715854b59dec3e61fae3cdba3f53fc1dc7a562f0c5a798ae"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e00c7dce6a7b82fca94afa3dd9ce9eeafce5fb1b8d69e92e6cb0fcd66ca9bffb"
    sha256 cellar: :any_skip_relocation, ventura:       "9150a11ae6d3e9297771962fcec5b50e9576d06ed21e239a66a299041ae38b3b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "56ece3dd0ddec80bc4c2d88d60564919d9fa28d9c26d9f279ff6f13b1d417d56"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "13b6cb33da235d475b8df89e168ac27245d7e2a04e831f0719cae0a64bd53508"
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
