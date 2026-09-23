# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT87 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/psr/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "e19a5dd3fe608d64cf8ee08ec4aaf3cc9ba8fb7821276993d53b6eb452ecbba6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "73b36315766910dc5336958b975942fadfa4d92a996b887740c3dbcb5e44a9b2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "bb9936507b9470cb37c08d70b318097caee7bd853f7009b1398593114ed67597"
    sha256 cellar: :any,                 arm64_linux:       "0b2528a81b489fe8937525414f600073cda58a088d206b7f752f02ddd5edd368"
    sha256 cellar: :any,                 x86_64_linux:      "41b6ad243389339f453eb502dd2872a764168aa35c5400e9828d255dcd99beb9"
  end

  depends_on "pcre"

  def install
    Dir.chdir "psr-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-psr"
    system "make"
    prefix.install "modules/psr.so"
    write_config_file
  end
end
