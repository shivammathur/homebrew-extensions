# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT83 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.4.0.tgz"
  sha256 "a9b930582de8054e2b1a3502bec9d9e064941b5b9b217acc31e4b47f442b93ef"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ab42488ba0ff0d9e93d756dcaadadd1281bc3e18fc78650efaaa8490e2abb292"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e6a2d0f124fd15bc42a6cfe3ea4c04e98bf3f20eaaecedc4d38972f61b58d09d"
    sha256 cellar: :any_skip_relocation, ventura:        "20f033b3eae2f4440b0c057bdbb567a4590da528ed66ef88d66098506fd5b1d7"
    sha256 cellar: :any_skip_relocation, monterey:       "81d381599648731adcec495f9dbf4afe9f1eaa8d9a15a5daea24c99496fa4629"
    sha256 cellar: :any_skip_relocation, big_sur:        "a86a9d2e06dfc311fe6689bc1e7efa8200b0f1f4e80dfd309037ffa6b1831ef7"
    sha256 cellar: :any_skip_relocation, catalina:       "68d1dd1e7d28cec20724b2103b11052440af66dd28244f4d7ea7f7b5534ea8ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "936a152fd5f51b0a605da3a620468cd4d2a966aaf6f6dc599f86f6957754e5e6"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
