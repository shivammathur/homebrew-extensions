# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.1.1.tgz"
  sha256 "4e5946397cc5dca06122d980658d8cc5b261b985bf2b8f90cd5d873e0d9d36c0"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8f9a31025249225b409c77136b3173819c4a18835316ae1f6ff1e1e162b5cc0a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f8de650d78a8c84f2a94e2bbf1fac779b14928112925fbe01168235b01f437b5"
    sha256 cellar: :any_skip_relocation, monterey:       "52be3333f8f5dc33ff2a1e98ff9d105c2feaa93e31fab610418ac8ed02223437"
    sha256 cellar: :any_skip_relocation, big_sur:        "4e8f2564ece6ccfae1e078a6022a0a9de61d9987afa83c5fd746fb6ddd6c2b86"
    sha256 cellar: :any_skip_relocation, catalina:       "cfe416c588a1f1a455510f0f8edfa1c90c59c27726eb3e729ce0eff765619ed6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "75ebdeac0aaae663e0d3d3861e5ee0d120dc13e1ac6031e164c903168c0d732d"
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
