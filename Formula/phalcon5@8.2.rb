# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.6.1.tgz"
  sha256 "9842c0f75e89ae64cc33f1a2e517eaa014eeef47994d9a438bfa1ac00b6fdd54"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "78bf386db7fd3b9253f0d66c38465d31ac62eee6d93a15db951e2cfca6f9abbb"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d688487c65a9beb995087420a6e39305bed80426e5359150a401bbbc03f04919"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "11a40f1e67b760a7f6a731406d88e2ea830df17c2bacb8b7b31a2505f719a2a4"
    sha256 cellar: :any_skip_relocation, ventura:        "9ce494f8678ae28ff482e9fa118282dedac8cd2e8cd546140f4b8c77b0c93394"
    sha256 cellar: :any_skip_relocation, monterey:       "5c32ab9f532a4dd62639f97e3d8249d76cf733867cfaf73eb06ab80f14452e02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "af8733a1493788ad5f1f2ac72bb3a0f8e9a536082382e2ad1d75f90103be80e8"
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
