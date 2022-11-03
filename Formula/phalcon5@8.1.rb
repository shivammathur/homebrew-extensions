# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.1.0.tgz"
  sha256 "b65c663fa36e2184289cde64d30c5b62b3d94974b9e99258a49a9a3fd338c788"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3ee84d37fc1ce39d9778a7221e4f3d61e7b2ed1599d755e60924a63e1206c286"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2976d40efb32552aa96510e6723c008436f92a421f7160da0fd93235f983c524"
    sha256 cellar: :any_skip_relocation, monterey:       "cc8776c87c216314bbe347e38557e95a962378591cf64fa80a00b8827c5e30ce"
    sha256 cellar: :any_skip_relocation, big_sur:        "84727a543c3d7b59fd9aa73b17302f159da80c1cd47246cc966c793b96e1e572"
    sha256 cellar: :any_skip_relocation, catalina:       "59aeb4933d25cc76b56384b1f2af4bc6fb069eb907b13bc7b966f13d8624bb63"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e639f0d8f94f3c6d1f4ed17a63fd87bcf75fbf831c345a788064df2ed5082781"
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
