# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "aeab7781395c6d371a8d75f573420ac39138dfad7a0b6116c19521d4fa1e07ec"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "aa0f13c26732b9bff5361a2057af4cfec3cdaf452a09db38168a67bd0d250f25"
    sha256 cellar: :any_skip_relocation, monterey:       "ef92796cf17ba14e220da4c726eb2d3c5a7e2f65c2c900d3565d32b6979b466f"
    sha256 cellar: :any_skip_relocation, big_sur:        "859d2b629af71c8e469e7b52e227deb74f051e0259ba8a317ba4ac254f0ec476"
    sha256 cellar: :any_skip_relocation, catalina:       "512e642f2b8a8f7330719de9ac30495c52f759f28871b606aa98b193d7e37ff0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c07f03e212ac41a363684a6c59b34e2de09c256a1cecf77e0a7362624db08fd3"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
