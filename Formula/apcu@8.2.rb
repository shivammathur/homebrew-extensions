# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT82 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f7111b61a1469bfab444db83f828072a9e58d65e2f986adf8545bfd4d3352800"
    sha256 cellar: :any_skip_relocation, big_sur:       "bc410e00b1152a617618c3410c666696e2a8be7c34cceb69f402b5010e456940"
    sha256 cellar: :any_skip_relocation, catalina:      "9a805bd070a80e0b19d7cf969e240ff0319f883317cfca86fd9533546eb33221"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "28e6d6579ba10a6ea2e7a185cfc4b5216c6c619356e70b76444ce27cdbc7f113"
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
