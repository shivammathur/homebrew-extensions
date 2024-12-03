# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT70 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "a30be7cdd77d97fa2a8b3e2acf65fa9221cab297bca3371b2a9a3b186865ac48"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7a4940c2e9c4bb963ab96b1ecc5f284d2c9f2feca4b6fe0ac24c5a51311547c2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "00a6c868433e8bbbc37676eb18da4aca6dc06ad9e875d4d5f909e2a901a1db51"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bfbe624b5b6a44415ea3e4eefa14b2580402835ad4e1d2da0db3b210c7f00848"
    sha256 cellar: :any_skip_relocation, ventura:        "387b00462fd7b2fc0658e6852c92896dd458effca8594f3456e6d84db8557b43"
    sha256 cellar: :any_skip_relocation, monterey:       "92fe85964983b5921a8fc4fff6ca566193014dae2a07694bbbf93ea151898084"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bcde225fdff67947c5524d7f55adafd131e2f5452746875daf18da7b74c1c57c"
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
