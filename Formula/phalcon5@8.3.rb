# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.6.1.tgz"
  sha256 "9842c0f75e89ae64cc33f1a2e517eaa014eeef47994d9a438bfa1ac00b6fdd54"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "68602e0268fee537bdccd6bf427fa2f158eec2dbb6d6fd5d1ba9d0e88a725504"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5064a5a61834fd719655b861295ac4e6cba9a3f19d362d8700484df876c2a9bb"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c6297add3e5ae26074c484491eefa9534136f166762b51502be7d3054a06a973"
    sha256 cellar: :any_skip_relocation, ventura:        "47188542033305507d9665559192d6e5d60f97080c9f35afeda4313e4f7602c2"
    sha256 cellar: :any_skip_relocation, monterey:       "3797c7f8eea2630fa11935e705832be38b9f20491d1325c67c51b3251991cf73"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5f061668cfcf21b4327fbf84536ec65a2c8ada69ba9346b4f74c6fe5bfb4b1c4"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
