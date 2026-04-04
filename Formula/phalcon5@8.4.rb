# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.11.0.tgz"
  sha256 "c4d0e1659d82151ce8f0087ad9f2dfb7b0bd8bd19814526d424d010e24877601"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3027f09a8fed8e3898600288b1f99cf1376290f21186037dd715ee5ac1461400"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0203fd7527b46191efbd4cb184cb8adbf92015ff7ec02f8deb97237d05180e56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f35b2d91c88ac25d1d82f2923faa8fe2c534356511b7448328f38bb116ecbece"
    sha256 cellar: :any_skip_relocation, sonoma:        "02261bec6e1905a1c228ca628903e35ef3eda10eb65c1e938242f50a17ebf4e9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "066eeaa887003341ea2d37c1a1bea053b3c94796dd04f59723df5ad6de2b3e37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2fdb117898e0aea669b2b2a6e0d2df7341dd824a9deff2529fbe30489647c3fc"
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
