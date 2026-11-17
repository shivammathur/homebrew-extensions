# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT74 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.1.tgz"
  sha256 "2212d8266df54654b282ca681ee9b82f312a776e801b667b288d80f3541741ed"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "7130c8a8f45667523eff9cf04a25b33fcf1bfe3eb9c0316e3b1f81dc5e6a00a0"
    sha256 cellar: :any, arm64_tahoe:       "44cd202cd81813668f3e3f86d15592403237f683295f66652fd2f1eaa286aaef"
    sha256 cellar: :any, arm64_sequoia:     "01579a6a7ae5de66e3d11ad99cc349fbff885edfa40bd3a4cdd86879aa3de305"
    sha256 cellar: :any, arm64_linux:       "6ba570dc512ad310e1e09931aa60b4f290ab1ad426d31be158c7b03a82e95ffb"
    sha256 cellar: :any, x86_64_linux:      "990300523802c98a45587436826e3fd5ed357fd1907432eb1663fd6255ad1dd9"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
    ]
    Dir.chdir "ssh2-#{version}"
    inreplace "ssh2.c", "#include \"Zend/zend_attributes.h\"\n", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
