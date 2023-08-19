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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b97305fbcf834f61c94e4adb20bbc20491ed6ded6eba9180654135f3bb3bd344"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "cac45c6e16d115a593ec12b49809275cb123db6ed03f26871a71edef4cf457c4"
    sha256 cellar: :any_skip_relocation, ventura:        "f9b433e040d36bf4766d79806faa785a3a197a2c395c299724fb531786b1f966"
    sha256 cellar: :any_skip_relocation, monterey:       "e403e82227010ebcd4a351470f8d84884367e5d5836f225720f3c98afe9016e2"
    sha256 cellar: :any_skip_relocation, big_sur:        "92524b74b4a8dd5ba697ee0280e8afc3e96ef585312fc62a6e81c14184d526f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "df570649944c5d3b63879ecd9395d87d95f962b3a530711d3b23a24cf2c87950"
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
