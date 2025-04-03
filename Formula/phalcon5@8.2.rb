# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.2.tgz"
  sha256 "c85b6739e4e6b0816c4f9b4e6f7328d614d63b4f553641732b918df54fe13409"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "64da14efd493f62796126aed3da8b43fb4dc3b2645c304b06316c0ca137383bb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "eade817c9de7304e38f6d845a936fe6cf3303c0b7a15b1e1e8de391ddaa83d0a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d1292bac53eedda6dfa98b99de411828b421c421fa8d8dcb6fcb35464ee30f19"
    sha256 cellar: :any_skip_relocation, ventura:       "8a6f3bc0e1ab57547b990cf9604925345a880c6781686fe507f5929313010e81"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b55f2c76ff10ed422dc47e66c461bb609a336f304a8c0f1b56b873d0edebfffb"
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
