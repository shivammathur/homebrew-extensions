# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.1.2.tgz"
  sha256 "750712956179f296d68d4d022e223955d1e534ea32672c2d7875f2611920a2b6"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5f69d69f9c1fad464af755ad96ac8cb063f658071d2017192026a4f6de32a348"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "cb3f56c36235d03181ab010ec4b3086731ce3526862aca287f0aa264a340b12c"
    sha256 cellar: :any_skip_relocation, monterey:       "1faf769242bc89f0596189692b55a798014c3f2231f045e460a437db89d1adc8"
    sha256 cellar: :any_skip_relocation, big_sur:        "ab450c958c58be4f727a1952d3b783df87bdf4712a84ff82fb44ef6de277afd4"
    sha256 cellar: :any_skip_relocation, catalina:       "52bec45108e0d3d712f3ba1f5ae91c6d5ea9f18afe4a136934135d9dd6c02bd2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2d0851ae919fe387e0702463d3704691d14b6203deb6420e30ae62042ad5d42b"
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
