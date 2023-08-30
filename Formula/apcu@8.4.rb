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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e1083e8de4b1e9e9f6216d0c6e5983dc80ac8c10d6c80caf07d22911c0a1063f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a41af8971c7bd11818e51b0bc53d0b91a40e960cba82173f5774cb84f1c62797"
    sha256 cellar: :any_skip_relocation, ventura:        "775eb303d34230ba755693012b1fa38cc450267413f77c5156b070ee28214754"
    sha256 cellar: :any_skip_relocation, monterey:       "a4568f74939e345ec2deb1ee02a619761c58261afa5444d7782cfe777f546d7d"
    sha256 cellar: :any_skip_relocation, big_sur:        "1e2ea91afa18893c8304e75819745e2ab3de02a168e27912b7d10cccc2ddf580"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "34fc04f6bd6e2ae3a1945117273c36855be5c2a3896805004242b72f7c77af41"
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
