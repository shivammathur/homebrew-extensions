# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT84 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.22.tgz"
  sha256 "010a0d8fd112e1ed7a52a356191da3696a6b76319423f7b0dfdeaeeafcb41a1e"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9df4cc6cc1d01397b705d9555955d14252e2ca5d4243086ef342c58e0a658e61"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e2755409692087a2b6f2c402be8d6348412a1a9d2025e2c74145a656840807d0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "19922a5e762434837e23250fa4ae512723f4c456478e77c8519f82a2d9faa254"
    sha256 cellar: :any_skip_relocation, ventura:        "62473be5875032cd7cb05e91ed10a76d04d29c1421021da6f2baf568a3f1a14f"
    sha256 cellar: :any_skip_relocation, monterey:       "56e5fb463578a2253935ea6d8fa558ebee51a35040c32cb783b8e277c6196d3e"
    sha256 cellar: :any_skip_relocation, big_sur:        "e44a6649ef268fcad4f78c1b27828d29a45a3b361f626f3d3ed7055822272bdb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "88aef652f4588d07d999cff187bb926c2182705035311ef7657234ef4e647706"
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
