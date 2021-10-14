# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT70 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "487b111a8a78680b134e1bfee3300447a25833eb07f076503c324028e6835b5b"
    sha256 cellar: :any_skip_relocation, big_sur:       "64bf26602a6456e733981058057cd1f0623ff0e46d1e8641a42a8d274cc5d082"
    sha256 cellar: :any_skip_relocation, catalina:      "a500a91f5276e80d37ae036f0f5b57ee79ec0484b0ecee5a1a2c16c2ffa5b76b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f2dc4537fa68b81a3913a2205fc1ff490e011a4f3cdce95a3044efd4123a1221"
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
