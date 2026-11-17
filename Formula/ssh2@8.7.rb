# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT87 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "5012d203b3e9e6659bd0e503c85cc83615bd929bdd26c1f03c60e23cd0f46955"
    sha256 cellar: :any, arm64_tahoe:       "94126e1d7fd057d041a0656616e820048a5ab6eaf2e48906eef9f17ebad0ea8b"
    sha256 cellar: :any, arm64_sequoia:     "ab6c193768fe184aa5de360a5315cc23704defb5f5770c47c80be5afbb563d6c"
    sha256 cellar: :any, arm64_linux:       "014e825d99a2c950168c43ec7e3ad87e6409ede9d86a92a0e9f0d3bb908c468e"
    sha256 cellar: :any, x86_64_linux:      "fea4555434cc2b5dbcf4cb798e8b9434dc81025661ab32313167c0143860104c"
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
