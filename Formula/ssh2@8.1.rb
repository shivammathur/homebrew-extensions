# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "eccaf521a1b8d8f37b447c5740d475eb232249d4225e8d27c9f49e863db55b77"
    sha256 cellar: :any, arm64_tahoe:       "fdb17e105a2d7c587ac1350e00ffa0e96cf1ed2d74929af404b57958d796ec92"
    sha256 cellar: :any, arm64_sequoia:     "c2f21ef9860b1cccef8d3bb9943d518f23855df7e8732cafd2ea4624ae637269"
    sha256 cellar: :any, arm64_linux:       "305d7cd0ba70d5da411e5f7b9571403d3286d8539b0088c0071d2f8163cd0d42"
    sha256 cellar: :any, x86_64_linux:      "504df7de25f9ab1d59d2d2a48a22bbd0bcc7997791a2df0a21b6925ab92d30d4"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
