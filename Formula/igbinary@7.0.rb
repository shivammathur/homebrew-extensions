# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "741894180a82ffcc12f4680da222991e35100e29c7a956353181bb2df5453815"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "18b522f9daddedc8abe9d72849b67bd16232d571961237b196742e5279b24404"
    sha256 cellar: :any_skip_relocation, monterey:       "a57d30ad54dc7a6890e9937af4734cc99ccb423868168ffe1f1d7e62faa44a5f"
    sha256 cellar: :any_skip_relocation, big_sur:        "49a56a8d1c628613988597a346381f8a57d564e2b8a225d5c3d11c67c5922929"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "86b880d5c25b39d8df3535f84e497636973b4c2905997578394d6dc2f71f0a18"
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
