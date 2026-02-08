# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT74 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-6.1.2.tgz"
  sha256 "d84b8a2ed89afc174be2dd2771410029deaf5796a2473162f94681885a4d39a8"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "aee39fe9955dd16e493b061b9ace883a2c5de7c18dcb3b27ca20fda02b39f14b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2a14c5828741e0396af46b92c90a4e66445aa60b7448025e8027bf62cf15a484"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e605a9b028265afa43ff3412fc440fecf4ea0b7933335fc2b22817bbcfe21487"
    sha256 cellar: :any_skip_relocation, sonoma:        "4b68f44f0c34a4ae153df907e50dee0d84c67fd1ec1145662a577511ebab22c1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6d1e76383a0268b03138c57e770c4e5cf4d8382a4ccd5009b9331cff87dbd898"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "37a45d2c8a1579fa3f8cc2fac0ab11cee952b8f0ce7cc60f2f7c8adc6d805463"
  end

  priority "10"

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
